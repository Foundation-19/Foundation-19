import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
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

export const OutletInjector = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    name = 'injector',
    power,
    id,
    frequency = 0,
    frequency_decimal,
  } = data;
  const frequencyDisplay = frequency_decimal ? `${frequency}` : `${frequency}.0`;

  return (
    <Window width={400} height={320}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.accent, letterSpacing: '0.15em', fontWeight: 'bold' }}>OUTLET INJECTOR</Box>
            <Box style={{ color: C.dim, fontSize: '10px' }}>{name}</Box>
          </Box>

          <Section title="Status" style={panelStyle}>
            <LabeledList>
              <LabeledList.Item label="Power">
                <Button
                  icon={power ? 'toggle-on' : 'toggle-off'}
                  content={power ? 'Injecting' : 'Offline'}
                  selected={power}
                  onClick={() => act('toggle_power')} />
              </LabeledList.Item>
            </LabeledList>
          </Section>

          <Section title="Radio" style={panelStyle}>
            <LabeledList>
              <LabeledList.Item label="ID Tag">
                <Box inline mr={0.5}>{id || 'None'}</Box>
                <Button icon="pen" content="Set ID Tag" onClick={() => act('settag')} />
              </LabeledList.Item>
              <LabeledList.Item label="Frequency">
                <Box inline mr={0.5}>{frequencyDisplay}</Box>
                <Button icon="wifi" content="Set Frequency" onClick={() => act('setfreq')} />
              </LabeledList.Item>
            </LabeledList>
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
