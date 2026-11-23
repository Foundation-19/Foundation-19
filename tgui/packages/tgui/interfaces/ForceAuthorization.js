import { useBackend } from '../backend';
import { Box, Button, Flex, LabeledList, NoticeBox, Section } from '../components';
import { Window } from '../layouts';

const C = {
  bg: '#0a0a0c',
  border: '#2a2a30',
  borderRed: '#6b0000',
  amber: '#d4a017',
  text: '#c8c8c8',
  textDim: '#6a6a70',
  good: '#0a6e0a',
  red: '#cc2222',
  mono: '"Consolas", "Courier New", monospace',
};

const GunRow = (props, context) => {
  const { act } = useBackend(context);
  const { gun } = props;
  return (
    <Box mb={1} pb={1} style={{ borderBottom: '1px solid ' + C.border }}>
      <Flex align="center" mb={0.5}>
        <Box style={{ color: C.amber, fontWeight: 'bold', flex: 1 }}>{gun.name}</Box>
        {gun.owner ? (
          <Box style={{ color: C.text }}>{gun.owner}</Box>
        ) : (
          <Box style={{ color: C.red }}>UNREGISTERED</Box>
        )}
      </Flex>
      <Box style={{ color: C.textDim, fontSize: '10px' }}>{gun.area}</Box>
      {gun.modes.length === 0 ? (
        <Box style={{ color: C.textDim, fontSize: '10px' }}>No restricted firemodes.</Box>
      ) : (
        gun.modes.map((mode) => (
          <Flex key={mode.index} align="center" mt={0.5}>
            <Box style={{ flex: 1 }}>{mode.mode_name}</Box>
            <Box mr={1} style={{ color: mode.authorized ? C.good : C.red }}>
              {mode.authorized ? 'AUTHORIZED' : 'RESTRICTED'}
            </Box>
            <Button
              content={mode.authorized ? 'Restrict' : 'Authorize'}
              color={mode.authorized ? 'bad' : 'good'}
              disabled={gun.out_of_range}
              onClick={() => act('authorize', { gun: gun.ref, mode: mode.index, authorize: mode.authorized ? 0 : 1 })}
            />
          </Flex>
        ))
      )}
    </Box>
  );
};

export const ForceAuthorization = (props, context) => {
  const { data } = useBackend(context);
  const { registered_guns = [], unregistered_guns = [] } = data;

  return (
    <Window theme="scp_terminal" width={560} height={640}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.borderRed, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>USE OF FORCE AUTHORIZATION MANAGER</Box>
            <Box style={{ color: C.textDim, fontSize: '9px' }}>NT1019 AUTHORIZATION CHIP UPLINK — SECURITY CLEARANCE 4</Box>
          </Box>
          <Section title="REGISTERED WEAPONS">
            {registered_guns.length === 0 ? (
              <Box style={{ color: C.textDim }}>No registered weapons detected on-site.</Box>
            ) : (
              registered_guns.map((gun, i) => <GunRow key={i} gun={gun} />)
            )}
          </Section>
          <Section title="UNREGISTERED WEAPONS">
            {unregistered_guns.length === 0 ? (
              <Box style={{ color: C.textDim }}>No unregistered weapons detected on-site.</Box>
            ) : (
              unregistered_guns.map((gun, i) => <GunRow key={i} gun={gun} />)
            )}
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
