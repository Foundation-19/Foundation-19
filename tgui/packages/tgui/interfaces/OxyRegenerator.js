import { useBackend } from '../backend';
import { Box, Button, LabeledList, ProgressBar, Section } from '../components';
import { Window } from '../layouts';

const PHASE_COLOR = {
  filling: '#4caf50',
  processing: '#ff9800',
  releasing: '#2196f3',
};

export const OxyRegenerator = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    on,
    powerSetting,
    gasProcessed,
    air1Pressure,
    air2Pressure,
    tankPressure,
    targetPressure,
    phase,
    co2,
    o2,
  } = data;

  return (
    <Window width={440} height={300} resizable>
      <Window.Content>
        <Section>
          <LabeledList>
            <LabeledList.Item label="Power">
              <Button
                icon={on ? 'toggle-on' : 'toggle-off'}
                content={on ? 'On' : 'Off'}
                selected={on}
                onClick={() => act('toggleStatus')} />
            </LabeledList.Item>
            <LabeledList.Item label="Power Level">
              {[1, 2, 3, 4, 5].map(level => (
                <Button
                  key={level}
                  content={level}
                  selected={powerSetting === level}
                  onClick={() => act('setPower', { setPower: level })} />
              ))}
            </LabeledList.Item>
            <LabeledList.Item label="Phase">
              <Box inline color={PHASE_COLOR[phase]}>
                {phase.charAt(0).toUpperCase() + phase.slice(1)}
              </Box>
            </LabeledList.Item>
            <LabeledList.Item label="Intake Pressure">
              {air1Pressure} kPa
            </LabeledList.Item>
            <LabeledList.Item label="Output Pressure">
              {air2Pressure} kPa
            </LabeledList.Item>
            <LabeledList.Item label="Tank Pressure">
              {tankPressure} / {targetPressure} kPa
            </LabeledList.Item>
            <LabeledList.Item label="Gas Processed">
              {gasProcessed} moles
            </LabeledList.Item>
            <LabeledList.Item label="Tank CO2">
              <ProgressBar value={co2} minValue={0} maxValue={100} color="bad">
                {co2}%
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Tank O2">
              <ProgressBar value={o2} minValue={0} maxValue={100} color="good">
                {o2}%
              </ProgressBar>
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
