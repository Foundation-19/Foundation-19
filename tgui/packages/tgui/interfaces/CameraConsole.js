import { useBackend } from '../backend';
import { Box, Button, Section } from '../components';
import { Window } from '../layouts';
import { ProgramExitButtons } from './common/ProgramExitButtons';

const C = {
  bg: '#08080a',
  panel: '#0c0c10',
  border: '#1e1e24',
  borderRed: '#6b0000',
  red: '#8b0000',
  redBright: '#cc2222',
  green: '#1a7a1a',
  greenBright: '#44ff44',
  text: '#b0b0b0',
  textBright: '#e0e0e8',
  textDim: '#555560',
  amber: '#d4a017',
  mono: '"Consolas", "Courier New", "Lucida Console", monospace',
};

// Zone tab labels: networks arrive pre-named by the map ("Light Containment
// Zone Network", "SCP-173 CCTV Network", ...). Strip the boilerplate suffix.
const zoneLabel = (tag) => {
  if (!tag) return '???';
  return tag
    .replace(/ Network$/, '')
    .replace(/ CCTV Network/, '')
    .replace(/ \(CAUTION!\)/, '')
    .toUpperCase();
};

export const CameraConsole = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    current_camera,
    current_network,
    networks = [],
    cameras = [],
  } = data;
  const showExit = data && data.PC_showexitprogram;

  const online = cameras.filter((cam) => !cam.deact).length;
  const offline = cameras.length - online;

  return (
    <Window theme="scp_terminal" width={620} height={680} buttons={showExit ? <ProgramExitButtons act={act} /> : undefined}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', fontFamily: C.mono, color: C.text }}>
          {/* Header */}
          <Box style={{ borderBottom: '2px solid ' + C.borderRed, padding: '10px 14px 8px', background: 'linear-gradient(180deg, #0e0000 0%, #08080a 100%)' }}>
            <Box style={{ fontSize: '14px', fontWeight: 'bold', color: C.amber, letterSpacing: '0.18em' }}>
              SCP CAMERA MONITORING
            </Box>
            <Box style={{ fontSize: '11px', color: C.textDim, letterSpacing: '0.12em', marginTop: '2px' }}>
              {cameras.length} FEEDS | {offline} OFFLINE | {current_network ? zoneLabel(current_network) : 'NO ZONE SELECTED'}
            </Box>
          </Box>

          {/* Zone tabs */}
          <Box style={{ borderBottom: '1px solid ' + C.borderRed, background: C.panel, overflowX: 'auto', marginBottom: '8px' }}>
            <Box style={{ whiteSpace: 'nowrap' }}>
              {networks.map((n) => {
                const isActive = current_network === n.tag;
                return (
                  <Box
                    key={n.tag}
                    inline
                    style={{
                      padding: '5px 10px',
                      cursor: n.has_access ? 'pointer' : 'not-allowed',
                      background: isActive ? 'rgba(139,0,0,0.25)' : 'transparent',
                      borderRight: '1px solid ' + C.border,
                      borderBottom: isActive ? '2px solid ' + C.amber : '2px solid transparent',
                      color: n.has_access ? (isActive ? C.textBright : C.textDim) : '#3a3a3a',
                      fontSize: '10px',
                      letterSpacing: '0.1em',
                      textDecoration: n.has_access ? 'none' : 'line-through',
                    }}
                    onClick={() => { if (n.has_access) { act('switch_network', { switch_network: n.tag }); } }}
                  >
                    {zoneLabel(n.tag)}
                  </Box>
                );
              })}
            </Box>
          </Box>

          {/* Active feed banner */}
          {current_camera ? (
            <Box style={{ margin: '0 14px 8px', padding: '6px 10px', borderLeft: '2px solid ' + C.green, background: C.panel }}>
              <Box style={{ color: C.greenBright, fontSize: '11px', fontWeight: 'bold' }}>
                LIVE FEED: {current_camera.name}
              </Box>
              <Box style={{ color: C.textDim, fontSize: '10px' }}>
                AREA: {(current_camera.area || 'UNKNOWN').toUpperCase()} | POS: ({current_camera.x}, {current_camera.y}, {current_camera.z})
              </Box>
              <Box style={{ marginTop: '4px' }}>
                <Button
                  content="END FEED"
                  onClick={() => act('reset')}
                  style={{
                    fontFamily: C.mono, fontSize: '10px', letterSpacing: '0.1em',
                    border: '1px solid ' + C.borderRed, borderRadius: 0,
                    color: C.textBright, background: 'rgba(139,0,0,0.2)', padding: '2px 8px',
                  }}
                />
              </Box>
            </Box>
          ) : null}

          {/* Camera list */}
          <Section title="CAMERA FEEDS" style={{ background: 'transparent', margin: '0 14px' }}>
            {cameras.length === 0 ? (
              <Box style={{ color: C.textDim, fontStyle: 'italic', fontSize: '11px' }}>
                {current_network ? 'NO CAMERAS IN ZONE' : 'SELECT A ZONE TO LIST FEEDS'}
              </Box>
            ) : (
              cameras.map((cam, i) => (
                <Box
                  key={i}
                  style={{
                    marginBottom: '3px',
                    padding: '5px 8px',
                    borderLeft: '2px solid ' + (cam.deact ? C.redBright : C.green),
                    background: C.panel,
                  }}
                >
                  <Box style={{ display: 'inline-block', width: '78%', verticalAlign: 'top' }}>
                    <Box style={{ color: cam.deact ? C.textDim : C.textBright, fontSize: '11px', fontWeight: 'bold' }}>
                      {cam.name}
                    </Box>
                    <Box style={{ color: C.textDim, fontSize: '10px' }}>
                      {(cam.area || 'UNKNOWN').toUpperCase()}
                    </Box>
                  </Box>
                  <Box style={{ display: 'inline-block', width: '20%', textAlign: 'right' }}>
                    {cam.deact ? (
                      <Box style={{ color: C.redBright, fontSize: '10px', letterSpacing: '0.1em' }}>OFFLINE</Box>
                    ) : (
                      <Button
                        content="VIEW"
                        onClick={() => act('switch_camera', { switch_camera: cam.camera })}
                        style={{
                          fontFamily: C.mono, fontSize: '10px', letterSpacing: '0.1em',
                          border: '1px solid ' + C.borderRed, borderRadius: 0,
                          color: C.textBright, background: 'rgba(139,0,0,0.2)', padding: '3px 10px',
                        }}
                      />
                    )}
                  </Box>
                </Box>
              ))
            )}
          </Section>

          {/* Footer */}
          <Box style={{ borderTop: '1px solid ' + C.border, padding: '4px 14px', background: C.panel, marginTop: '8px' }}>
            <Box style={{ color: C.textDim, fontSize: '10px', letterSpacing: '0.1em' }}>
              SCP FOUNDATION | CAMERA MONITORING | ALL FEEDS RECORDED |
              {' '}UNAUTHORIZED ACCESS IS A CLASS-A INFRACTION
            </Box>
          </Box>
        </Box>
      </Window.Content>
    </Window>
  );
};
