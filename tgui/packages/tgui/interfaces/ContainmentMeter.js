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

export const ContainmentMeter = (props, context) => {
  const { data } = useBackend(context);
  const { scps = [], show_detailed } = data;

  return (
    <Window width={420} height={480}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>
              SCP CONTAINMENT STATUS
            </Box>
          </Box>

          <Section title="Overview" style={{ border: '1px solid ' + C.border }}>
            {scps.length === 0 ? (
              <Box style={{ color: C.textDim }}>No SCP data available.</Box>
            ) : (
              <Box>
                {scps.map((scp) => (
                  <Box key={scp.designation} mb={0.5}>
                    <Box inline style={{ color: scp.status_color }}>
                      SCP-{scp.designation} ({scp.classification}) - {scp.status}
                    </Box>
                    {show_detailed ? (
                      <Box inline style={{ color: C.textDim }}>
                        {' | Research: '}
                        {scp.research}
                        {' | Rating: '}
                        {scp.rating}
                        {' | Breaches: '}
                        {scp.breaches}
                      </Box>
                    ) : null}
                  </Box>
                ))}
              </Box>
            )}
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
