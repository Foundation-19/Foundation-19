import { useBackend } from '../backend';
import { Box, Button, Section } from '../components';
import { Window } from '../layouts';

const C = {
  bg: '#0a0a0c',
  panel: '#111114',
  border: '#2a2a30',
  amber: '#c2960e',
  text: '#c8c8c8',
  textDim: '#7a7a80',
  mono: 'Consolas, monospace',
};

export const SuspensionGenerator = (props, context) => {
  const { act, data } = useBackend(context);
  const { cell, active } = data;

  return (
    <Window width={360} height={300}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>
              SUSPENSION FIELD GENERATOR
            </Box>
          </Box>

          <Section title="Energy Cell" style={{ border: '1px solid ' + C.border }}>
            {!cell ? (
              <Box style={{ color: C.textDim }}>None</Box>
            ) : (
              <Box style={{ color: cell.colour }}>{cell.percent}%</Box>
            )}
          </Section>

          <Box mt={1}>
            <Button
              inline
              icon="power-off"
              content={active ? 'Disable Field' : 'Enable Field'}
              onClick={() => act('toggle_field')} />
          </Box>

          <Box mt={1} style={{ color: C.amber, fontSize: '11px' }}>
            Always wear safety gear and consult a field manual before operation.
          </Box>
        </Box>
      </Window.Content>
    </Window>
  );
};
