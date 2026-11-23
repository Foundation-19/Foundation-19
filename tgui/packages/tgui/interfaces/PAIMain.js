import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, Flex, NoticeBox } from '../components';
import { Window } from '../layouts';

export const PAIMain = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    bought,
    not_bought,
    available_ram,
    emotions,
    current_emotion,
  } = data;
  return (
    <Window width={450} height={600}>
      <Window.Content scrollable>
        <Section title="pAI Software Interface">
          <LabeledList>
            <LabeledList.Item label="Available RAM">
              {available_ram}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Installed Software">
          {bought && bought.map((soft, i) => (
            <Button key={i} mr={1} mb={1} onClick={() => act('software', { software: soft.id })}>
              {soft.name} {soft.on ? "[ON]" : ""}
            </Button>
          ))}
        </Section>
        <Section title="Available Software">
          {not_bought && not_bought.map((soft, i) => (
            <Button key={i} mr={1} mb={1} disabled={available_ram < soft.ram} onClick={() => act('purchase', { purchase: soft.id })}>
              {soft.name} ({soft.ram} RAM)
            </Button>
          ))}
        </Section>
        <Section title="Emotion">
          <Flex wrap>
            {emotions && emotions.map((emote, i) => (
              <Flex.Item key={i} m={1}>
                <Button selected={emote.id === current_emotion} onClick={() => act('image', { image: emote.id })}>
                  {emote.name}
                </Button>
              </Flex.Item>
            ))}
          </Flex>
        </Section>
      </Window.Content>
    </Window>
  );
};
