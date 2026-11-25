import { useBackend } from '../backend';
import { Box, Button, Flex, NoticeBox, Section } from '../components';
import { Window } from '../layouts';
import { ProgramExitButtons } from './common/ProgramExitButtons';

export const News = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    has_network,
    notifs_enabled,
    prog_state,
    time_blurb,
    channels = [],
    active_channels = [],
    active_channel,
    active_stories = [],
  } = data;
  const showExit = data && data.PC_showexitprogram;

  return (
    <Window theme="scp_terminal" width={620} height={640} buttons={showExit ? <ProgramExitButtons act={act} /> : undefined}>
      <Window.Content scrollable>
        <Box style={{ background: '#0a0a0c', minHeight: '100%', padding: '10px', fontFamily: '"Consolas", monospace', color: '#c8c8c8' }}>
          <Box style={{ borderBottom: '2px solid #6b0000', paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: '#d4a017', letterSpacing: '0.15em', fontWeight: 'bold' }}>SCPiNET NEWS NETWORK</Box>
            <Box style={{ color: '#6a6a70', fontSize: '9px' }} dangerouslySetInnerHTML={{ __html: time_blurb }} />
          </Box>

          {!has_network ? (
            <NoticeBox danger>NO NETWORK CONNECTION — re-establishing...</NoticeBox>
          ) : (
            <Box>
              <Section
                title={prog_state === 1 && active_channel ? 'CHANNEL: ' + active_channel.name : 'CHANNELS'}
                buttons={
                  <Box>
                    <Button
                      icon="bell"
                      content={notifs_enabled ? 'Notifs ON' : 'Notifs OFF'}
                      selected={notifs_enabled}
                      onClick={() => act('toggle_notifs')}
                    />
                    {prog_state === 1 && active_channel ? (
                      <Button icon="arrow-left" content="Back" onClick={() => act('return_to_home')} />
                    ) : null}
                  </Box>
                }
              >
                {prog_state === 1 && active_channel ? (
                  <Box>
                    {active_stories.map((story, i) => (
                      <Box key={i} mb={2} pb={1} style={{ borderBottom: '1px solid #2a2a30' }}>
                        <Box style={{ color: '#d4a017' }}>{story.author}</Box>
                        <Box mt={0.5} dangerouslySetInnerHTML={{ __html: story.body }} />
                      </Box>
                    ))}
                    {active_stories.length === 0 ? <Box style={{ color: '#6a6a70' }}>No stories in this channel.</Box> : null}
                  </Box>
                ) : (
                  <Box>
                    {channels.map((ch) => (
                      <Flex key={ch.ref} align="center" mb={0.5}>
                        <Box style={{ flex: 1 }}>
                          {ch.name}
                          {ch.admin ? <Box inline ml={1} style={{ color: '#44ff44' }}>[ADMIN]</Box> : null}
                          {ch.censored ? <Box inline ml={1} style={{ color: '#cc2222' }}>[CENSORED]</Box> : null}
                        </Box>
                        <Button icon="book-open" content="View" onClick={() => act('view_channel', { channel: ch.ref })} />
                      </Flex>
                    ))}
                  </Box>
                )}
              </Section>
            </Box>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
