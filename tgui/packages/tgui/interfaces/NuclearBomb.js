import { useBackend } from '../backend';
import { Box, Button, Flex, LabeledList, NoticeBox, Section } from '../components';
import { Window } from '../layouts';

export const NuclearBomb = (props, context) => {
  const { act, data } = useBackend(context);
  const { auth, moveable_anchor, authstatus, safe, time, timer, safety, anchored, yescode, message } = data;

  const pad = (n) => String(Math.floor(n)).padStart(2, '0');
  const mins = pad(time / 60);
  const secs = pad(time % 60);

  return (
    <Window width={300} height={510} resizable>
      <Window.Content>
        <Section title="Nuclear Fission Explosive">
          <Box textAlign="center" fontSize="32px" fontFamily="monospace" color={timer ? 'bad' : 'label'}>
            {mins}:{secs}
          </Box>
          <LabeledList mt={1}>
            <LabeledList.Item label="Status">
              <Box color={timer ? 'bad' : 'good'} bold>
                {authstatus}
              </Box>
            </LabeledList.Item>
            <LabeledList.Item label="Safety">
              <Button
                icon={safety ? 'shield-alt' : 'exclamation-triangle'}
                content={safe}
                color={safety ? 'good' : 'bad'}
                disabled={!yescode}
                onClick={() => act('safety')} />
            </LabeledList.Item>
            {!!moveable_anchor && (
              <LabeledList.Item label="Anchor">
                <Button
                  icon={anchored ? 'lock' : 'unlock'}
                  content={anchored ? 'Anchored' : 'Unanchored'}
                  disabled={!yescode}
                  onClick={() => act('anchor')} />
              </LabeledList.Item>
            )}
          </LabeledList>
        </Section>
        <Section title="Authentication">
          <Button
            fluid
            icon={auth ? 'eject' : 'id-card'}
            content={auth ? 'Remove Disk' : 'Insert Disk'}
            onClick={() => act('auth')} />
        </Section>
        {!!auth && (
          <Section title="Code Entry">
            <Box textAlign="center" fontSize="24px" fontFamily="monospace" mb={1}>
              {message}
            </Box>
            <Flex wrap={1} justify="center">
              {[1, 2, 3, 4, 5, 6, 7, 8, 9, 0].map((n) => (
                <Flex.Item key={n} m={0.5}>
                  <Button
                    content={String(n)}
                    fontSize="16px"
                    onClick={() => act('type', { type: String(n) })} />
                </Flex.Item>
              ))}
            </Flex>
            <Flex mt={1} justify="center">
              <Flex.Item>
                <Button content="E" color="good" onClick={() => act('type', { type: 'E' })} />
              </Flex.Item>
              <Flex.Item ml={1}>
                <Button content="R" color="bad" onClick={() => act('type', { type: 'R' })} />
              </Flex.Item>
            </Flex>
          </Section>
        )}
        {!!yescode && (
          <Section title="Detonation">
            <Flex justify="center">
              <Flex.Item>
                <Button
                  content="-5"
                  disabled={timer}
                  onClick={() => act('time', { time: -300 })} />
              </Flex.Item>
              <Flex.Item>
                <Button
                  content="-1"
                  disabled={timer}
                  onClick={() => act('time', { time: -60 })} />
              </Flex.Item>
              <Flex.Item>
                <Button
                  content="+1"
                  disabled={timer}
                  onClick={() => act('time', { time: 60 })} />
              </Flex.Item>
              <Flex.Item>
                <Button
                  content="+5"
                  disabled={timer}
                  onClick={() => act('time', { time: 300 })} />
              </Flex.Item>
            </Flex>
            <Button
              fluid
              mt={1}
              icon="bomb"
              content={timer ? 'Abort' : 'Detonate'}
              color="bad"
              onClick={() => act('timer')} />
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
