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

export const HolodeckControl = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    islocked,
    linked,
    programs = [],
    restricted = [],
    safety_disabled,
    emagged,
    is_silicon,
    gravity,
  } = data;

  return (
    <Window width={400} height={500}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>HOLODECK CONTROL SYSTEM</Box>
          </Box>

          <Box mb={1}>
            Holodeck is{' '}
            <Button
              inline
              content={islocked ? '(LOCKED)' : '(UNLOCKED)'}
              color={islocked ? 'red' : 'green'}
              onClick={() => act('togglehololock')} />
          </Box>

          {islocked ? null : !linked ? (
            <Box style={{ color: '#cc2222' }}>Warning: Unable to locate holodeck.</Box>
          ) : !programs.length ? (
            <Box style={{ color: '#cc2222' }}>Warning: No supported holo-programs loaded.</Box>
          ) : (
            <Box>
              <Section title="Current Loaded Programs" style={{ border: '1px solid ' + C.border, background: C.panel }}>
                {programs.map((program, i) => (
                  <Box key={i} mb={0.5}>
                    <Button inline icon="play" content={program.label} onClick={() => act('program', { program: program.value })} />
                  </Box>
                ))}
                <Box mt={1}>
                  <Button icon="power-off" content="Turn Off" onClick={() => act('program', { program: 'turnoff' })} />
                </Box>
              </Section>

              <Box mt={1} style={{ color: C.textDim }}>
                Please ensure that only holographic weapons are used in the holodeck if a combat simulation has been loaded.
              </Box>

              {is_silicon ? (
                <Box mt={1}>
                  {safety_disabled ? (
                    emagged ? (
                      <Box style={{ color: '#cc2222' }}><b>ERROR</b>: Cannot re-enable Safety Protocols.</Box>
                    ) : (
                      <Button icon="check" color="green" content="Re-Enable Safety Protocols?" onClick={() => act('AIoverride')} />
                    )
                  ) : (
                    <Button icon="exclamation-triangle" color="red" content="Override Safety Protocols?" onClick={() => act('AIoverride')} />
                  )}
                </Box>
              ) : null}

              {safety_disabled ? (
                <Box mt={1}>
                  {restricted.map((program, i) => (
                    <Box key={i} mb={0.5}>
                      <Button inline color="red" content={'Begin ' + program.label} onClick={() => act('program', { program: program.value })} />
                      <Box style={{ color: C.textDim }}>Ensure the holodeck is empty before testing.</Box>
                    </Box>
                  ))}
                  <Box style={{ color: '#cc2222' }}>Safety Protocols are DISABLED</Box>
                </Box>
              ) : (
                <Box mt={1} style={{ color: '#44ff44' }}>Safety Protocols are ENABLED</Box>
              )}

              <Box mt={1}>
                Gravity is{' '}
                <Button
                  inline
                  content={gravity ? '(ON)' : '(OFF)'}
                  color={gravity ? 'green' : 'blue'}
                  onClick={() => act('gravity')} />
              </Box>
            </Box>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
