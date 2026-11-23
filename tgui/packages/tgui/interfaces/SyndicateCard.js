import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const SyndicateCard = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    electronic_warfare,
    entries,
  } = data;
  return (
    <Window width={600} height={400}>
      <Window.Content scrollable>
        <Section title="Agent ID Card">
          <LabeledList>
            <LabeledList.Item label="Electronic Warfare">
              <Button
                selected={electronic_warfare}
                onClick={() => act('electronic_warfare', { electronic_warfare: electronic_warfare ? 0 : 1 })}
              >
                {electronic_warfare ? "Enabled" : "Disabled"}
              </Button>
            </LabeledList.Item>
          </LabeledList>
          {entries && entries.map((entry, i) => (
            <Button key={i} fluid mt={1} onClick={() => act('set', { set: entry.name })}>
              {entry.name}: {entry.value}
            </Button>
          ))}
        </Section>
      </Window.Content>
    </Window>
  );
};
