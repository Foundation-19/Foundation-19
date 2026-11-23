import { useBackend } from '../backend';
import { Box, Button, LabeledList, NumberInput, ProgressBar, Section } from '../components';
import { Window } from '../layouts';

export const PortableScrubber = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    on,
    portConnected,
    tankPressure,
    rate,
    minrate,
    maxrate,
    powerDraw,
    cellCharge,
    cellMaxCharge,
    hasHoldingTank,
    holdingTank,
  } = data;

  return (
    <Window width={480} height={450} resizable>
      <Window.Content>
        <Section title="Scrubber">
          <LabeledList>
            <LabeledList.Item label="Power">
              <Button
                icon={on ? 'toggle-on' : 'toggle-off'}
                content={on ? 'On' : 'Off'}
                selected={on}
                onClick={() => act('power')} />
            </LabeledList.Item>
            <LabeledList.Item label="Port">
              <Box color={portConnected ? 'good' : 'bad'}>
                {portConnected ? 'Connected' : 'Not Connected'}
              </Box>
            </LabeledList.Item>
            <LabeledList.Item label="Scrubbing Rate">
              <NumberInput
                value={rate}
                minValue={minrate}
                maxValue={maxrate}
                step={10}
                stepPixelSize={3}
                width="80px"
                onChange={(e, value) => act('volume_adj', { volume_adj: value - rate })} />
              <Button icon="backward" onClick={() => act('volume_adj', { volume_adj: -10 })} />
              <Button icon="forward" onClick={() => act('volume_adj', { volume_adj: 10 })} />
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
