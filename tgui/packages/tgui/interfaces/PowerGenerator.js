import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, ProgressBar } from '../components';
import { Window } from '../layouts';

export const PowerGenerator = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    totalOutput,
    maxTotalOutput,
    thermalOutput,
    circConnected,
    primaryDir,
    primaryOutput,
    primaryFlowCapacity,
    primaryInletPressure,
    primaryInletTemperature,
    primaryOutletPressure,
    primaryOutletTemperature,
    secondaryDir,
    secondaryOutput,
    secondaryFlowCapacity,
    secondaryInletPressure,
    secondaryInletTemperature,
    secondaryOutletPressure,
    secondaryOutletTemperature,
  } = data;
  return (
    <Window width={450} height={500}>
      <Window.Content scrollable>
        <Section title="Thermoelectric Generator">
          <LabeledList>
            <LabeledList.Item label="Total Output">
              <ProgressBar value={totalOutput / maxTotalOutput}>
                {totalOutput} / {maxTotalOutput} kW
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Thermal Output">{thermalOutput} kW</LabeledList.Item>
          </LabeledList>
        </Section>
        {!!circConnected && (
          <Section title="Circulators">
            <LabeledList>
              <LabeledList.Item label={`${primaryDir} Circulator`}>
                Output: {primaryOutput} kW | Flow: {primaryFlowCapacity}%
              </LabeledList.Item>
              <LabeledList.Item label="Inlet">
                {primaryInletPressure} kPa | {primaryInletTemperature} K
              </LabeledList.Item>
              <LabeledList.Item label="Outlet">
                {primaryOutletPressure} kPa | {primaryOutletTemperature} K
              </LabeledList.Item>
              <LabeledList.Item label={`${secondaryDir} Circulator`}>
                Output: {secondaryOutput} kW | Flow: {secondaryFlowCapacity}%
              </LabeledList.Item>
              <LabeledList.Item label="Inlet">
                {secondaryInletPressure} kPa | {secondaryInletTemperature} K
              </LabeledList.Item>
              <LabeledList.Item label="Outlet">
                {secondaryOutletPressure} kPa | {secondaryOutletTemperature} K
              </LabeledList.Item>
            </LabeledList>
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
