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

export const SCP216 = (props, context) => {
  const { act, data } = useBackend(context);
  const { open, current_code, items = [] } = data;

  return (
    <Window width={350} height={420}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>SCP-216</Box>
          </Box>

          <Box mb={1}>
            <Button
              inline
              mr={0.5}
              color={open ? 'caution' : undefined}
              content={open ? 'Close Safe' : 'Open Safe'}
              onClick={() => act('open')} />
            <Button inline content="Change Code" onClick={() => act('change_code')} />
          </Box>

          <Box mb={1} style={{ color: C.textDim }}>
            Current code: <Box inline style={{ color: C.amber }}>{current_code}</Box>
          </Box>

          <Section title="Contents" style={{ border: '1px solid ' + C.border }}>
            {!open ? (
              <Box style={{ color: C.textDim }}>The safe is closed.</Box>
            ) : items.length === 0 ? (
              <Box style={{ color: C.textDim }}>The safe is empty.</Box>
            ) : (
              <LabeledList>
                {items.map((item) => (
                  <LabeledList.Item key={item.ref} label={item.name}>
                    <Button
                      inline
                      icon="hand-paper"
                      content="Retrieve"
                      onClick={() => act('retrieve', { ref: item.ref })} />
                  </LabeledList.Item>
                ))}
              </LabeledList>
            )}
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
