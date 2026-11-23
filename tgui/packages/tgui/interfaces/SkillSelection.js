import { useBackend } from '../backend';
import { Box, Button, Flex, LabeledList, Section } from '../components';
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

const SkillRow = (props, context) => {
  const { act } = useBackend(context);
  const { skill } = props;
  const canRaise = skill.current < skill.max && skill.current < skill.max_affordable;
  const canLower = skill.current > skill.min;
  return (
    <Flex align="center" mb={0.5}>
      <Box style={{ width: '180px', flexShrink: 0, color: C.text }}>{skill.name}</Box>
      <Flex.Item grow={1}>
        <Flex align="center">
          {skill.levels.map((lvl) => {
            const isCurrent = lvl.level === skill.current;
            const selectable = lvl.level <= skill.max_affordable && lvl.level >= skill.min;
            return (
              <Flex.Item key={lvl.level} mr={0.5}>
                <Button
                  content={lvl.name}
                  selected={isCurrent}
                  color={isCurrent ? 'good' : undefined}
                  disabled={!selectable}
                  onClick={() => act('set_skill', { skill: skill.skill_ref, value: lvl.level })}
                />
              </Flex.Item>
            );
          })}
        </Flex>
      </Flex.Item>
      <Box style={{ color: skill.spent > 0 ? C.amber : C.textDim, width: '40px', textAlign: 'right' }}>
        {skill.spent}pt
      </Box>
    </Flex>
  );
};

export const SkillSelection = (props, context) => {
  const { data } = useBackend(context);
  const {
    job_title,
    points_remaining,
    categories = [],
  } = data;

  return (
    <Window theme="scp_terminal" width={760} height={720}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.borderRed, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>SKILL ALLOCATION — {job_title}</Box>
            <Box style={{ color: points_remaining > 0 ? C.good : C.textDim, fontSize: '11px' }}>
              SKILL POINTS REMAINING: {points_remaining}
            </Box>
          </Box>

          {categories.map((cat) => (
            <Section key={cat.name} title={cat.name}>
              {cat.skills.map((skill, i) => (
                <SkillRow key={i} skill={skill} />
              ))}
            </Section>
          ))}

          <Box style={{ color: C.textDim, fontSize: '10px', padding: '8px' }}>
            Click a level name to allocate. Costs are per-job; min levels are free. Points not spent are lost on round start.
          </Box>
        </Box>
      </Window.Content>
    </Window>
  );
};
