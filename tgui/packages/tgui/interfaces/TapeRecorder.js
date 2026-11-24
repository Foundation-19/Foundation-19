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

export const TapeRecorder = (props, context) => {
  const { act, data } = useBackend(context);
  const { entries = [] } = data;

  return (
    <Window width={220} height={600}>
      <Window.Content scrollable>
        <Box
          style={{
            background: C.bg,
            minHeight: '100%',
            padding: '10px',
            fontFamily: C.mono,
            color: C.text,
            textAlign: 'center',
          }}>
          <Box
            style={{
              borderBottom: '2px solid ' + C.border,
              paddingBottom: '6px',
              marginBottom: '10px',
            }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>
              CUTTING TAPE
            </Box>
          </Box>

          <Section style={{ border: '1px solid ' + C.border }}>
            {entries.length === 0 ? (
              <Box style={{ color: C.textDim }}>There's nothing on this tape!</Box>
            ) : (
              entries.map((entry) => (
                <Box key={entry.index} mb={1}>
                  <Box style={{ color: C.text }}>[{entry.time}]</Box>
                  <Button
                    inline
                    content="-----CUT------"
                    onClick={() => act('cut_after', { index: entry.index })}
                  />
                </Box>
              ))
            )}
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
