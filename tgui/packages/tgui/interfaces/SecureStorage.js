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

const KEYS = [
  ['1', '2', '3'],
  ['4', '5', '6'],
  ['7', '8', '9'],
  ['R', '0', 'E'],
];

export const SecureStorage = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    name,
    locked,
    code,
    needs_code,
    emagged,
    setshort,
  } = data;

  return (
    <Window width={320} height={300}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>{name || 'SECURE STORAGE'}</Box>
          </Box>

          <Section title="Lock Status" style={{ border: '1px solid ' + C.border }}>
            <Box>
              State:{' '}
              <Box inline style={{ color: locked ? '#cc2222' : '#55cc55' }}>
                {locked ? 'LOCKED' : 'UNLOCKED'}
              </Box>
            </Box>
            {needs_code ? (
              <Box mt={1} style={{ color: C.amber }}>5-DIGIT PASSCODE NOT SET. ENTER NEW PASSCODE.</Box>
            ) : null}
            {emagged ? (
              <Box mt={1} style={{ color: '#cc2222' }}>LOCKING SYSTEM ERROR - 1701</Box>
            ) : null}
            {setshort ? (
              <Box mt={1} style={{ color: '#cc2222' }}>ALERT: MEMORY SYSTEM ERROR - 6040 201</Box>
            ) : null}
            <Box mt={1} style={{ color: C.amber, fontSize: '20px', letterSpacing: '0.2em' }}>{code || ''}</Box>
          </Section>

          <Section title="Keypad" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
            {KEYS.map((row, i) => (
              <Box key={i} mb={0.5}>
                {row.map((key) => (
                  <Button
                    key={key}
                    inline
                    mr={0.5}
                    content={key}
                    onClick={() => act('type', { type: key })} />
                ))}
              </Box>
            ))}
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
