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

export const TankDispenser = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    oxygentanks = 0,
    phorontanks = 0,
  } = data;

  return (
    <Window width={350} height={240}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.borderRed, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>TANK STORAGE UNIT</Box>
          </Box>

          <Section title="Oxygen Tanks" style={{ border: '1px solid ' + C.border }}>
            <Box>Stored: {oxygentanks}</Box>
            <Button
              mt={1}
              icon="eject"
              content="Dispense"
              disabled={!oxygentanks}
              onClick={() => act('oxygen')} />
          </Section>

          <Section title="Phoron Tanks" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
            <Box>Stored: {phorontanks}</Box>
            <Button
              mt={1}
              icon="eject"
              content="Dispense"
              disabled={!phorontanks}
              onClick={() => act('phoron')} />
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
