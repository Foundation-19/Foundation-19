import { useBackend } from '../backend';
import { Box, Button, LabeledList, ProgressBar, Section } from '../components';
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

export const SpaceHeater = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    on,
    has_cell,
    cell_percent = 0,
    set_temperature = 0,
    set_temperature_c = 0,
    active = 0,
  } = data;

  return (
    <Window width={400} height={360}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.accent, letterSpacing: '0.15em', fontWeight: 'bold' }}>SPACE HEATER</Box>
            <Box style={{ color: C.dim, fontSize: '10px' }}>CONTROL PANEL</Box>
          </Box>

          <Section title="Power Cell" style={panelStyle}>
            <LabeledList>
              <LabeledList.Item label="Cell">
                <Button
                  content={has_cell ? 'Installed' : 'Removed'}
                  selected={has_cell}
                  onClick={() => act(has_cell ? 'cellremove' : 'cellinstall')} />
              </LabeledList.Item>
              <LabeledList.Item label="Power Level">
                <ProgressBar value={cell_percent} minValue={0} maxValue={100} color="blue">
                  {cell_percent}%
                </ProgressBar>
              </LabeledList.Item>
            </LabeledList>
          </Section>

          <Section title="Temperature" style={panelStyle}>
            <LabeledList>
              <LabeledList.Item label="Set Temperature">
                <Button content="-" mr={0.5} onClick={() => act('temp', { val: -5 })} />
                <Box inline mr={0.5} ml={0.5}>{set_temperature}K ({set_temperature_c}&deg;C)</Box>
                <Button content="+" mr={0.5} onClick={() => act('temp', { val: 5 })} />
              </LabeledList.Item>
              <LabeledList.Item label="Status">
                <Box style={{ color: on ? C.good : C.dim }}>
                  {!on ? 'Off' : active > 0 ? 'Heating' : active < 0 ? 'Cooling' : 'Standby'}
                </Box>
              </LabeledList.Item>
            </LabeledList>
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
