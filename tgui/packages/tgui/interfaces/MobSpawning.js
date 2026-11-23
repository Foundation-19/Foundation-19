import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const MobSpawning = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    area_name,
    mobs,
    messages,
    message_class,
    interval,
    variation,
    radius,
    atmos_immune,
    faction,
    spawn_count,
    paused,
  } = data;
  return (
    <Window width={425} height={600}>
      <Window.Content scrollable>
        <Section title={`Spawner - ${area_name || "Unknown"}`}>
          <LabeledList>
            <LabeledList.Item label="Spawn Count">
              <Button onClick={() => act('set_spawn_count')}>{spawn_count === 0 ? "Infinite" : spawn_count}</Button>
            </LabeledList.Item>
            <LabeledList.Item label="Interval">
              <Button onClick={() => act('set_spawn_interval')}>{interval / 10}s</Button>
            </LabeledList.Item>
            <LabeledList.Item label="Variation">
              <Button onClick={() => act('set_spawn_time_variation')}>{variation / 10}s</Button>
            </LabeledList.Item>
            <LabeledList.Item label="Radius">
              <Button onClick={() => act('set_radius')}>{radius === -1 ? "Area" : radius}</Button>
            </LabeledList.Item>
            <LabeledList.Item label="Atmos Immune">
              <Button selected={atmos_immune} onClick={() => act('atmos_immune')}>{atmos_immune ? "Yes" : "No"}</Button>
            </LabeledList.Item>
            <LabeledList.Item label="Faction">
              <Button onClick={() => act('set_faction', { set_faction: faction || "reset" })}>{faction || "Default"}</Button>
            </LabeledList.Item>
            <LabeledList.Item label="Paused">
              <Button selected={paused} onClick={() => act('pause')}>{paused ? "Paused" : "Running"}</Button>
            </LabeledList.Item>
          </LabeledList>
          <Button mt={1} color="good" onClick={() => act('pick')}>Add Mob</Button>
          <Button ml={1} color="bad" onClick={() => act('remove')}>Remove Mob</Button>
          <Button ml={1} color="bad" onClick={() => act('delete')}>Delete Spawner</Button>
        </Section>
        <Section title="Mobs">
          {mobs && mobs.map((mob, i) => (
            <Box key={i}>{mob}</Box>
          ))}
        </Section>
        <Section title="Messages" buttons={
          <Box>
            <Button onClick={() => act('add_message')}>Add</Button>
            <Button ml={1} onClick={() => act('remove_message')}>Remove</Button>
            <Button ml={1} onClick={() => act('set_span_class')}>Class: {message_class}</Button>
          </Box>
        }>
          {messages && messages.map((msg, i) => (
            <Box key={i}>{msg}</Box>
          ))}
        </Section>
      </Window.Content>
    </Window>
  );
};
