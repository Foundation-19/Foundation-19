import { useBackend } from '../backend';
import { Box, Button, LabeledList, ProgressBar, Section } from '../components';
import { Window } from '../layouts';

export const SimpleAirlockConsole = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    chamber_pressure,
    exterior_status,
    interior_status,
    processing,
  } = data;

  return (
    <Window width={470} height={290} resizable>
      <Window.Content>
        <Section title="Airlock Control">
          <LabeledList>
            <LabeledList.Item label="Chamber Pressure">
              <ProgressBar
                value={chamber_pressure / 101.325}
                content={chamber_pressure + " kPa"} />
            </LabeledList.Item>
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
