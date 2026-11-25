import { useBackend } from '../backend';
import { Box, Button, Flex, Input, LabeledList, NoticeBox, ProgressBar, Section } from '../components';
import { Window } from '../layouts';
import { ProgramExitButtons } from './common/ProgramExitButtons';

export const CommConsole = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    authenticated,
    isAI,
    net_comms,
    net_syscont,
    have_printer,
    emagged,
    message_line1,
    message_line2,
    state,
    boss_short,
    current_security_level_title,
    cannot_change_security_level,
    security_levels = [],
    evac_options = [],
    comms_channels = [],
    comms_hazard_active,
  } = data;
  const showExit = data && data.PC_showexitprogram;

  return (
    <Window theme="scp_terminal" width={620} height={660} buttons={showExit ? <ProgramExitButtons act={act} /> : undefined}>
      <Window.Content scrollable>
        <Box style={{ background: '#0a0a0c', minHeight: '100%', padding: '10px', fontFamily: '"Consolas", monospace', color: '#c8c8c8' }}>
          <Box style={{ borderBottom: '2px solid #6b0000', paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: '#d4a017', letterSpacing: '0.15em', fontWeight: 'bold' }}>COMMUNICATIONS CONSOLE</Box>
            <Box style={{ color: '#6a6a70', fontSize: '9px' }}>
              {boss_short} COMMAND UPLINK — {authenticated ? 'AUTHENTICATED' : 'GUEST'}
            </Box>
          </Box>

          {!net_comms || !net_syscont ? (
            <NoticeBox danger>SCiPNET connection required for network functions.</NoticeBox>
          ) : null}

          {authenticated ? (
            <Section title="Priority Announcement">
              <Box mb={1} style={{ color: '#6a6a70' }}>Set announcement lines, then broadcast.</Box>
              <Flex mb={1}>
                <Flex.Item mr={1} grow={1}>
                  <Input value={message_line1 || ''} onChange={(e, v) => act('line1', { line1: v })} style={{ width: '100%' }} placeholder="Line 1" />
                </Flex.Item>
              </Flex>
              <Flex mb={1}>
                <Flex.Item mr={1} grow={1}>
                  <Input value={message_line2 || ''} onChange={(e, v) => act('line2', { line2: v })} style={{ width: '100%' }} placeholder="Line 2" />
                </Flex.Item>
              </Flex>
              <Button icon="bullhorn" content="Announce" color="good" onClick={() => act('announce')} />
              {have_printer ? <Button icon="print" content="Print" onClick={() => act('printmessage')} /> : null}
            </Section>
          ) : null}

          <Section title="Security Level" buttons={
            <Box style={{ color: '#6a6a70', fontSize: '10px' }}>CURRENT: {current_security_level_title}</Box>
          }>
            {!cannot_change_security_level ? (
              <Flex wrap="wrap">
                {security_levels.map((lvl) => (
                  <Flex.Item key={lvl.title} mr={0.5} mb={0.5}>
                    <Button
                      content={lvl.title}
                      selected={lvl.title === current_security_level_title}
                      color={lvl.title === 'Delta' ? 'bad' : undefined}
                      disabled={!authenticated || !net_syscont}
                      onClick={() => act('setalert', { target: lvl.ref })}
                    />
                  </Flex.Item>
                ))}
              </Flex>
            ) : (
              <Box style={{ color: '#cc2222' }}>Security level cannot be changed at this time.</Box>
            )}
          </Section>

          {authenticated ? (
            <Section title="Emergency Evacuation">
              {evac_options.map((opt) => (
                <Flex key={opt.option_target} align="center" mb={0.5}>
                  <Box style={{ flex: 1 }}>{opt.option_text}</Box>
                  <Button content="Execute" disabled={!net_syscont || !opt.needs_syscontrol ? true : false} onClick={() => act('evac', { target: opt.option_target })} />
                </Flex>
              ))}
              <Box mt={1}>
                <Button icon="door-closed" content="Bolt Doors" onClick={() => act('bolt_doors')} />
                <Button icon="door-open" content="Unbolt Doors" onClick={() => act('unbolt_doors')} />
              </Box>
            </Section>
          ) : null}

          {comms_channels.length > 0 ? (
            <Section title="Relay Integrity Board">
              {comms_hazard_active ? (
                <NoticeBox danger mb={1}>
                  ANOMALOUS SIGNAL CONTAMINATION DETECTED ON COMMAND CHANNEL.
                  <Button
                    ml={1}
                    color="bad"
                    content="CUT RELAY"
                    onClick={() => act('cut_hazard')} />
                </NoticeBox>
              ) : null}
              <LabeledList>
                {comms_channels.map((ch) => (
                  <LabeledList.Item
                    key={ch.name}
                    label={ch.name}
                    color={ch.degraded ? 'bad' : (ch.rebooting ? 'average' : undefined)}>
                    <Box style={{ display: 'inline-block', width: '45%', verticalAlign: 'middle' }}>
                      <ProgressBar
                        value={ch.rebooting ? 0 : ch.integrity}
                        minValue={0}
                        maxValue={100}
                        color={ch.degraded ? 'bad' : (ch.rebooting ? 'average' : 'good')}>
                        {ch.rebooting ? 'REBOOTING' : ch.integrity + '%'}
                      </ProgressBar>
                    </Box>
                    <Button
                      inline
                      ml={1}
                      content="Reboot"
                      disabled={!authenticated || ch.rebooting || ch.integrity >= 100}
                      onClick={() => act('reboot_channel', { channel: ch.name })} />
                  </LabeledList.Item>
                ))}
              </LabeledList>
            </Section>
          ) : null}

          <Section title="Access">
            <Button icon="key" content={authenticated ? 'Log Out' : 'Log In'} onClick={() => act('sw_menu', { target: authenticated ? 0 : 1 })} />
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
