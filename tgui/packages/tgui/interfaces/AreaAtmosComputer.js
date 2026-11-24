import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

const C = {
  bg: '#0a0a0c',
  panel: '#111114',
  border: '#2a2a30',
  accent: '#c2960e',
  good: '#44aa44',
  bad: '#cc2222',
  text: '#c8c8c8',
  dim: '#7a7a80',
  mono: 'Consolas, monospace',
};

const panelStyle = {
  background: C.panel,
  border: '1px solid ' + C.border,
  marginBottom: '8px',
};

export const AreaAtmosComputer = (props, context) => {
  const { act, data } = useBackend(context);
  const { status = '', zone = '', scrubbers = [] } = data;

  return (
    <Window width={520} height={480}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.accent, letterSpacing: '0.15em', fontWeight: 'bold' }}>AREA AIR CONTROL</Box>
          </Box>

          {status ? (
            <Box mb={1} style={{ color: C.bad }}>{status}</Box>
          ) : null}

          <Box mb={1}>
            <Button icon="search" content="Scan" onClick={() => act('scan')} />
          </Box>

          {scrubbers.length === 0 ? (
            <Section title="Scrubbers" style={panelStyle}>
              <Box style={{ color: C.dim }}>No scrubbers connected.</Box>
            </Section>
          ) : (
            scrubbers.map((scrubber, i) => (
              <Section key={i} title={scrubber.name} style={panelStyle}>
                <LabeledList>
                  <LabeledList.Item label="Pressure">
                    {scrubber.pressure} kPa
                  </LabeledList.Item>
                  <LabeledList.Item label="Flow Rate">
                    {scrubber.flow_rate} L/s
                  </LabeledList.Item>
                  <LabeledList.Item label="Load">
                    {scrubber.power_draw} W
                  </LabeledList.Item>
                  <LabeledList.Item label="State">
                    <Box inline mr={0.5} style={{ color: scrubber.on ? C.good : C.dim }}>
                      {scrubber.on ? 'On' : 'Off'}
                    </Box>
                    <Button
                      content="Turn On"
                      selected={scrubber.on}
                      mr={0.5}
                      ml={0.5}
                      onClick={() => act('toggle', { scrub: scrubber.ref, toggle: 1 })} />
                    <Button
                      content="Turn Off"
                      selected={!scrubber.on}
                      mr={0.5}
                      onClick={() => act('toggle', { scrub: scrubber.ref, toggle: 0 })} />
                  </LabeledList.Item>
                </LabeledList>
              </Section>
            ))
          )}

          <Box style={{ color: C.dim, fontSize: '10px', marginTop: '8px' }}>{zone}</Box>
        </Box>
      </Window.Content>
    </Window>
  );
};
