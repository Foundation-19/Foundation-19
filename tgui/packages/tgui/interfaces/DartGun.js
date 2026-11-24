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

export const DartGun = (props, context) => {
  const { act, data } = useBackend(context);
  const { beakers = [], has_magazine, magazine_rounds } = data;

  return (
    <Window width={360} height={480}>
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
              DART GUN MIXING CONTROL
            </Box>
          </Box>

          {beakers.length === 0 ? (
            <Section title="Beakers" style={{ border: '1px solid ' + C.border }}>
              <Box style={{ color: C.textDim }}>There are no beakers inserted.</Box>
            </Section>
          ) : (
            beakers.map((beaker) => (
              <Section
                key={beaker.index}
                title={'Beaker ' + beaker.index}
                style={{ border: '1px solid ' + C.border, marginBottom: '8px' }}>
                {beaker.reagents.length === 0 ? (
                  <Box style={{ color: C.textDim }}>Nothing.</Box>
                ) : (
                  <LabeledList>
                    {beaker.reagents.map((reagent, j) => (
                      <LabeledList.Item key={j} label={reagent.name}>
                        {reagent.volume}u
                      </LabeledList.Item>
                    ))}
                  </LabeledList>
                )}
                <Box mt={1}>
                  <Button
                    inline
                    mr={0.5}
                    color={beaker.mixing ? 'green' : 'red'}
                    icon="flask"
                    content={beaker.mixing ? 'Mixing' : 'Not Mixing'}
                    onClick={() =>
                      act(beaker.mixing ? 'stop_mix' : 'mix', { index: beaker.index })
                    }
                  />
                  <Button
                    inline
                    icon="eject"
                    content="Eject"
                    onClick={() => act('eject', { index: beaker.index })}
                  />
                </Box>
              </Section>
            ))
          )}

          <Section title="Dart Cartridge" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
            {has_magazine ? (
              <Box>
                <Box style={{ color: magazine_rounds ? C.text : '#c0392b' }}>
                  {magazine_rounds
                    ? 'The dart cartridge has ' + magazine_rounds + ' shots remaining.'
                    : 'The dart cartridge is empty!'}
                </Box>
                <Button
                  mt={1}
                  icon="eject"
                  content="Eject Cartridge"
                  onClick={() => act('eject_cart')}
                />
              </Box>
            ) : (
              <Box style={{ color: C.textDim }}>No cartridge inserted.</Box>
            )}
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
