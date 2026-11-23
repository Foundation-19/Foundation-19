import { useBackend } from '../backend';
import { Box, Button, LabeledList, NumberInput, Section, Flex, ProgressBar } from '../components';
import { Window } from '../layouts';

export const ChemicalDispenser = (props, context) => {
  const { act, data } = useBackend(context);
  const { amount, isBeakerLoaded, beakerContents = [], beakerCurrentVolume, beakerMaxVolume, chemicals = [] } = data;

  return (
    <Window width={390} height={680} resizable>
      <Window.Content scrollable>
        <Section title="Dispense Amount">
          <NumberInput
            value={amount}
            minValue={0}
            maxValue={120}
            step={5}
            stepPixelSize={3}
            width="60px"
            onChange={(e, value) => act('amount', { amount: value })} />
          <Box inline ml={1} color="label">units</Box>
        </Section>
        <Section title="Beaker">
          {isBeakerLoaded ? (
            <Box>
              <ProgressBar
                value={beakerCurrentVolume}
                minValue={0}
                maxValue={beakerMaxVolume}
                color="blue">
                {beakerCurrentVolume} / {beakerMaxVolume} units
              </ProgressBar>
              {beakerContents.length > 0 && (
                <LabeledList mt={1}>
                  {beakerContents.map((reagent) => (
                    <LabeledList.Item key={reagent.name} label={reagent.name}>
                      {reagent.volume}u
                    </LabeledList.Item>
                  ))}
                </LabeledList>
              )}
              <Button
                mt={1}
                icon="eject"
                content="Eject Beaker"
                onClick={() => act('ejectBeaker')} />
            </Box>
          ) : (
            <Box color="label">No beaker loaded.</Box>
          )}
        </Section>
        <Section title="Chemicals">
          <Flex wrap={1}>
            {chemicals.map((chemical) => (
              <Flex.Item key={chemical.label} m={0.5}>
                <Button
                  content={chemical.label}
                  onClick={() => act('dispense', { dispense: chemical.label })} />
              </Flex.Item>
            ))}
          </Flex>
        </Section>
      </Window.Content>
    </Window>
  );
};
