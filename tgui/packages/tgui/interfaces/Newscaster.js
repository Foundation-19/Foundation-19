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

export const Newscaster = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    screen,
    unit_no,
    scanned_user,
    security,
    channel_name,
    c_locked,
    msg,
    paper_remaining,
    company,
    station,
    has_photo,
    photo,
    channels = [],
    errors = [],
    stats = {},
    viewing,
    wanted,
    wanted_issue,
  } = data;

  const channelRows = (actionName) => (
    channels.map((channel, i) => (
      <Box key={i} mb={0.5}>
        <Button
          inline
          icon="bullhorn"
          content={channel.name}
          color={channel.admin ? 'green' : undefined}
          onClick={() => act(actionName, { ref: channel.ref })} />
        {channel.admin ? <Box inline ml={1} style={{ color: '#44ff44' }}>[ADMIN]</Box> : null}
        {channel.censored ? <Box inline ml={1} style={{ color: '#cc2222' }}>***</Box> : null}
      </Box>
    ))
  );

  const result = (text, back) => (
    <Box>
      <Box>{text}</Box>
      <Box mt={1}>
        <Button inline icon="arrow-left" content="Return" onClick={() => act('setScreen', { screen: back })} />
      </Box>
    </Box>
  );

  const errorScreen = (title, back) => (
    <Box>
      <Box style={{ color: '#cc2222', fontWeight: 'bold' }}>{title}</Box>
      <Box mt={1}>
        {errors.map((error, i) => (
          <Box key={i} style={{ color: '#cc2222' }}>{error}</Box>
        ))}
      </Box>
      <Box mt={1}>
        <Button inline icon="arrow-left" content="Return" onClick={() => act('setScreen', { screen: back })} />
      </Box>
    </Box>
  );

  const photoBlock = (
    <Box>
      {has_photo ? (
        <Box>
          <Box mt={0.5}><img src={photo} width="180" /></Box>
          <Box mt={0.5}>
            <Button inline icon="trash" content="Delete Photo" onClick={() => act('set_attachment')} />
          </Box>
        </Box>
      ) : (
        <Button inline icon="camera" content="Attach Photo" onClick={() => act('set_attachment')} />
      )}
    </Box>
  );

  const renderScreen = () => {
    switch (screen) {
      case 0:
        return (
          <Box>
            <Box style={{ color: C.textDim }}>
              Welcome to Newscasting Unit #{unit_no}. Interface & News networks Operational.
            </Box>
            <Box style={{ color: C.textDim, fontSize: '10px' }}>
              Property of Ward-Takahashi GMB
            </Box>
            {wanted ? (
              <Box mt={1}>
                <Button inline icon="exclamation-triangle" content="Read Wanted Issue" onClick={() => act('view_wanted')} />
              </Box>
            ) : null}
            <Box mt={1}>
              <Button inline icon="plus" content="Create Feed Channel" mr={0.5} onClick={() => act('create_channel')} />
              <Button inline icon="list" content="View Feed Channels" mr={0.5} onClick={() => act('view')} />
              <Button inline icon="pen" content="Submit new Feed story" mr={0.5} onClick={() => act('create_feed_story')} />
              <Button inline icon="print" content="Print newspaper" mr={0.5} onClick={() => act('menu_paper')} />
              <Button inline icon="sync" content="Re-scan User" onClick={() => act('refresh')} />
            </Box>
            {security ? (
              <Section title="Feed Security functions" style={{ border: '1px solid ' + C.border, background: C.panel, marginTop: '8px' }}>
                <Box mb={0.5}>
                  <Button inline icon="user-secret" content={(wanted ? 'Manage' : 'Publish') + ' "Wanted" Issue'} onClick={() => act('menu_wanted')} />
                </Box>
                <Box mb={0.5}>
                  <Button inline icon="ban" content="Censor Feed Stories" onClick={() => act('menu_censor_story')} />
                </Box>
                <Box>
                  <Button inline icon="exclamation" content={'Mark Feed Channel with ' + company + ' D-Notice'} onClick={() => act('menu_censor_channel')} />
                </Box>
              </Section>
            ) : null}
            <Box mt={1}>
              The newscaster recognises you as:{' '}
              <Box inline style={{ color: '#44ff44' }}>{scanned_user}</Box>
            </Box>
          </Box>
        );

      case 1:
        return (
          <Box>
            <Box mb={1} style={{ color: C.amber }}>Local Feed Channels</Box>
            {channels.length === 0 ? (
              <Box style={{ color: C.textDim }}>No active channels found...</Box>
            ) : channelRows('show_channel')}
            <Box mt={1}>
              <Button inline icon="sync" content="Refresh" mr={0.5} onClick={() => act('refresh')} />
              <Button inline icon="arrow-left" content="Back" onClick={() => act('setScreen', { screen: 0 })} />
            </Box>
          </Box>
        );

      case 2:
        return (
          <Box>
            <Box style={{ color: C.amber }}>Creating new Feed Channel...</Box>
            <Box mt={1}>
              Channel Name:{' '}
              <Button inline icon="edit" content={channel_name || '(none)'} onClick={() => act('set_channel_name')} />
            </Box>
            <Box mt={0.5}>
              Channel Author: <Box inline style={{ color: '#44ff44' }}>{scanned_user}</Box>
            </Box>
            <Box mt={0.5}>
              Will Accept Public Feeds:{' '}
              <Button inline content={c_locked ? 'NO' : 'YES'} onClick={() => act('set_channel_lock')} />
            </Box>
            <Box mt={1}>
              <Button inline icon="check" color="green" content="Submit" mr={0.5} onClick={() => act('submit_new_channel')} />
              <Button inline icon="times" content="Cancel" onClick={() => act('setScreen', { screen: 0 })} />
            </Box>
          </Box>
        );

      case 3:
        return (
          <Box>
            <Box style={{ color: C.amber }}>Creating new Feed Message...</Box>
            <Box mt={1}>
              Receiving Channel:{' '}
              <Button inline icon="bullhorn" content={channel_name || '(none)'} onClick={() => act('set_channel_receiving')} />
            </Box>
            <Box mt={0.5}>
              Message Author: <Box inline style={{ color: '#44ff44' }}>{scanned_user}</Box>
            </Box>
            <Box mt={0.5}>
              Message Body:{' '}
              <Button inline icon="edit" content={msg || '(empty)'} onClick={() => act('set_new_message')} />
            </Box>
            <Box mt={0.5}>Photo: {photoBlock}</Box>
            <Box mt={1}>
              <Button inline icon="check" color="green" content="Submit" mr={0.5} onClick={() => act('submit_new_message')} />
              <Button inline icon="times" content="Cancel" onClick={() => act('setScreen', { screen: 0 })} />
            </Box>
          </Box>
        );

      case 4:
        return result('Feed story successfully submitted to ' + channel_name + '.', 0);

      case 5:
        return result('Feed Channel ' + channel_name + ' created successfully.', 0);

      case 6:
        return errorScreen('ERROR: Could not submit Feed story to Network.', 3);

      case 7:
        return errorScreen('ERROR: Could not submit Feed Channel to Network.', 2);

      case 8:
        return (
          <Box>
            <Box>
              Network currently serves a total of {stats.total} Feed channels, {stats.active} of which are active, and a total of {stats.messages} Feed Stories.
            </Box>
            <Box mt={1}>Liquid Paper remaining: {paper_remaining * 100} cm^3</Box>
            <Box mt={1}>
              <Button inline icon="print" content="Print Paper" mr={0.5} onClick={() => act('print_paper')} />
              <Button inline icon="times" content="Cancel" onClick={() => act('setScreen', { screen: 0 })} />
            </Box>
          </Box>
        );

      case 9:
        if (!viewing) {
          return result('Channel no longer available.', 1);
        }
        return (
          <Box>
            <Box>
              <Box inline style={{ color: C.amber, fontWeight: 'bold' }}>{viewing.name}</Box>
              <Box inline ml={1} style={{ color: C.textDim, fontSize: '10px' }}>
                [created by: {viewing.author}] [views: {viewing.views}]
              </Box>
            </Box>
            {viewing.censored ? (
              <Box mt={1} style={{ color: '#cc2222' }}>
                ATTENTION: This channel has been deemed as threatening to the welfare of the {station}, and marked with a {company} D-Notice. No further feed story additions are allowed while the D-Notice is in effect.
              </Box>
            ) : viewing.messages.length === 0 ? (
              <Box mt={1} style={{ color: C.textDim }}>No feed messages found in channel...</Box>
            ) : (
              <Box mt={1}>
                {viewing.messages.map((message, i) => (
                  <Box key={i} mb={1} pb={0.5} style={{ borderBottom: '1px solid ' + C.border }}>
                    <Box dangerouslySetInnerHTML={{ __html: message.body }} />
                    {message.img ? <Box mt={0.5}><img src={message.img} width="180" /></Box> : null}
                    {message.caption ? <Box style={{ fontSize: '10px' }}><b>{message.caption}</b></Box> : null}
                    <Box style={{ fontSize: '10px', color: C.textDim }}>
                      [Story by {message.author} - {message.time}]
                    </Box>
                  </Box>
                ))}
              </Box>
            )}
            <Box mt={1}>
              <Button inline icon="sync" content="Refresh" mr={0.5} onClick={() => act('refresh')} />
              <Button inline icon="arrow-left" content="Back" onClick={() => act('setScreen', { screen: 1 })} />
            </Box>
          </Box>
        );

      case 10:
        return (
          <Box>
            <Box style={{ color: C.amber, fontWeight: 'bold' }}>{company} Feed Censorship Tool</Box>
            <Box mt={0.5} style={{ color: C.textDim, fontSize: '10px' }}>
              NOTE: Due to the nature of news Feeds, total deletion of a Feed Story is not possible. Keep in mind that users attempting to view a censored feed will instead see the [REDACTED] tag above it.
            </Box>
            <Box mt={1}>Select Feed channel to get Stories from:</Box>
            {channels.length === 0 ? (
              <Box style={{ color: C.textDim }}>No feed channels found active...</Box>
            ) : channelRows('pick_censor_channel')}
            <Box mt={1}>
              <Button inline icon="times" content="Cancel" onClick={() => act('setScreen', { screen: 0 })} />
            </Box>
          </Box>
        );

      case 11:
        return (
          <Box>
            <Box style={{ color: C.amber, fontWeight: 'bold' }}>{company} D-Notice Handler</Box>
            <Box mt={0.5} style={{ color: C.textDim, fontSize: '10px' }}>
              A D-Notice is to be bestowed upon the channel if the handling Authority deems it as harmful for the {station}'s morale, integrity or disciplinary behaviour. A D-Notice will render a channel unable to be updated by anyone, without deleting any feed stories it might contain at the time. You can lift a D-Notice if you have the required access at any time.
            </Box>
            {channels.length === 0 ? (
              <Box style={{ color: C.textDim }}>No feed channels found active...</Box>
            ) : channelRows('pick_d_notice')}
            <Box mt={1}>
              <Button inline icon="arrow-left" content="Back" onClick={() => act('setScreen', { screen: 0 })} />
            </Box>
          </Box>
        );

      case 12:
        if (!viewing) {
          return result('Channel no longer available.', 10);
        }
        return (
          <Box>
            <Box>
              <Box inline style={{ color: C.amber, fontWeight: 'bold' }}>{viewing.name}</Box>
              <Box inline ml={1} style={{ color: C.textDim, fontSize: '10px' }}>
                [ created by: {viewing.author} ]
              </Box>
            </Box>
            <Box mt={1}>
              <Button
                inline
                color="red"
                content={viewing.author_censored ? 'Undo Author censorship' : 'Censor channel Author'}
                onClick={() => act('censor_channel_author', { ref: viewing.ref })} />
            </Box>
            {viewing.messages.length === 0 ? (
              <Box mt={1} style={{ color: C.textDim }}>No feed messages found in channel...</Box>
            ) : (
              <Box mt={1}>
                {viewing.messages.map((message, i) => (
                  <Box key={i} mb={1}>
                    <Box dangerouslySetInnerHTML={{ __html: message.body }} />
                    <Box style={{ fontSize: '10px', color: C.textDim }}>
                      [{message.type} by {message.author}]
                    </Box>
                    <Button
                      inline
                      content={message.body_censored ? 'Undo story censorship' : 'Censor story'}
                      mr={0.5}
                      onClick={() => act('censor_channel_story_body', { ref: message.ref })} />
                    <Button
                      inline
                      content={message.author_censored ? 'Undo Author Censorship' : 'Censor message Author'}
                      onClick={() => act('censor_channel_story_author', { ref: message.ref })} />
                  </Box>
                ))}
              </Box>
            )}
            <Box mt={1}>
              <Button inline icon="arrow-left" content="Back" onClick={() => act('setScreen', { screen: 10 })} />
            </Box>
          </Box>
        );

      case 13:
        if (!viewing) {
          return result('Channel no longer available.', 11);
        }
        return (
          <Box>
            <Box>
              <Box inline style={{ color: C.amber, fontWeight: 'bold' }}>{viewing.name}</Box>
              <Box inline ml={1} style={{ color: C.textDim, fontSize: '10px' }}>
                [ created by: {viewing.author} ]
              </Box>
            </Box>
            <Box mt={1}>
              Channel messages listed below. If you deem them dangerous to the {station}, you can{' '}
              <Button inline content="Bestow a D-Notice upon the channel" onClick={() => act('toggle_d_notice', { ref: viewing.ref })} />.
            </Box>
            {viewing.censored ? (
              <Box mt={1} style={{ color: '#cc2222' }}>
                ATTENTION: This channel has been deemed as threatening to the welfare of the {station}, and marked with a {company} D-Notice. No further feed story additions are allowed while the D-Notice is in effect.
              </Box>
            ) : viewing.messages.length === 0 ? (
              <Box mt={1} style={{ color: C.textDim }}>No feed messages found in channel...</Box>
            ) : (
              <Box mt={1}>
                {viewing.messages.map((message, i) => (
                  <Box key={i} mb={1}>
                    <Box dangerouslySetInnerHTML={{ __html: message.body }} />
                    <Box style={{ fontSize: '10px', color: C.textDim }}>
                      [{message.type} by {message.author}]
                    </Box>
                  </Box>
                ))}
              </Box>
            )}
            <Box mt={1}>
              <Button inline icon="arrow-left" content="Back" onClick={() => act('setScreen', { screen: 11 })} />
            </Box>
          </Box>
        );

      case 14:
        return (
          <Box>
            <Box style={{ color: C.amber, fontWeight: 'bold' }}>Wanted Issue Handler:</Box>
            {wanted ? (
              <Box mt={0.5} style={{ color: C.textDim }}>
                A wanted issue is already in Feed Circulation. You can edit or cancel it below.
              </Box>
            ) : null}
            <Box mt={1}>
              Criminal Name:{' '}
              <Button inline icon="edit" content={channel_name || '(none)'} onClick={() => act('set_wanted_name')} />
            </Box>
            <Box mt={0.5}>
              Description:{' '}
              <Button inline icon="edit" content={msg || '(none)'} onClick={() => act('set_wanted_desc')} />
            </Box>
            <Box mt={0.5}>Photo: {photoBlock}</Box>
            {wanted ? (
              <Box mt={0.5}>
                Wanted Issue created by: <Box inline style={{ color: '#44ff44' }}>{wanted_issue ? wanted_issue.backup_author : ''}</Box>
              </Box>
            ) : (
              <Box mt={0.5}>
                Wanted Issue will be created under prosecutor: <Box inline style={{ color: '#44ff44' }}>{scanned_user}</Box>
              </Box>
            )}
            <Box mt={1}>
              <Button
                inline
                icon="check"
                color="green"
                content={wanted ? 'Edit Issue' : 'Submit'}
                mr={0.5}
                onClick={() => act('submit_wanted', { end_param: wanted ? 2 : 1 })} />
              {wanted ? (
                <Button inline icon="trash" color="red" content="Take down Issue" mr={0.5} onClick={() => act('cancel_wanted')} />
              ) : null}
              <Button inline icon="times" content="Cancel" onClick={() => act('setScreen', { screen: 0 })} />
            </Box>
          </Box>
        );

      case 15:
        return result('Wanted issue for ' + channel_name + ' is now in Network Circulation.', 0);

      case 16:
        return errorScreen('ERROR: Wanted Issue rejected by Network.', 0);

      case 17:
        return result('Wanted Issue successfully deleted from Circulation', 0);

      case 18:
        if (!wanted_issue) {
          return result('No wanted issue in circulation.', 0);
        }
        return (
          <Box>
            <Box style={{ color: '#cc2222', fontWeight: 'bold' }}>-- STATIONWIDE WANTED ISSUE --</Box>
            <Box style={{ color: C.textDim, fontSize: '10px' }}>
              [Submitted by: {wanted_issue.backup_author}]
            </Box>
            <Box mt={1}><b>Criminal</b>: {wanted_issue.author}</Box>
            <Box><b>Description</b>: {wanted_issue.body}</Box>
            <Box mt={0.5}>
              <b>Photo</b>:{' '}
              {wanted_issue.img ? <Box mt={0.5}><img src={wanted_issue.img} width="180" /></Box> : 'None'}
            </Box>
            <Box mt={1}>
              <Button inline icon="arrow-left" content="Back" onClick={() => act('setScreen', { screen: 0 })} />
            </Box>
          </Box>
        );

      case 19:
        return result('Wanted issue for ' + channel_name + ' successfully edited.', 0);

      case 20:
        return result('Printing successful. Please receive your newspaper from the bottom of the machine.', 0);

      case 21:
        return result('Unable to print newspaper. Insufficient paper. Please notify maintenance personnel to refill machine storage.', 0);

      default:
        return (
          <Box style={{ color: '#cc2222' }}>
            I'm sorry to break your immersion. This UI is in an unknown state.
          </Box>
        );
    }
  };

  return (
    <Window width={460} height={640}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.borderRed, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>NEWSCASTER UNIT #{unit_no}</Box>
          </Box>
          {renderScreen()}
        </Box>
      </Window.Content>
    </Window>
  );
};
