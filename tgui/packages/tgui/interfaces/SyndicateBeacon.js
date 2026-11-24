import { useBackend } from '../backend';
import { Box, Button } from '../components';
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

export const SyndicateBeacon = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    temptext,
    status,
    name,
    scan_phrase,
    honorific,
    phrase,
    selfdestructing,
  } = data;

  return (
    <Window width={400} height={300}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>SYNDICATE BEACON</Box>
          </Box>

          <Box style={{ color: '#005500' }}>
            <i>Scanning {scan_phrase}...</i>
            <Box><i>Identity confirmed,</i></Box>
          </Box>

          {status === 'special' ? (
            <Box mt={1} style={{ color: '#007700' }}>
              <i>Operative record found. Greetings, Agent {name}.</i>
            </Box>
          ) : status === 'severed' ? (
            <Box mt={1}><tt>Connection severed.</tt></Box>
          ) : status === 'unknown' ? (
            <Box mt={1} style={{ color: '#cc2222' }}>
              <i>Identity not found in operative database. What can the Syndicate do for you today, {honorific} {name}?</i>
              {!selfdestructing ? (
                <Box mt={1}>
                  <Button icon="user-secret" content={phrase} onClick={() => act('betraitor')} />
                </Box>
              ) : null}
            </Box>
          ) : null}

          {temptext ? (
            <Box mt={1} dangerouslySetInnerHTML={{ __html: temptext }} />
          ) : null}
        </Box>
      </Window.Content>
    </Window>
  );
};
