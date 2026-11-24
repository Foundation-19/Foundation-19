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

export const SolarControl = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    lastgen = 0,
    sun_angle = 0,
    sun_angle_text,
    cdir = 0,
    cdir_text,
    track = 0,
    trackrate = 0,
    connected_panels = 0,
    connected_tracker,
  } = data;

  return (
    <Window width={480} height={440}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.accent, letterSpacing: '0.15em', fontWeight: 'bold' }}>SOLAR CONTROL</Box>
          </Box>

          <Section title="Array" style={panelStyle}>
            <LabeledList>
              <LabeledList.Item label="Generated Power">
                <Box style={{ color: C.accent }}>{lastgen} W</Box>
              </LabeledList.Item>
              <LabeledList.Item label="Star Orientation">
                {sun_angle}&deg; ({sun_angle_text})
              </LabeledList.Item>
              <LabeledList.Item label="Array Orientation">
                <Button content="-15" mr={0.5} onClick={() => act('adjust_cdir', { amount: -15 })} />
                <Button content="-1" mr={0.5} onClick={() => act('adjust_cdir', { amount: -1 })} />
                <Box inline mr={0.5} ml={0.5}>{cdir}&deg;</Box>
                <Button content="+1" mr={0.5} onClick={() => act('adjust_cdir', { amount: 1 })} />
                <Button content="+15" mr={0.5} onClick={() => act('adjust_cdir', { amount: 15 })} />
                <Box inline style={{ color: C.dim }}>({cdir_text})</Box>
              </LabeledList.Item>
            </LabeledList>
          </Section>

          <Section title="Tracking" style={panelStyle}>
            <LabeledList>
              <LabeledList.Item label="Mode">
                <Button
                  content="Off"
                  selected={track === 0}
                  mr={0.5}
                  onClick={() => act('track', { track: 0 })} />
                <Button
                  content="Timed"
                  selected={track === 1}
                  mr={0.5}
                  onClick={() => act('track', { track: 1 })} />
                <Button
                  content="Auto"
                  selected={track === 2}
                  mr={0.5}
                  onClick={() => act('track', { track: 2 })} />
              </LabeledList.Item>
              <LabeledList.Item label="Tracking Rate">
                <Button content="-180" mr={0.5} onClick={() => act('adjust_tdir', { amount: -180 })} />
                <Button content="-30" mr={0.5} onClick={() => act('adjust_tdir', { amount: -30 })} />
                <Button content="-1" mr={0.5} onClick={() => act('adjust_tdir', { amount: -1 })} />
                <Box inline mr={0.5} ml={0.5}>{trackrate} deg/h ({trackrate < 0 ? 'CCW' : 'CW'})</Box>
                <Button content="+1" mr={0.5} onClick={() => act('adjust_tdir', { amount: 1 })} />
                <Button content="+30" mr={0.5} onClick={() => act('adjust_tdir', { amount: 30 })} />
                <Button content="+180" mr={0.5} onClick={() => act('adjust_tdir', { amount: 180 })} />
              </LabeledList.Item>
            </LabeledList>
          </Section>

          <Section title="Connected Devices" style={panelStyle}>
            <LabeledList>
              <LabeledList.Item label="Solar Panels">
                {connected_panels} connected
              </LabeledList.Item>
              <LabeledList.Item label="Solar Tracker">
                <Box inline style={{ color: connected_tracker ? C.good : C.bad }}>
                  {connected_tracker ? 'Found' : 'Not found'}
                </Box>
              </LabeledList.Item>
            </LabeledList>
            <Box mt={1}>
              <Button icon="search" content="Search for devices" onClick={() => act('search_connected')} />
            </Box>
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
