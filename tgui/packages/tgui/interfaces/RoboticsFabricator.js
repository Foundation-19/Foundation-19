import { useBackend, useLocalState } from '../backend';
import { Box, Button, Flex, LabeledList, NoticeBox, ProgressBar, Section, Tabs } from '../components';
import { Window } from '../layouts';

export const RoboticsFabricator = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    current,
    queue,
    buildable,
    category,
    categories,
    manufacturers,
    manufacturer,
    materials,
    maxres,
    sync,
    builtperc,
  } = data;

  const [selectedCategory, setSelectedCategory] = useLocalState(context, 'selectedCategory', category);

  return (
    <Window width={800} height={600} resizable>
      <Window.Content scrollable>
        <Flex direction="row" wrap="wrap" m={-0.5}>
          <Flex.Item basis="60%" grow={1} m={0.5}>
            <Section title="Exosuit Fabricator">
              {current && (
                <LabeledList>
                  <LabeledList.Item label="Building">
                    {current}
                  </LabeledList.Item>
                  <LabeledList.Item label="Progress">
                    <ProgressBar value={builtperc / 100} content={builtperc + "%"} />
                  </LabeledList.Item>
                </LabeledList>
              )}
              {!current && (
                <Box color="label">No item being built.</Box>
              )}
              <Box mt={1}>
                <Button
                  icon="sync"
                  content="Sync Research"
                  onClick={() => act('sync')} />
              </Box>
              {sync && (
                <Box mt={1} color="label">{sync}</Box>
              )}
            </Section>
            <Section title="Build Queue">
              {queue && queue.length > 0 && queue.map((name, i) => (
                <Box key={i} mb={1}>
                  <Flex align="center" justify="space-between">
                    <Flex.Item>{name}</Flex.Item>
                    <Flex.Item>
                      <Button
                        icon="trash"
                        color="bad"
                        content="Remove"
                        onClick={() => act('remove', { remove: i + 2 })} />
                    </Flex.Item>
                  </Flex>
                </Box>
              ))}
              {(!queue || queue.length === 0) && (
                <Box color="label">Queue is empty.</Box>
              )}
            </Section>
          </Flex.Item>
          <Flex.Item basis="35%" grow={1} m={0.5}>
            <Section title="Materials">
              {materials && materials.map((mat, i) => (
                <Box key={i} mb={1}>
                  <Flex align="center" justify="space-between">
                    <Flex.Item grow={1}>
                      {mat.mat}: {mat.amt}
                    </Flex.Item>
                    <Flex.Item>
                      <Button
                        icon="eject"
                        content="Eject"
                        disabled={mat.amt <= 0}
                        onClick={() => act('eject', {
                          eject: mat.mat,
                          amount: 50,
                        })} />
                      <Button
                        icon="eject"
                        content="All"
                        disabled={mat.amt <= 0}
                        onClick={() => act('eject', {
                          eject: mat.mat,
                          amount: -1,
                        })} />
                    </Flex.Item>
                  </Flex>
                </Box>
              ))}
            </Section>
            {manufacturers && (
              <Section title="Manufacturer">
                {manufacturers.map((m, i) => (
                  <Button
                    key={i}
                    content={m.company}
                    selected={manufacturer === m.id}
                    onClick={() => act('manufacturer', { manufacturer: m.id })} />
                ))}
              </Section>
            )}
          </Flex.Item>
        </Flex>
        <Section title="Designs">
          <Tabs>
            {categories && categories.map((cat, i) => (
              <Tabs.Tab
                key={i}
                selected={selectedCategory === cat}
                onClick={() => {
                  setSelectedCategory(cat);
                  act('category', { category: cat });
                }}>
                {cat}
              </Tabs.Tab>
            ))}
          </Tabs>
          {buildable && buildable
            .filter(d => d.category === selectedCategory)
            .map((design, i) => (
              <Box key={i} mb={1}>
                <Flex align="center" justify="space-between">
                  <Flex.Item grow={1}>
                    <Box bold>{design.name}</Box>
                    <Box fontSize="11px" color="label">
                      {design.resourses} | {design.time}
                    </Box>
                  </Flex.Item>
                  <Flex.Item>
                    <Button
                      icon="plus"
                      content="Add"
                      onClick={() => act('build', { build: design.id })} />
                  </Flex.Item>
                </Flex>
              </Box>
            ))}
        </Section>
      </Window.Content>
    </Window>
  );
};
