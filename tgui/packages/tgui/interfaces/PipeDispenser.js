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

export const PipeDispenser = (props, context) => {
  const { act, data } = useBackend(context);
  const { categories = [], has_colors, pipe_color, colors = [] } = data;

  return (
    <Window width={420} height={600}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.borderRed, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>PIPE DISPENSER</Box>
          </Box>

          {has_colors ? (
            <Section title="Pipe Color" style={{ border: '1px solid ' + C.border }}>
              {colors.map((color) => (
                <Button
                  key={color}
                  inline
                  mr={0.5}
                  mb={0.5}
                  content={color}
                  selected={pipe_color === color}
                  onClick={() => act('set_color', { color })} />
              ))}
            </Section>
          ) : null}

          {categories.map((category, ci) => (
            <Section
              key={ci}
              title={category.name}
              style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
              {(category.pipes || []).map((pipe) => (
                <Box key={pipe.ref} mb={0.5}>
                  <Box inline mr={1} style={{ minWidth: '180px', color: C.text }}>
                    {pipe.name}
                  </Box>
                  <Button
                    inline
                    mr={0.5}
                    content="1x"
                    onClick={() => act('build', { pipe: pipe.ref, amount: 1 })} />
                  <Button
                    inline
                    mr={0.5}
                    content="5x"
                    onClick={() => act('build', { pipe: pipe.ref, amount: 5 })} />
                  <Button
                    inline
                    content="10x"
                    onClick={() => act('build', { pipe: pipe.ref, amount: 10 })} />
                </Box>
              ))}
            </Section>
          ))}
        </Box>
      </Window.Content>
    </Window>
  );
};
