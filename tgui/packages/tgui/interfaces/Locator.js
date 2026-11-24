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

export const Locator = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    frequency,
    show_results,
    beacons = [],
    signals = [],
    position,
    error,
  } = data;

  return (
    <Window width={360} height={480}>
      <Window.Content scrollable>
        <Box
          style={{
            background: C.bg,
            minHeight: '100%',
            padding: '10px',
            fontFamily: C.mono,
            color: C.text,
          }}>
          <Box
            style={{
              borderBottom: '2px solid ' + C.border,
              paddingBottom: '6px',
              marginBottom: '10px',
            }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>
              PERSISTENT SIGNAL LOCATOR
            </Box>
          </Box>

          {!show_results ? (
            <Section style={{ border: '1px solid ' + C.border }}>
              <LabeledList>
                <LabeledList.Item label="Frequency">
                  <Button inline mr={0.5} content="-" onClick={() => act('freq', { value: -10 })} />
                  <Button inline mr={0.5} content="-" onClick={() => act('freq', { value: -2 })} />
                  <Box inline mr={0.5} style={{ color: C.amber }}>
                    {frequency}
                  </Box>
                  <Button inline mr={0.5} content="+" onClick={() => act('freq', { value: 2 })} />
                  <Button inline content="+" onClick={() => act('freq', { value: 10 })} />
                </LabeledList.Item>
              </LabeledList>
              <Box mt={1}>
                <Button inline icon="search" content="Refresh" onClick={() => act('refresh')} />
              </Box>
            </Section>
          ) : (
            <>
              {error ? (
                <Section style={{ border: '1px solid ' + C.border }}>
                  <Box style={{ color: '#c0392b' }}>Processing Error: {error}</Box>
                </Section>
              ) : (
                <>
                  <Section title="Located Beacons" style={{ border: '1px solid ' + C.border }}>
                    {beacons.length === 0 ? (
                      <Box style={{ color: C.textDim }}>None found.</Box>
                    ) : (
                      <LabeledList>
                        {beacons.map((beacon, i) => (
                          <LabeledList.Item key={i} label={beacon.name}>
                            {beacon.direction} — {beacon.strength}
                          </LabeledList.Item>
                        ))}
                      </LabeledList>
                    )}
                  </Section>
                  <Section
                    title="Extraneous Signals"
                    style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
                    {signals.length === 0 ? (
                      <Box style={{ color: C.textDim }}>None found.</Box>
                    ) : (
                      <LabeledList>
                        {signals.map((signal, i) => (
                          <LabeledList.Item key={i} label={signal.name}>
                            {signal.direction} — {signal.strength}
                          </LabeledList.Item>
                        ))}
                      </LabeledList>
                    )}
                  </Section>
                  <Box mt={1} style={{ color: C.amber }}>
                    You are at [{position}] in orbital coordinates.
                  </Box>
                </>
              )}
              <Box mt={1}>
                <Button inline mr={0.5} icon="search" content="Refresh" onClick={() => act('refresh')} />
                <Button inline icon="times" content="Clear" onClick={() => act('temp')} />
              </Box>
            </>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
