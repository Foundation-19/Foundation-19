import { useBackend } from '../backend';
import { Box, Button, LabeledList, NumberInput, Section } from '../components';
import { Window } from '../layouts';

export const EnvEditor = (props, context) => {
  const { act, data } = useBackend(context);
  const { env_params } = data;
  return (
    <Window width={300} height={800} resizable>
      <Window.Content scrollable>
        <Section title="Environment Parameters" buttons={
          <Button content="Reset All" color="bad" onClick={() => act('reset_all')} />
        }>
          <LabeledList>
            {env_params.map(param => (
              <LabeledList.Item key={param.index} label={param.name}>
                <NumberInput
                  value={param.value}
                  step={param.real ? 0.1 : 1}
                  onDrag={(e, value) => act('set', { index: param.index, value: value })} />
                <Button content="Reset" onClick={() => act('reset', { index: param.index })} />
                <Button content="?" onClick={() => act('desc', { index: param.index })} />
              </LabeledList.Item>
            ))}
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
