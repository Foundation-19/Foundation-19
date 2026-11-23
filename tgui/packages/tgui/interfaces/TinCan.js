import { useBackend } from '../backend';
import { Box, Button, LabeledList, ProgressBar, Section } from '../components';
import { Window } from '../layouts';

const STATE_FILL = 1;
const STATE_EVACUATE = 2;
const STATE_SEALED = 3;

const stateLabels = {
  [STATE_FILL]: "Fill",
  [STATE_EVACUATE]: "Evacuate",
  [STATE_SEALED]: "Sealed",
};

export const TinCan = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    chamber_pressure,
    door_safety,
    state,
  } = data;

  return (
    <Window width={470} height={290} resizable>
      <Window.Content>
        <Section title="Vessel Atmosphere Control">
          <LabeledList>
            <LabeledList.Item label="Chamber Pressure">
              <ProgressBar
                value={chamber_pressure / 101.325}
                content={chamber_pressure + " kPa"} />
            </LabeledList.Item>
            <LabeledList.Item label="State">
              {stateLabels[state] || "Unknown"}
            </LabeledList.Item>
            <LabeledList.Item label="Door Safety">
              {door_safety ? "On" : "Off"}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Controls">
          <Button
            icon="fill-drip"
            content="Fill"
            selected={state === STATE_FILL}
            onClick={() => act('fill_atmos')} />
          <Button
            icon="wind"
            content="Evacuate"
            selected={state === STATE_EVACUATE}
            color={state === STATE_EVACUATE ? "bad" : "default"}
            onClick={() => act('evacuate_atmos')} />
          <Button
            icon="lock"
            content="Seal"
            selected={state === STATE_SEALED}
            onClick={() => act('seal')} />
          <Button
            icon="shield-alt"
            content={door_safety ? "Disable Safety" : "Enable Safety"}
            color={door_safety ? "default" : "bad"}
            onClick={() => act('toggle_door_safety')} />
        </Section>
      </Window.Content>
    </Window>
  );
};
