import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

const C = {
  bg: '#0a0a0c',
  panel: '#111114',
  border: '#2a2a30',
  accent: '#c2960e',
  good: '#44aa44',
  text: '#c8c8c8',
  dim: '#7a7a80',
  mono: 'Consolas, monospace',
};

const panelStyle = {
  background: C.panel,
  border: '1px solid ' + C.border,
  marginBottom: '8px',
};

export const ChemicalHeater = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    name = 'Chemical Heater',
    target_temperature = 0,
    current_temperature = 0,
    min_temperature = 0,
    max_temperature = 0,
    heating_power = 0,
    on,
    has_container,
    container_name,
    container_temperature,
  } = data;
  const canDecrease = target_temperature > min_temperature;
  const canIncrease = target_temperature < max_temperature;

  return (
    <Window width={420} height={360}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.accent, letterSpacing: '0.15em', fontWeight: 'bold' }}>{name.toUpperCase()}</Box>
          </Box>

          <Section title="Temperature" style={panelStyle}>
            <LabeledList>
              <LabeledList.Item label="Target">
                <Button
                  content="-"
                  disabled={!canDecrease}
                  mr={0.5}
                  onClick={() => act('adjust_temperature', { amount: -heating_power })} />
                <Box inline mr={0.5} ml={0.5}>{target_temperature}&deg;C</Box>
                <Button
                  content="+"
                  disabled={!canIncrease}
                  mr={0.5}
                  onClick={() => act('adjust_temperature', { amount: heating_power })} />
              </LabeledList.Item>
              <LabeledList.Item label="Current">
                {current_temperature}&deg;C
              </LabeledList.Item>
            </LabeledList>
          </Section>

          <Section title="Loaded Container" style={panelStyle}>
            {has_container ? (
              <>
                <Box mb={1}>{container_name} ({container_temperature}&deg;C)</Box>
                <Button icon="eject" content="Remove" onClick={() => act('remove_container')} />
              </>
            ) : (
              <Box style={{ color: C.dim }}>None.</Box>
            )}
          </Section>

          <Section title="Power" style={panelStyle}>
            <Button
              icon={on ? 'toggle-on' : 'toggle-off'}
              content={on ? 'On' : 'Off'}
              selected={on}
              onClick={() => act('toggle_power')} />
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
