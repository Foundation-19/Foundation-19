import { useBackend } from '../backend';
import { Box, Button, LabeledList, ProgressBar, Section } from '../components';
import { Window } from '../layouts';

export const AdvancedAirlockConsole = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    chamber_pressure,
    external_pressure,
    internal_pressure,
    processing,
    purge,
    secure,
  } = data;

  return (
    <Window width={470} height={290} resizable>
      <Window.Content>
        <Section title="Advanced Airlock Control">
          <LabeledList>
            <LabeledList.Item label="Chamber Pressure">
              <ProgressBar
                value={chamber_pressure / 101.325}
                content={chamber_pressure + " kPa"} />
            </LabeledList.Item>
            <LabeledList.Item label="External Pressure">
              {external_pressure} kPa
            </LabeledList.Item>
            <LabeledList.Item label="Internal Pressure">
              {internal_pressure} kPa
            </LabeledList.Item>
            <LabeledList.Item label="Processing">
              {processing ? "Yes" : "No"}
            </LabeledList.Item>
            <LabeledList.Item label="Purge">
              {purge ? "Active" : "Inactive"}
            </LabeledList.Item>
            <LabeledList.Item label="Secure">
              {secure ? "Locked" : "Unlocked"}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
