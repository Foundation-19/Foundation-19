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

export const DepthScanner = (props, context) => {
  const { act, data } = useBackend(context);
  const { current, locations = [] } = data;

  return (
    <Window width={360} height={480}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>DEPTH ANALYSIS SCANNER</Box>
          </Box>

          <Section title="Current Reading" style={{ border: '1px solid ' + C.border }}>
            {!current ? (
              <Box style={{ color: C.textDim }}>Select an entry from the list.</Box>
            ) : (
              <Box>
                <LabeledList>
                  <LabeledList.Item label="Time">{current.time}</LabeledList.Item>
                  <LabeledList.Item label="Coords">{current.coords}</LabeledList.Item>
                  <LabeledList.Item label="Anomaly depth">{current.depth} cm</LabeledList.Item>
                  <LabeledList.Item label="Anomaly size">{current.clearance} cm</LabeledList.Item>
                  <LabeledList.Item label="Dissonance spread">{current.dissonance_spread}</LabeledList.Item>
                  <LabeledList.Item label="Anomaly material">{current.material}</LabeledList.Item>
                </LabeledList>
                <Box mt={1}>
                  <Button
                    inline
                    color="caution"
                    content="Clear Entry"
                    onClick={() => act('clear', { index: current.record_index })} />
                </Box>
              </Box>
            )}
          </Section>

          <Box mt={1}>
            <Button inline content="Clear All" onClick={() => act('clear', { index: 0 })} />
          </Box>

          <Section title="Recorded Coordinates" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
            {locations.length === 0 ? (
              <Box style={{ color: C.textDim }}>No entries recorded.</Box>
            ) : (
              <LabeledList>
                {locations.map((entry) => (
                  <LabeledList.Item key={entry.index} label={entry.time}>
                    <Button
                      inline
                      content={entry.coords}
                      onClick={() => act('select', { index: entry.index })} />
                  </LabeledList.Item>
                ))}
              </LabeledList>
            )}
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
