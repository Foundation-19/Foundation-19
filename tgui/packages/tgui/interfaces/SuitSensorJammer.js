import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, ProgressBar, NumberInput, Flex } from '../components';
import { Window } from '../layouts';

export const SuitSensorJammer = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    active,
    current_charge,
    max_charge,
    range,
    max_range,
    methods,
    current_method,
    current_cost,
    total_cost,
  } = data;
  return (
    <Window width={300} height={640}>
      <Window.Content scrollable>
        <Section title="Sensor Jammer">
          <LabeledList>
            <LabeledList.Item label="Status">
              <Button selected={active} onClick={() => active ? act('disable_jammer') : act('enable_jammer')}>
                {active ? "Active" : "Inactive"}
              </Button>
            </LabeledList.Item>
            <LabeledList.Item label="Charge">
              <ProgressBar value={current_charge / max_charge}>
                {round(current_charge, 1)}/{max_charge}
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Range">
              <NumberInput
                value={range}
                minValue={0}
                maxValue={max_range}
                step={1}
                onChange={(e, value) => act('set_range', { set_range: value })}
              />
              <Button ml={1} onClick={() => act('increase_range')}>+</Button>
              <Button ml={1} onClick={() => act('decrease_range')}>-</Button>
            </LabeledList.Item>
            <LabeledList.Item label="Total Cost">{total_cost}</LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Methods">
          {methods && methods.map((method, i) => (
            <Button key={i} fluid selected={method.ref === current_method} onClick={() => act('select_method', { select_method: method.ref })}>
              {method.name} (Cost: {method.cost})
            </Button>
          ))}
        </Section>
      </Window.Content>
    </Window>
  );
};

function round(val, precision) {
  return Math.round(val * Math.pow(10, precision)) / Math.pow(10, precision);
}
