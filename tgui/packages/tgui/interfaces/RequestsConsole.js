import { useBackend } from '../backend';
import { Box, Button, Flex, LabeledList, Section, NoticeBox } from '../components';
import { Window } from '../layouts';

const RCS_MAINMENU = 0;
const RCS_RQASSIST = 1;
const RCS_RQSUPPLY = 2;
const RCS_SENDINFO = 3;
const RCS_SENTPASS = 4;
const RCS_SENTFAIL = 5;
const RCS_VIEWMSGS = 6;
const RCS_MESSAUTH = 7;
const RCS_ANNOUNCE = 8;

const DepartmentList = (props, context) => {
  const { act, data } = useBackend(context);
  const { departments, department } = props;
  const myDept = data.department;

  if (!departments || departments.length === 0) {
    return <Box color="label">No departments available.</Box>;
  }

  return (
    <Flex direction="column" wrap>
      {departments
        .filter(d => d !== myDept)
        .map(d => (
          <Flex.Item key={d} mb={1}>
            <Flex align="center" justify="space-between">
              <Flex.Item grow={1}>{d}</Flex.Item>
              <Flex.Item>
                <Button
                  content="Message"
                  onClick={() => act('write', { recipient: d, priority: '1' })} />
                <Button
                  content="High Priority"
                  color="bad"
                  onClick={() => act('write', { recipient: d, priority: '2' })} />
              </Flex.Item>
            </Flex>
          </Flex.Item>
        ))}
    </Flex>
  );
};

export const RequestsConsole = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    screen,
    department,
    message_log,
    newmessagepriority,
    silent,
    announcementConsole,
    assist_dept,
    supply_dept,
    info_dept,
    message,
    recipient,
    priority,
    msgStamped,
    msgVerified,
    announceAuth,
  } = data;

  return (
    <Window width={520} height={460} resizable>
      <Window.Content scrollable>
        {screen === RCS_MAINMENU && (
          <Section title={department + " Requests Console"}>
            {newmessagepriority === 1 && (
              <NoticeBox>There are new messages</NoticeBox>
            )}
            {newmessagepriority === 2 && (
              <NoticeBox danger>NEW PRIORITY MESSAGES</NoticeBox>
            )}
            <Button
              icon={newmessagepriority ? "envelope" : "envelope-open"}
              content="View Messages"
              onClick={() => act('setScreen', { screen: RCS_VIEWMSGS })} />
            <Box mt={1}>
              <Button
                icon="hands-helping"
                content="Request Assistance"
                onClick={() => act('setScreen', { screen: RCS_RQASSIST })} />
            </Box>
            <Box mt={1}>
              <Button
                icon="box"
                content="Request Supplies"
                onClick={() => act('setScreen', { screen: RCS_RQSUPPLY })} />
            </Box>
            <Box mt={1}>
              <Button
                icon="comment"
                content="Relay Anonymous Information"
                onClick={() => act('setScreen', { screen: RCS_SENDINFO })} />
            </Box>
            {announcementConsole && (
              <Box mt={1}>
                <Button
                  icon="bullhorn"
                  content="Send Announcement"
                  onClick={() => act('setScreen', { screen: RCS_ANNOUNCE })} />
              </Box>
            )}
            <Box mt={1}>
              <Button
                icon={silent ? "volume-mute" : "volume-up"}
                content={silent ? "Speaker OFF" : "Speaker ON"}
                selected={!silent}
                onClick={() => act('toggleSilent')} />
            </Box>
          </Section>
        )}
        {screen === RCS_RQASSIST && (
          <Section title="Request Assistance">
            <DepartmentList departments={assist_dept} />
            <Button
              mt={1}
              icon="arrow-left"
              content="Back"
              onClick={() => act('setScreen', { screen: RCS_MAINMENU })} />
          </Section>
        )}
        {screen === RCS_RQSUPPLY && (
          <Section title="Request Supplies">
            <DepartmentList departments={supply_dept} />
            <Button
              mt={1}
              icon="arrow-left"
              content="Back"
              onClick={() => act('setScreen', { screen: RCS_MAINMENU })} />
          </Section>
        )}
        {screen === RCS_SENDINFO && (
          <Section title="Relay Information">
            <DepartmentList departments={info_dept} />
            <Button
              mt={1}
              icon="arrow-left"
              content="Back"
              onClick={() => act('setScreen', { screen: RCS_MAINMENU })} />
          </Section>
        )}
        {screen === RCS_SENTPASS && (
          <Section title="Message Sent">
            <NoticeBox success>Message sent successfully.</NoticeBox>
            <Button
              icon="arrow-right"
              content="Continue"
              onClick={() => act('setScreen', { screen: RCS_MAINMENU })} />
          </Section>
        )}
        {screen === RCS_SENTFAIL && (
          <Section title="Message Failed">
            <NoticeBox danger>An error occurred. Message not sent.</NoticeBox>
            <Button
              icon="arrow-right"
              content="Continue"
              onClick={() => act('setScreen', { screen: RCS_MAINMENU })} />
          </Section>
        )}
        {screen === RCS_VIEWMSGS && (
          <Section title="Messages">
            {(!message_log || message_log.length === 0) && (
              <Box color="label">No messages have been received.</Box>
            )}
            {message_log && message_log.map((msg, i) => (
              <Box key={i} dangerouslySetInnerHTML={{ __html: msg }} />
            ))}
            <Button
              mt={1}
              icon="arrow-left"
              content="Back"
              onClick={() => act('setScreen', { screen: RCS_MAINMENU })} />
          </Section>
        )}
        {screen === RCS_MESSAUTH && (
          <Section title="Message Authentication">
            <LabeledList>
              <LabeledList.Item label="Recipient">
                {recipient}
              </LabeledList.Item>
              <LabeledList.Item label="Message">
                {message}
              </LabeledList.Item>
              <LabeledList.Item label="Validated by">
                <Box dangerouslySetInnerHTML={{ __html: msgVerified }} />
              </LabeledList.Item>
              <LabeledList.Item label="Stamped by">
                <Box dangerouslySetInnerHTML={{ __html: msgStamped }} />
              </LabeledList.Item>
            </LabeledList>
            <Box mt={1}>
              <Button
                icon="paper-plane"
                content="Send Message"
                color="good"
                onClick={() => act('sendMessage')} />
              <Button
                icon="arrow-left"
                content="Back"
                onClick={() => act('setScreen', { screen: RCS_MAINMENU })} />
            </Box>
          </Section>
        )}
        {screen === RCS_ANNOUNCE && (
          <Section title="Announcement">
            <LabeledList>
              <LabeledList.Item label="Message">
                {message || "No message written."}
              </LabeledList.Item>
            </LabeledList>
            <Button
              mt={1}
              icon="pen"
              content="Write Message"
              onClick={() => act('writeAnnouncement')} />
            <Box mt={1}>
              {announceAuth ? (
                <Box color="good">ID verified. Authentication accepted.</Box>
              ) : (
                <Box color="label">Swipe your ID card to authenticate yourself.</Box>
              )}
            </Box>
            <Box mt={1}>
              <Button
                icon="bullhorn"
                content="Announce"
                color="good"
                disabled={!announceAuth || !message}
                onClick={() => act('sendAnnouncement')} />
              <Button
                icon="arrow-left"
                content="Back"
                onClick={() => act('setScreen', { screen: RCS_MAINMENU })} />
            </Box>
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
