import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, ProgressBar } from '../components';
import { Window } from '../layouts';

const C = {
  bg: '#0a0a0c',
  panel: '#111114',
  border: '#2a2a30',
  borderRed: '#6b0000',
  amber: '#c2960e',
  text: '#c8c8c8',
  textDim: '#7a7a80',
  mono: 'Consolas, monospace',
};

const AMOUNTS = [5, 10, 15, 20, 30, 40, 60, 120];

export const ChemicalDispenser = (props, context) => {
  const { act, data } = useBackend(context);
  const { amount, isBeakerLoaded, beakerContents = [], beakerCurrentVolume, beakerMaxVolume, chemicals = [] } = data;

  return (
    <Window width={390} height={640}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.borderRed, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>CHEMICAL DISPENSER</Box>
          </Box>

          <Section title="Dispense Amount" style={{ border: '1px solid ' + C.border }}>
            <Box>
              {AMOUNTS.map((a) => (
                <Button
                  key={a}
                  inline
                  selected={amount === a}
                  content={a}
                  mb={0.5}
                  mr={0.5}
                  onClick={() => act('amount', { amount: a })} />
              ))}
            </Box>
            <Box mt={1} style={{ color: C.textDim, fontSize: '10px' }}>
              CURRENT: {amount} UNITS
            </Box>
          </Section>

          <Section title="Beaker" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
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

          <Section title="Chemicals" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
            <Box>
              {chemicals.map((chemical) => (
                <Button
                  key={chemical.label}
                  inline
                  mb={0.5}
                  mr={0.5}
                  disabled={!isBeakerLoaded}
                  content={chemical.label}
                  onClick={() => act('dispense', { dispense: chemical.label })} />
              ))}
            </Box>
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
