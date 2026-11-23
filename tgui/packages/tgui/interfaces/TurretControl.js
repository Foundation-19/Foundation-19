import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const TurretControl = (props, context) => {
  const { act, data } = useBackend(context);
  const { access, locked, enabled, lethal, is_lethal, settings = [] } = data;

  if(!access) {
    return (
      <Window width={500} height={200} resizable>
        <Window.Content>
          <Section title="Turret Controls">
            <Box color="bad" textAlign="center" fontSize="16px">
              Access Denied
            </Box>
          </Section>
        </Window.Content>
      </Window>
    );
  }

  return (
    <Window width={500} height={350} resizable>
      <Window.Content scrollable>
        <Section title="Turret Controls">
          <LabeledList>
            <LabeledList.Item label="Turrets">
              <Button
                icon={enabled ? 'toggle-on' : 'toggle-off'}
                content={enabled ? 'Enabled' : 'Disabled'}
                selected={enabled}
                onClick={() => act('enable', { value: enabled ? 0 : 1 })} />
            </LabeledList.Item>
            {!!is_lethal && (
              <LabeledList.Item label="Lethal Mode">
                <Button
                  icon={lethal ? 'exclamation-triangle' : 'hand-paper'}
                  content={lethal ? 'Lethal' : 'Stun'}
                  color={lethal ? 'bad' : 'good'}
                  onClick={() => act('lethal', { value: lethal ? 0 : 1 })} />
              </LabeledList.Item>
            )}
          </LabeledList>
        </Section>
        <Section title="Targeting Settings">
          <LabeledList>
            {settings.map((s) => (
              <LabeledList.Item key={s.setting} label={s.category}>
                <Button
                  icon={s.value ? 'toggle-on' : 'toggle-off'}
                  content={s.value ? 'Yes' : 'No'}
                  selected={s.value}
                  onClick={() => act(s.setting, { value: s.value ? 0 : 1 })} />
              </LabeledList.Item>
            ))}
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
