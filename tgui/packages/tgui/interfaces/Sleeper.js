import { useBackend } from '../backend';
import { Box, Button, LabeledList, NoticeBox, Section, Flex, ProgressBar } from '../components';
import { Window } from '../layouts';

export const Sleeper = (props, context) => {
  const { act, data } = useBackend(context);
  const { power, occupant, reagents = [], beaker, filtering, pump, stasis, stasis_settings = [], skill_check } = data;

  if (!power) {
    return (
      <Window width={600} height={400} resizable>
        <Window.Content>
          <NoticeBox danger>Unit is unpowered.</NoticeBox>
        </Window.Content>
      </Window>
    );
  }

  return (
    <Window width={600} height={600} resizable>
      <Window.Content scrollable>
        <Section title="Occupant">
          {occupant ? (
            <Box dangerouslySetInnerHTML={{ __html: occupant }} />
          ) : (
            <Box color="label">No occupant detected.</Box>
          )}
          <Flex mt={1}>
            <Flex.Item>
              <Button
                icon="eject"
                content="Eject Occupant"
                disabled={!occupant}
                onClick={() => act('eject')} />
            </Flex.Item>
            <Flex.Item ml={2}>
              <Button
                icon="flask"
                content="Eject Beaker"
                disabled={beaker < 0}
                onClick={() => act('beaker')} />
            </Flex.Item>
          </Flex>
        </Section>
        <Section title="Dialysis">
          <LabeledList>
            <LabeledList.Item label="Blood Filter">
              <Button
                icon={filtering ? 'toggle-on' : 'toggle-off'}
                content={filtering ? 'Active' : 'Inactive'}
                selected={filtering}
                disabled={!occupant || beaker < 0}
                onClick={() => act('filter', { filter: filtering ? 0 : 1 })} />
            </LabeledList.Item>
            <LabeledList.Item label="Stomach Pump">
              <Button
                icon={pump ? 'toggle-on' : 'toggle-off'}
                content={pump ? 'Active' : 'Inactive'}
                selected={pump}
                disabled={!occupant || beaker < 0}
                onClick={() => act('pump', { pump: pump ? 0 : 1 })} />
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Chemical Injection">
          {!occupant && (
            <Box color="label">No occupant detected.</Box>
          )}
          {reagents.map((reagent) => (
            <Flex key={reagent.name} mb={1} align="center">
              <Flex.Item grow={1}>
                <Box bold>{reagent.name}</Box>
                {reagent.amount !== undefined && (
                  <ProgressBar
                    value={reagent.amount}
                    minValue={0}
                    maxValue={20}
                    ml={1}
                    width="100px"
                    color="blue">
                    {reagent.amount}u
                  </ProgressBar>
                )}
              </Flex.Item>
              <Flex.Item ml={1}>
                <Button
                  content="5u"
                  disabled={!occupant}
                  onClick={() => act('chemical', { chemical: reagent.name, amount: 5 })} />
                <Button
                  content="10u"
                  disabled={!occupant}
                  onClick={() => act('chemical', { chemical: reagent.name, amount: 10 })} />
              </Flex.Item>
            </Flex>
          ))}
        </Section>
        <Section title="Stasis">
          {stasis_settings.map((setting) => (
            <Button
              key={setting}
              content={`${setting}x`}
              selected={stasis === setting}
              onClick={() => act('stasis', { stasis: setting })} />
          ))}
        </Section>
      </Window.Content>
    </Window>
  );
};
