import { useBackend } from '../backend';
import { Box, Button, LabeledList, NumberInput, Section } from '../components';
import { Window } from '../layouts';

const C = {
  bg: '#0a0a0c',
  panel: '#111114',
  border: '#2a2a30',
  accent: '#c2960e',
  text: '#c8c8c8',
  dim: '#7a7a80',
  mono: 'Consolas, monospace',
};

const panelStyle = {
  background: C.panel,
  border: '1px solid ' + C.border,
  marginBottom: '8px',
};

const presets = [0, 101, 500, 1000];

const PressureRow = (props, context) => {
  const { act } = useBackend(context);
  const { label, value, max, action } = props;
  return (
    <LabeledList.Item label={label}>
      <NumberInput
        value={value}
        minValue={0}
        maxValue={max}
        step={1}
        width="70px"
        onChange={(e, newValue) => act(action, { pressure: newValue })} />
      {presets.map(preset => (
        <Button
          key={preset}
          content={preset}
          selected={value === preset}
          mr={0.5}
          ml={0.5}
          onClick={() => act(action, { pressure: preset })} />
      ))}
    </LabeledList.Item>
  );
};

export const VentPump = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    name = 'Air Vent',
    pump_direction,
    power,
    external_pressure_bound,
    internal_pressure_bound,
    pressure_checks,
    max_pressure = 1000,
  } = data;

  return (
    <Window width={440} height={420}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.accent, letterSpacing: '0.15em', fontWeight: 'bold' }}>VENT PUMP</Box>
            <Box style={{ color: C.dim, fontSize: '10px' }}>{name}</Box>
          </Box>

          <Section title="Status" style={panelStyle}>
            <LabeledList>
              <LabeledList.Item label="Pump Mode">
                <Button
                  icon={pump_direction ? 'arrow-up' : 'arrow-down'}
                  content={pump_direction ? 'Releasing' : 'Siphoning'}
                  selected={pump_direction}
                  onClick={() => act('switch_mode')} />
              </LabeledList.Item>
              <LabeledList.Item label="Power">
                <Box style={{ color: power ? C.accent : C.dim }}>{power ? 'Active' : 'Off'}</Box>
              </LabeledList.Item>
            </LabeledList>
          </Section>

          <Section title="Pressure Bounds" style={panelStyle}>
            <LabeledList>
              <PressureRow
                label="External"
                value={external_pressure_bound}
                max={max_pressure}
                action="set_external_pressure" />
              <PressureRow
                label="Internal"
                value={internal_pressure_bound}
                max={max_pressure}
                action="set_internal_pressure" />
            </LabeledList>
          </Section>

          <Section title="Pressure Checks" style={panelStyle}>
            <Button
              content="External"
              selected={!!(pressure_checks & 1)}
              mr={0.5}
              onClick={() => act('toggle_check', { check: 1 })} />
            <Button
              content="Internal"
              selected={!!(pressure_checks & 2)}
              mr={0.5}
              onClick={() => act('toggle_check', { check: 2 })} />
            <Button
              icon="undo"
              content="Reset Defaults"
              ml={0.5}
              onClick={() => act('reset_defaults')} />
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
