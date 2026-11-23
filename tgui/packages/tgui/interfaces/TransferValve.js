import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const TransferValve = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    attachmentOne,
    attachmentTwo,
    valveAttachment,
    valveOpen,
  } = data;
  return (
    <Window width={460} height={280}>
      <Window.Content>
        <Section title="Tank Transfer Valve">
          <LabeledList>
            <LabeledList.Item label="Tank One">
              {attachmentOne || "None"}
              {!!attachmentOne && (
                <Button ml={1} onClick={() => act('tankone')}>Remove</Button>
              )}
            </LabeledList.Item>
            <LabeledList.Item label="Tank Two">
              {attachmentTwo || "None"}
              {!!attachmentTwo && (
                <Button ml={1} onClick={() => act('tanktwo')}>Remove</Button>
              )}
            </LabeledList.Item>
            <LabeledList.Item label="Valve">
              <Button selected={valveOpen} onClick={() => act('open')}>
                {valveOpen ? "Open" : "Closed"}
              </Button>
            </LabeledList.Item>
            <LabeledList.Item label="Attachment">
              {valveAttachment || "None"}
              {!!valveAttachment && (
                <Box inline>
                  <Button ml={1} onClick={() => act('device')}>Interact</Button>
                  <Button ml={1} onClick={() => act('rem_device')}>Remove</Button>
                </Box>
              )}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
