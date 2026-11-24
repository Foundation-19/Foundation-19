import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
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

export const Microwave = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    broken,
    operating,
    dirty,
    ingredients = [],
  } = data;

  return (
    <Window width={360} height={480}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>MICROWAVE CONTROLS</Box>
          </Box>

          {broken ? (
            <Section style={{ border: '1px solid ' + C.border }}>
              <Box style={{ color: '#cc5555' }}>
                This microwave is very broken. It must be fixed before it can be used again.
              </Box>
            </Section>
          ) : operating ? (
            <Section title="Microwaving" style={{ border: '1px solid ' + C.border }}>
              <Box style={{ color: C.amber }}>Microwaving in progress!</Box>
              <Box style={{ color: C.textDim }}>Please wait...</Box>
            </Section>
          ) : dirty ? (
            <Section style={{ border: '1px solid ' + C.border }}>
              <Box style={{ color: '#cc5555' }}>
                This microwave is covered in muck. It must be wiped down or cleaned out before it can be used again.
              </Box>
            </Section>
          ) : (
            <>
              <Section title="Ingredients" style={{ border: '1px solid ' + C.border }}>
                {ingredients.length === 0 ? (
                  <Box style={{ color: C.textDim }}>The microwave is empty.</Box>
                ) : (
                  <LabeledList>
                    {ingredients.map((item, i) => (
                      <LabeledList.Item key={i} label={item.name}>
                        {item.count} {item.unit}
                      </LabeledList.Item>
                    ))}
                  </LabeledList>
                )}
              </Section>
              <Box mt={1}>
                <Button
                  inline
                  mr={0.5}
                  content="Turn on!"
                  onClick={() => act('cook')} />
                <Button
                  inline
                  mr={0.5}
                  content="Eject ingredients!"
                  onClick={() => act('dispose')} />
              </Box>
            </>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
