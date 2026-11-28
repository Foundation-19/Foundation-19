import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, ProgressBar, Flex, Tabs } from '../components';
import { Window } from '../layouts';

export const Fabricator = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    category,
    functional,
    material_storage,
    current_build,
    build_queue,
    build_options,
  } = data;
  return (
    <Window width={480} height={410} resizable>
      <Window.Content scrollable>
        <Section title="Fabricator">
          {!functional && <Box color="bad">Fabricator is non-functional.</Box>}
          {!!functional && (
            <>
              <Section title="Materials" level={2}>
                <LabeledList>
                  {(material_storage || []).map(mat => (
                    <LabeledList.Item key={mat.name} label={mat.name}>
                      <ProgressBar value={mat.stored / mat.max}>
                        {mat.stored} / {mat.max}
                      </ProgressBar>
                      <Button ml={1} content={mat.eject_label} onClick={() => act('eject', { eject_key: mat.eject_key })} />
                    </LabeledList.Item>
                  ))}
                </LabeledList>
              </Section>
              <Section title="Current Build" level={2}>
                <LabeledList>
                  <LabeledList.Item label="Building">
                    {current_build?.name || "Nothing"} {current_build?.multiplier !== "-" ? `x${current_build.multiplier}` : ""}
                  </LabeledList.Item>
                  <LabeledList.Item label="Progress">
                    {current_build?.progress || "-"}
                  </LabeledList.Item>
                </LabeledList>
              </Section>
              <Section title="Build Queue" level={2}>
                {(build_queue || []).map((order, i) => (
                  <Box key={i} mb={0.5}>
                    {order.name} {order.multiplier !== "-" ? `x${order.multiplier}` : ""}
                    {!!order.reference && (
                      <Button ml={1} icon="times" content="Cancel" onClick={() => act('cancel', { reference: order.reference })} />
                    )}
                  </Box>
                ))}
              </Section>
              <Section title="Build Options" level={2}>
                {(build_options || []).map((option, i) => (
                  <Box key={i} mb={1}>
                    <Button content={option.name} onClick={() => act('build', { reference: option.reference })} />
                    {!!option.unavailable && <Box inline color="bad" ml={1}>Insufficient materials</Box>}
                    <Box inline ml={1} color="label">{option.cost}</Box>
                    {(option.multipliers || []).map(mult => (
                      <Button key={mult.multiplier} content={mult.label} onClick={() => act('build', { reference: option.reference, multiplier: mult.multiplier })} />
                    ))}
                  </Box>
                ))}
              </Section>
            </>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
