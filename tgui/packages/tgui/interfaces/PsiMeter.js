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

export const PsiMeter = (props, context) => {
  const { act, data } = useBackend(context);
  const { has_assay, assay_html, assayed_name, candidates = [] } = data;

  return (
    <Window width={420} height={500}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>TELESTO MARK I PSI-METER</Box>
          </Box>

          {has_assay ? (
            <>
              <Section title="Assay Results" style={{ border: '1px solid ' + C.border }}>
                {assayed_name ? (
                  <Box mb={1} style={{ color: C.textDim }}>Subject: {assayed_name}</Box>
                ) : null}
                <Box dangerouslySetInnerHTML={{ __html: assay_html || '' }} />
              </Section>
              <Box mt={1}>
                <Button inline mr={0.5} icon="print" content="Print" onClick={() => act('print')} />
                <Button inline mr={0.5} icon="trash" content="Clear Buffer" onClick={() => act('clear')} />
              </Box>
            </>
          ) : (
            <Section title="Candidates" style={{ border: '1px solid ' + C.border }}>
              {candidates.length === 0 ? (
                <Box style={{ color: C.textDim }}>No candidates found.</Box>
              ) : (
                candidates.map((candidate, i) => (
                  <Box key={i} mb={0.5}>
                    <Box inline>{candidate.name}</Box>
                    <Button
                      inline
                      ml={1}
                      content="Conduct Assay"
                      onClick={() => act('assay', { ref: candidate.ref })} />
                  </Box>
                ))
              )}
            </Section>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
