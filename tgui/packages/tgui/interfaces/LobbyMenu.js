import { Component } from 'inferno';
import { useBackend, useLocalState } from '../backend';
import { Box, Button, LabeledList } from '../components';
import { Window } from '../layouts';

// Palette sampled from the Foundation-19 character setup terminal:
// near-black panels, dark red title bars and rules, amber values,
// dim grey labels, green only for "selected / active".
const C = {
  room: '#050506',
  bezel: '#16161a',
  bezelEdge: '#2a2a31',
  bezelHi: '#383842',
  bg: '#0b0b0d',
  panel: '#101013',
  panelAlt: '#141418',
  border: '#2a2a31',
  borderLit: '#3c3c46',
  red: '#6b0000',
  redDark: '#3a0000',
  redLine: '#5a1010',
  redBright: '#cc2222',
  amber: '#e0a030',
  text: '#c9c9cf',
  textHi: '#ffffff',
  textDim: '#7a7a85',
  good: '#3ddc3d',
  mono: '"Consolas", "Courier New", monospace',
};

const SCREEN_H = 400;
const TASKBAR_H = 28;

// Applications that can be opened on the desktop.
const APPS = {
  terminal: {
    title: 'TERMINAL',
    sub: 'SCP FOUNDATION — COMMAND INTERFACE',
    sub2: 'SCiPNET-OS v5.0 | SESSION LOGGED | TYPE HELP',
    label: 'Terminal',
    icon: '>_',
    iconSize: '16px',
    left: 106,
    top: 26,
    width: 470,
  },
  personnel: {
    title: 'PERSONNEL FILE',
    sub: 'SCP FOUNDATION — PERSONNEL CONFIGURATION',
    sub2: 'CLEARANCE LEVEL 2 | CLASSIFIED | ENCRYPTION: AES-512',
    label: 'Personnel',
    icon: '▣',
    left: 128,
    top: 34,
    width: 360,
  },
  manifest: {
    title: 'CREW MANIFEST',
    sub: 'SCP FOUNDATION — SITE-53 PERSONNEL ROSTER',
    sub2: 'LIVE FEED | CLASSIFIED',
    label: 'Manifest',
    icon: '▤',
    left: 112,
    top: 40,
    width: 450,
  },
  status: {
    title: 'SYSTEM STATUS',
    sub: 'SCP FOUNDATION — SYSTEM STATUS',
    sub2: 'SCiPNET UPLINK | ALL SYSTEMS NOMINAL',
    label: 'Status',
    icon: '◈',
    left: 140,
    top: 56,
    width: 340,
  },
};
const APP_IDS = ['terminal', 'personnel', 'manifest', 'status'];

// Title bar gradient shared by windows, boot screen and start menu.
const TITLE_BG = 'linear-gradient(180deg, ' + C.red + ', ' + C.redDark + ')';

// Small uppercase section label with a dark-red rule underneath.
const SectionLabel = (props) => (
  <Box style={{
    color: C.textDim,
    fontSize: '10px',
    letterSpacing: '0.12em',
    textTransform: 'uppercase',
    paddingBottom: '3px',
    marginBottom: '6px',
    borderBottom: '1px solid ' + C.redLine,
  }}>
    {props.children}
  </Box>
);

// Monitor shell: bezel + stand. The screen is a fixed-size desktop.
const Monitor = (props) => (
  <Box style={{
    margin: '14px auto 0',
    width: '612px',
    background: 'linear-gradient(180deg, #202026 0%, #121216 100%)',
    border: '2px solid ' + C.bezelEdge,
    borderTop: '3px solid ' + C.bezelHi,
    borderRadius: '10px 10px 4px 4px',
    padding: '14px 14px 10px',
    boxShadow: '0 10px 30px rgba(0,0,0,0.6), inset 0 1px 0 rgba(255,255,255,0.06)',
  }}>
    <Box style={{
      position: 'relative',
      background: C.bg,
      border: '1px solid ' + C.border,
      height: SCREEN_H + 'px',
      overflow: 'hidden',
    }}>
      {/* Faint scanlines. These sit BELOW the content layer: tgui's embedded
          browser may ignore pointer-events, so an overlay on top would
          swallow every click. */}
      <Box style={{
        position: 'absolute',
        top: 0, left: 0, bottom: 0, right: 0,
        background: 'repeating-linear-gradient(0deg, rgba(0,0,0,0.10) 0px, rgba(0,0,0,0.10) 1px, transparent 1px, transparent 3px)',
        pointerEvents: 'none',
        zIndex: 1,
      }} />
      {/* Content layer */}
      <Box style={{
        position: 'absolute',
        top: 0, left: 0, bottom: 0, right: 0,
        zIndex: 3,
      }}>
        {props.children}
      </Box>
    </Box>
    {/* Brand strip + power LED */}
    <Box style={{
      display: 'flex', alignItems: 'center', justifyContent: 'space-between',
      padding: '6px 8px 0',
    }}>
      <Box style={{ color: '#5a5a66', fontSize: '9px', letterSpacing: '0.3em', fontFamily: C.mono }}>
        SCiPNET TERMINAL MK-V
      </Box>
      <Box style={{
        width: '8px', height: '8px', borderRadius: '50%',
        background: C.good,
        boxShadow: '0 0 6px ' + C.good,
      }} />
    </Box>
    {/* Stand */}
    <Box style={{ margin: '6px auto 0', width: '120px', height: '10px', background: '#1a1a20', borderRadius: '0 0 3px 3px' }} />
    <Box style={{ margin: '0 auto', width: '220px', height: '8px', background: 'linear-gradient(180deg, #22222a, #101014)', borderRadius: '2px' }} />
  </Box>
);

// A desktop icon: glyph tile with a label underneath.
const DesktopIcon = (props) => (
  <Box
    onClick={props.onClick}
    style={{
      width: '84px',
      textAlign: 'center',
      cursor: 'pointer',
      margin: '0 0 10px',
      padding: '6px 2px 4px',
      border: '1px solid ' + (props.selected ? C.borderLit : 'transparent'),
      background: props.selected ? 'rgba(255,255,255,0.04)' : 'transparent',
      fontFamily: C.mono,
    }}>
    <Box style={{
      width: '40px',
      height: '36px',
      lineHeight: '34px',
      margin: '0 auto 4px',
      fontSize: props.iconSize || '24px',
      color: C.amber,
      background: 'linear-gradient(180deg, ' + C.panelAlt + ', ' + C.panel + ')',
      border: '1px solid ' + C.border,
      borderBottom: '2px solid ' + C.red,
      borderRadius: '2px',
    }}>
      {props.icon}
    </Box>
    <Box style={{
      fontSize: '10px',
      color: C.text,
      textTransform: 'uppercase',
      letterSpacing: '0.06em',
      textShadow: '0 1px 2px #000',
    }}>
      {props.label}
    </Box>
  </Box>
);

// A window with a red title bar and minimize / close controls.
const AppWindow = (props) => {
  const { app, focused, onFocus, onMinimize, onClose, zIndex } = props;
  const ctrl = {
    display: 'inline-block',
    width: '18px',
    height: '14px',
    lineHeight: '13px',
    textAlign: 'center',
    marginLeft: '3px',
    fontSize: '10px',
    cursor: 'pointer',
    border: '1px solid rgba(255,255,255,0.25)',
    background: 'rgba(0,0,0,0.35)',
    color: C.textHi,
  };
  return (
    <Box
      onClick={onFocus}
      style={{
        position: 'absolute',
        left: app.left + 'px',
        top: app.top + 'px',
        width: app.width + 'px',
        zIndex: zIndex,
        background: C.panel,
        border: '1px solid ' + (focused ? C.redBright : C.border),
        boxShadow: '0 6px 18px rgba(0,0,0,0.75)',
        fontFamily: C.mono,
        color: C.text,
        textShadow: '0 0 3px rgba(201,201,207,0.15)',
      }}>
      <Box style={{
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'space-between',
        padding: '3px 4px 3px 8px',
        background: focused ? TITLE_BG : C.panelAlt,
        borderBottom: '1px solid ' + (focused ? C.redBright : C.border),
      }}>
        <Box style={{
          fontSize: '10px',
          fontWeight: 'bold',
          letterSpacing: '0.1em',
          color: focused ? C.textHi : C.textDim,
        }}>
          <span style={{ color: C.good }}>◉</span> {app.title}
        </Box>
        <Box>
          <Box style={ctrl} onClick={(e) => { e.stopPropagation(); onMinimize(); }}>_</Box>
          <Box style={ctrl} onClick={(e) => { e.stopPropagation(); onClose(); }}>x</Box>
        </Box>
      </Box>
      {/* Header block, like the character setup terminal */}
      <Box style={{
        padding: '8px 10px 6px',
        background: 'rgba(0,0,0,0.25)',
        borderBottom: '1px solid ' + C.border,
      }}>
        <Box style={{ fontSize: '10px', color: C.amber, letterSpacing: '0.06em' }}>
          {app.sub}
        </Box>
        <Box style={{ fontSize: '9px', color: C.textDim, marginTop: '1px' }}>
          {app.sub2}
        </Box>
      </Box>
      <Box style={{ padding: '10px' }}>
        {props.children}
      </Box>
    </Box>
  );
};

// Manifest app body: departmental table.
const ManifestBody = (props) => {
  const { manifest, manifest_count } = props.data;
  const deptColor = {
    'Command': C.amber,
    'Security': '#d46a6a',
    'Research': '#7ab8d4',
    'Medical': '#d4a0a0',
    'Engineering': '#d4b87a',
  };
  if (!manifest || !manifest.length) {
    return (
      <Box style={{ color: C.textDim, fontSize: '11px' }}>
        NO CREW RECORDS ON FILE.<br />
        Manifest populates once the crew is assigned and spawned.
      </Box>
    );
  }
  return (
    <Box>
      <SectionLabel>Active personnel — {manifest_count}</SectionLabel>
      <Box style={{ maxHeight: '190px', overflowY: 'auto', border: '1px solid ' + C.border, padding: '6px' }}>
        {manifest.map((dept, di) => (
          <Box key={di} mb={2}>
            <Box style={{
              color: deptColor[dept.name] || C.textDim,
              fontSize: '10px',
              letterSpacing: '0.1em',
              borderBottom: '1px solid ' + C.redLine,
              marginBottom: '3px',
              paddingBottom: '1px',
            }}>
              {dept.name.toUpperCase()}
            </Box>
            {dept.members.map((member, mi) => (
              <Box key={mi} style={{
                display: 'flex',
                fontSize: '11px',
                padding: '1px 4px',
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
      </Box>
      <Box style={{ color: C.textDim, fontSize: '9px', marginTop: '4px' }}>
        ● ACTIVE &nbsp; ○ INACTIVE
      </Box>
    </Box>
  );
};

// ---------------------------------------------------------------------------
// Interactive terminal
// ---------------------------------------------------------------------------
const TERM_MAX_LINES = 80;
const L = (t, c) => ({ t: t, c: c });
const trimLines = (a) => (a.length > TERM_MAX_LINES
  ? a.slice(a.length - TERM_MAX_LINES)
  : a);

const makeBanner = (ckey) => [
  L(' ___   ___  ___ ', C.redBright),
  L('/ __| / __|| _ \\', C.redBright),
  L('\\__ \\| (__ |  _/', C.redBright),
  L('|___/ \\___||_|  ', C.redBright),
  L(''),
  L('SCiPNET-OS v5.0 — SECURE NETWORK TERMINAL', C.amber),
  L('SCP FOUNDATION — SITE-53 | CLASSIFIED | AES-512', C.textDim),
  L('Session opened for ' + (ckey ? String(ckey).toUpperCase() : 'GUEST')
    + '. All activity is logged.', C.textDim),
  L("Type 'help' for a list of commands."),
  L(''),
];

// The one live <input>. Kept in a module variable so clicking anywhere in the
// terminal can focus it.
let termInputEl = null;
const bindTermInput = (el) => {
  if (el && el !== termInputEl) {
    termInputEl = el;
    el.focus();
  }
};
const focusTermInput = () => {
  if (termInputEl) {
    termInputEl.focus();
  }
};

// Scrollback that sticks to the bottom as lines are added.
class TermOutput extends Component {
  constructor(props) {
    super(props);
    this.setEl = (el) => {
      this.el = el;
    };
  }

  componentDidMount() {
    this.scroll();
  }

  componentDidUpdate() {
    this.scroll();
  }

  scroll() {
    if (this.el) {
      this.el.scrollTop = this.el.scrollHeight;
    }
  }

  render() {
    const { lines } = this.props;
    return (
      <div
        ref={this.setEl}
        onClick={focusTermInput}
        style={{
          height: '190px',
          overflowY: 'auto',
          padding: '6px 8px',
          background: 'rgba(0,0,0,0.35)',
          border: '1px solid ' + C.border,
          fontSize: '11px',
          lineHeight: '1.5',
          textShadow: '0 0 4px rgba(224,160,48,0.18)',
        }}>
        {lines.map((l, i) => (
          <div key={i} style={{ whiteSpace: 'pre-wrap', color: l.c || C.text }}>
            {l.t === '' ? '\u00a0' : l.t}
          </div>
        ))}
      </div>
    );
  }
}

const TerminalBody = (props) => {
  const { lines, prompt, value, onInput, onSubmit, onHistory } = props;
  return (
    <Box>
      <TermOutput lines={lines} />
      <div
        onClick={focusTermInput}
        style={{
          display: 'flex',
          alignItems: 'center',
          marginTop: '4px',
          paddingTop: '5px',
          borderTop: '1px solid ' + C.redLine,
          fontSize: '11px',
        }}>
        <span style={{ color: C.amber, whiteSpace: 'nowrap', marginRight: '6px' }}>
          {prompt}
        </span>
        <input
          ref={bindTermInput}
          type="text"
          value={value}
          autocomplete="off"
          onInput={(e) => onInput(e.target.value)}
          onKeyDown={(e) => {
            const k = e.keyCode || e.which;
            if (k === 13) {
              e.preventDefault();
              onSubmit();
            } else if (k === 38) {
              e.preventDefault();
              onHistory();
            }
          }}
          style={{
            flex: '1 1 auto',
            minWidth: 0,
            background: 'transparent',
            border: 'none',
            outline: 'none',
            padding: 0,
            color: C.textHi,
            caretColor: C.amber,
            fontFamily: C.mono,
            fontSize: '11px',
          }} />
      </div>
    </Box>
  );
};

// Animated boot sequence. Each check line appears, then resolves to [ OK ];
// a progress bar fills, then the prompt blinks. A click at any point skips.
const BOOT_LINES = [
  'POST ...................................',
  'MEMORY CHECK ...........................',
  'ENCRYPTION MODULE (AES-512) ............',
  'SCiPNET UPLINK .........................',
  'COGNITOHAZARD SCREENING ................',
];
const BOOT_TICK_MS = 180;
const BOOT_BAR_START = 2 * BOOT_LINES.length + 1;
const BOOT_BAR_STEPS = 8;
const BOOT_DONE = BOOT_BAR_START + BOOT_BAR_STEPS + 1;

class BootSequence extends Component {
  constructor(props) {
    super(props);
    this.state = { step: 0 };
  }

  componentDidMount() {
    this.timer = setInterval(() => {
      this.setState({ step: this.state.step + 1 });
    }, BOOT_TICK_MS);
  }

  componentWillUnmount() {
    clearInterval(this.timer);
  }

  render() {
    const { ckey, onDone } = this.props;
    const step = this.state.step;
    const blink = step % 2 === 0;
    const done = step >= BOOT_DONE;
    const barPct = Math.max(0, Math.min(100,
      ((step - BOOT_BAR_START) / BOOT_BAR_STEPS) * 100));
    const name = ckey ? String(ckey).toUpperCase() : 'GUEST';
    // The last visible line gets a blinking cursor until the bar starts.
    return (
      <Box
        style={{
          fontFamily: C.mono,
          color: C.text,
          fontSize: '11px',
          height: '100%',
          cursor: 'pointer',
        }}
        onClick={onDone}>
        <Box style={{
          background: TITLE_BG,
          color: C.textHi,
          fontWeight: 'bold',
          letterSpacing: '0.1em',
          padding: '5px 10px',
          borderBottom: '1px solid ' + C.redBright,
        }}>
          <span style={{ color: C.good }}>◉</span> SCiPNET-OS v5.0 — SECURE NETWORK TERMINAL
        </Box>
        <Box style={{ padding: '14px 16px', lineHeight: '1.6' }}>
          <Box style={{ color: C.amber }}>SCP FOUNDATION — PERSONNEL TERMINAL</Box>
          <Box style={{ color: C.textDim }}>CLASSIFIED | ENCRYPTION: AES-512</Box>
          <Box mt={2}>
            {BOOT_LINES.map((label, i) => {
              if (step < 1 + 2 * i) {
                return null;
              }
              const ok = step >= 2 + 2 * i;
              return (
                <Box key={i}>
                  {label}{' '}
                  {ok ? (
                    <span style={{ color: C.good }}>[ OK ]</span>
                  ) : (
                    <span style={{ color: C.amber }}>
                      {blink ? '[ .. ]' : '[    ]'}
                    </span>
                  )}
                </Box>
              );
            })}
          </Box>
          {step >= BOOT_BAR_START ? (
            <Box mt={2}>
              <Box>
                LOADING PERSONNEL SESSION FOR{' '}
                <span style={{ color: C.amber }}>{name}</span>...
              </Box>
              <Box style={{
                width: '280px',
                height: '10px',
                marginTop: '4px',
                border: '1px solid ' + C.borderLit,
                background: C.panel,
              }}>
                <Box style={{
                  width: barPct + '%',
                  height: '100%',
                  background: 'linear-gradient(180deg, ' + C.redBright + ', ' + C.red + ')',
                }} />
              </Box>
            </Box>
          ) : null}
          {done ? (
            <Box mt={2}>
              <Box style={{ color: C.good }}>
                SESSION ESTABLISHED — ACCESS GRANTED
              </Box>
              <Box mt={2} style={{ color: blink ? C.text : C.textDim }}>
                [ CLICK ANYWHERE TO CONTINUE ]
              </Box>
            </Box>
          ) : (
            <Box mt={2} style={{ color: C.textDim, fontSize: '9px' }}>
              CLICK TO SKIP
            </Box>
          )}
        </Box>
      </Box>
    );
  }
}

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

  const [booting, setBooting] = useLocalState(context, 'os.booting', true);
  // `open` doubles as the z-order: last entry is the front-most window.
  const [open, setOpen] = useLocalState(context, 'os.open', ['terminal']);
  const [minimized, setMinimized] = useLocalState(context, 'os.minimized', []);
  const [menuOpen, setMenuOpen] = useLocalState(context, 'os.menu', false);
  const [termLines, setTermLines] = useLocalState(context, 'os.termLines', makeBanner(ckey));
  const [termInput, setTermInput] = useLocalState(context, 'os.termInput', '');
  const [termHist, setTermHist] = useLocalState(context, 'os.termHist', []);

  if (booting) {
    return (
      <Window theme="scp_terminal" width={660} height={540}>
        <Window.Content style={{ background: C.room, padding: 0 }}>
          <Monitor>
            <BootSequence ckey={ckey} onDone={() => setBooting(false)} />
          </Monitor>
        </Window.Content>
      </Window>
    );
  }

  const front = open.length ? open[open.length - 1] : null;

  const openApp = (id) => {
    setOpen(open.filter((x) => x !== id).concat([id]));
    setMinimized(minimized.filter((x) => x !== id));
    setMenuOpen(false);
  };
  const closeApp = (id) => {
    setOpen(open.filter((x) => x !== id));
    setMinimized(minimized.filter((x) => x !== id));
  };
  const minimizeApp = (id) => {
    if (minimized.indexOf(id) === -1) {
      setMinimized(minimized.concat([id]));
    }
  };
  const focusApp = (id) => {
    if (front !== id) {
      setOpen(open.filter((x) => x !== id).concat([id]));
    }
  };
  // Taskbar tab: restore/raise a window, or minimize it if already on top.
  const toggleApp = (id) => {
    if (front === id && minimized.indexOf(id) === -1) {
      minimizeApp(id);
    } else {
      openApp(id);
    }
  };

  const termPrompt = (ckey ? String(ckey).toLowerCase() : 'guest') + '@site-53:~$';

  const runCommand = () => {
    const raw = termInput.trim();
    const echo = L(termPrompt + ' ' + termInput, C.textDim);
    if (!raw) {
      setTermLines(trimLines(termLines.concat([echo])));
      setTermInput('');
      return;
    }
    setTermHist(termHist.concat([raw]).slice(-20));
    const parts = raw.split(/\s+/);
    const cmd = parts[0].toLowerCase();
    const arg = parts[1] ? parts[1].toLowerCase() : '';
    let out = [];
    let clear = false;

    if (cmd === 'help' || cmd === '?') {
      out = [
        L('AVAILABLE COMMANDS', C.amber),
        L('  help            this list'),
        L('  whoami          show session identity'),
        L('  status          site and round status'),
        L('  time            server time'),
        L('  manifest        print the crew roster'),
        L('  ls              list programs'),
        L('  open <app>      open a program (personnel, manifest, status)'),
        L('  setup           open character setup'),
        L('  ready / unready toggle round readiness'),
        L('  join            join the round in progress'),
        L('  observe         observe the round'),
        L('  clear           clear the screen'),
        L('  ver             system version'),
      ];
    } else if (cmd === 'whoami') {
      out = [
        L('OPERATOR     ' + (ckey || 'guest')),
        L('DESIGNATION  ' + (character_name || 'UNASSIGNED'), C.amber),
        L('CLEARANCE    LEVEL 2 — PROVISIONAL'),
      ];
    } else if (cmd === 'status') {
      out = [
        L('SERVER TIME    ' + (server_time || '--:--')),
        L('PLAYERS ONLINE ' + player_count),
        L('SECURITY LEVEL ' + security_level, C.amber),
        L('ROUND STATUS   ' + (round_started
          ? 'IN PROGRESS — ' + (round_duration || '')
          : 'LOBBY — PREGAME')),
      ];
    } else if (cmd === 'time' || cmd === 'date') {
      out = [L(String(server_time || '--:--'))];
    } else if (cmd === 'ver' || cmd === 'version') {
      out = [L('SCiPNET-OS v5.0 (Mk-V terminal)'), L('Cognitohazard screening: ACTIVE', C.good)];
    } else if (cmd === 'ls' || cmd === 'dir') {
      out = [
        L('terminal        TERMINAL'),
        L('personnel       PERSONNEL FILE'),
        L('manifest        CREW MANIFEST'),
        L('status          SYSTEM STATUS'),
      ];
    } else if (cmd === 'manifest') {
      if (!data.manifest || !data.manifest.length) {
        out = [L('NO CREW RECORDS ON FILE.', C.textDim)];
      } else {
        out = [L('SITE-53 PERSONNEL ROSTER — ' + data.manifest_count + ' ACTIVE', C.amber)];
        data.manifest.forEach((dept) => {
          out.push(L('[' + String(dept.name).toUpperCase() + ']', C.redBright));
          dept.members.forEach((m) => {
            out.push(L('  ' + (m.active ? '●' : '○') + ' ' + m.name + ' — ' + m.rank,
              m.active ? C.text : C.textDim));
          });
        });
      }
    } else if (cmd === 'open') {
      if (arg && APPS[arg]) {
        openApp(arg);
        out = [L('Launching ' + APPS[arg].title + '...', C.good)];
      } else {
        out = [L("Usage: open <app>. Type 'ls' for programs.", C.redBright)];
      }
    } else if (cmd === 'setup') {
      act('character_setup');
      out = [L('Opening character setup...', C.good)];
    } else if (cmd === 'ready' || cmd === 'unready') {
      if (round_started) {
        out = [L('Round already in progress. Use: join / observe', C.redBright)];
      } else {
        act('ready', { value: cmd === 'ready' ? 1 : 0 });
        out = [cmd === 'ready'
          ? L('Readiness confirmed. Standing by.', C.good)
          : L('Readiness withdrawn.', C.amber)];
      }
    } else if (cmd === 'join') {
      if (round_started) {
        act('late_join');
        out = [L('Requesting site entry...', C.good)];
      } else {
        out = [L('Round has not started. Use: ready', C.redBright)];
      }
    } else if (cmd === 'observe') {
      act('observe');
      out = [L('Switching to observer feed...', C.good)];
    } else if (cmd === 'clear' || cmd === 'cls') {
      clear = true;
    } else {
      out = [L("command not found: " + parts[0] + " (type 'help')", C.redBright)];
    }

    setTermLines(clear ? [] : trimLines(termLines.concat([echo], out)));
    setTermInput('');
  };

  const recallLastCommand = () => {
    if (termHist.length) {
      setTermInput(termHist[termHist.length - 1]);
    }
  };

  const renderBody = (id) => {
    if (id === 'terminal') {
      return (
        <TerminalBody
          lines={termLines}
          prompt={termPrompt}
          value={termInput}
          onInput={setTermInput}
          onSubmit={runCommand}
          onHistory={recallLastCommand} />
      );
    }
    if (id === 'personnel') {
      return (
        <Box>
          <SectionLabel>Personnel summary</SectionLabel>
          <LabeledList>
            <LabeledList.Item label="Operator">{ckey}</LabeledList.Item>
            <LabeledList.Item label="Designation">
              <span style={{ color: C.amber }}>{character_name}</span>
            </LabeledList.Item>
            <LabeledList.Item label="Clearance">LEVEL 2 — PROVISIONAL</LabeledList.Item>
          </LabeledList>
          <Box mt={2} pt={2} style={{ borderTop: '1px solid ' + C.redLine }}>
            <Button icon="user" content="Open Character Setup" color="good" onClick={() => act('character_setup')} />
          </Box>
        </Box>
      );
    }
    if (id === 'manifest') {
      return <ManifestBody data={data} />;
    }
    return (
      <Box>
        <SectionLabel>Site telemetry</SectionLabel>
        <LabeledList>
          <LabeledList.Item label="Server Time">{server_time}</LabeledList.Item>
          <LabeledList.Item label="Players Online">{player_count}</LabeledList.Item>
          <LabeledList.Item label="Security Level">
            <span style={{ color: C.amber }}>{security_level}</span>
          </LabeledList.Item>
          <LabeledList.Item label="Round Status">
            {round_started ? 'IN PROGRESS — ' + (round_duration || '') : 'LOBBY — PREGAME'}
          </LabeledList.Item>
        </LabeledList>
      </Box>
    );
  };

  // Primary round action shown in the taskbar tray.
  let trayAction;
  if (round_started) {
    trayAction = (
      <Button content="JOIN GAME" color="good" onClick={() => act('late_join')} />
    );
  } else if (ready === 1) {
    trayAction = (
      <Button content="READY ✔" color="good" onClick={() => act('ready', { value: 0 })} />
    );
  } else {
    trayAction = (
      <Button content="NOT READY" color="bad" onClick={() => act('ready', { value: 1 })} />
    );
  }

  return (
    <Window theme="scp_terminal" width={660} height={540}>
      <Window.Content style={{ background: C.room, padding: 0 }}>
        <Monitor>
          {/* Desktop wallpaper */}
          <Box
            onClick={() => setMenuOpen(false)}
            style={{
              position: 'absolute',
              top: 0, left: 0, right: 0,
              bottom: TASKBAR_H + 'px',
              background:
                'linear-gradient(rgba(255,255,255,0.025) 1px, transparent 1px), '
                + 'linear-gradient(90deg, rgba(255,255,255,0.025) 1px, transparent 1px), '
                + 'radial-gradient(ellipse at 80% 90%, #2a0808 0%, #0b0b0d 65%)',
              backgroundSize: '24px 24px, 24px 24px, 100% 100%',
              zIndex: 1,
            }}>
            {/* Faint wallpaper watermark */}
            <Box style={{
              position: 'absolute',
              right: '18px',
              bottom: '14px',
              textAlign: 'right',
              fontFamily: C.mono,
              color: 'rgba(204,34,34,0.10)',
              fontSize: '28px',
              letterSpacing: '0.2em',
              fontWeight: 'bold',
            }}>
              SCP FOUNDATION
              <Box style={{ fontSize: '10px', letterSpacing: '0.3em' }}>SITE-53</Box>
            </Box>
          </Box>

          {/* Top status line, like a terminal header */}
          <Box style={{
            position: 'absolute',
            top: 0, left: 0, right: 0,
            height: '18px',
            zIndex: 65,
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'space-between',
            padding: '0 8px',
            background: 'linear-gradient(180deg, ' + C.panelAlt + ', ' + C.room + ')',
            borderBottom: '1px solid ' + C.redLine,
            fontFamily: C.mono,
            fontSize: '9px',
            letterSpacing: '0.12em',
            textTransform: 'uppercase',
            color: C.textDim,
          }}>
            <Box>
              <span style={{ color: C.redBright }}>◉</span> SCiPNET-OS v5.0 ▸ SITE-53
            </Box>
            <Box>
              USER: <span style={{ color: C.amber }}>{ckey ? String(ckey) : 'guest'}</span>
            </Box>
            <Box>
              SEC: <span style={{ color: C.amber }}>{security_level}</span>
              {' | '}PLAYERS: {player_count}
            </Box>
          </Box>

          {/* Desktop icons, one column down the left edge */}
          <Box style={{
            position: 'absolute',
            top: '26px',
            left: '8px',
            zIndex: 2,
          }}>
            {APP_IDS.map((id) => (
              <DesktopIcon
                key={id}
                icon={APPS[id].icon}
                iconSize={APPS[id].iconSize}
                label={APPS[id].label}
                selected={open.indexOf(id) !== -1}
                onClick={() => openApp(id)}
              />
            ))}
          </Box>

          {/* Open windows, z-order follows the `open` array */}
          {open.map((id, i) => (
            minimized.indexOf(id) !== -1 ? null : (
              <AppWindow
                key={id}
                app={APPS[id]}
                focused={front === id}
                zIndex={10 + i}
                onFocus={() => focusApp(id)}
                onMinimize={() => minimizeApp(id)}
                onClose={() => closeApp(id)}>
                {renderBody(id)}
              </AppWindow>
            )
          ))}

          {/* Start menu */}
          {menuOpen ? (
            <Box style={{
              position: 'absolute',
              left: '0',
              bottom: TASKBAR_H + 'px',
              width: '190px',
              zIndex: 60,
              background: C.panel,
              border: '1px solid ' + C.redBright,
              borderBottom: 'none',
              boxShadow: '0 -4px 16px rgba(0,0,0,0.7)',
              fontFamily: C.mono,
            }}>
              <Box style={{
                padding: '5px 8px',
                fontSize: '10px',
                fontWeight: 'bold',
                color: C.textHi,
                background: TITLE_BG,
                letterSpacing: '0.1em',
              }}>
                {ckey ? String(ckey).toUpperCase() : 'GUEST'}@SITE-53
              </Box>
              <Box style={{ padding: '4px' }}>
                {APP_IDS.map((id) => (
                  <Button
                    key={id}
                    fluid
                    content={APPS[id].icon + '  ' + APPS[id].title}
                    onClick={() => openApp(id)}
                  />
                ))}
                <Box style={{ borderTop: '1px solid ' + C.redLine, margin: '4px 0' }} />
                <Button
                  fluid
                  icon="user"
                  content="Character Setup"
                  onClick={() => { setMenuOpen(false); act('character_setup'); }}
                />
                {round_started ? (
                  <Button
                    fluid
                    icon="play"
                    color="good"
                    content="Join Game"
                    onClick={() => { setMenuOpen(false); act('late_join'); }}
                  />
                ) : (
                  <Box>
                    <Button
                      fluid
                      content="Ready"
                      selected={ready === 1}
                      onClick={() => { setMenuOpen(false); act('ready', { value: 1 }); }}
                    />
                    <Button
                      fluid
                      content="Not Ready"
                      selected={ready === 0}
                      onClick={() => { setMenuOpen(false); act('ready', { value: 0 }); }}
                    />
                  </Box>
                )}
                <Button
                  fluid
                  icon="eye"
                  content="Observe"
                  selected={ready === 2}
                  onClick={() => { setMenuOpen(false); act('observe'); }}
                />
              </Box>
            </Box>
          ) : null}

          {/* Taskbar */}
          <Box style={{
            position: 'absolute',
            left: 0, right: 0, bottom: 0,
            height: TASKBAR_H + 'px',
            zIndex: 70,
            display: 'flex',
            alignItems: 'center',
            background: 'linear-gradient(180deg, ' + C.panelAlt + ', ' + C.room + ')',
            borderTop: '1px solid ' + C.redBright,
            fontFamily: C.mono,
          }}>
            <Box
              onClick={() => setMenuOpen(!menuOpen)}
              style={{
                padding: '0 10px',
                height: '100%',
                lineHeight: (TASKBAR_H - 1) + 'px',
                color: C.textHi,
                fontWeight: 'bold',
                fontSize: '11px',
                letterSpacing: '0.08em',
                cursor: 'pointer',
                background: menuOpen ? C.redDark : TITLE_BG,
                borderRight: '1px solid ' + C.border,
              }}>
              <span style={{ color: C.good }}>◉</span> START
            </Box>
            {/* Window tabs */}
            <Box style={{ display: 'flex', flex: '1 1 auto', overflow: 'hidden', padding: '0 4px' }}>
              {open.map((id) => {
                const isFront = front === id && minimized.indexOf(id) === -1;
                return (
                  <Box
                    key={id}
                    onClick={() => toggleApp(id)}
                    style={{
                      width: '84px',
                      marginRight: '3px',
                      padding: '0 6px',
                      height: '20px',
                      lineHeight: '19px',
                      fontSize: '10px',
                      textTransform: 'uppercase',
                      letterSpacing: '0.05em',
                      whiteSpace: 'nowrap',
                      overflow: 'hidden',
                      textOverflow: 'ellipsis',
                      cursor: 'pointer',
                      color: isFront ? C.textHi : C.textDim,
                      border: '1px solid ' + (isFront ? C.redBright : C.border),
                      background: isFront ? 'rgba(255,255,255,0.05)' : 'transparent',
                    }}>
                    {APPS[id].icon} {APPS[id].label}
                  </Box>
                );
              })}
            </Box>
            {/* System tray */}
            <Box style={{
              display: 'flex',
              alignItems: 'center',
              padding: '0 6px',
              borderLeft: '1px solid ' + C.border,
              height: '100%',
            }}>
              {trayAction}
              <Box style={{
                marginLeft: '8px',
                fontSize: '10px',
                color: C.textDim,
                whiteSpace: 'nowrap',
              }}>
                {server_time}
              </Box>
            </Box>
          </Box>
        </Monitor>
      </Window.Content>
    </Window>
  );
};
