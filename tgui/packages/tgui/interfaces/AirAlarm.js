import { useBackend } from '../backend';
import { Box, Button, Flex, LabeledList, NoticeBox, ProgressBar, Section, Tabs } from '../components';
import { Window } from '../layouts';

const AALARM_SCREEN_MAIN = 1;
const AALARM_SCREEN_VENT = 2;
const AALARM_SCREEN_SCRUB = 3;
const AALARM_SCREEN_MODE = 4;
const AALARM_SCREEN_SENSORS = 5;

const dangerLevelColor = (level) => {
  if(level === 2) return 'bad';
  if(level === 1) return 'average';
  return 'good';
};

export const AirAlarm = (props, context) => {
  const { act, data } = useBackend(context);
  const { locked, screen, rcon, total_danger, atmos_alarm, fire_alarm, environment = [] } = data;

  return (
    <Window width={325} height={625} resizable>
      <Window.Content scrollable>
        {!!atmos_alarm && (
          <NoticeBox danger>ATMOSPHERE ALERT</NoticeBox>
        )}
        {!!fire_alarm && (
          <NoticeBox danger>FIRE ALERT</NoticeBox>
        )}
        <Section title="Environment Status">
          {environment.map((entry, i) => (
            <LabeledList key={i}>
              <LabeledList.Item label={entry.name}>
                <Box inline color={dangerLevelColor(entry.danger_level)}>
                  {typeof entry.value === 'number' ? (entry.value < 10 ? entry.value.toFixed(1) : Math.round(entry.value)) : entry.value} {entry.unit}
                </Box>
              </LabeledList.Item>
            </LabeledList>
          ))}
        </Section>
        {!locked && (
          <>
            <Tabs>
              <Tabs.Tab selected={screen === AALARM_SCREEN_MAIN} onClick={() => act('screen', { screen: 1 })}>Main</Tabs.Tab>
              <Tabs.Tab selected={screen === AALARM_SCREEN_VENT} onClick={() => act('screen', { screen: 2 })}>Vents</Tabs.Tab>
              <Tabs.Tab selected={screen === AALARM_SCREEN_SCRUB} onClick={() => act('screen', { screen: 3 })}>Scrubs</Tabs.Tab>
              <Tabs.Tab selected={screen === AALARM_SCREEN_MODE} onClick={() => act('screen', { screen: 4 })}>Mode</Tabs.Tab>
              <Tabs.Tab selected={screen === AALARM_SCREEN_SENSORS} onClick={() => act('screen', { screen: 5 })}>Sensors</Tabs.Tab>
            </Tabs>
            {screen === AALARM_SCREEN_MAIN && <MainScreen />}
            {screen === AALARM_SCREEN_VENT && <VentScreen />}
            {screen === AALARM_SCREEN_SCRUB && <ScrubScreen />}
            {screen === AALARM_SCREEN_MODE && <ModeScreen />}
            {screen === AALARM_SCREEN_SENSORS && <SensorScreen />}
          </>
        )}
      </Window.Content>
    </Window>
  );
};

const MainScreen = (props, context) => {
  const { act, data } = useBackend(context);
  const { rcon, mode, target_temperature } = data;

  return (
    <Section>
      <LabeledList>
        <LabeledList.Item label="Alert">
          <Button color="bad" content="Atmos Alert" onClick={() => act('atmos_alarm')} />
          <Button color="good" content="Reset" onClick={() => act('atmos_reset')} />
        </LabeledList.Item>
        <LabeledList.Item label="RCON">
          <Button content="Off" selected={rcon === 0} onClick={() => act('rcon', { rcon: 0 })} />
          <Button content="Auto" selected={rcon === 1} onClick={() => act('rcon', { rcon: 1 })} />
          <Button content="On" selected={rcon === 2} onClick={() => act('rcon', { rcon: 2 })} />
        </LabeledList.Item>
        <LabeledList.Item label="Thermostat">
          <Button content={target_temperature} onClick={() => act('temperature')} />
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

const VentScreen = (props, context) => {
  const { act, data } = useBackend(context);
  const { vents = [] } = data;

  return (
    <Section title="Vents">
      {vents.length === 0 && <Box color="label">No vents detected.</Box>}
      {vents.map((vent) => (
        <Section key={vent.id_tag} title={vent.long_name} level={2}>
          <LabeledList>
            <LabeledList.Item label="Power">
              <Button
                icon={vent.power ? 'toggle-on' : 'toggle-off'}
                content={vent.power ? 'On' : 'Off'}
                selected={vent.power}
                onClick={() => act('command', { id_tag: vent.id_tag, command: 'set_power', val: vent.power ? 0 : 1 })} />
            </LabeledList.Item>
            <LabeledList.Item label="Checks">
              <Button content={vent.checks === 1 ? 'Pressure' : 'Default'}
                onClick={() => act('command', { id_tag: vent.id_tag, command: 'set_checks', val: vent.checks === 1 ? 0 : 1 })} />
            </LabeledList.Item>
          </LabeledList>
        </Section>
      ))}
    </Section>
  );
};

const ScrubScreen = (props, context) => {
  const { act, data } = useBackend(context);
  const { scrubbers = [] } = data;

  return (
    <Section title="Scrubbers">
      {scrubbers.length === 0 && <Box color="label">No scrubbers detected.</Box>}
      {scrubbers.map((scrubber) => (
        <Section key={scrubber.id_tag} title={scrubber.long_name} level={2}>
          <LabeledList>
            <LabeledList.Item label="Power">
              <Button
                icon={scrubber.power ? 'toggle-on' : 'toggle-off'}
                content={scrubber.power ? 'On' : 'Off'}
                selected={scrubber.power}
                onClick={() => act('command', { id_tag: scrubber.id_tag, command: 'set_power', val: scrubber.power ? 0 : 1 })} />
            </LabeledList.Item>
            <LabeledList.Item label="Mode">
              <Button
                content={scrubber.scrubbing ? 'Scrubbing' : 'Siphoning'}
                onClick={() => act('command', { id_tag: scrubber.id_tag, command: 'set_scrubbing', scrub_mode: scrubber.scrubbing ? 'siphon' : 'scrub' })} />
            </LabeledList.Item>
          </LabeledList>
        </Section>
      ))}
    </Section>
  );
};

const ModeScreen = (props, context) => {
  const { act, data } = useBackend(context);
  const { modes = [], mode } = data;

  return (
    <Section title="Operating Mode">
      {modes.map((m) => (
        <Button
          key={m.mode}
          fluid
          content={m.name}
          selected={m.selected}
          color={m.danger ? (m.selected ? 'bad' : 'default') : undefined}
          onClick={() => act('mode', { mode: m.mode })} />
      ))}
    </Section>
  );
};

const SensorScreen = (props, context) => {
  const { act, data } = useBackend(context);
  const { thresholds = [] } = data;

  return (
    <Section title="Sensor Thresholds">
      {thresholds.map((threshold, i) => (
        <Section key={i} title={threshold.name} level={2}>
          <LabeledList>
            {threshold.settings.map((s) => (
              <LabeledList.Item key={`${s.env}-${s.val}`} label={`Threshold ${s.val}`}>
                <Button
                  content={s.selected}
                  onClick={() => act('command', { command: 'set_threshold', env: s.env, var: s.val })} />
              </LabeledList.Item>
            ))}
          </LabeledList>
        </Section>
      ))}
    </Section>
  );
};
