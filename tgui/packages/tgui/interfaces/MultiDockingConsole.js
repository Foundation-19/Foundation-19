import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const MultiDockingConsole = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    docking_status,
    airlocks,
  } = data;

  return (
    <Window width={470} height={290} resizable>
      <Window.Content>
        <Section title="Multi-Docking Port">
          <LabeledList>
            <LabeledList.Item label="Docking Status">
              {docking_status}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Airlocks">
          {airlocks && airlocks.map((al, i) => (
            <Box key={i} mb={1}>
              <LabeledList>
                <LabeledList.Item label={al.name}>
                  {al.override_enabled ? "Override Active" : "Normal"}
                </LabeledList.Item>
              </LabeledList>
            </Box>
          ))}
          {(!airlocks || airlocks.length === 0) && (
            <Box color="label">No airlocks configured.</Box>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
