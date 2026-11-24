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

export const Stove = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    operable,
    cooking,
    cook_time,
    items = [],
    reagents = [],
  } = data;

  return (
    <Window width={420} height={540}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>STOVE CONTROLS</Box>
          </Box>

          {!operable ? (
            <Section style={{ border: '1px solid ' + C.border }}>
              <Box style={{ color: '#cc5555' }}>The stove is in no condition to operate.</Box>
            </Section>
          ) : cooking ? (
            <Section title="Cooking" style={{ border: '1px solid ' + C.border }}>
              <Box style={{ color: C.amber }}>Contents are cooking. Please wait...</Box>
            </Section>
          ) : (
            <>
              <Box mb={1}>
                <Button
                  inline
                  mr={0.5}
                  content="Empty Ingredients"
                  onClick={() => act('empty_stove')} />
                <Button
                  inline
                  mr={0.5}
                  content="Start"
                  onClick={() => act('start_cooking')} />
              </Box>
              <Box mb={1} style={{ color: C.textDim }}>
                Cooking time for you: {cook_time} seconds.
              </Box>
              <Section title="Contents" style={{ border: '1px solid ' + C.border }}>
                {items.length === 0 ? (
                  <Box style={{ color: '#cc5555' }}>No ingredients!</Box>
                ) : (
                  items.map((line, i) => <Box key={i}>{line}</Box>)
                )}
              </Section>
              {reagents.length > 0 && (
                <Section title="Reagents" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
                  {reagents.map((reagent, i) => (
                    <Box key={i}>{reagent.volume} units of {reagent.name}</Box>
                  ))}
                </Section>
              )}
            </>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
