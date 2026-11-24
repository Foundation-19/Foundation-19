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

export const HandScanner = (props, context) => {
  const { act, data } = useBackend(context);
  const { scan_title, scan_data, width, height } = data;

  return (
    <Window width={width || 450} height={height || 600}>
      <Window.Content scrollable>
        <Box
          style={{
            background: C.bg,
            minHeight: '100%',
            padding: '10px',
            fontFamily: C.mono,
            color: C.text,
          }}>
          <Box
            style={{
              borderBottom: '2px solid ' + C.border,
              paddingBottom: '6px',
              marginBottom: '10px',
            }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>
              {scan_title || 'HANDHELD SCANNER'}
            </Box>
          </Box>

          <Box mb={1}>
            <Button inline mr={0.5} icon="print" content="Print Report" onClick={() => act('print')} />
            <Button inline icon="trash" content="Clear Data" onClick={() => act('clear')} />
          </Box>

          <Section style={{ border: '1px solid ' + C.border }}>
            {scan_data ? (
              <Box style={{ whiteSpace: 'pre-wrap', color: C.text }}>{scan_data}</Box>
            ) : (
              <Box style={{ color: C.textDim }}>No scan data.</Box>
            )}
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
