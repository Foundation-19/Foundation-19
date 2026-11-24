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

export const SlideProjector = (props, context) => {
  const { act, data } = useBackend(context);
  const { projecting, slides = [] } = data;

  return (
    <Window width={360} height={440}>
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
              SLIDE PROJECTOR
            </Box>
          </Box>

          <Section style={{ border: '1px solid ' + C.border }}>
            {projecting ? (
              <Button
                inline
                color="red"
                icon="power-off"
                content="Disable projector"
                onClick={() => act('stop_projector')}
              />
            ) : (
              <Box style={{ color: C.textDim }}>Projector inactive</Box>
            )}
          </Section>

          <Section title="Slides" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
            {slides.length === 0 ? (
              <Box style={{ color: C.textDim }}>No slides loaded.</Box>
            ) : (
              slides.map((slide) => (
                <Box key={slide.index} mb={1}>
                  <Box inline mr={1} style={{ color: C.textDim }}>
                    #{slide.index}
                  </Box>
                  <Box inline mr={1} style={{ color: slide.active ? C.amber : C.text }}>
                    {slide.name}
                  </Box>
                  {slide.active ? (
                    <Box inline style={{ color: C.amber }}>
                      SHOWING
                    </Box>
                  ) : (
                    <Button
                      inline
                      content="SHOW"
                      onClick={() => act('set_active', { index: slide.index })}
                    />
                  )}
                </Box>
              ))
            )}
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
