import { useBackend } from '../backend';
import { Box, Button, LabeledList, ProgressBar, Section } from '../components';
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

export const ArtifactHarvester = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    has_scanner,
    harvesting,
    has_battery,
    battery_name,
    stored_charge,
    capacity,
    charge_percent,
    artifact_id,
  } = data;

  return (
    <Window width={380} height={480}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>
              EXOTIC PARTICLE HARVESTER
            </Box>
          </Box>

          {!has_scanner ? (
            <Box style={{ color: '#c0392b' }}>Unable to locate analysis pad.</Box>
          ) : (
            <Box>
              {harvesting ? (
                <Section title="Processing" style={{ border: '1px solid ' + C.border }}>
                  <Box style={{ color: C.amber }}>
                    {harvesting > 0 ? 'Harvesting in progress' : 'Energy dump in progress'} ({charge_percent}%).
                  </Box>
                  <Box mt={1}>
                    <Button inline content="Halt Early" onClick={() => act('stopharvest')} />
                  </Box>
                </Section>
              ) : !has_battery ? (
                <Box style={{ color: C.textDim }}>No battery inserted.</Box>
              ) : (
                <Section title="Battery" style={{ border: '1px solid ' + C.border }}>
                  <LabeledList>
                    <LabeledList.Item label="Battery">{battery_name}</LabeledList.Item>
                    <LabeledList.Item label="Energy signature ID">{artifact_id}</LabeledList.Item>
                    <LabeledList.Item label="Charge">
                      {stored_charge} / {capacity} ({charge_percent}%)
                    </LabeledList.Item>
                  </LabeledList>
                  <ProgressBar
                    mt={1}
                    value={stored_charge}
                    minValue={0}
                    maxValue={capacity}
                    color="blue" />
                  <Box mt={1}>
                    <Button
                      inline
                      mr={0.5}
                      icon="cog"
                      content="Begin Harvesting"
                      onClick={() => act('harvest')} />
                    <Button
                      inline
                      mr={0.5}
                      icon="eject"
                      content="Eject Battery"
                      onClick={() => act('ejectbattery')} />
                    <Button
                      inline
                      color="caution"
                      content="Drain Battery"
                      onClick={() => act('drainbattery')} />
                  </Box>
                </Section>
              )}
            </Box>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
