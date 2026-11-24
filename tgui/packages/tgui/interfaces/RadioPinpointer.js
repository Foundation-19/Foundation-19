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

export const RadioPinpointer = (props, context) => {
  const { act, data } = useBackend(context);
  const { active, freq } = data;

  return (
    <Window width={340} height={220}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>RADIO FREQUENCY TRACKER</Box>
          </Box>

          <Section title="Tracking" style={{ border: '1px solid ' + C.border }}>
            <Box>
              <Box inline style={{ color: C.textDim }}>Status: </Box>
              {active ? 'Enabled' : 'Disabled'}
            </Box>
            <Box mt={1}>
              <Button inline icon="power-off" content="Toggle Tracking" onClick={() => act('toggle')} />
            </Box>
            <Box mt={1}>
              <Button inline icon="undo" content="Reset Tracker" onClick={() => act('reset_tracking')} />
            </Box>
          </Section>

          <Section title="Frequency" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
            <Box>
              <Button inline mr={0.5} content="-10" onClick={() => act('freq', { amount: -10 })} />
              <Button inline mr={0.5} content="-2" onClick={() => act('freq', { amount: -2 })} />
              <Box inline style={{ color: C.amber, fontWeight: 'bold', padding: '0 6px' }}>{freq}</Box>
              <Button inline mr={0.5} content="+2" onClick={() => act('freq', { amount: 2 })} />
              <Button inline content="+10" onClick={() => act('freq', { amount: 10 })} />
            </Box>
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
