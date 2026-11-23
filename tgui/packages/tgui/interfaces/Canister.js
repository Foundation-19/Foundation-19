import { useBackend } from '../backend';
import { Box, Button, Flex, LabeledList, NumberInput, Section } from '../components';
import { Window } from '../layouts';

export const Canister = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    name,
    canLabel,
    portConnected,
    tankPressure,
    releasePressure,
    minReleasePressure,
    maxReleasePressure,
    valveOpen,
    hasHoldingTank,
    holdingTank,
  } = data;

  return (
    <Window width={480} height={400} resizable>
      <Window.Content>
        <Section title={name}>
          <LabeledList>
            <LabeledList.Item label="Pressure">
              {tankPressure} kPa
            </LabeledList.Item>
            <LabeledList.Item label="Port">
              <Box color={portConnected ? 'good' : 'bad'}>
                {portConnected ? 'Connected' : 'Not Connected'}
              </Box>
            </LabeledList.Item>
            <LabeledList.Item label="Release Pressure">
              <NumberInput
                value={releasePressure}
                minValue={minReleasePressure}
                maxValue={maxReleasePressure}
                step={10}
                stepPixelSize={3}
                width="80px"
                onChange={(e, value) => act('pressure_adj', { pressure_adj: value - releasePressure })} />
              <Button
                icon="fast-backward"
                onClick={() => act('pressure_adj', { pressure_adj: -(releasePressure - minReleasePressure) })} />
              <Button
                icon="backward"
                onClick={() => act('pressure_adj', { pressure_adj: -10 })} />
              <Button
                icon="forward"
                onClick={() => act('pressure_adj', { pressure_adj: 10 })} />
              <Button
                icon="fast-forward"
                onClick={() => act('pressure_adj', { pressure_adj: maxReleasePressure - releasePressure })} />
            </LabeledList.Item>
            <LabeledList.Item label="Valve">
              <Button
                icon={valveOpen ? 'toggle-on' : 'toggle-off'}
                content={valveOpen ? 'Open' : 'Closed'}
                selected={valveOpen}
                onClick={() => act('toggle')} />
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
                <Button
                  icon="eject"
                  content="Remove Tank"
                  onClick={() => act('remove_tank')} />
              </LabeledList.Item>
            </LabeledList>
          ) : (
            <Box color="label">No holding tank inserted.</Box>
          )}
        </Section>
        {!!canLabel && (
          <Section>
            <Button
              icon="tag"
              content="Relabel Canister"
              onClick={() => act('relabel')} />
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
