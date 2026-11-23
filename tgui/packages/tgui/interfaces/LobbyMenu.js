import { useBackend, useLocalState } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

const C = {
  bg: '#0a0a0c',
  desk: '#111114',
  border: '#2a2a30',
  borderRed: '#6b0000',
  amber: '#d4a017',
  text: '#c8c8c8',
  textDim: '#6a6a70',
  good: '#0a6e0a',
  red: '#cc2222',
  mono: '"Consolas", "Courier New", monospace',
};

// App panel: fixed 460px block (proven layout pattern — no flex).
const AppFrame = (props) => (
  <Box style={{
    background: C.desk,
    border: '1px solid ' + C.border,
    borderTop: '2px solid ' + C.borderRed,
    width: '440px',
    display: 'inline-block',
    verticalAlign: 'top',
    padding: '10px',
    margin: '10px',
    fontFamily: C.mono,
    color: C.text,
  }}>
    <Box style={{ borderBottom: '1px solid ' + C.border, paddingBottom: '4px', marginBottom: '8px', color: C.textDim, fontSize: '10px' }}>
      {props.title} — SCiPNET-OS
    </Box>
    {props.children}
  </Box>
);

// Desktop icon: 110px block.
const DesktopIcon = (props) => (
  <Box style={{
    display: 'inline-block',
    verticalAlign: 'top',
    width: '110px',
    textAlign: 'center',
    cursor: 'pointer',
    margin: '10px',
    fontFamily: C.mono,
  }} onClick={props.onClick}>
    <Box style={{ fontSize: '30px', color: C.amber }}>{props.icon}</Box>
    <Box style={{ fontSize: '9px', color: C.text }}>{props.label}</Box>
  </Box>
);

export const LobbyMenu = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    ckey,
    character_name,
    round_started,
    ready,
    round_duration,
    player_count,
    server_time,
    security_level,
  } = data;

  const [activeApp, setActiveApp] = useLocalState(context, 'os.activeApp', 'desktop');
  const [booting, setBooting] = useLocalState(context, 'os.booting', true);

  if (booting) {
    return (
      <Window theme="scp_terminal" width={640} height={520}>
        <Window.Content style={{ background: '#000', padding: 0 }}>
          <Box style={{ fontFamily: C.mono, color: '#44ff44', padding: '16px', fontSize: '11px' }} onClick={() => setBooting(false)}>
            <Box>SCiPNET-OS v5.0 — SECURE NETWORK TERMINAL</Box>
            <Box mt={2}>POST .................................. [ OK ]</Box>
            <Box>MEMORY CHECK ......................... [ OK ]</Box>
            <Box>ENCRYPTION MODULE (AES-512) .......... [ OK ]</Box>
            <Box>SCiPNET UPLINK ....................... [ OK ]</Box>
            <Box>COGNITOHAZARD SCREENING .............. [ OK ]</Box>
            <Box mt={2}>LOADING PERSONNEL SESSION FOR {ckey ? String(ckey).toUpperCase() : 'GUEST'}...</Box>
            <Box mt={4} style={{ color: C.textDim }}>[ CLICK ANYWHERE TO CONTINUE ]</Box>
          </Box>
        </Window.Content>
      </Window>
    );
  }

  return (
    <Window theme="scp_terminal" width={640} height={520}>
      <Window.Content scrollable style={{ background: C.bg }}>
        {/* Desktop icons row */}
        <Box style={{ padding: '10px 6px 0' }}>
          <DesktopIcon icon="▣" label="Personnel_File.exe" onClick={() => setActiveApp('personnel')} />
          <DesktopIcon icon="▤" label="Foundation_Briefing.txt" onClick={() => setActiveApp('manifest')} />
          <DesktopIcon icon="◈" label="System_Status.cfg" onClick={() => setActiveApp('status')} />
        </Box>

        {activeApp === 'desktop' ? (
          <AppFrame title="DESKTOP">
            <Box style={{ fontSize: '11px', lineHeight: '1.8' }}>
              <Box style={{ color: C.amber }}>C:\Users\{ckey}\SCiP&gt; dir</Box>
              <Box> PERSONNEL_FILE.EXE     2,048 KB</Box>
              <Box> FOUNDATION_BRIEFING.TXT  512 KB</Box>
              <Box> SYSTEM_STATUS.CFG        128 KB</Box>
              <Box mt={2} style={{ color: C.textDim }}>Click an icon above to open. All activity is logged.</Box>
            </Box>
          </AppFrame>
        ) : null}

        {activeApp === 'personnel' ? (
          <AppFrame title="PERSONNEL_FILE.EXE">
            <LabeledList>
              <LabeledList.Item label="Operator">{ckey}</LabeledList.Item>
              <LabeledList.Item label="Active Character">{character_name}</LabeledList.Item>
              <LabeledList.Item label="Clearance">LEVEL 2 — PROVISIONAL</LabeledList.Item>
            </LabeledList>
            <Box mt={2}>
              <Button icon="user" content="Open Character Setup" color="good" onClick={() => act('character_setup')} />
            </Box>
          </AppFrame>
        ) : null}

        {activeApp === 'manifest' ? (
          <AppFrame title="FOUNDATION_BRIEFING.TXT">
            <Box style={{ fontSize: '11px', lineHeight: '1.7' }}>
              <Box style={{ color: C.amber }}>SITE-53 — ORIENTATION MEMORANDUM</Box>
              <Box mt={1}>All personnel are reminded:</Box>
              <Box>1. Class-D personnel are to be escorted at all times.</Box>
              <Box>2. Do not approach anomalous objects without authorization.</Box>
              <Box>3. Report all unusual observations to your supervisor.</Box>
              <Box>4. In the event of a breach, follow posted evacuation routes.</Box>
              <Box mt={2} style={{ color: C.textDim }}>SECURE. CONTAIN. PROTECT.</Box>
            </Box>
          </AppFrame>
        ) : null}

        {activeApp === 'status' ? (
          <AppFrame title="SYSTEM_STATUS.CFG">
            <LabeledList>
              <LabeledList.Item label="Server Time">{server_time}</LabeledList.Item>
              <LabeledList.Item label="Players Online">{player_count}</LabeledList.Item>
              <LabeledList.Item label="Security Level">{security_level}</LabeledList.Item>
              <LabeledList.Item label="Round Status">
                {round_started ? 'IN PROGRESS — ' + (round_duration || '') : 'LOBBY — PREGAME'}
              </LabeledList.Item>
            </LabeledList>
          </AppFrame>
        ) : null}

        {/* Taskbar: one row of buttons, block layout */}
        <Box style={{
          background: C.desk,
          borderTop: '1px solid ' + C.border,
          padding: '6px 10px',
          margin: '10px 6px',
          fontFamily: C.mono,
        }}>
          <Box style={{ display: 'inline-block', marginRight: '10px', color: C.amber, fontWeight: 'bold', cursor: 'pointer' }} onClick={() => setActiveApp('desktop')}>
            ▣ START
          </Box>
          <Button content="Personnel" selected={activeApp === 'personnel'} onClick={() => setActiveApp('personnel')} />
          <Button content="Briefing" selected={activeApp === 'manifest'} onClick={() => setActiveApp('manifest')} />
          <Button content="Status" selected={activeApp === 'status'} onClick={() => setActiveApp('status')} />
          {round_started ? (
            <Box style={{ display: 'inline-block', marginLeft: '10px' }}>
              <Button content="JOIN GAME" color="good" onClick={() => act('late_join')} />
              <Button content="OBSERVE" onClick={() => act('observe')} />
            </Box>
          ) : (
            <Box style={{ display: 'inline-block', marginLeft: '10px' }}>
              <Button content="Ready" selected={ready === 1} color={ready === 1 ? 'good' : undefined} onClick={() => act('ready', { value: 1 })} />
              <Button content="Not Ready" selected={ready === 0} color={ready === 0 ? 'bad' : undefined} onClick={() => act('ready', { value: 0 })} />
              <Button content="Observe" selected={ready === 2} onClick={() => act('observe')} />
            </Box>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
