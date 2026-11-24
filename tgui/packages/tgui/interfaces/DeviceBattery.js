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

const TimeButtons = ({ act, field, amount, label }) => (
  <Button
    inline
    mr={0.5}
    content={label}
    onClick={() => act('changetime', { changetime: amount, [field]: 1 })} />
);

export const DeviceBattery = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    activated,
    has_battery,
    battery_name,
    artifact_id,
    stored_charge,
    capacity,
    time_left,
    duration,
    interval,
  } = data;

  return (
    <Window width={360} height={420}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>
              ANOMALOUS MATERIALS ENERGY UTILISER
            </Box>
          </Box>

          {!has_battery ? (
            <Box style={{ color: C.textDim }}>Please insert battery.</Box>
          ) : (
            <Section title="Battery" style={{ border: '1px solid ' + C.border }}>
              {activated ? <Box style={{ color: C.amber }}>Device active.</Box> : null}
              <LabeledList mt={activated ? 1 : 0}>
                <LabeledList.Item label="Battery">{battery_name}</LabeledList.Item>
                <LabeledList.Item label="Anomaly ID">{artifact_id}</LabeledList.Item>
                <LabeledList.Item label="Charge">
                  {stored_charge} / {capacity}
                </LabeledList.Item>
                <LabeledList.Item label="Time left activated">{time_left}</LabeledList.Item>
              </LabeledList>

              <Box mt={1}>
                {activated ? (
                  <Button inline content="Shutdown" onClick={() => act('shutdown')} />
                ) : (
                  <Button inline content="Start" onClick={() => act('startup')} />
                )}
              </Box>

              <Box mt={1}>
                <Box inline mr={1} style={{ color: C.textDim }}>
                  Duration (sec):
                </Box>
                <TimeButtons act={act} field="duration" amount={-100} label="--" />
                <TimeButtons act={act} field="duration" amount={-10} label="-" />
                <Box inline mr={0.5} style={{ color: C.amber }}>{duration}</Box>
                <TimeButtons act={act} field="duration" amount={10} label="+" />
                <TimeButtons act={act} field="duration" amount={100} label="++" />
              </Box>

              <Box mt={1}>
                <Box inline mr={1} style={{ color: C.textDim }}>
                  Interval (sec):
                </Box>
                <TimeButtons act={act} field="interval" amount={-100} label="--" />
                <TimeButtons act={act} field="interval" amount={-10} label="-" />
                <Box inline mr={0.5} style={{ color: C.amber }}>{interval}</Box>
                <TimeButtons act={act} field="interval" amount={10} label="+" />
                <TimeButtons act={act} field="interval" amount={100} label="++" />
              </Box>

              <Box mt={1}>
                <Button inline icon="eject" content="Eject Battery" onClick={() => act('ejectbattery')} />
              </Box>
            </Section>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
