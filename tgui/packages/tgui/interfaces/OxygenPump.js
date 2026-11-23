import { useBackend } from '../backend';
import { Box, Button, LabeledList, NoticeBox, ProgressBar, Section } from '../components';
import { Window } from '../layouts';

export const OxygenPump = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    tankPressure,
    releasePressure,
    defaultReleasePressure,
    maxReleasePressure,
    maskConnected,
    tankInstalled,
  } = data;

  return (
    <Window width={500} height={300} resizable>
      <Window.Content>
        <Section title="Emergency Oxygen Pump">
          {!tankInstalled && (
            <NoticeBox danger>No tank installed!</NoticeBox>
          )}
          {tankInstalled && (
            <LabeledList>
              <LabeledList.Item label="Tank Pressure">
                <ProgressBar
                  value={tankPressure / maxReleasePressure}
                  color={tankPressure > defaultReleasePressure ? "good" : "bad"}
                  content={tankPressure + " kPa"} />
              </LabeledList.Item>
              <LabeledList.Item label="Release Pressure">
                <ProgressBar
                  value={releasePressure / maxReleasePressure}
                  content={releasePressure + " kPa"} />
              </LabeledList.Item>
              <LabeledList.Item label="Mask">
                {maskConnected ? "Connected" : "Disconnected"}
              </LabeledList.Item>
            </LabeledList>
          )}
          {tankInstalled && (
            <Box mt={1}>
              <Button
                icon="minus"
                content="-10"
                onClick={() => act('dist_p', { dist_p: -10 })} />
              <Button
                icon="minus"
                content="-1"
                onClick={() => act('dist_p', { dist_p: -1 })} />
              <Button
                icon="undo"
                content="Reset"
                onClick={() => act('dist_p', { dist_p: "reset" })} />
              <Button
                icon="plus"
                content="+1"
                onClick={() => act('dist_p', { dist_p: 1 })} />
              <Button
                icon="plus"
                content="+10"
                onClick={() => act('dist_p', { dist_p: 10 })} />
              <Button
                icon="arrow-up"
                content="Max"
                onClick={() => act('dist_p', { dist_p: "max" })} />
            </Box>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
