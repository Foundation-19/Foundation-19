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

export const ScryingOrb = (props, context) => {
  const { act, data } = useBackend(context);
  const { types = [] } = data;

  return (
    <Window width={460} height={480}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>SUMMONING STONE</Box>
          </Box>

          <Box mb={1} style={{ color: C.textDim }}>Choose a companion to help you.</Box>

          <Section title="Companions" style={{ border: '1px solid ' + C.border }}>
            {types.map((type, i) => (
              <Box key={i} mb={1}>
                <Button
                  inline
                  content={type.name}
                  onClick={() => act('type', { path: type.path })} />
                <Box mt={0.5} style={{ color: C.textDim }}>{type.desc}</Box>
              </Box>
            ))}
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
