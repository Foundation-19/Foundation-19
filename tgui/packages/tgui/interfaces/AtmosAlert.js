import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, NoticeBox } from '../components';
import { Window } from '../layouts';

export const AtmosAlert = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    priority_alarms,
    minor_alarms,
  } = data;
  return (
    <Window width={500} height={500}>
      <Window.Content scrollable>
        <Section title="Priority Alarms">
          {priority_alarms && priority_alarms.length > 0 ? (
            priority_alarms.map((alarm, i) => (
              <Box key={i} mb={1}>
                <Button color="bad" onClick={() => act('clear_alarm', { clear_alarm: alarm.ref })}>
                  {alarm.name}
                </Button>
              </Box>
            ))
          ) : (
            <NoticeBox info>No Priority Alarms</NoticeBox>
          )}
        </Section>
        <Section title="Minor Alarms">
          {minor_alarms && minor_alarms.length > 0 ? (
            minor_alarms.map((alarm, i) => (
              <Box key={i} mb={1}>
                <Button onClick={() => act('clear_alarm', { clear_alarm: alarm.ref })}>
                  {alarm.name}
                </Button>
              </Box>
            ))
          ) : (
            <NoticeBox info>No Minor Alarms</NoticeBox>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
