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

export const PsiMonitor = (props, context) => {
  const { act, data } = useBackend(context);
  const { authorized, show_violations, dampeners = [], violations = [] } = data;

  return (
    <Window width={520} height={500}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>PSI DAMPENER MONITOR</Box>
          </Box>

          <Box mb={1}>
            {authorized ? (
              <>
                <Box inline mr={1}>{authorized}</Box>
                <Button inline content="Logout" onClick={() => act('logout')} />
              </>
            ) : (
              <Button inline content="Login" onClick={() => act('login')} />
            )}
          </Box>

          <Section title="Active Psionic Dampeners" style={{ border: '1px solid ' + C.border }}>
            {dampeners.length === 0 ? (
              <Box style={{ color: C.textDim }}>No active dampeners.</Box>
            ) : (
              <LabeledList>
                {dampeners.map((dampener, i) => (
                  <LabeledList.Item key={i} label={dampener.name}>
                    {dampener.malfunction ? (
                      <Box style={{ color: '#cc5555' }}>ERROR</Box>
                    ) : (
                      <>
                        <Box inline mr={1}>{dampener.overload}%</Box>
                        {authorized ? (
                          <Button
                            inline
                            content={dampener.mode}
                            onClick={() => act('change_mode', { ref: dampener.ref })} />
                        ) : (
                          <Box inline>{dampener.mode}</Box>
                        )}
                      </>
                    )}
                  </LabeledList.Item>
                ))}
              </LabeledList>
            )}
          </Section>

          <Section title="Psionic Control Violations" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
            <Box mb={1}>
              <Button
                inline
                content={show_violations ? 'Collapse' : 'Expand'}
                onClick={() => act('show_violations', { show: !show_violations })} />
            </Box>
            {show_violations ? (
              violations.length === 0 ? (
                <Box style={{ color: C.textDim }}>None reported.</Box>
              ) : (
                violations.map((violation, i) => (
                  <Box key={i} mb={0.5}>
                    <Box inline dangerouslySetInnerHTML={{ __html: violation }} />
                    {authorized ? (
                      <Button
                        inline
                        ml={1}
                        content="Remove"
                        onClick={() => act('remove_violation', { index: String(i + 1) })} />
                    ) : null}
                  </Box>
                ))
              )
            ) : null}
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
