import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

const C = {
  bg: '#0a0a0c',
  panel: '#111114',
  border: '#2a2a30',
  amber: '#c2960e',
  text: '#c8c8c8',
  textDim: '#7a7a80',
  mono: 'Consolas, monospace',
};

export const ArcadeGame = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    enemy_name,
    temp,
    player_hp,
    player_mp,
    enemy_hp,
    gameover,
    blocked,
  } = data;

  return (
    <Window width={400} height={320}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>{enemy_name}</Box>
          </Box>

          <Section style={{ border: '1px solid ' + C.border }}>
            <Box style={{ color: C.amber }}>{temp}</Box>
          </Section>

          <Section title="Status" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
            <LabeledList>
              <LabeledList.Item label="Health">{player_hp}</LabeledList.Item>
              <LabeledList.Item label="Magic">{player_mp}</LabeledList.Item>
              <LabeledList.Item label="Enemy Health">{enemy_hp}</LabeledList.Item>
            </LabeledList>
          </Section>

          <Box mt={1}>
            {gameover ? (
              <Button inline icon="redo" content="New Game" onClick={() => act('newgame')} />
            ) : (
              <>
                <Button
                  inline
                  mr={0.5}
                  icon="bolt"
                  content="Attack"
                  disabled={blocked}
                  onClick={() => act('attack')} />
                <Button
                  inline
                  mr={0.5}
                  icon="medkit"
                  content="Heal"
                  disabled={blocked}
                  onClick={() => act('heal')} />
                <Button
                  inline
                  mr={0.5}
                  icon="battery-three-quarters"
                  content="Recharge Power"
                  disabled={blocked}
                  onClick={() => act('charge')} />
              </>
            )}
          </Box>
        </Box>
      </Window.Content>
    </Window>
  );
};
