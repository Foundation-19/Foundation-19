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

export const CrowPanel = (props, context) => {
  const { act, data } = useBackend(context);
  const { access_card, messenger_bag } = data;

  return (
    <Window width={380} height={220}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>CROW INVENTORY</Box>
          </Box>

          <Section title="Equipment" style={{ border: '1px solid ' + C.border }}>
            <Box mb={1}>
              <Box inline mr={1}>ID:</Box>
              {access_card ? (
                <>
                  <Box inline mr={1}>{access_card}</Box>
                  <Button
                    inline
                    content="Remove"
                    onClick={() => act('remove_inv', { slot: 'access cuff' })} />
                </>
              ) : (
                <Button
                  inline
                  content="Nothing"
                  onClick={() => act('add_inv', { slot: 'access cuff' })} />
              )}
            </Box>
            <Box>
              <Box inline mr={1}>Back:</Box>
              {messenger_bag ? (
                <>
                  <Box inline mr={1}>{messenger_bag}</Box>
                  <Button
                    inline
                    content="Remove"
                    onClick={() => act('remove_inv', { slot: 'back' })} />
                </>
              ) : (
                <Button
                  inline
                  content="Nothing"
                  onClick={() => act('add_inv', { slot: 'back' })} />
              )}
            </Box>
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
