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

export const RPD = (props, context) => {
  const { act, data } = useBackend(context);
  const { categories = [], pipe_color, colors = [] } = data;

  return (
    <Window width={380} height={600}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.borderRed, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>RAPID PIPING DEVICE</Box>
          </Box>

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

          {categories.map((category, ci) => (
            <Section
              key={ci}
              title={category.name}
              style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
              {(category.pipes || []).map((pipe, pi) => (
                <Button
                  key={pi}
                  inline
                  mr={0.5}
                  mb={0.5}
                  content={pipe.name}
                  selected={pipe.selected}
                  onClick={() => act('set_buildtype', { pipe: pipe.ref })} />
              ))}
            </Section>
          ))}
        </Box>
      </Window.Content>
    </Window>
  );
};
