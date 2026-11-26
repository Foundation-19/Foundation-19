import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, ProgressBar } from '../components';
import { Window } from '../layouts';

export const SkillUI = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    name,
    job,
    hide_unskilled,
    skills_by_cat,
    can_choose,
    selection_data,
    antag_buff,
    antag,
    admin_mode,
  } = data;
  return (
    <Window width={600} height={600}>
      <Window.Content scrollable>
        <Section title={name} buttons={
          <Button onClick={() => act('toggle_hide_unskilled')}>
            {hide_unskilled ? "Show Unskilled" : "Hide Unskilled"}
          </Button>
        }>
          {job && <Box color="label">Job: {job}</Box>}
          {!!can_choose && selection_data && (
            <Box mt={1}>
              {selection_data.map((level, i) => (
                <Box key={i} mb={1}>
                  <Box bold>{level.name} (Remaining: {level.remaining})</Box>
                  {level.selected && level.selected.map((skill, j) => (
                    <Button key={j} ml={1} onClick={() => act('remove_skill', { remove_skill: skill.ref })}>
                      {skill.name} ✕
                    </Button>
                  ))}
                  <Button ml={1} onClick={() => act('add_skill', { add_skill: level.level })}>
                    Add Skill
                  </Button>
                </Box>
              ))}
              <Button mt={1} color="good" onClick={() => act('submit')}>
                Commit Selection
              </Button>
              <Button ml={1} color="bad" onClick={() => act('admin_reset')}>
                Request Admin Reset
              </Button>
            </Box>
          )}
          {!!antag_buff && <Box color="bad" mt={1}>Antag buffs active</Box>}
        </Section>
        {skills_by_cat && skills_by_cat.map((cat, i) => (
          <Section key={i} title={cat.name}>
            {cat.skills && cat.skills.map((skill, j) => (
              <Box key={j} mb={1}>
                <Box bold>{skill.name}</Box>
                {skill.levels && skill.levels.map((level, k) => (
                  <Button
                    key={k}
                    ml={1}
                    selected={level.selected}
                    disabled={level.blank || (!level.available && !admin_mode)}
                    onClick={() => act('value_hit', { skill: skill.ref, value_hit: level.val })}
                  >
                    {level.name || level.val}
                  </Button>
                ))}
              </Box>
            ))}
          </Section>
        ))}
      </Window.Content>
    </Window>
  );
};
