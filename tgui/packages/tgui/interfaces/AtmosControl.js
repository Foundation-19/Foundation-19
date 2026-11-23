import { useBackend } from '../backend';
import { Box, Button, Flex, Section } from '../components';
import { Window } from '../layouts';

const AlarmRow = (props, context) => {
  const { act } = useBackend(context);
  const { alarm } = props;
  const color = alarm.danger === 2 ? '#cc2222' : alarm.danger === 1 ? '#d4a017' : '#44ff44';
  const label = alarm.danger === 2 ? '[DANGER]' : alarm.danger === 1 ? '[WARNING]' : '[OK]';
  return (
    <Flex align="center" mb={0.5}>
      <Box style={{ flex: 1 }}>
        {alarm.name} <Box inline ml={1} style={{ color }}>{label}</Box>
      </Box>
      <Button icon="expand" content="Access" onClick={() => act('alarm', { alarm: alarm.ref })} />
    </Flex>
  );
};

export const AtmosControl = (props, context) => {
  const { data } = useBackend(context);
  const { alarms = [], alarmsAlert = [], alarmsDanger = [] } = data;

  return (
    <Window theme="scp_terminal" width={640} height={680}>
      <Window.Content scrollable>
        <Box style={{ background: '#0a0a0c', minHeight: '100%', padding: '10px', fontFamily: '"Consolas", monospace', color: '#c8c8c8' }}>
          <Box style={{ borderBottom: '2px solid #6b0000', paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: '#d4a017', letterSpacing: '0.15em', fontWeight: 'bold' }}>ATMOSPHERICS CONTROL</Box>
            <Box style={{ color: '#6a6a70', fontSize: '9px' }}>AIR ALARM REMOTE ACCESS NETWORK</Box>
          </Box>
          {alarmsDanger.length > 0 ? (
            <Section title="Danger Alarms">
              {alarmsDanger.map((a, i) => <AlarmRow key={i} alarm={a} />)}
            </Section>
          ) : null}
          {alarmsAlert.length > 0 ? (
            <Section title="Warnings">
              {alarmsAlert.map((a, i) => <AlarmRow key={i} alarm={a} />)}
            </Section>
          ) : null}
          <Section title="Nominal">
            {alarms.map((a, i) => <AlarmRow key={i} alarm={a} />)}
            {alarms.length === 0 ? <Box style={{ color: '#6a6a70' }}>No nominal alarms.</Box> : null}
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
