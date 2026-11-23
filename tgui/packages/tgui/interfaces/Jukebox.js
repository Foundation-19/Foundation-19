import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, NumberInput, Flex } from '../components';
import { Window } from '../layouts';

export const Jukebox = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    track,
    playing,
    volume,
    tracks,
  } = data;
  return (
    <Window width={350} height={400}>
      <Window.Content scrollable>
        <Section title="Now Playing">
          <LabeledList>
            <LabeledList.Item label="Track">{track}</LabeledList.Item>
            <LabeledList.Item label="Status">
              <Button selected={playing} onClick={() => playing ? act('stop') : act('play')}>
                {playing ? "Playing" : "Stopped"}
              </Button>
            </LabeledList.Item>
            <LabeledList.Item label="Volume">
              <NumberInput
                value={volume}
                minValue={0}
                maxValue={50}
                step={10}
                onChange={(e, value) => act('volume', { dat: value })}
              />
            </LabeledList.Item>
          </LabeledList>
          <Flex mt={1}>
            <Flex.Item>
              <Button onClick={() => act('last')}>Previous</Button>
            </Flex.Item>
            <Flex.Item ml={1}>
              <Button onClick={() => act('next')}>Next</Button>
            </Flex.Item>
          </Flex>
        </Section>
        <Section title="Track List">
          {tracks && tracks.map((t, i) => (
            <Button key={i} fluid onClick={() => act('track', { dat: t.index })}>
              {t.track}
            </Button>
          ))}
        </Section>
      </Window.Content>
    </Window>
  );
};
