import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, ProgressBar, Flex } from '../components';
import { Window } from '../layouts';

export const BatteryRack = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    mode,
    transfer_max,
    output_load,
    input_load,
    equalise,
    cells_max,
    cells_cur,
    cells_list,
  } = data;
  return (
    <Window width={500} height={430}>
      <Window.Content scrollable>
        <Section title="Cell Rack PSU">
          <LabeledList>
            <LabeledList.Item label="Mode">
              <Button content="Off" selected={mode === 0} onClick={() => act('disable')} />
              <Button content="Output" selected={mode === 1} onClick={() => act('enable', { enable: 1 })} />
              <Button content="Input" selected={mode === 2} onClick={() => act('enable', { enable: 2 })} />
              <Button content="Auto" selected={mode === 3} onClick={() => act('enable', { enable: 3 })} />
            </LabeledList.Item>
            <LabeledList.Item label="Transfer Rate">{transfer_max} W</LabeledList.Item>
            <LabeledList.Item label="Output Load">{output_load} W</LabeledList.Item>
            <LabeledList.Item label="Input Load">{input_load} W</LabeledList.Item>
            <LabeledList.Item label="Equalise">
              <Button
                icon={equalise ? 'toggle-on' : 'toggle-off'}
                content={equalise ? 'On' : 'Off'}
                selected={equalise}
                onClick={() => act(equalise ? 'equaliseoff' : 'equaliseon')} />
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Cells ({cells_cur}/{cells_max})">
          <Flex wrap>
            {cells_list.map(cell => (
              <Flex key={cell.slot} basis="33%" mb={1}>
                <Box width="100%">
                  {cell.used ? (
                    <ProgressBar value={cell.percentage / 100} ranges={{ good: [0.5, Infinity], average: [0.15, 0.5], bad: [-Infinity, 0.15] }}>
                      Slot {cell.slot}: {cell.percentage}%
                    </ProgressBar>
                  ) : (
                    <Box color="label">Slot {cell.slot}: Empty</Box>
                  )}
                  {cell.used && (
                    <Button content="Eject" mt={0.5} onClick={() => act('ejectcell', { ejectcell: cell.slot })} />
                  )}
                </Box>
              </Flex>
            ))}
          </Flex>
        </Section>
      </Window.Content>
    </Window>
  );
};
