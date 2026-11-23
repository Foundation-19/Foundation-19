import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, NumberInput } from '../components';
import { Window } from '../layouts';

export const OvermapHelm = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    sector,
    sector_info,
    landed,
    s_x,
    s_y,
    dest,
    d_x,
    d_y,
    speedlimit,
    accel,
    heading,
    autopilot,
    manual_control,
    canburn,
    accellimit,
    speed,
    ETAnext,
    locations,
    viewing,
    viewing_silicon,
  } = data;
  return (
    <Window width={565} height={545}>
      <Window.Content scrollable>
        <Section title="Navigation">
          <LabeledList>
            <LabeledList.Item label="Sector">{sector}</LabeledList.Item>
            <LabeledList.Item label="Info">{sector_info}</LabeledList.Item>
            <LabeledList.Item label="Position">X: {s_x} Y: {s_y}</LabeledList.Item>
            {!!landed && (
              <LabeledList.Item label="Landed">{landed}</LabeledList.Item>
            )}
            <LabeledList.Item label="Speed">{speed}</LabeledList.Item>
            <LabeledList.Item label="Heading">{heading}°</LabeledList.Item>
            <LabeledList.Item label="Acceleration">{accel}</LabeledList.Item>
            <LabeledList.Item label="ETA">{ETAnext}</LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Controls">
          <LabeledList>
            <LabeledList.Item label="Autopilot">
              <Button
                icon={autopilot ? 'toggle-on' : 'toggle-off'}
                content={autopilot ? 'ON' : 'OFF'}
                selected={autopilot}
                onClick={() => act('apilot')} />
            </LabeledList.Item>
            <LabeledList.Item label="Manual Control">
              <Button
                icon="eye"
                content={manual_control ? 'Release' : 'Take Control'}
                selected={manual_control}
                onClick={() => act('manual')} />
            </LabeledList.Item>
            <LabeledList.Item label="Brake">
              <Button icon="stop" content="Brake" onClick={() => act('brake')} />
            </LabeledList.Item>
            <LabeledList.Item label="Speed Limit">
              <Button content={speedlimit} onClick={() => act('speedlimit')} />
            </LabeledList.Item>
            <LabeledList.Item label="Accel Limit">
              <Button content={accellimit} onClick={() => act('accellimit')} />
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Destination">
          <LabeledList>
            <LabeledList.Item label="Destination">
              {!!dest && <Box inline>X: {d_x} Y: {d_y}</Box>}
              <Button content="Set X" onClick={() => act('setx')} />
              <Button content="Set Y" onClick={() => act('sety')} />
              <Button content="Reset" onClick={() => act('reset')} />
            </LabeledList.Item>
          </LabeledList>
        </Section>
        {!!locations && locations.length > 0 && (
          <Section title="Known Sectors">
            <LabeledList>
              {locations.map(loc => (
                <LabeledList.Item key={loc.reference} label={loc.name}>
                  X: {loc.x} Y: {loc.y}
                  <Button ml={1} content="Navigate" onClick={() => act('move', { x: loc.x, y: loc.y })} />
                  <Button content="Remove" color="bad" onClick={() => act('remove', { remove: loc.reference })} />
                </LabeledList.Item>
              ))}
            </LabeledList>
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
