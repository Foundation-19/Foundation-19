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

export const UnderWardrobe = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    quota = 0,
    categories = [],
  } = data;

  return (
    <Window width={400} height={320}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.borderRed, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>UNDERWEAR WARDROBE</Box>
          </Box>

          <Section title="Underwear" style={{ border: '1px solid ' + C.border }}>
            <Box>
              You may claim {quota} more article{quota === 1 ? '' : 's'} this shift.
            </Box>
          </Section>

          <Section title="Available Categories" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
            {categories.length === 0 ? (
              <Box style={{ color: C.textDim }}>No categories available.</Box>
            ) : (
              categories.map((category, i) => (
                <Box key={i} mb={0.5}>
                  <Button
                    inline
                    mr={0.5}
                    content="Select"
                    onClick={() => act('select_underwear', { category: category.name })} />
                  {category.name}
                </Box>
              ))
            )}
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
