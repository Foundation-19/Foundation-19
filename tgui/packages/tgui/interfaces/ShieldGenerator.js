import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, ProgressBar, NumberInput, NoticeBox, Flex } from '../components';
import { Window } from '../layouts';

export const ShieldGenerator = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    running,
    modes,
    overloaded,
    mitigation_max,
    mitigation_physical,
    mitigation_em,
    mitigation_heat,
    field_integrity,
    max_energy,
    current_energy,
    percentage_energy,
    total_segments,
    functional_segments,
    field_radius,
    target_radius,
    input_cap_kw,
    upkeep_power_usage,
    power_usage,
    hacked,
    offline_for,
    idle_multiplier,
    idle_valid_values,
  } = data;
  return (
    <Window width={500} height={800} resizable>
      <Window.Content scrollable>
        {!!offline_for && (
          <NoticeBox danger>Offline for {offline_for}s</NoticeBox>
        )}
        {!!overloaded && (
          <NoticeBox warning>Field overloaded - regenerating</NoticeBox>
        )}
        <Section title="Shield Status">
          <LabeledList>
            <LabeledList.Item label="Status">
              {running === 0 && <Box color="bad">Offline</Box>}
              {running === 1 && <Box color="average">Idle</Box>}
              {running === 2 && <Box color="good">Running</Box>}
              {running === 3 && <Box color="average">Discharging</Box>}
              {running === 4 && <Box color="average">Spinning Up</Box>}
            </LabeledList.Item>
            <LabeledList.Item label="Field Integrity">
              <ProgressBar value={field_integrity / 100} ranges={{ good: [0.5, Infinity], average: [0.25, 0.5], bad: [-Infinity, 0.25] }}>
                {field_integrity}%
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Energy">
              <ProgressBar value={percentage_energy / 100}>
                {current_energy} / {max_energy} MJ ({percentage_energy}%)
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Segments">
              {functional_segments} / {total_segments} functional
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Controls">
          <LabeledList>
            {running > 0 && (
              <LabeledList.Item label="Shutdown">
                <Button content="Begin Shutdown" color="bad" onClick={() => act('begin_shutdown')} />
                <Button content="Emergency Shutdown" color="bad" onClick={() => act('emergency_shutdown')} />
              </LabeledList.Item>
            )}
            {running === 0 && (
              <LabeledList.Item label="Start">
                <Button content="Start Generator" color="good" onClick={() => act('start_generator')} />
              </LabeledList.Item>
            )}
            {running >= 2 && (
              <LabeledList.Item label="Idle">
                <Button
                  icon={running === 1 ? 'toggle-on' : 'toggle-off'}
                  content={running === 1 ? 'Active' : 'Idle'}
                  selected={running === 1}
                  onClick={() => act('toggle_idle', { toggle_idle: running === 1 ? 0 : 1 })} />
              </LabeledList.Item>
            )}
          </LabeledList>
        </Section>
        <Section title="Configuration">
          <LabeledList>
            <LabeledList.Item label="Field Radius">
              {field_radius} (target: {target_radius})
              <Button content="Set" onClick={() => act('set_range')} />
            </LabeledList.Item>
            <LabeledList.Item label="Input Cap">
              {input_cap_kw} kW
              <Button content="Set" onClick={() => act('set_input_cap')} />
            </LabeledList.Item>
            <LabeledList.Item label="Idle Multiplier">
              {(idle_valid_values || []).map(val => (
                <Button key={val} content={`x${val}`} selected={idle_multiplier === val} onClick={() => act('switch_idle', { switch_idle: val })} />
              ))}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Mitigation">
          <LabeledList>
            <LabeledList.Item label="Physical">
              <ProgressBar value={mitigation_physical / mitigation_max}>{mitigation_physical}</ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="EM">
              <ProgressBar value={mitigation_em / mitigation_max}>{mitigation_em}</ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Heat">
              <ProgressBar value={mitigation_heat / mitigation_max}>{mitigation_heat}</ProgressBar>
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Power Usage">
          <LabeledList>
            <LabeledList.Item label="Upkeep">{upkeep_power_usage} kW</LabeledList.Item>
            <LabeledList.Item label="Total">{power_usage} kW</LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Shield Modes">
          <LabeledList>
            {(modes || []).map(mode => (
              <LabeledList.Item key={mode.flag} label={mode.name}>
                <Button
                  icon={mode.status ? 'toggle-on' : 'toggle-off'}
                  content={mode.status ? 'Enabled' : 'Disabled'}
                  selected={mode.status}
                  onClick={() => act('toggle_mode', { toggle_mode: mode.flag })} />
                <Box inline ml={1} color="label">{mode.desc}</Box>
              </LabeledList.Item>
            ))}
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
