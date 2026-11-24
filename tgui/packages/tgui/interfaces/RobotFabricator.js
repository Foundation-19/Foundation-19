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

const PARTS = [
  { type: 1, name: 'Left Arm', cost: 25000 },
  { type: 2, name: 'Right Arm', cost: 25000 },
  { type: 3, name: 'Left Leg', cost: 25000 },
  { type: 4, name: 'Right Leg', cost: 25000 },
  { type: 5, name: 'Chest', cost: 50000 },
  { type: 6, name: 'Head', cost: 50000 },
  { type: 7, name: 'Robot Frame', cost: 75000 },
];

export const RobotFabricator = (props, context) => {
  const { act, data } = useBackend(context);
  const { operating, metal_amount, building } = data;

  return (
    <Window width={380} height={480}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.borderRed, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>ROBOTIC FABRICATOR</Box>
          </Box>

          {operating ? (
            <Section title="Building" style={{ border: '1px solid ' + C.border }}>
              <Box>Building {building}.</Box>
              <Box style={{ color: C.textDim }}>Please wait until completion...</Box>
            </Section>
          ) : (
            <>
              <Section title="Metal Storage" style={{ border: '1px solid ' + C.border }}>
                <Box>
                  <Box inline mr={1}>Metal Amount:</Box>
                  {metal_amount} cm3 (MAX: 150,000)
                </Box>
              </Section>

              <Section title="Production" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
                {PARTS.map((part) => (
                  <Box key={part.type} mb={0.5}>
                    <Button
                      inline
                      mr={1}
                      content={part.name}
                      disabled={metal_amount < part.cost}
                      onClick={() => act('make', { part: part.type })} />
                    <Box inline style={{ color: C.textDim }}>
                      ({part.cost.toLocaleString()} cc metal)
                    </Box>
                  </Box>
                ))}
              </Section>
            </>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
