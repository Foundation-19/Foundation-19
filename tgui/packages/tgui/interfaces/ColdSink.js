import { useBackend } from '../backend';
import { Box, Button, LabeledList, NumberInput, Section } from '../components';
import { Window } from '../layouts';

const TEMPERATURE_COLOR = {
  good: '#4caf50',
  average: '#ff9800',
  bad: '#f44336',
};

export const ColdSink = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    on,
    gasPressure,
    gasTemperature,
    minGasTemperature,
    maxGasTemperature,
    targetGasTemperature,
    powerSetting,
    gasTemperatureClass,
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
            <LabeledList.Item label="Temperature">
              <Box inline color={TEMPERATURE_COLOR[gasTemperatureClass] || 'label'}>
                {gasTemperature} K
              </Box>
            </LabeledList.Item>
            <LabeledList.Item label="Pressure">
              {gasPressure} kPa
            </LabeledList.Item>
            <LabeledList.Item label="Target Temperature">
              <NumberInput
                value={targetGasTemperature}
                minValue={minGasTemperature}
                maxValue={maxGasTemperature}
                step={10}
                stepPixelSize={3}
                width="80px"
                onChange={(e, value) => {
                  const diff = value - targetGasTemperature;
                  act('temp', { temp: diff });
                }} />
              <Button icon="backward" onClick={() => act('temp', { temp: -10 })} />
              <Button icon="forward" onClick={() => act('temp', { temp: 10 })} />
            </LabeledList.Item>
            <LabeledList.Item label="Power Level">
              {[20, 40, 60, 80, 100].map(level => (
                <Button
                  key={level}
                  content={level + '%'}
                  selected={powerSetting === level}
                  onClick={() => act('setPower', { setPower: level })} />
              ))}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
