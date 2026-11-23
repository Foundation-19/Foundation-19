import { useBackend } from '../backend';
import { Box, Button, LabeledList, ProgressBar, Section } from '../components';
import { Window } from '../layouts';

export const DockingAirlockConsole = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    chamber_pressure,
    exterior_status,
    interior_status,
    processing,
    docking_status,
    airlock_disabled,
    override_enabled,
    docking_codes,
    name,
  } = data;

  return (
    <Window width={470} height={290} resizable>
      <Window.Content>
        <Section title="Docking Port">
          <LabeledList>
            <LabeledList.Item label="Name">
              {name}
            </LabeledList.Item>
            <LabeledList.Item label="Docking Status">
              {docking_status}
            </LabeledList.Item>
            <LabeledList.Item label="Docking Codes">
              {docking_codes || "N/A"}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Airlock">
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
          <Box mt={1}>
            <Button
              icon="exclamation-triangle"
              content={override_enabled ? "Disable Override" : "Enable Override"}
              color={override_enabled ? "bad" : "default"}
              onClick={() => act('toggle_override')} />
          </Box>
        </Section>
      </Window.Content>
    </Window>
  );
};
