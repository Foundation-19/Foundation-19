import { useBackend } from '../backend';
import { Box, Button, LabeledList, NumberInput, Section } from '../components';
import { Window } from '../layouts';

const REGULATE_MODES = [
  { mode: 0, label: 'Off', icon: 'toggle-off' },
  { mode: 1, label: 'Input', icon: 'sign-in-alt' },
  { mode: 2, label: 'Output', icon: 'sign-out-alt' },
];

export const PassiveGate = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    on,
    pressure_set,
    max_pressure,
    input_pressure,
    output_pressure,
    regulate_mode,
    set_flow_rate,
    last_flow_rate,
  } = data;

  return (
    <Window width={470} height={370} resizable>
      <Window.Content>
        <Section>
          <LabeledList>
            <LabeledList.Item label="Valve">
              <Button
                icon={on ? 'toggle-on' : 'toggle-off'}
                content={on ? 'Open' : 'Closed'}
                selected={on}
                onClick={() => act('toggle_valve')} />
            </LabeledList.Item>
            <LabeledList.Item label="Regulate Mode">
              {REGULATE_MODES.map(mode => (
                <Button
                  key={mode.mode}
                  icon={mode.icon}
                  content={mode.label}
                  selected={regulate_mode === mode.mode}
                  onClick={() => act('regulate_mode', { regulate_mode: mode.label.toLowerCase() })} />
              ))}
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
            <LabeledList.Item label="Input Pressure">
              {input_pressure / 100} kPa
            </LabeledList.Item>
            <LabeledList.Item label="Output Pressure">
              {output_pressure / 100} kPa
            </LabeledList.Item>
            <LabeledList.Item label="Flow Rate Limit">
              <NumberInput
                value={set_flow_rate}
                minValue={0}
                step={10}
                stepPixelSize={3}
                width="80px"
                onChange={(e, value) => act('set_flow_rate', { set_flow_rate: 'custom', flow_rate: value / 10 })} />
              <Button icon="backward" onClick={() => act('set_flow_rate', { set_flow_rate: 'min' })} />
              <Button icon="forward" onClick={() => act('set_flow_rate', { set_flow_rate: 'max' })} />
            </LabeledList.Item>
            <LabeledList.Item label="Flow Rate">
              {last_flow_rate / 10} L/s
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
