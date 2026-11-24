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
    <Window width={470} height={440}>
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
        <Section title="Cycling">
          <Button
            fluid
            content="Cycle to External (loop)"
            onClick={() => act('cycle_ext')} />
          <Button
            fluid
            mt={0.5}
            content="Cycle to Internal (loop)"
            onClick={() => act('cycle_int')} />
        </Section>
        <Section title="Door Overrides">
          <Button
            fluid
            content="Toggle Exterior Door"
            onClick={() => act('force_ext')} />
          <Button
            fluid
            mt={0.5}
            content="Toggle Interior Door"
            onClick={() => act('force_int')} />
        </Section>
        <Section title="Diagnostics">
          <Box mb={1}>
            <Button
              fluid
              content="Open Both Doors (venting)"
              onClick={() => act('cycle_ext_door')} />
            <Button
              fluid
              mt={0.5}
              content="Close Both Doors"
              onClick={() => act('cycle_int_door')} />
          </Box>
          <Box mb={1}>
            <Button
              fluid
              icon="lock"
              selected={secure}
              content="Toggle Door Bolts"
              onClick={() => act('secure')} />
          </Box>
          <Box>
            <Button
              fluid
              icon="warning"
              selected={purge}
              content="Toggle Chamber Purge"
              onClick={() => act('purge')} />
            <Button
              fluid
              mt={0.5}
              content="Abort Cycle"
              onClick={() => act('abort')} />
          </Box>
        </Section>
      </Window.Content>
    </Window>
  );
};
