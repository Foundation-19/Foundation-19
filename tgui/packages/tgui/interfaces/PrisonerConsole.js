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
  bad: '#d04040',
  mono: 'Consolas, monospace',
};

export const PrisonerConsole = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    screen = 0,
    chem_implants = [],
    tracking_implants = [],
  } = data;

  return (
    <Window width={480} height={560}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.amber, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>
              PRISONER IMPLANT MANAGER
            </Box>
          </Box>

          {screen === 0 ? (
            <Section title="Access" style={{ border: '1px solid ' + C.border }}>
              <Box mb={1} style={{ color: C.textDim }}>Console locked.</Box>
              <Button
                icon="unlock"
                content="Unlock Console"
                onClick={() => act('lock')} />
            </Section>
          ) : (
            <>
              <Section title="Chemical Implants" style={{ border: '1px solid ' + C.border }}>
                {chem_implants.length === 0 ? (
                  <Box style={{ color: C.textDim }}>No active chemical implants.</Box>
                ) : (
                  chem_implants.map((implant, i) => (
                    <Box
                      key={i}
                      mb={1}
                      style={{ borderBottom: '1px solid ' + C.border, paddingBottom: '4px' }}>
                      <Box style={{ color: C.text }}>{implant.name}</Box>
                      <Box style={{ color: C.textDim }}>Remaining Units: {implant.units}</Box>
                      <Box mt={0.5}>
                        <Button
                          inline
                          mr={0.5}
                          content="(1)"
                          onClick={() => act('inject', { ref: implant.ref, amount: 1 })} />
                        <Button
                          inline
                          mr={0.5}
                          content="(5)"
                          onClick={() => act('inject', { ref: implant.ref, amount: 5 })} />
                        <Button
                          inline
                          content="(10)"
                          onClick={() => act('inject', { ref: implant.ref, amount: 10 })} />
                      </Box>
                    </Box>
                  ))
                )}
              </Section>

              <Section title="Tracking Implants" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
                {tracking_implants.length === 0 ? (
                  <Box style={{ color: C.textDim }}>No active tracking implants.</Box>
                ) : (
                  tracking_implants.map((implant, i) => (
                    <Box
                      key={i}
                      mb={1}
                      style={{ borderBottom: '1px solid ' + C.border, paddingBottom: '4px' }}>
                      <Box style={{ color: C.text }}>
                        ID: {implant.id} | Location: {implant.location}
                      </Box>
                      <Box mt={0.5}>
                        <Button
                          inline
                          icon="bullhorn"
                          content="Message Holder"
                          onClick={() => act('warn', { ref: implant.ref })} />
                      </Box>
                    </Box>
                  ))
                )}
              </Section>

              <Box mt={1}>
                <Button
                  icon="lock"
                  content="Lock Console"
                  onClick={() => act('lock')} />
              </Box>
            </>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
