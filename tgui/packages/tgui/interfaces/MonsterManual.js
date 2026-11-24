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

export const MonsterManual = (props, context) => {
  const { act, data } = useBackend(context);
  const { temp, uses, monsters = [] } = data;

  return (
    <Window width={480} height={480}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>MONSTER MANUAL</Box>
          </Box>

          {temp ? (
            <Section style={{ border: '1px solid ' + C.border }}>
              <Box>{temp}</Box>
              <Box mt={1}>
                <Button inline content="Return" onClick={() => act('return')} />
              </Box>
            </Section>
          ) : (
            <>
              <Box mb={1} style={{ color: C.textDim }}>You have {uses} uses left.</Box>
              <Section title="Familiars" style={{ border: '1px solid ' + C.border }}>
                {monsters.map((monster, i) => (
                  <Box key={i} mb={1}>
                    <Button
                      inline
                      content={monster.name}
                      onClick={() => act('summon', { path: monster.path })} />
                    <Box inline ml={1} style={{ color: C.textDim }}>- {monster.info}</Box>
                  </Box>
                ))}
              </Section>
            </>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
