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

export const Telemonitor = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    screen,
    network,
    temp,
    machines = [],
    selected,
    links = [],
  } = data;

  return (
    <Window width={575} height={400}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>TELECOMMUNICATIONS MONITOR</Box>
          </Box>

          {temp ? <Box mb={1} dangerouslySetInnerHTML={{ __html: temp }} /> : null}

          <Section title="Network" style={{ border: '1px solid ' + C.border, background: C.panel }}>
            Current Network:{' '}
            <Button inline icon="edit" content={network || 'NULL'} onClick={() => act('network')} />
          </Section>

          {screen === 0 ? (
            <Section title="Detected Network Entities" style={{ border: '1px solid ' + C.border, background: C.panel, marginTop: '8px' }}>
              {machines.length === 0 ? (
                <Button icon="search" content="Probe Network" onClick={() => act('operation', { operation: 'probe' })} />
              ) : (
                <Box>
                  {machines.map((machine, i) => (
                    <Box key={i} mb={0.5}>
                      <Button
                        inline
                        icon="desktop"
                        content={machine.name + ' (' + machine.id + ')'}
                        onClick={() => act('viewmachine', { id: machine.id })} />
                    </Box>
                  ))}
                  <Box mt={1}>
                    <Button icon="trash" content="Flush Buffer" onClick={() => act('operation', { operation: 'release' })} />
                  </Box>
                </Box>
              )}
            </Section>
          ) : (
            <Section title="Selected Network Entity" style={{ border: '1px solid ' + C.border, background: C.panel, marginTop: '8px' }}>
              <Button inline icon="arrow-left" content="Main Menu" mr={1} onClick={() => act('operation', { operation: 'mainmenu' })} />
              <Box mt={1}>
                Selected: {selected ? selected.name + ' (' + selected.id + ')' : 'None'}
              </Box>
              <Box mt={1} style={{ color: C.textDim }}>Linked Entities:</Box>
              {links.length === 0 ? (
                <Box style={{ color: C.textDim }}>None.</Box>
              ) : (
                links.map((machine, i) => (
                  <Box key={i} mb={0.5}>
                    <Button
                      inline
                      icon="desktop"
                      content={machine.name + ' (' + machine.id + ')'}
                      onClick={() => act('viewmachine', { id: machine.id })} />
                  </Box>
                ))
              )}
            </Section>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
