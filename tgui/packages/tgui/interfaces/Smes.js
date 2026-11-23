import { useBackend } from '../backend';
import { Box, Button, Flex, LabeledList, NoticeBox, ProgressBar, Section } from '../components';
import { Window } from '../layouts';

export const Smes = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    nameTag,
    storedCapacity,
    storedCapacityAbs,
    storedCapacityMax,
    charging,
    chargeMode,
    chargeLevel,
    chargeMax,
    chargeLoad,
    outputOnline,
    outputLevel,
    outputMax,
    outputLoad,
    failTime,
    outputting,
  } = data;

  return (
    <Window width={540} height={400} resizable>
      <Window.Content scrollable>
        {!!failTime && (
          <NoticeBox danger>
            System failure! Reboot in {failTime}s
            <Button icon="redo" content="Reboot" ml={1} onClick={() => act('reboot')} />
          </NoticeBox>
        )}
        <Section title={nameTag || 'SMES Unit'}>
          <LabeledList>
            <LabeledList.Item label="Energy Storage">
              <ProgressBar
                value={storedCapacity / 100}
                ranges={{ good: [0.5, Infinity], average: [0.15, 0.5], bad: [-Infinity, 0.15] }}>
                {storedCapacity}% ({storedCapacityAbs} / {storedCapacityMax} kJ)
              </ProgressBar>
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Input">
          <LabeledList>
            <LabeledList.Item label="Charging">
              <Button
                icon={chargeMode ? 'toggle-on' : 'toggle-off'}
                content={chargeMode ? 'Auto' : 'Off'}
                selected={chargeMode}
                onClick={() => act('cmode')} />
              <Box inline ml={1} color={charging ? 'good' : 'label'}>
                {charging ? 'Charging' : 'Not Charging'}
              </Box>
            </LabeledList.Item>
            <LabeledList.Item label="Input Level">
              {chargeLevel} / {chargeMax} kW
              <Button ml={1} content="Min" onClick={() => act('input', { input: 'min' })} />
              <Button content="Max" onClick={() => act('input', { input: 'max' })} />
              <Button content="Set" onClick={() => act('input', { input: 'set' })} />
            </LabeledList.Item>
            <LabeledList.Item label="Available">
              {chargeLoad} kW
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Output">
          <LabeledList>
            <LabeledList.Item label="Output">
              <Button
                icon={outputOnline ? 'toggle-on' : 'toggle-off'}
                content={outputOnline ? 'Online' : 'Offline'}
                selected={outputOnline}
                onClick={() => act('online')} />
              <Box inline ml={1} color={outputting ? 'good' : 'label'}>
                {outputting ? 'Outputting' : 'Idle'}
              </Box>
            </LabeledList.Item>
            <LabeledList.Item label="Output Level">
              {outputLevel} / {outputMax} kW
              <Button ml={1} content="Min" onClick={() => act('output', { output: 'min' })} />
              <Button content="Max" onClick={() => act('output', { output: 'max' })} />
              <Button content="Set" onClick={() => act('output', { output: 'set' })} />
            </LabeledList.Item>
            <LabeledList.Item label="Output Load">
              {outputLoad} kW
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
