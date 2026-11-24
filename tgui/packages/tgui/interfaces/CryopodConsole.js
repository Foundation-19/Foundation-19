import { useBackend } from '../backend';
import { Box, Button, Section } from '../components';
import { Window } from '../layouts';

const C = {
  bg: '#0a0a0c',
  panel: '#111114',
  border: '#2a2a30',
  borderRed: '#6b0000',
  amber: '#c2960e',
  text: '#c8c8c8',
  textDim: '#7a7a80',
  mono: 'Consolas, monospace',
};

export const CryopodConsole = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    storage_name,
    storage_type,
    allow_items,
    user_name,
    view_mode,
    frozen_crew = [],
    frozen_items = [],
  } = data;

  return (
    <Window width={400} height={480}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.borderRed, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>CRYOPOD CONSOLE</Box>
          </Box>

          {view_mode === 'log' ? (
            <Section title={'Recently stored ' + storage_type} style={{ border: '1px solid ' + C.border }}>
              {frozen_crew.length === 0 ? (
                <Box style={{ color: C.textDim }}>No records.</Box>
              ) : (
                frozen_crew.map((person, i) => (
                  <Box key={i}>{person}</Box>
                ))
              )}
              <Box mt={1}>
                <Button content="Back" onClick={() => act('back')} />
              </Box>
            </Section>
          ) : view_mode === 'view' ? (
            <Section title="Recently stored objects" style={{ border: '1px solid ' + C.border }}>
              {frozen_items.length === 0 ? (
                <Box style={{ color: C.textDim }}>No stored objects.</Box>
              ) : (
                frozen_items.map((item) => (
                  <Box key={item.ref}>{item.name}</Box>
                ))
              )}
              <Box mt={1}>
                <Button content="Back" onClick={() => act('back')} />
              </Box>
            </Section>
          ) : view_mode === 'recover' ? (
            <Section title="Object Recovery" style={{ border: '1px solid ' + C.border }}>
              {frozen_items.length === 0 ? (
                <Box style={{ color: C.textDim }}>There is nothing to recover from storage.</Box>
              ) : (
                frozen_items.map((item) => (
                  <Box key={item.ref} mb={0.5}>
                    <Box inline mr={1}>{item.name}</Box>
                    <Button
                      inline
                      content="Recover"
                      onClick={() => act('recover', { item: item.ref })} />
                  </Box>
                ))
              )}
              <Box mt={1}>
                <Button content="Back" onClick={() => act('back')} />
              </Box>
            </Section>
          ) : (
            <>
              <Section style={{ border: '1px solid ' + C.border }}>
                <Box style={{ color: C.amber }}>{storage_name}</Box>
                <Box style={{ color: C.textDim }}>Welcome, {user_name}.</Box>
              </Section>

              <Section title="Functions" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
                <Box mb={0.5}>
                  <Button content="View storage log" onClick={() => act('log')} />
                </Box>
                {allow_items ? (
                  <>
                    <Box mb={0.5}>
                      <Button content="View objects" onClick={() => act('view')} />
                    </Box>
                    <Box mb={0.5}>
                      <Button content="Recover object" onClick={() => act('item')} />
                    </Box>
                    <Box mb={0.5}>
                      <Button content="Recover all objects" onClick={() => act('allitems')} />
                    </Box>
                  </>
                ) : null}
              </Section>
            </>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
