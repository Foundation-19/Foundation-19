import { useBackend } from '../backend';
import { Box, Section } from '../components';
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

export const OperatingConsole = (props, context) => {
  const { data } = useBackend(context);
  const { has_patient, patient, scan } = data;
  const scanHtml = Array.isArray(scan) ? scan.join('') : (scan || '');

  return (
    <Window width={520} height={520}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.amber, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>
              PATIENT MONITORING
            </Box>
          </Box>

          <Section title="Patient Information" style={{ border: '1px solid ' + C.border }}>
            {has_patient ? (
              <>
                <Box mb={1} style={{ color: C.amber }}>{patient}</Box>
                <Box dangerouslySetInnerHTML={{ __html: scanHtml }} />
              </>
            ) : (
              <Box style={{ color: C.textDim }}>No Patient Detected</Box>
            )}
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
