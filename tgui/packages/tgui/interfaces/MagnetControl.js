import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

const C = {
  bg: '#0a0a0c',
  panel: '#111114',
  border: '#2a2a30',
  accent: '#c2960e',
  text: '#c8c8c8',
  dim: '#7a7a80',
  mono: 'Consolas, monospace',
};

const panelStyle = {
  background: C.panel,
  border: '1px solid ' + C.border,
  marginBottom: '8px',
};

export const MagnetControl = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    frequency = 0,
    code = 0,
    autolink,
    speed = 1,
    path = 'NULL',
    moving,
    looping,
    magnets = [],
  } = data;

  return (
    <Window width={480} height={520}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.accent, letterSpacing: '0.15em', fontWeight: 'bold' }}>MAGNETIC CONTROL</Box>
          </Box>

          <Section title="Console" style={panelStyle}>
            <LabeledList>
              <LabeledList.Item label="Frequency">{frequency}</LabeledList.Item>
              <LabeledList.Item label="Code">{code}</LabeledList.Item>
            </LabeledList>
            {autolink ? null : (
              <Box mt={1}>
                <Button icon="satellite-dish" content="Probe Generators" onClick={() => act('operation', { op: 'probe' })} />
              </Box>
            )}
          </Section>

          <Section title="Generators" style={panelStyle}>
            {magnets.length === 0 ? (
              <Box style={{ color: C.dim }}>No generators confirmed.</Box>
            ) : (
              magnets.map((magnet, i) => (
                <Box key={i} style={{ borderBottom: '1px solid ' + C.border, padding: '4px 0' }}>
                  <Box inline mr={1} style={{ color: C.dim }}>[{i + 1}]</Box>
                  <Button
                    content={magnet.on ? 'On' : 'Off'}
                    selected={magnet.on}
                    mr={1}
                    onClick={() => act('radio_op', { op: 'togglepower' })} />
                  <Box inline mr={0.5}>Electricity:</Box>
                  <Button content="-" mr={0.5} onClick={() => act('radio_op', { op: 'minuselec' })} />
                  <Box inline mr={0.5}>{magnet.electricity_level}</Box>
                  <Button content="+" mr={1} onClick={() => act('radio_op', { op: 'pluselec' })} />
                  <Box inline mr={0.5}>Field:</Box>
                  <Button content="-" mr={0.5} onClick={() => act('radio_op', { op: 'minusmag' })} />
                  <Box inline mr={0.5}>{magnet.magnetic_field}</Box>
                  <Button content="+" mr={0.5} onClick={() => act('radio_op', { op: 'plusmag' })} />
                </Box>
              ))
            )}
          </Section>

          <Section title="Movement" style={panelStyle}>
            <LabeledList>
              <LabeledList.Item label="Speed">
                <Button content="-" mr={0.5} onClick={() => act('operation', { op: 'minusspeed' })} />
                <Box inline mr={0.5} ml={0.5}>{speed}</Box>
                <Button content="+" mr={0.5} onClick={() => act('operation', { op: 'plusspeed' })} />
              </LabeledList.Item>
              <LabeledList.Item label="Path">
                <Box inline mr={0.5}>{'{' + path + '}'}</Box>
                <Button icon="pen" content="Set Path" onClick={() => act('operation', { op: 'setpath' })} />
              </LabeledList.Item>
              <LabeledList.Item label="Moving">
                <Button
                  content={moving ? 'Enabled' : 'Disabled'}
                  selected={moving}
                  onClick={() => act('operation', { op: 'togglemoving' })} />
              </LabeledList.Item>
              <LabeledList.Item label="Status">
                <Box style={{ color: looping ? C.accent : C.dim }}>{looping ? 'Looping' : 'Idle'}</Box>
              </LabeledList.Item>
            </LabeledList>
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
