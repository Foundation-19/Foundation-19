import { useBackend } from '../backend';
import { Box, Button, Flex, LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const BrigTimer = (props, context) => {
  const { act, data } = useBackend(context);
  const { timing, minutes, seconds, flash } = data;

  const pad = (n) => String(n).padStart(2, '0');

  return (
    <Window width={270} height={180} resizable>
      <Window.Content>
        <Section title="Brig Timer">
          <Box fontSize="24px" textAlign="center" fontFamily="monospace">
            {pad(minutes)}:{pad(seconds)}
          </Box>
          <Flex mt={1} justify="center">
            <Flex.Item>
              <Button
                icon={timing ? 'pause' : 'play'}
                content={timing ? 'Stop' : 'Start'}
                color={timing ? 'bad' : 'good'}
                onClick={() => act('toggle')} />
            </Flex.Item>
            <Flex.Item ml={1}>
              <Button
                icon="lightbulb"
                content="Flash"
                disabled={!flash}
                onClick={() => act('flash')} />
            </Flex.Item>
          </Flex>
          {!timing && (
            <Flex mt={1} justify="center">
              <Flex.Item>
                <Button content="-5m" onClick={() => act('adjust', { adjust: -300 })} />
              </Flex.Item>
              <Flex.Item>
                <Button content="-1m" onClick={() => act('adjust', { adjust: -60 })} />
              </Flex.Item>
              <Flex.Item>
                <Button content="+1m" onClick={() => act('adjust', { adjust: 60 })} />
              </Flex.Item>
              <Flex.Item>
                <Button content="+5m" onClick={() => act('adjust', { adjust: 300 })} />
              </Flex.Item>
            </Flex>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
