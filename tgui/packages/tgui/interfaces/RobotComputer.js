import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, ProgressBar } from '../components';
import { Window } from '../layouts';

export const RobotComputer = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    robots,
    is_ai,
  } = data;
  return (
    <Window width={400} height={500}>
      <Window.Content scrollable>
        <Section title="Robotic Control Console">
          {robots && robots.map((robot, i) => (
            <Section key={i} title={robot.name}>
              <LabeledList>
                <LabeledList.Item label="Location">{robot.location}</LabeledList.Item>
                <LabeledList.Item label="Status">{robot.status}</LabeledList.Item>
                <LabeledList.Item label="Module">{robot.module}</LabeledList.Item>
                <LabeledList.Item label="Master AI">{robot.master_ai}</LabeledList.Item>
                {!!robot.cell && (
                  <LabeledList.Item label="Cell Charge">
                    <ProgressBar value={robot.cell_percentage / 100}>
                      {robot.cell_percentage}%
                    </ProgressBar>
                  </LabeledList.Item>
                )}
              </LabeledList>
              <Button mt={1} onClick={() => act('lockdown', { lockdown: robot.name })}>
                {robot.status === "Lockdown" ? "Unlock" : "Lockdown"}
              </Button>
              {!!robot.hackable && (
                <Button mt={1} color="bad" onClick={() => act('hack', { hack: robot.name })}>
                  Hack
                </Button>
              )}
              <Button mt={1} onClick={() => act('message', { message: robot.name })}>
                Message
              </Button>
            </Section>
          ))}
        </Section>
      </Window.Content>
    </Window>
  );
};
