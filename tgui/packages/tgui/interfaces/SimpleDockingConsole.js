import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const SimpleDockingConsole = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    docking_status,
    override_enabled,
    door_state,
    door_lock,
  } = data;

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
          </LabeledList>
        </Section>
        <Section title="Controls">
          <Button
            icon="exclamation-triangle"
            content={override_enabled ? "Disable Override" : "Enable Override"}
            color={override_enabled ? "bad" : "default"}
            onClick={() => act('toggle_override')} />
          {override_enabled && (
            <Button
              icon="door-open"
              content={door_state === "open" ? "Force Close" : "Force Open"}
              onClick={() => act('force_door')} />
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
