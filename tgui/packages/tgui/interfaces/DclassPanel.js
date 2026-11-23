import { useBackend } from '../backend';
import { Box, Button, Flex, LabeledList, ProgressBar, Section } from '../components';
import { Window } from '../layouts';

const C = {
  bg: '#0a0a0c',
  border: '#2a2a30',
  borderRed: '#6b0000',
  amber: '#d4a017',
  text: '#c8c8c8',
  textDim: '#6a6a70',
  good: '#0a6e0a',
  red: '#cc2222',
  mono: '"Consolas", "Courier New", monospace',
};

const trustLabel = (t) => {
  switch (t) {
    case 0: return 'Hostile';
    case 1: return 'Suspicious';
    case 2: return 'Neutral';
    case 3: return 'Cooperative';
    case 4: return 'Trusted';
    default: return 'Neutral';
  }
};

export const DclassPanel = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    dclass_number,
    level,
    experience,
    xp_next,
    credits,
    trust_points,
    trust_level,
    strikes,
    tests_completed,
    escape_attempts,
    successful_escapes,
    faction,
    reputation,
    work_options = [],
    current_work,
    time_slot,
    security_level,
    routes = [],
  } = data;

  const work = work_options.find((w) => w.id === current_work);

  return (
    <Window theme="scp_terminal" width={560} height={640}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.borderRed, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>CLASS-D PERSONNEL TERMINAL</Box>
            <Box style={{ color: C.textDim, fontSize: '9px' }}>
              SUBJECT {dclass_number} | SHIFT: {time_slot} | SITE ALERT: {security_level}
            </Box>
          </Box>

          <Section title="Status">
            <LabeledList>
              <LabeledList.Item label="Level">
                <ProgressBar value={experience} minValue={0} maxValue={xp_next} color="blue">
                  Lv {level} — {experience}/{xp_next} XP
                </ProgressBar>
              </LabeledList.Item>
              <LabeledList.Item label="Credits">
                <Box style={{ color: C.amber }}>{credits} cr</Box>
              </LabeledList.Item>
              <LabeledList.Item label="Trust">
                <ProgressBar value={trust_points} minValue={0} maxValue={100}
                  ranges={{ good: [70, 100], average: [40, 70], bad: [0, 40] }}>
                  {trustLabel(trust_level)} ({trust_points})
                </ProgressBar>
              </LabeledList.Item>
              <LabeledList.Item label="Strikes">
                <Box style={{ color: strikes >= 2 ? C.red : C.text }}>
                  {strikes} / 3 {strikes >= 3 ? ' — TERMINATION REVIEW' : ''}
                </Box>
              </LabeledList.Item>
              <LabeledList.Item label="Record">
                {tests_completed} tests | {escape_attempts} escape attempts | {successful_escapes} escapes | rep {reputation}
              </LabeledList.Item>
              <LabeledList.Item label="Faction">
                {faction === 0 ? (
                  <Box>
                    Unaffiliated
                    <Box mt={0.5}>
                      <Button content="Join Rebels" color="bad" onClick={() => act('join_faction', { join_faction: 1 })} />
                      <Button content="Join Collaborators" onClick={() => act('join_faction', { join_faction: 2 })} />
                      <Button content="Join Survivors" onClick={() => act('join_faction', { join_faction: 3 })} />
                    </Box>
                  </Box>
                ) : (
                  <Box>
                    {[null, 'Rebels', 'Collaborators', 'Survivors'][faction]}
                    <Box mt={0.5}>
                      <Button content="Leave Faction" onClick={() => act('leave_faction')} />
                    </Box>
                  </Box>
                )}
              </LabeledList.Item>
            </LabeledList>
          </Section>

          <Section title={current_work ? ('WORK: ' + (work ? work.name : '...')) : 'Work Assignments'}>
            {current_work ? (
              <Box>
                <ProgressBar value={work ? work.time - (work.time - current_work + (work ? 0 : 0)) : 0} minValue={0} maxValue={work ? work.time : 1}>
                  Working...
                </ProgressBar>
                <Box mt={1}>
                  <Button icon="times" content="Abandon (loses trust)" color="bad" onClick={() => act('abandon_work')} />
                </Box>
              </Box>
            ) : (
              <Flex wrap="wrap">
                {work_options.map((w) => (
                  <Flex.Item key={w.id} mr={0.5} mb={0.5}>
                    <Button
                      content={w.name + ' (' + w.reward + 'cr)'}
                      color={w.risk >= 3 ? 'bad' : w.risk >= 2 ? 'warning' : undefined}
                      onClick={() => act('start_work', { start_work: w.id })}
                    />
                  </Flex.Item>
                ))}
              </Flex>
            )}
          </Section>

          <Section title="Escape Routes (Rumored)">
            {routes.map((r) => (
              <Flex key={r.id} align="center" mb={0.5}>
                <Box style={{ flex: 1 }}>
                  {r.name}
                  <Box inline ml={1} style={{ color: C.textDim }}>difficulty {r.difficulty}/4</Box>
                </Box>
                <Box style={{ color: C.textDim, fontSize: '9px' }}>{(r.needs || []).join(', ')}</Box>
              </Flex>
            ))}
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
