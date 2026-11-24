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

export const CircuitPrinter = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    debug,
    upgraded,
    can_clone,
    fast_clone,
    cloning,
    has_program,
    current_category,
    allow_ic_printing,
    materials = [],
    categories = [],
    circuits = [],
  } = data;

  const can_print = allow_ic_printing || debug;

  return (
    <Window width={640} height={600}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>INTEGRATED CIRCUIT PRINTER</Box>
          </Box>

          {debug ? (
            <Box mb={1} style={{ color: C.amber }}>DEBUG PRINTER -- Infinite materials. Cloning available.</Box>
          ) : (
            <Section title="Materials" style={{ border: '1px solid ' + C.border }}>
              <LabeledList>
                {materials.map((material, i) => (
                  <LabeledList.Item key={i} label={material.name}>
                    {material.amount}/{material.max}
                  </LabeledList.Item>
                ))}
              </LabeledList>
            </Section>
          )}

          <Box mt={1} style={{ color: C.textDim }}>
            {can_print ? (
              <Box>Assembly cloning: {can_clone ? (fast_clone ? 'Instant' : 'Available') : 'Unavailable'}.</Box>
            ) : null}
            <Box>Circuits available: {upgraded || debug ? 'Advanced' : 'Regular'}.</Box>
            {!upgraded ? (
              <Box>Crossed out circuits mean that the printer is not sufficiently upgraded to create that circuit.</Box>
            ) : null}
          </Box>

          {can_print ? (
            <Section title="Assembly" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
              <Box>
                {!cloning ? (
                  <Button
                    inline
                    mr={0.5}
                    content="Load Program"
                    onClick={() => act('print', { mode: 'load' })} />
                ) : null}
                {!has_program ? (
                  <Button
                    inline
                    mr={0.5}
                    disabled
                    content={(fast_clone ? 'Print' : 'Begin Printing') + ' Assembly'} />
                ) : cloning ? (
                  <Button
                    inline
                    mr={0.5}
                    content="Cancel Print"
                    onClick={() => act('print', { mode: 'cancel' })} />
                ) : (
                  <Button
                    inline
                    mr={0.5}
                    content={(fast_clone ? 'Print' : 'Begin Printing') + ' Assembly'}
                    onClick={() => act('print', { mode: 'print' })} />
                )}
              </Box>
            </Section>
          ) : null}

          <Section title="Categories" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
            {categories.map((category, i) => (
              <Button
                key={i}
                inline
                mr={0.5}
                content={category}
                disabled={category === current_category}
                onClick={() => act('category', { category: category })} />
            ))}
          </Section>

          <Section title={current_category} style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
            {circuits.map((circuit, i) => (
              <Box key={i} mb={0.5}>
                {circuit.can_build ? (
                  <Button
                    inline
                    content={'[' + circuit.name + ']'}
                    onClick={() => act('build', { path: circuit.path })} />
                ) : (
                  <Box
                    inline
                    style={{ color: C.textDim, textDecoration: 'line-through' }}>
                    {'[' + circuit.name + ']'}
                  </Box>
                )}
                <Box inline ml={1} style={{ color: C.textDim }}>{circuit.desc}</Box>
              </Box>
            ))}
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
