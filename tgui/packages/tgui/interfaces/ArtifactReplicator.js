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

export const ArtifactReplicator = (props, context) => {
  const { act, data } = useBackend(context);
  const { construction = [] } = data;

  return (
    <Window width={380} height={480}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>ALIEN MACHINE</Box>
          </Box>

          <Box mb={1} style={{ color: C.textDim }}>
            The control panel displays an incomprehensible selection of controls, many with unusual
            markings or text around them.
          </Box>

          <Section title="Controls" style={{ border: '1px solid ' + C.border }}>
            {construction.length === 0 ? (
              <Box style={{ color: C.textDim }}>No controls available.</Box>
            ) : (
              <Box>
                {construction.map((entry) => (
                  <Box key={entry.index} mb={0.5}>
                    <Button
                      inline
                      content={'[' + entry.name + ']'}
                      onClick={() => act('activate', { index: entry.index })} />
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
