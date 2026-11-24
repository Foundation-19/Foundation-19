import { useBackend } from '../backend';
import { Box, Button, Section } from '../components';
import { Window } from '../layouts';

const C = {
  bg: '#0a0a0c',
  panel: '#111114',
  border: '#2a2a30',
  borderRed: '#6b0000',
  amber: '#c2960e',
  text: '#c8c8c8',
  textDim: '#7a7a80',
  mono: 'Consolas, monospace',
};

export const ShipReconnect = (props, context) => {
  const { act, data } = useBackend(context);
  const { flavor = 'the vessel' } = data;

  return (
    <Window width={340} height={200}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.borderRed, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>CONNECTION ERROR</Box>
          </Box>
          <Section title="Connection Lost" style={{ border: '1px solid ' + C.border }}>
            <Box style={{ color: '#cc2222', fontWeight: 'bold' }}>Unable to connect to {flavor}.</Box>
            <Box mt={1}>
              <Button inline icon="sync" content="Reconnect" color="good" onClick={() => act('sync')} />
            </Box>
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
