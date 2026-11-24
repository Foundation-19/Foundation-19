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

export const Cooker = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    operable,
    processing,
    cook_mode,
    cook_modes = [],
    items = [],
  } = data;

  return (
    <Window width={400} height={500}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>COOKER</Box>
          </Box>

          {!operable ? (
            <Section style={{ border: '1px solid ' + C.border }}>
              <Box style={{ color: '#cc5555' }}>The cooker is in no condition to operate.</Box>
            </Section>
          ) : (
            <>
              <Box mb={1}>
                <Button
                  inline
                  mr={0.5}
                  content="Empty Ingredients"
                  onClick={() => act('empty_cooker')} />
                <Button
                  inline
                  mr={0.5}
                  content={processing ? 'Turn Off' : 'Turn On'}
                  onClick={() => act('toggle_state')} />
              </Box>
              <Section title="Cook Mode" style={{ border: '1px solid ' + C.border }}>
                <Box mb={1} style={{ color: C.amber }}>Current: {cook_mode}</Box>
                {cook_modes.length > 1 && cook_modes.map((mode, i) => (
                  <Button
                    key={i}
                    inline
                    mr={0.5}
                    selected={cook_mode === mode.name}
                    disabled={processing}
                    content={mode.name}
                    onClick={() => act('cook_mode', { mode: mode.name })} />
                ))}
              </Section>
              <Section
                title={processing ? 'Contents (Cooking!)' : 'Contents'}
                style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
                {items.length === 0 ? (
                  <Box style={{ color: '#cc5555' }}>None!</Box>
                ) : (
                  items.map((line, i) => <Box key={i}>{line}</Box>)
                )}
              </Section>
            </>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
