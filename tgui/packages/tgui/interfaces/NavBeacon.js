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

export const NavBeacon = (props, context) => {
  const { act, data } = useBackend(context);
  const { open, locked, ai, location, codes = [] } = data;
  const editable = open && !locked;

  return (
    <Window width={360} height={420}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>NAVIGATION BEACON</Box>
          </Box>

          <Box mb={1} style={{ color: C.textDim }}>
            {locked && !ai ? '(swipe card to unlock controls)' : '(swipe card to lock controls)'}
          </Box>

          <Box mb={1}>
            Location:{' '}
            {editable ? (
              <Button inline icon="edit" content={location || '(none)'} onClick={() => act('locedit')} />
            ) : (
              <Box inline>{location || '(none)'}</Box>
            )}
          </Box>

          <Section title="Transponder Codes" style={{ border: '1px solid ' + C.border, background: C.panel }}>
            {codes.length === 0 ? (
              <Box style={{ color: C.textDim }}>None.</Box>
            ) : (
              codes.map((code, i) => (
                <Box key={i} mb={0.5}>
                  {code.key} ... {code.value}
                  {editable ? (
                    <Box inline ml={1}>
                      <Button inline icon="edit" content="Edit" mr={0.5} onClick={() => act('edit', { code: code.key })} />
                      <Button inline icon="trash" color="red" content="Delete" onClick={() => act('delete', { code: code.key })} />
                    </Box>
                  ) : null}
                </Box>
              ))
            )}
            {editable ? (
              <Box mt={1}>
                <Button icon="plus" content="Add New" onClick={() => act('add')} />
              </Box>
            ) : null}
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
