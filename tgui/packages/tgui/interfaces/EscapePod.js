import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const EscapePod = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    docking_status,
    override_enabled,
    door_state,
    door_lock,
    can_force,
    is_armed,
    armed,
    is_berth,
  } = data;

  if (is_berth) {
    return (
      <Window width={470} height={290} resizable>
        <Window.Content>
          <Section title="Docking Status">
            <LabeledList>
              <LabeledList.Item label="Status">
                {docking_status}
              </LabeledList.Item>
              <LabeledList.Item label="Override">
                <Box color={override_enabled ? 'good' : 'bad'}>
                  {override_enabled ? 'Enabled' : 'Disabled'}
                </Box>
              </LabeledList.Item>
              <LabeledList.Item label="Armed">
                <Box color={armed ? 'good' : 'bad'}>
                  {armed ? 'Yes' : 'No'}
                </Box>
              </LabeledList.Item>
            </LabeledList>
          </Section>
        </Window.Content>
      </Window>
    );
  }

  return (
    <Window width={470} height={290} resizable>
      <Window.Content>
        <Section title="Docking Status">
          <LabeledList>
            <LabeledList.Item label="Status">
              {docking_status}
            </LabeledList.Item>
            <LabeledList.Item label="Door">
              {door_state} / {door_lock}
            </LabeledList.Item>
            <LabeledList.Item label="Override">
              <Box color={override_enabled ? 'good' : 'bad'}>
                {override_enabled ? 'Enabled' : 'Disabled'}
              </Box>
            </LabeledList.Item>
            <LabeledList.Item label="Armed">
              <Box color={is_armed ? 'good' : 'bad'}>
                {is_armed ? 'Yes' : 'No'}
              </Box>
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Controls">
          <Button
            icon="exclamation-triangle"
            content="Arm Pod"
            disabled={is_armed}
            color="bad"
            onClick={() => act('manual_arm')} />
          <Button
            icon="rocket"
            content="Force Launch"
            disabled={!can_force}
            onClick={() => act('force_launch')} />
        </Section>
      </Window.Content>
    </Window>
  );
};
