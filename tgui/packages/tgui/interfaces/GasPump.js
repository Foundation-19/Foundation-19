import { useBackend } from '../backend';
import { Box, Button, LabeledList, NumberInput, ProgressBar, Section } from '../components';
import { Window } from '../layouts';

export const GasPump = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    on,
    pressure_set,
    max_pressure,
    last_flow_rate,
    last_power_draw,
    max_power_draw,
  } = data;

  return (
    <Window width={470} height={290} resizable>
      <Window.Content>
        <Section>
          <LabeledList>
            <LabeledList.Item label="Power">
              <Button
                icon={on ? 'toggle-on' : 'toggle-off'}
                content={on ? 'On' : 'Off'}
                selected={on}
                onClick={() => act('power')} />
            </LabeledList.Item>
            <LabeledList.Item label="Target Pressure">
              <NumberInput
                value={pressure_set}
                minValue={0}
                maxValue={max_pressure * 100}
                step={100}
                stepPixelSize={3}
                width="80px"
                onChange={(e, value) => act('set_press', { set_press: 'custom', pressure: value / 100 })} />
              <Button icon="backward" onClick={() => act('set_press', { set_press: 'min' })} />
              <Button icon="forward" onClick={() => act('set_press', { set_press: 'max' })} />
            </LabeledList.Item>
            <LabeledList.Item label="Flow Rate">
              {last_flow_rate / 10} L/s
            </LabeledList.Item>
            <LabeledList.Item label="Power Draw">
              <ProgressBar value={last_power_draw} minValue={0} maxValue={max_power_draw}>
                {last_power_draw} W
              </ProgressBar>
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
