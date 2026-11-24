import { useBackend } from '../backend';
import { Box, Button, Section } from '../components';
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

export const HumanInventory = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    name,
    slots = [],
    has_hands,
    left_hand,
    right_hand,
    left_hand_slot,
    right_hand_slot,
    can_toggle_internals,
    has_suit,
    has_sensors,
    can_lock_sensors,
    sensor_locked,
    handcuffed,
    handcuffed_slot,
    underwear = [],
  } = data;

  return (
    <Window width={420} height={560}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>{name} INVENTORY</Box>
          </Box>

          <Section title="Gear" style={{ border: '1px solid ' + C.border }}>
            {slots.map((slot, i) => (
              <Box key={i} mb={0.5}>
                <Box inline mr={1}>{slot.name}:</Box>
                <Button
                  inline
                  content={slot.item}
                  onClick={() => act('strip', { slot: slot.slot })} />
                {slot.has_accessory ? (
                  <Button
                    inline
                    ml={1}
                    content="Remove accessory"
                    onClick={() => act('strip', { slot: 'tie', holder: slot.holder })} />
                ) : null}
              </Box>
            ))}
          </Section>

          {has_hands ? (
            <Section title="Hands" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
              <Box mb={0.5}>
                <Box inline mr={1}>Left hand:</Box>
                <Button
                  inline
                  content={left_hand}
                  onClick={() => act('strip', { slot: left_hand_slot })} />
              </Box>
              <Box>
                <Box inline mr={1}>Right hand:</Box>
                <Button
                  inline
                  content={right_hand}
                  onClick={() => act('strip', { slot: right_hand_slot })} />
              </Box>
            </Section>
          ) : null}

          <Section title="Actions" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
            <Box>
              {can_toggle_internals ? (
                <Button
                  inline
                  mr={0.5}
                  content="Toggle internals"
                  onClick={() => act('strip', { slot: 'internals' })} />
              ) : null}
              {has_suit ? (
                <Button
                  inline
                  mr={0.5}
                  content="Empty or Place Item"
                  onClick={() => act('strip', { slot: 'pockets' })} />
              ) : null}
              {has_sensors ? (
                <Button
                  inline
                  mr={0.5}
                  content="Set sensors"
                  onClick={() => act('strip', { slot: 'sensors' })} />
              ) : null}
              {can_lock_sensors ? (
                <Button
                  inline
                  mr={0.5}
                  content={sensor_locked ? 'Unlock sensors' : 'Lock sensors'}
                  onClick={() => act('strip', { slot: 'lock_sensors' })} />
              ) : null}
              {handcuffed ? (
                <Button
                  inline
                  mr={0.5}
                  content="Handcuffed"
                  onClick={() => act('strip', { slot: handcuffed_slot })} />
              ) : null}
              <Button
                inline
                mr={0.5}
                content="Refresh"
                onClick={() => act('refresh')} />
            </Box>
          </Section>

          {underwear.length > 0 ? (
            <Section title="Underwear" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
              {underwear.map((item, i) => (
                <Box key={i} mb={0.5}>
                  <Button
                    inline
                    content={'Remove ' + item.name}
                    onClick={() => act('strip', { slot: item.ref })} />
                </Box>
              ))}
            </Section>
          ) : null}
        </Box>
      </Window.Content>
    </Window>
  );
};
