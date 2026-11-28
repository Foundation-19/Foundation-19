import { useBackend } from '../backend';
import { Box, Button, ProgressBar } from '../components';
import { Window } from '../layouts';

type DclassPlayer = {
  ckey: string;
  name: string;
  compliance: number;
  defiance: number;
  trust: number;
  incidents: number;
  streak: number;
  label: string;
};

type DclassData = {
  players: DclassPlayer[];
  recent_log: {
    ckey: string;
    action: string;
    amount: number;
    source: string;
    time: string;
  }[];
};

const C = {
  bg: '#08080a',
  panel: '#0c0c10',
  border: '#1e1e24',
  borderRed: '#6b0000',
  red: '#8b0000',
  amber: '#d4a017',
  green: '#1a7a1a',
  text: '#b0b0b0',
  textBright: '#e0e0e0',
  textDim: '#555560',
  mono: '"Consolas", "Courier New", "Lucida Console", monospace',
};

const labelColor = (label: string) => {
  switch (label) {
    case 'COOPERATIVE':
      return C.green;
    case 'COMPLIANT':
      return '#3a9a3a';
    case 'NEUTRAL':
      return C.text;
    case 'UNCOOPERATIVE':
      return C.amber;
    default:
      return C.red;
  }
};

export const ScpDclassBehaviorProgram = (props, context) => {
  const { act, data } = useBackend<DclassData>(context);
  const { players = [], recent_log = [] } = data;

  return (
    <Window
      theme="scp_terminal"
      title="SCP FOUNDATION - D-CLASS BEHAVIOR"
      width={700}
      height={560}
    >
      <Window.Content scrollable>
        <Box
          style={{
            background: C.bg,
            padding: '14px',
            fontFamily: C.mono,
            color: C.text,
            minHeight: '100%',
          }}
        >
          <Box
            style={{
              borderBottom: `1px solid ${C.borderRed}`,
              paddingBottom: '10px',
              marginBottom: '12px',
            }}
          >
            <Box
              style={{
                fontSize: '15px',
                fontWeight: 'bold',
                color: C.textBright,
                letterSpacing: '2px',
              }}
            >
              D-CLASS BEHAVIOR MONITOR
            </Box>
            <Box style={{ fontSize: '10px', color: C.textDim, marginTop: '2px' }}>
              COMPLIANCE TRACKING - CLASS D PERSONNEL
            </Box>
          </Box>

          {players.length === 0 && (
            <Box
              style={{
                border: `1px solid ${C.border}`,
                background: C.panel,
                padding: '14px',
                textAlign: 'center',
                color: C.textDim,
              }}
            >
              NO TRACKED PERSONNEL
            </Box>
          )}

          {players.map((p) => (
            <Box
              key={p.ckey}
              style={{
                border: `1px solid ${labelColor(p.label)}`,
                background: C.panel,
                padding: '8px 10px',
                marginBottom: '8px',
              }}
            >
              <Box
                style={{
                  display: 'flex',
                  justifyContent: 'space-between',
                  marginBottom: '4px',
                }}
              >
                <Box style={{ fontSize: '12px', fontWeight: 'bold', color: C.textBright }}>
                  {p.name}
                </Box>
                <Box
                  style={{
                    fontSize: '10px',
                    fontWeight: 'bold',
                    color: labelColor(p.label),
                    letterSpacing: '1px',
                  }}
                >
                  {p.label}
                </Box>
              </Box>
              <Box style={{ marginBottom: '4px' }}>
                <Box style={{ fontSize: '9px', color: C.textDim, marginBottom: '2px' }}>
                  COMPLIANCE: {p.compliance} | TRUST: {p.trust} | DEFIANCE: {p.defiance} |
                  INCIDENTS: {p.incidents} | STREAK: {p.streak}
                </Box>
                <ProgressBar
                  value={p.compliance / 100}
                  color={labelColor(p.label)}
                  background={C.bg}
                />
              </Box>
              <Box style={{ display: 'flex', gap: '8px' }}>
                <Button
                  style={{
                    padding: '4px 8px',
                    background: C.panel,
                    border: `1px solid ${C.border}`,
                    color: C.textBright,
                    fontFamily: C.mono,
                    fontSize: '9px',
                  }}
                  onClick={() => act('reward_compliance', { ckey: p.ckey })}
                >
                  REWARD (+10)
                </Button>
                <Button
                  style={{
                    padding: '4px 8px',
                    background: C.panel,
                    border: `1px solid ${C.border}`,
                    color: C.amber,
                    fontFamily: C.mono,
                    fontSize: '9px',
                  }}
                  onClick={() => act('penalize', { ckey: p.ckey })}
                >
                  PENALIZE
                </Button>
                <Button
                  style={{
                    padding: '4px 8px',
                    background: C.panel,
                    border: `1px solid ${C.border}`,
                    color: C.red,
                    fontFamily: C.mono,
                    fontSize: '9px',
                  }}
                  onClick={() => act('reset_behavior', { ckey: p.ckey })}
                >
                  RESET
                </Button>
              </Box>
            </Box>
          ))}

          <Box
            style={{
              border: `1px solid ${C.border}`,
              background: C.panel,
              padding: '10px',
            }}
          >
            <Box style={{ fontSize: '10px', color: C.textDim, marginBottom: '6px' }}>
              BEHAVIOR LOG
            </Box>
            {recent_log.map((entry, i) => (
              <Box
                key={i}
                style={{
                  fontSize: '10px',
                  color: C.text,
                  padding: '2px 0',
                  borderTop: i > 0 ? `1px solid ${C.border}` : undefined,
                }}
              >
                [{entry.time}] {entry.ckey}: {entry.action}
                {entry.amount ? ` (${entry.amount > 0 ? '+' : ''}${entry.amount})` : ''} -
                {entry.source}
              </Box>
            ))}
          </Box>
        </Box>
      </Window.Content>
    </Window>
  );
};
