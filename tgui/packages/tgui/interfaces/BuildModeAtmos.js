import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, NumberInput, Flex } from '../components';
import { Window } from '../layouts';

export const BuildModeAtmos = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    total_moles,
    temperature,
    volume_total,
    gases,
    mode,
    title,
  } = data;
  return (
    <Window width={425} height={600}>
      <Window.Content scrollable>
        <Section title={`Atmosphere Editor - ${title || "Unknown"}`}>
          <LabeledList>
            <LabeledList.Item label="Mode">
              <Button onClick={() => act('change_mode')}>{mode}</Button>
            </LabeledList.Item>
            <LabeledList.Item label="Temperature">
              {temperature}K
              <Button ml={1} onClick={() => act('temperature')}>Set</Button>
            </LabeledList.Item>
            <LabeledList.Item label="Total Moles">
              {total_moles}
              <Button ml={1} onClick={() => act('moles_total')}>Adjust</Button>
            </LabeledList.Item>
            <LabeledList.Item label="Volume">{volume_total}L</LabeledList.Item>
          </LabeledList>
          <Button mt={1} color="good" onClick={() => act('set_predefined_atmos', { set_predefined_atmos: "o2n2_standard" })}>
            Set Standard Atmos
          </Button>
          <Button mt={1} onClick={() => act('add_gas')}>Add Gas</Button>
          <Button mt={1} onClick={() => act('remove_gas')}>Remove Gas</Button>
        </Section>
        <Section title="Gas Composition">
          {gases && Object.entries(gases).map(([gasId, moles]) => (
            <Box key={gasId} mb={1}>
              {gasId}: {moles} moles
              <Button ml={1} onClick={() => act('modify_gas', { modify_gas: gasId })}>Set</Button>
            </Box>
          ))}
        </Section>
      </Window.Content>
    </Window>
  );
};
