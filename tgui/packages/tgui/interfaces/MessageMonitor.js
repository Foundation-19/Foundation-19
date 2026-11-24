import { useBackend } from '../backend';
import { Box, Button, Section } from '../components';
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

const BINARY = '0100001001110010011101010111010001100101001011001100110111101110011011001010110100101101110011001100100000011001100110111101110001011100100010000001110011011001010111001001110110011001010111001000100000011010110110010101111001001001110010000000100100101110100010000011101000110100101101100011001100010000001110100011000010110101101100101001000000011001000110000001000000111001101100101011000110110111101101110011001000111001100100000011001100110111101110010001000000110010101110110011001010111001001111001001000000110001101101000011000010111011100100000011101000110100001100101011100100110010100100000011101000110100101101101001000000110000101101110011101000110100101101110011011110111010101110011001000000110010101111001011001010111001100101110';

export const MessageMonitor = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    message,
    authorized,
    screen,
    server_active,
    server_online,
    can_hack,
    silicon,
    logs = [],
  } = data;

  return (
    <Window width={700} height={700}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.borderRed, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>MESSAGE MONITOR CONSOLE</Box>
          </Box>

          <Box mb={1} dangerouslySetInnerHTML={{ __html: message || '' }} />

          <Box mb={1}>
            <Button
              inline
              mr={1}
              content={authorized ? '[Authenticated]' : '[Unauthenticated]'}
              color={authorized ? 'good' : 'bad'}
              onClick={() => act('auth')} />
            <Box inline style={{ color: C.textDim }}>Server Power: </Box>
            {authorized ? (
              <Button
                inline
                content={server_active ? '[On]' : '[Off]'}
                color={server_active ? 'good' : 'bad'}
                onClick={() => act('active')} />
            ) : (
              <Box inline style={{ color: C.text }}>{server_active ? '[On]' : '[Off]'}</Box>
            )}
          </Box>

          {screen === 0 && (
            <Section title="Main Menu" style={{ border: '1px solid ' + C.border }}>
              <Box mb={0.5}>
                <Button inline content="1. Link To A Server" onClick={() => act('find')} />
              </Box>
              {authorized ? (
                server_online ? (
                  <>
                    <Box mb={0.5}>
                      <Button inline content="2. View Request Console Logs" onClick={() => act('viewr')} />
                    </Box>
                    <Box mb={0.5}>
                      <Button inline content="3. Clear Request Console Logs" onClick={() => act('clearr')} />
                    </Box>
                    <Box mb={0.5}>
                      <Button inline content="4. Set Custom Key" onClick={() => act('pass')} />
                    </Box>
                  </>
                ) : (
                  <Box style={{ color: '#cc2222' }}>ERROR: Server not found!</Box>
                )
              ) : (
                <Box mt={1} style={{ color: C.textDim }}>
                  Please authenticate with the server in order to show additional options.
                </Box>
              )}
              {can_hack ? (
                <Box mt={1}>
                  <Button inline content="*&@#. Bruteforce Key" color="bad" onClick={() => act('hack')} />
                </Box>
              ) : null}
            </Section>
          )}

          {screen === 2 && (
            <Section title="Brute-Forcing" style={{ border: '1px solid ' + C.border }}>
              {silicon ? (
                <Box>
                  <Box>Brute-forcing for server key.</Box>
                  <Box mt={1}>It will take 20 seconds for every character that the password has.</Box>
                  <Box mt={1}>
                    In the meantime, this console can reveal your true intentions if you let someone access it.
                    Make sure no humans enter the room during that time.
                  </Box>
                </Box>
              ) : (
                <Box style={{ color: C.textDim, wordBreak: 'break-all', lineHeight: '1.4' }}>{BINARY}</Box>
              )}
            </Section>
          )}

          {screen === 4 && (
            <Section title="Request Console Logs" style={{ border: '1px solid ' + C.border }}>
              <Box mb={1}>
                <Button inline mr={0.5} icon="arrow-left" content="Back" onClick={() => act('back')} />
                <Button inline icon="sync" content="Refresh" onClick={() => act('refresh')} />
              </Box>
              {logs.length === 0 ? (
                <Box style={{ color: C.textDim }}>No log entries.</Box>
              ) : (
                logs.map((log, i) => (
                  <Box
                    key={i}
                    mb={1}
                    style={{ border: '1px solid ' + C.border, background: C.panel, padding: '6px' }}>
                    <Box mb={0.5}>
                      <Button
                        inline
                        icon="times"
                        content="Delete"
                        color="bad"
                        onClick={() => act('deleter', { ref: log.ref })} />
                    </Box>
                    <Box><Box inline style={{ color: C.textDim }}>Sending Dep.: </Box>{log.send_dpt}</Box>
                    <Box><Box inline style={{ color: C.textDim }}>Receiving Dep.: </Box>{log.rec_dpt}</Box>
                    <Box><Box inline style={{ color: C.textDim }}>Message: </Box>{log.message}</Box>
                    <Box><Box inline style={{ color: C.textDim }}>Stamp: </Box>{log.stamp}</Box>
                    <Box><Box inline style={{ color: C.textDim }}>ID Auth.: </Box>{log.id_auth}</Box>
                    <Box><Box inline style={{ color: C.textDim }}>Priority: </Box>{log.priority}</Box>
                  </Box>
                ))
              )}
            </Section>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
