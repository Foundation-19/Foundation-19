import { useBackend } from '../backend';
import { Box, Button } from '../components';
import { Window } from '../layouts';

// Standalone crew manifest window, opened from the lobby desktop's
// Manifest app. Reuses the same manifest payload the desktop app had
// (server computes it once per act/open), but with real estate to breathe
// and its own scrollbar instead of being crammed into the 612px monitor.

const C = {
  bg: '#0b0b0d',
  panel: '#101013',
  border: '#2a2a31',
  redLine: '#5a1010',
  red: '#6b0000',
  redDark: '#3a0000',
  redBright: '#cc2222',
  amber: '#e0a030',
  text: '#c9c9cf',
  textDim: '#7a7a85',
  good: '#3ddc3d',
  mono: '"Consolas", "Courier New", monospace',
};

const TITLE_BG = 'linear-gradient(180deg, ' + C.red + ', ' + C.redDark + ')';

const DEPT_COLOR = {
  Command: C.amber,
  'Command Support': '#c9b06a',
  Research: '#7ab8d4',
  Security: '#d46a6a',
  Medical: '#d4a0a0',
  Engineering: '#d4b87a',
  Supply: '#a8b86a',
  Exploration: '#6ac4a8',
  Service: '#b8a8d4',
  Civilian: '#c4c4a0',
  Miscellaneous: C.textDim,
};

export const LobbyManifest = (props, context) => {
  const { act, data } = useBackend(context);
  const { manifest, manifest_count } = data;

  return (
    <Window theme="scp_terminal" width={500} height={600}>
      <Window.Content scrollable style={{ background: C.bg, padding: 0 }}>
        <Box style={{ fontFamily: C.mono, color: C.text, minHeight: '100%' }}>
          <Box style={{
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'space-between',
            padding: '5px 10px',
            background: TITLE_BG,
            color: C.textHi,
            fontWeight: 'bold',
            letterSpacing: '0.1em',
            borderBottom: '1px solid ' + C.redBright,
          }}>
            <Box style={{ fontSize: '11px' }}>
              <span style={{ color: C.good }}>◉</span> CREW MANIFEST — SITE-53
            </Box>
            <Button
              content="Back"
              onClick={() => act('manifest_window_close')}
            />
          </Box>
          <Box style={{
            padding: '6px 10px',
            background: 'rgba(0,0,0,0.25)',
            borderBottom: '1px solid ' + C.border,
            fontSize: '9px',
            color: C.textDim,
            letterSpacing: '0.06em',
          }}>
            SCP FOUNDATION — SITE-53 PERSONNEL ROSTER | LIVE FEED | CLASSIFIED
          </Box>

          <Box style={{ padding: '10px 12px' }}>
            {(!manifest || !manifest.length) ? (
              <Box style={{ color: C.textDim, fontSize: '11px' }}>
                NO CREW RECORDS ON FILE.<br />
                Manifest populates once the crew is assigned and spawned.
              </Box>
            ) : (
              <Box>
                <Box style={{
                  color: C.textDim,
                  fontSize: '10px',
                  letterSpacing: '0.12em',
                  textTransform: 'uppercase',
                  paddingBottom: '3px',
                  marginBottom: '6px',
                  borderBottom: '1px solid ' + C.redLine,
                }}>
                  Active personnel — {manifest_count}
                </Box>
                {manifest.map((dept, di) => (
                  <Box key={di} mb={3}>
                    <Box style={{
                      color: DEPT_COLOR[dept.name] || C.textDim,
                      fontSize: '11px',
                      letterSpacing: '0.1em',
                      borderBottom: '1px solid ' + C.redLine,
                      marginBottom: '3px',
                      paddingBottom: '2px',
                    }}>
                      {dept.name.toUpperCase()}
                    </Box>
                    {dept.members.map((member, mi) => (
                      <Box key={mi} style={{
                        display: 'flex',
                        fontSize: '12px',
                        padding: '2px 6px',
                        background: mi % 2 ? 'rgba(255,255,255,0.025)' : 'transparent',
                        color: member.active ? C.text : C.textDim,
                      }}>
                        <Box style={{ width: '46%', overflow: 'hidden', whiteSpace: 'nowrap', textOverflow: 'ellipsis' }}>
                          {member.name}
                        </Box>
                        <Box style={{ width: '40%', overflow: 'hidden', whiteSpace: 'nowrap', textOverflow: 'ellipsis', color: C.textDim }}>
                          {member.rank}
                        </Box>
                        <Box style={{ width: '14%', textAlign: 'right', color: member.active ? C.good : C.textDim, fontSize: '10px' }}>
                          {member.active ? '●' : '○'}
                        </Box>
                      </Box>
                    ))}
                  </Box>
                ))}
                <Box style={{ color: C.textDim, fontSize: '9px', marginTop: '4px' }}>
                  ● ACTIVE &nbsp; ○ INACTIVE
                </Box>
              </Box>
            )}
          </Box>
        </Box>
      </Window.Content>
    </Window>
  );
};
