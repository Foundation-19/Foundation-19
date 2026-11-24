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

export const TurboliftConsole = (props, context) => {
  const { act, data } = useBackend(context);
  const { floors = [], doors_open } = data;

  return (
    <Window width={280} height={420}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.amber, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>LIFT PANEL</Box>
          </Box>

          <Section title="Floors" style={{ border: '1px solid ' + C.border }}>
            {floors.length === 0 ? (
              <Box style={{ color: C.textDim }}>No floors registered.</Box>
            ) : (
              floors.map((floor, i) => (
                <Box key={i} mb={0.5}>
                  <Button
                    inline
                    mr={0.5}
                    content={floor.label}
                    selected={floor.queued}
                    onClick={() => act('move_to_floor', { ref: floor.ref })} />
                  <Box inline style={{ color: floor.queued ? C.amber : C.textDim }}>
                    {floor.name}
                  </Box>
                </Box>
              ))
            )}
          </Section>

          <Section title="Doors" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
            {doors_open ? (
              <Button
                inline
                mr={0.5}
                icon="door-closed"
                content="Close Doors"
                onClick={() => act('close_doors')} />
            ) : (
              <Button
                inline
                mr={0.5}
                icon="door-open"
                content="Open Doors"
                onClick={() => act('open_doors')} />
            )}
            <Button
              inline
              icon="exclamation-triangle"
              content="Emergency Stop"
              color="bad"
              onClick={() => act('emergency_stop')} />
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
