import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const DoorAccessConsole = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    exterior_status,
    interior_status,
    processing,
  } = data;

  return (
    <Window width={330} height={220} resizable>
      <Window.Content>
        <Section title="Access Control">
          <LabeledList>
            <LabeledList.Item label="Exterior Door">
              {exterior_status?.state || "Unknown"} / {exterior_status?.lock || "Unknown"}
            </LabeledList.Item>
            <LabeledList.Item label="Interior Door">
              {interior_status?.state || "Unknown"} / {interior_status?.lock || "Unknown"}
            </LabeledList.Item>
            <LabeledList.Item label="Processing">
              {processing ? "Yes" : "No"}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
