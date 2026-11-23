import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, ProgressBar, NoticeBox } from '../components';
import { Window } from '../layouts';

export const AICard = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    has_ai,
    name,
    hardware_integrity,
    backup_capacitor,
    radio,
    wireless,
    operational,
    flushing,
    laws,
    has_laws,
  } = data;
  return (
    <Window width={600} height={400}>
      <Window.Content scrollable>
        {!has_ai ? (
          <NoticeBox>No AI Loaded</NoticeBox>
        ) : (
          <Section title={name}>
            <LabeledList>
              <LabeledList.Item label="Operational">
                {operational ? "Yes" : "No"}
              </LabeledList.Item>
              <LabeledList.Item label="Hardware Integrity">
                <ProgressBar value={hardware_integrity / 100}>
                  {hardware_integrity}%
                </ProgressBar>
              </LabeledList.Item>
              <LabeledList.Item label="Backup Capacitor">
                <ProgressBar value={backup_capacitor / 100}>
                  {backup_capacitor}%
                </ProgressBar>
              </LabeledList.Item>
              <LabeledList.Item label="Radio">
                <Button selected={radio} onClick={() => act('radio', { radio: radio ? 1 : 0 })}>
                  {radio ? "Enabled" : "Disabled"}
                </Button>
              </LabeledList.Item>
              <LabeledList.Item label="Wireless">
                <Button selected={wireless} onClick={() => act('wireless', { wireless: wireless ? 1 : 0 })}>
                  {wireless ? "Enabled" : "Disabled"}
                </Button>
              </LabeledList.Item>
              <LabeledList.Item label="Memory Wipe">
                <Button color="bad" onClick={() => act('wipe')}>Wipe</Button>
                {flushing && <Box inline color="bad"> WIPING...</Box>}
              </LabeledList.Item>
            </LabeledList>
          </Section>
        )}
        {!!has_laws && (
          <Section title="Laws">
            {laws && laws.map((law, i) => (
              <Box key={i} mb={1}>
                {law.index}. {law.law}
              </Box>
            ))}
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
