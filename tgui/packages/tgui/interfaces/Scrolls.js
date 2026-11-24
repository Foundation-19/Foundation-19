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

export const Scrolls = (props, context) => {
  const { act, data } = useBackend(context);
  const { uses } = data;

  return (
    <Window width={340} height={280}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>SCROLL OF TELEPORTATION</Box>
          </Box>

          <Section title="Usage" style={{ border: '1px solid ' + C.border }}>
            <Box>
              Number of uses:{' '}
              <Box inline style={{ color: C.amber }}>{uses}</Box>
            </Box>
          </Section>

          <Section title="Invocation" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
            <Box>Four uses, use them wisely:</Box>
            <Box mt={1}>
              <Button
                inline
                icon="bolt"
                content="Teleport"
                onClick={() => act('spell_teleport')} />
            </Box>
          </Section>

          <Section style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
            <Box>Kind regards,</Box>
            <Box style={{ color: C.amber }}>Wizards Federation</Box>
            <Box mt={1} style={{ color: C.textDim }}>
              P.S. Don't forget to bring your gear, you'll need it to cast most spells.
            </Box>
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
