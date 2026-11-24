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

export const ArtifactAnalyser = (props, context) => {
  const { act, data } = useBackend(context);
  const { has_scanner, scan_in_progress } = data;

  return (
    <Window width={360} height={300}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>ANOMALY ANALYSER</Box>
          </Box>

          {!has_scanner ? (
            <Box style={{ color: '#c0392b' }}>Unable to locate analysis pad.</Box>
          ) : scan_in_progress ? (
            <Section title="Scanning" style={{ border: '1px solid ' + C.border }}>
              <Box style={{ color: C.amber }}>Please wait. Analysis in progress.</Box>
              <Box mt={1}>
                <Button inline content="Halt Scanning" onClick={() => act('halt_scan')} />
              </Box>
            </Section>
          ) : (
            <Section title="Scanner" style={{ border: '1px solid ' + C.border }}>
              <Box style={{ color: C.text }}>Scanner is ready.</Box>
              <Box mt={1}>
                <Button inline icon="search" content="Begin Scanning" onClick={() => act('begin_scan')} />
              </Box>
            </Section>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
