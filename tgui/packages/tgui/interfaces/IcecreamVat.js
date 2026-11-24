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

export const IcecreamVat = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    dispensing,
    products = [],
    reagents = [],
  } = data;

  const icecreams = products.filter((product) => !product.is_cone);
  const cones = products.filter((product) => product.is_cone);

  return (
    <Window width={520} height={600}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>ICECREAM VAT</Box>
          </Box>

          <Box mb={1} style={{ color: C.amber }}>Dispensing: {dispensing} icecream</Box>

          <Section title="Icecream" style={{ border: '1px solid ' + C.border }}>
            {icecreams.map((product) => (
              <Box key={product.id} mb={1}>
                <Box inline bold mr={1}>{product.name}</Box>
                <Box inline mr={1} style={{ color: C.textDim }}>
                  {product.count} {product.unit} left
                </Box>
                <Button
                  inline
                  mr={0.5}
                  content="Select"
                  onClick={() => act('select', { select: product.id })} />
                <Button
                  inline
                  mr={0.5}
                  content="Make"
                  onClick={() => act('make', { make: product.id, amount: 1 })} />
                <Button
                  inline
                  mr={0.5}
                  content="x5"
                  onClick={() => act('make', { make: product.id, amount: 5 })} />
                <Box style={{ color: C.textDim, fontSize: '10px' }}>Ingredients: {product.ingredients}</Box>
              </Box>
            ))}
          </Section>

          <Section title="Cones" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
            {cones.map((product) => (
              <Box key={product.id} mb={1}>
                <Box inline bold mr={1}>{product.name}</Box>
                <Box inline mr={1} style={{ color: C.textDim }}>
                  {product.count} {product.unit} left
                </Box>
                <Button
                  inline
                  mr={0.5}
                  content="Dispense"
                  onClick={() => act('cone', { cone: product.id })} />
                <Button
                  inline
                  mr={0.5}
                  content="Make"
                  onClick={() => act('make', { make: product.id, amount: 1 })} />
                <Button
                  inline
                  mr={0.5}
                  content="x5"
                  onClick={() => act('make', { make: product.id, amount: 5 })} />
                <Box style={{ color: C.textDim, fontSize: '10px' }}>Ingredients: {product.ingredients}</Box>
              </Box>
            ))}
          </Section>

          <Section title="Vat Content" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
            {reagents.length === 0 ? (
              <Box style={{ color: C.textDim }}>Empty.</Box>
            ) : (
              reagents.map((reagent) => (
                <Box key={reagent.index} mb={0.5}>
                  <Box inline mr={1}>{reagent.name}: {reagent.volume}</Box>
                  <Button
                    inline
                    content="Purge"
                    onClick={() => act('disposeI', { index: reagent.index })} />
                </Box>
              ))
            )}
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
