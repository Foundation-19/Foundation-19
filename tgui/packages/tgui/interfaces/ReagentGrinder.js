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

export const ReagentGrinder = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    grinding,
    items = [],
    has_container,
    container_name,
    container_volume,
    container_max,
    reagents = [],
  } = data;

  return (
    <Window width={360} height={480}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.borderRed, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>REAGENT GRINDER</Box>
          </Box>

          {grinding ? (
            <Section title="Processing" style={{ border: '1px solid ' + C.border }}>
              <Box style={{ color: C.amber }}>Working, please wait...</Box>
            </Section>
          ) : (
            <>
              <Section title="Processing Hopper" style={{ border: '1px solid ' + C.border }}>
                {items.length === 0 ? (
                  <Box style={{ color: C.textDim }}>Hopper empty.</Box>
                ) : (
                  <Box>
                    <LabeledList>
                      {items.map((item, i) => (
                        <LabeledList.Item key={i} label={item.amount ? ('x' + item.amount) : '—'}>
                          {item.name}
                        </LabeledList.Item>
                      ))}
                    </LabeledList>
                    <Box mt={1}>
                      <Button
                        icon="cog"
                        content="Grind"
                        disabled={!has_container}
                        onClick={() => act('grind')}
                        style={{ marginRight: '6px' }} />
                      <Button
                        icon="eject"
                        content="Eject Items"
                        onClick={() => act('eject')} />
                    </Box>
                    {!has_container ? (
                      <Box mt={1} style={{ color: C.textDim, fontSize: '10px' }}>
                        ATTACH A BEAKER TO GRIND
                      </Box>
                    ) : null}
                  </Box>
                )}
              </Section>

              <Section title="Chemical Container" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
                {!has_container ? (
                  <Box style={{ color: C.textDim }}>No container attached.</Box>
                ) : (
                  <Box>
                    <Box style={{ color: C.textBright || C.text }}>
                      {container_name} — {container_volume} / {container_max} units
                    </Box>
                    <ProgressBar
                      mt={1}
                      value={container_volume}
                      minValue={0}
                      maxValue={container_max}
                      color="blue" />
                    {reagents.length > 0 && (
                      <LabeledList mt={1}>
                        {reagents.map((reagent, i) => (
                          <LabeledList.Item key={i} label={reagent.name}>
                            {reagent.volume}u
                          </LabeledList.Item>
                        ))}
                      </LabeledList>
                    )}
                    <Button
                      mt={1}
                      icon="eject"
                      content="Detach Container"
                      onClick={() => act('detach')} />
                  </Box>
                )}
              </Section>
            </>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
