import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

const C = {
  bg: '#0a0a0c',
  panel: '#111114',
  border: '#2a2a30',
  amber: '#c2960e',
  text: '#c8c8c8',
  textDim: '#7a7a80',
  mono: 'Consolas, monospace',
};

export const ImplantChair = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    has_occupant,
    occupant_name,
    occupant_health,
    occupant_dead,
    implant_count,
    ready,
  } = data;

  return (
    <Window width={360} height={280}>
      <Window.Content>
        <Box
          style={{
            background: C.bg,
            minHeight: '100%',
            padding: '10px',
            fontFamily: C.mono,
            color: C.text,
          }}>
          <Box
            style={{
              borderBottom: '2px solid ' + C.border,
              paddingBottom: '6px',
              marginBottom: '10px',
            }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>
              IMPLANTER STATUS
            </Box>
          </Box>

          <Section title="Current Occupant" style={{ border: '1px solid ' + C.border }}>
            {!has_occupant ? (
              <Box style={{ color: '#c0392b' }}>None</Box>
            ) : (
              <LabeledList>
                <LabeledList.Item label="Name">{occupant_name}</LabeledList.Item>
                <LabeledList.Item label="Health">
                  <Box style={{ color: occupant_dead || occupant_health < 0 ? '#c0392b' : C.text }}>
                    {occupant_dead ? 'Dead' : occupant_health}
                  </Box>
                </LabeledList.Item>
              </LabeledList>
            )}
          </Section>

          <Section title="Implants" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
            {implant_count ? (
              <Box>{implant_count}</Box>
            ) : (
              <Button
                inline
                icon="sync"
                content="Replenish"
                onClick={() => act('replenish')}
              />
            )}
            {has_occupant ? (
              <Box mt={1}>
                {ready ? (
                  <Button
                    inline
                    color="green"
                    icon="syringe"
                    content="Implant"
                    onClick={() => act('implant')}
                  />
                ) : (
                  <Box style={{ color: C.textDim }}>Recharging</Box>
                )}
              </Box>
            ) : null}
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
