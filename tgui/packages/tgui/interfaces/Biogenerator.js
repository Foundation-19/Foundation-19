import { useBackend, useLocalState } from '../backend';
import { Box, Button, Flex, LabeledList, NoticeBox, ProgressBar, Section, Tabs } from '../components';
import { Window } from '../layouts';

const BG_READY = 0;
const BG_PROCESSING = 1;
const BG_NO_BEAKER = 2;
const BG_COMPLETE = 3;
const BG_EMPTY = 4;

export const Biogenerator = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    state,
    points,
    types,
  } = data;

  const [selectedType, setSelectedType] = useLocalState(context, 'selectedType', types && types.length > 0 ? types[0].type_name : null);

  const stateLabels = {
    [BG_READY]: "Ready",
    [BG_PROCESSING]: "Processing...",
    [BG_NO_BEAKER]: "No beaker attached",
    [BG_COMPLETE]: "Complete",
    [BG_EMPTY]: "Empty - insert produce",
  };

  return (
    <Window width={440} height={600} resizable>
      <Window.Content scrollable>
        <Section title="Biogenerator">
          <LabeledList>
            <LabeledList.Item label="Status">
              {stateLabels[state] || "Unknown"}
            </LabeledList.Item>
            <LabeledList.Item label="Points">
              {points}
            </LabeledList.Item>
          </LabeledList>
          <Box mt={1}>
            <Button
              icon="power-off"
              content="Activate"
              disabled={state === BG_PROCESSING}
              onClick={() => act('activate')} />
            <Button
              icon="eject"
              content="Detach Beaker"
              onClick={() => act('detach')} />
            {state === BG_COMPLETE && (
              <Button
                icon="arrow-left"
                content="Return"
                onClick={() => act('return')} />
            )}
          </Box>
        </Section>
        {state === BG_READY && types && (
          <Section title="Products">
            <Tabs>
              {types.map((typeData, i) => (
                <Tabs.Tab
                  key={i}
                  selected={selectedType === typeData.type_name}
                  onClick={() => setSelectedType(typeData.type_name)}>
                  {typeData.type_name}
                </Tabs.Tab>
              ))}
            </Tabs>
            {types
              .filter(t => t.type_name === selectedType)
              .map((typeData, i) => (
                <Box key={i} mt={1}>
                  {typeData.products.map((product, j) => (
                    <Box key={j} mb={1}>
                      <Flex align="center" justify="space-between">
                        <Flex.Item>{product.name}</Flex.Item>
                        <Flex.Item>
                          <Button
                            content={product.cost + " pts"}
                            disabled={points < product.cost}
                            onClick={() => act('create', {
                              type: typeData.type_name,
                              product_index: product.product_index,
                            })} />
                        </Flex.Item>
                      </Flex>
                    </Box>
                  ))}
                </Box>
              ))}
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
