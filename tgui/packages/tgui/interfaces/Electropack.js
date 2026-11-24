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

export const Electropack = (props, context) => {
  const { act, data } = useBackend(context);
  const { on, frequency, code } = data;

  return (
    <Window width={320} height={220}>
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
              ELECTROPACK
            </Box>
          </Box>

          <Section style={{ border: '1px solid ' + C.border }}>
            <Button
              fluid
              color={on ? 'red' : 'green'}
              icon="power-off"
              content={on ? 'Turn Off' : 'Turn On'}
              onClick={() => act('toggle_power')}
            />
          </Section>

          <Section title="Frequency / Code" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
            <LabeledList>
              <LabeledList.Item label="Frequency">
                <Button inline mr={0.5} content="-" onClick={() => act('set_freq', { value: -10 })} />
                <Button inline mr={0.5} content="-" onClick={() => act('set_freq', { value: -2 })} />
                <Box inline mr={0.5} style={{ color: C.amber }}>
                  {frequency}
                </Box>
                <Button inline mr={0.5} content="+" onClick={() => act('set_freq', { value: 2 })} />
                <Button inline content="+" onClick={() => act('set_freq', { value: 10 })} />
              </LabeledList.Item>
              <LabeledList.Item label="Code">
                <Button inline mr={0.5} content="-" onClick={() => act('set_code', { value: -5 })} />
                <Button inline mr={0.5} content="-" onClick={() => act('set_code', { value: -1 })} />
                <Box inline mr={0.5} style={{ color: C.amber }}>
                  {code}
                </Box>
                <Button inline mr={0.5} content="+" onClick={() => act('set_code', { value: 1 })} />
                <Button inline content="+" onClick={() => act('set_code', { value: 5 })} />
              </LabeledList.Item>
            </LabeledList>
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
