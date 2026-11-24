import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
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

const DIGITS = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

export const Safe = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    open,
    dial,
    dial_input,
    items = [],
  } = data;

  return (
    <Window width={350} height={520}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.borderRed, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>SAFE</Box>
          </Box>

          <Section title="Dial" style={{ border: '1px solid ' + C.border }}>
            <Box style={{ color: C.amber, fontSize: '22px', marginBottom: '6px' }}>{dial}</Box>
            <Button inline mr={0.5} content="-" onClick={() => act('decrement')} />
            <Button inline mr={0.5} content="+" onClick={() => act('increment')} />
            <Button
              inline
              color={open ? 'caution' : undefined}
              content={open ? 'Close' : 'Open'}
              onClick={() => act('open')} />
            <Box mt={1} style={{ color: C.textDim }}>
              ENTERED: {dial_input || '—'}
            </Box>
            <Box mt={1}>
              {DIGITS.map((digit) => (
                <Button
                  key={digit}
                  inline
                  mr={0.5}
                  mb={0.5}
                  content={String(digit)}
                  onClick={() => act('dial', { digit: digit })} />
              ))}
            </Box>
            <Box>
              <Button inline mr={0.5} content="Clear" onClick={() => act('clear')} />
              <Button inline mr={0.5} color="caution" content="Try" onClick={() => act('try')} />
            </Box>
          </Section>

          <Section title="Contents" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
            {!open ? (
              <Box style={{ color: C.textDim }}>The safe is closed.</Box>
            ) : items.length === 0 ? (
              <Box style={{ color: C.textDim }}>The safe is empty.</Box>
            ) : (
              <LabeledList>
                {items.map((item, i) => (
                  <LabeledList.Item key={i} label={item.name}>
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
