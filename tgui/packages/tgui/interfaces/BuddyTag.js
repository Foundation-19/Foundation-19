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

export const BuddyTag = (props, context) => {
  const { act, data } = useBackend(context);
  const { on, id } = data;

  return (
    <Window width={290} height={200}>
      <Window.Content>
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
              BUDDY TAG
            </Box>
          </Box>

          <Section style={{ border: '1px solid ' + C.border }}>
            <LabeledList>
              <LabeledList.Item label="Status">
                <Button
                  inline
                  color={on ? 'green' : 'red'}
                  content={on ? 'Disable' : 'Enable'}
                  onClick={() => act('toggle')}
                />
              </LabeledList.Item>
              <LabeledList.Item label="ID">
                <Button inline content={id} onClick={() => act('setcode')} />
              </LabeledList.Item>
            </LabeledList>
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
