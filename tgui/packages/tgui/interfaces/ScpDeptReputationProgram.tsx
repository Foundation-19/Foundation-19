import { useBackend } from '../backend';
import { Box, ProgressBar } from '../components';
import { Window } from '../layouts';

type Department = {
  name: string;
  reputation: number;
  label: string;
};

type ReputationData = {
  departments: Department[];
  recent_log: {
    department: string;
    amount: number;
    source: string;
    new_value: number;
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
    case 'ALLIED':
      return C.green;
    case 'FRIENDLY':
      return '#3a9a3a';
    case 'NEUTRAL':
      return C.text;
    case 'TENSE':
      return C.amber;
    case 'HOSTILE':
      return '#b4551a';
    default:
      return C.red;
  }
};

export const ScpDeptReputationProgram = (props, context) => {
  const { data } = useBackend<ReputationData>(context);
  const { departments = [], recent_log = [] } = data;

  return (
    <Window
      theme="scp_terminal"
      title="SCP FOUNDATION - DEPARTMENT RELATIONS"
      width={620}
      height={540}
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
              DEPARTMENT RELATIONS MONITOR
            </Box>
            <Box style={{ fontSize: '10px', color: C.textDim, marginTop: '2px' }}>
              INTER-DEPARTMENT COOPERATION INDEX
            </Box>
          </Box>

          {departments.map((dept) => (
            <Box
              key={dept.name}
              style={{
                border: `1px solid ${C.border}`,
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
                <Box
                  style={{
                    fontSize: '12px',
                    fontWeight: 'bold',
                    color: C.textBright,
                  }}
                >
                  {dept.name.toUpperCase()}
                </Box>
                <Box
                  style={{
                    fontSize: '10px',
                    fontWeight: 'bold',
                    color: labelColor(dept.label),
                    letterSpacing: '1px',
                  }}
                >
                  {dept.label} ({dept.reputation})
                </Box>
              </Box>
              <ProgressBar
                value={dept.reputation / 100}
                color={labelColor(dept.label)}
                background={C.bg}
              />
            </Box>
          ))}

          <Box
            style={{
              border: `1px solid ${C.border}`,
              background: C.panel,
              padding: '10px',
              marginTop: '12px',
            }}
          >
            <Box style={{ fontSize: '10px', color: C.textDim, marginBottom: '6px' }}>
              RECENT ADJUSTMENTS
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
                [{entry.time}] {entry.department}: {entry.amount > 0 ? '+' : ''}
                {entry.amount} ({entry.source}) - now {entry.new_value}
              </Box>
            ))}
          </Box>
        </Box>
      </Window.Content>
    </Window>
  );
};
