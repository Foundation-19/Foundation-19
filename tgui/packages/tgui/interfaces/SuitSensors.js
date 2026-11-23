import { useBackend } from '../backend';
import { Box, Button, Flex, LabeledList, Section } from '../components';
import { Window } from '../layouts';

const statColor = (stat) => {
  if (stat === 0) return '#44ff44';
  if (stat === 1) return '#d4a017';
  return '#cc2222';
};

export const SuitSensors = (props, context) => {
  const { act, data } = useBackend(context);
  const { crewmembers = [] } = data;

  return (
    <Window theme="scp_terminal" width={640} height={660}>
      <Window.Content scrollable>
        <Box style={{ background: '#0a0a0c', minHeight: '100%', padding: '10px', fontFamily: '"Consolas", monospace', color: '#c8c8c8' }}>
          <Box style={{ borderBottom: '2px solid #6b0000', paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: '#d4a017', letterSpacing: '0.15em', fontWeight: 'bold' }}>CREW MONITOR</Box>
            <Box style={{ color: '#6a6a70', fontSize: '9px' }}>SUIT SENSOR TELEMETRY — {crewmembers.length} SIGNALS</Box>
          </Box>
          <Section title="Tracked Crew">
            {crewmembers.map((member, i) => (
              <Flex key={i} align="center" mb={0.5}>
                <Box style={{ flex: 1 }}>
                  {member.name}
                  {member.area ? <Box inline ml={1} style={{ color: '#6a6a70' }}>({member.area})</Box> : null}
                </Box>
                <Box mr={1} style={{ color: statColor(member.stat) }}>
                  {member.stat === 0 ? 'CONSCIOUS' : member.stat === 1 ? 'UNCONSCIOUS' : 'DECEASED'}
                </Box>
                <Box mr={1} style={{ color: '#c8c8c8' }}>
                  {typeof member.blood_level !== 'undefined' ? member.blood_level + '%' : ''}
                </Box>
                <Button
                  icon="location-arrow"
                  content="Track"
                  disabled={member.sensor_type < 3}
                  onClick={() => act('track', { track: member.ref })}
                />
              </Flex>
            ))}
            {crewmembers.length === 0 ? <Box style={{ color: '#6a6a70' }}>No suit sensor signals on this level.</Box> : null}
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
