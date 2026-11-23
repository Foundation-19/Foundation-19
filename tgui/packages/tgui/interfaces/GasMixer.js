import { useBackend } from '../backend';
import { Box, Button, LabeledList, NumberInput, Section } from '../components';
import { Window } from '../layouts';

export const GasMixer = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    power,
    config,
    ports,
    set_flow_rate,
    last_flow_rate,
  } = data;

  return (
    <Window width={360} height={330} resizable>
      <Window.Content scrollable>
        <Section>
          <LabeledList>
            <LabeledList.Item label="Power">
              <Button
                icon={power ? 'toggle-on' : 'toggle-off'}
                content={power ? 'On' : 'Off'}
                selected={power}
                disabled={config}
                onClick={() => act('power')} />
            </LabeledList.Item>
            <LabeledList.Item label="Configure">
              <Button
                icon="cog"
                content={config ? 'Done' : 'Configure'}
                selected={config}
                onClick={() => act('configure')} />
            </LabeledList.Item>
          </LabeledList>
        </Section>
        {ports && ports.length > 0 && (
          <Section title="Ports">
            <LabeledList>
              {ports.map(port => (
                <LabeledList.Item key={port.dir} label={port.dir}>
                  {config && !power && (
                    <Box inline>
                      <Button
                        icon="sign-in-alt"
                        content="In"
                        selected={port.input}
                        onClick={() => act('switch_mode', { dir: port.dir, mode: 'in' })} />
                      <Button
                        icon="sign-out-alt"
                        content="Out"
                        selected={port.output}
                        onClick={() => act('switch_mode', { dir: port.dir, mode: 'out' })} />
                      {port.input && (
                        <Box inline>
                          <Button
                            icon="lock"
                            content={port.con_lock ? 'Locked' : 'Unlocked'}
                            selected={port.con_lock}
                            onClick={() => act('switch_conlock', { dir: port.dir })} />
                          <Button
                            icon="percent"
                            content="Set Concentration"
                            onClick={() => act('switch_con', { dir: port.dir })} />
                        </Box>
                      )}
                    </Box>
                  )}
                  {!config && (
                    <Box inline>
                      {port.input && (
                        <Box inline color="label">
                          Input ({(port.concentration * 100).toFixed(0)}%)
                        </Box>
                      )}
                      {port.output && (
                        <Box inline color="label">
                          Output
                        </Box>
                      )}
                    </Box>
                  )}
                </LabeledList.Item>
              ))}
            </LabeledList>
          </Section>
        )}
        {set_flow_rate !== undefined && (
          <Section title="Flow Rate">
            <LabeledList>
              <LabeledList.Item label="Set Flow Rate">
                {config && !power ? (
                  <Button
                    icon="cog"
                    content={(set_flow_rate / 10).toFixed(1) + ' L/s'}
                    onClick={() => act('set_flow_rate')} />
                ) : (
                  <Box inline>{(set_flow_rate / 10).toFixed(1)} L/s</Box>
                )}
              </LabeledList.Item>
              <LabeledList.Item label="Current Flow Rate">
                {(last_flow_rate / 10).toFixed(1)} L/s
              </LabeledList.Item>
            </LabeledList>
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
