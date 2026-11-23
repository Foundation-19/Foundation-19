import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, ProgressBar, NumberInput } from '../components';
import { Window } from '../layouts';

export const OvermapEngineControl = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    state,
    global_state,
    global_limit,
    total_thrust,
    engines_info,
  } = data;
  return (
    <Window width={390} height={530}>
      <Window.Content scrollable>
        <Section title="Global Engine Control">
          <LabeledList>
            <LabeledList.Item label="Engines">
              <Button
                icon={global_state ? 'power-off' : 'power-off'}
                content={global_state ? 'Online' : 'Offline'}
                selected={global_state}
                onClick={() => act('global_toggle')} />
            </LabeledList.Item>
            <LabeledList.Item label="Thrust Limit">
              <ProgressBar value={global_limit / 100}>
                {global_limit}%
              </ProgressBar>
              <Button content="Set" onClick={() => act('set_global_limit')} />
              <Button content="-10" onClick={() => act('global_limit', { global_limit: -0.1 })} />
              <Button content="+10" onClick={() => act('global_limit', { global_limit: 0.1 })} />
            </LabeledList.Item>
            <LabeledList.Item label="Total Thrust">
              {total_thrust}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Engines">
          <LabeledList>
            {engines_info.map(engine => (
              <LabeledList.Item key={engine.eng_reference} label={engine.eng_type}>
                <Button
                  icon={engine.eng_on ? 'power-off' : 'power-off'}
                  content={engine.eng_on ? 'ON' : 'OFF'}
                  selected={engine.eng_on}
                  onClick={() => act('engine', { engine: engine.eng_reference, toggle: 1 })} />
                <Box inline mx={1}>Limit: {engine.eng_thrust_limiter}%</Box>
                <Button content="-10" onClick={() => act('engine', { engine: engine.eng_reference, limit: -0.1 })} />
                <Button content="+10" onClick={() => act('engine', { engine: engine.eng_reference, limit: 0.1 })} />
                <Button content="Set" onClick={() => act('engine', { engine: engine.eng_reference, set_limit: 1 })} />
                <Box inline mx={1}>Thrust: {engine.eng_thrust}</Box>
              </LabeledList.Item>
            ))}
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
