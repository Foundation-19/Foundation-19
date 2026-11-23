import { useBackend } from '../backend';
import { Box, Button, LabeledList, NumberInput, ProgressBar, Section } from '../components';
import { Window } from '../layouts';

export const PortablePump = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    on,
    pumpDir,
    portConnected,
    tankPressure,
    targetpressure,
    minpressure,
    maxpressure,
    powerDraw,
    cellCharge,
    cellMaxCharge,
    hasHoldingTank,
    holdingTank,
  } = data;

  return (
    <Window width={480} height={460} resizable>
      <Window.Content>
        <Section title="Pump">
          <LabeledList>
            <LabeledList.Item label="Power">
              <Button
                icon={on ? 'toggle-on' : 'toggle-off'}
                content={on ? 'On' : 'Off'}
                selected={on}
                onClick={() => act('power')} />
            </LabeledList.Item>
            <LabeledList.Item label="Direction">
              <Button
                icon={pumpDir ? 'sign-out-alt' : 'sign-in-alt'}
                content={pumpDir ? 'Out' : 'In'}
                selected={pumpDir}
                onClick={() => act('direction')} />
            </LabeledList.Item>
            <LabeledList.Item label="Port">
              <Box color={portConnected ? 'good' : 'bad'}>
                {portConnected ? 'Connected' : 'Not Connected'}
              </Box>
            </LabeledList.Item>
            <LabeledList.Item label="Target Pressure">
              <NumberInput
                value={targetpressure}
                minValue={minpressure}
                maxValue={maxpressure}
                step={10}
                stepPixelSize={3}
                width="80px"
                onChange={(e, value) => act('pressure_adj', { pressure_adj: value - targetpressure })} />
              <Button icon="backward" onClick={() => act('pressure_adj', { pressure_adj: -10 })} />
              <Button icon="forward" onClick={() => act('pressure_adj', { pressure_adj: 10 })} />
            </LabeledList.Item>
            <LabeledList.Item label="Internal Pressure">
              {tankPressure} kPa
            </LabeledList.Item>
            <LabeledList.Item label="Power Draw">
              {powerDraw} W
            </LabeledList.Item>
            <LabeledList.Item label="Cell Charge">
              <ProgressBar value={cellCharge} minValue={0} maxValue={cellMaxCharge}>
                {cellCharge} / {cellMaxCharge}
              </ProgressBar>
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Holding Tank">
          {hasHoldingTank ? (
            <LabeledList>
              <LabeledList.Item label="Tank">
                {holdingTank.name}
              </LabeledList.Item>
              <LabeledList.Item label="Pressure">
                {holdingTank.tankPressure} kPa
              </LabeledList.Item>
              <LabeledList.Item label="Actions">
                <Button icon="eject" content="Remove Tank" onClick={() => act('remove_tank')} />
              </LabeledList.Item>
            </LabeledList>
          ) : (
            <Box color="label">No holding tank inserted.</Box>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
