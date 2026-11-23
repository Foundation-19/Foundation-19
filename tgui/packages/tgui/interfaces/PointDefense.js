import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const PointDefense = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    id,
    name,
    turrets,
  } = data;
  return (
    <Window width={400} height={600}>
      <Window.Content scrollable>
        <Section title={name || "Fire Assist Mainframe"}>
          <LabeledList>
            <LabeledList.Item label="Network ID">{id}</LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Turrets">
          {turrets && turrets.map((turret, i) => (
            <Section key={i} title={turret.id}>
              <LabeledList>
                <LabeledList.Item label="Status">
                  <Button selected={turret.active} onClick={() => act('toggle_active', { toggle_active: turret.ref })}>
                    {turret.active ? "Online" : "Offline"}
                  </Button>
                </LabeledList.Item>
                <LabeledList.Item label="Range">{turret.effective_range}</LabeledList.Item>
                <LabeledList.Item label="Rotation Delay">{turret.reaction_wheel_delay}</LabeledList.Item>
                <LabeledList.Item label="Recharge Time">{turret.recharge_time}</LabeledList.Item>
              </LabeledList>
            </Section>
          ))}
        </Section>
      </Window.Content>
    </Window>
  );
};
