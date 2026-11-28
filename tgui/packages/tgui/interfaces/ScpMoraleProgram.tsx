import { useBackend } from '../backend';
import { Box, Button, ProgressBar } from '../components';
import { Window } from '../layouts';

type MoraleData = {
  global_morale: number;
  morale_label: string;
  morale_trend: number;
  zones: { name: string; morale: number }[];
  active_modifiers: {
    source: string;
    amount: number;
    zone: string;
    remaining: number;
  }[];
  recent_events: {
    source: string;
    amount: number;
    zone: string;
    time: string;
  }[];
  speed_mult: number;
  research_mult: number;
  breach_mult: number;
  threshold_effects: string[];
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

const moraleColor = (m: number) => {
  if (m <= 20) return C.red;
  if (m <= 40) return '#b4551a';
  if (m <= 80) return C.text;
  if (m <= 95) return '#3a9a3a';
  return C.green;
};

export const ScpMoraleProgram = (props, context) => {
  const { act, data } = useBackend<MoraleData>(context);
  const {
    global_morale = 60,
    morale_label = 'NORMAL',
    morale_trend = 0,
    zones = [],
    active_modifiers = [],
    recent_events = [],
    speed_mult = 1,
    research_mult = 1,
    breach_mult = 1,
    threshold_effects = [],
  } = data;

  const labelColor = moraleColor(global_morale);

  return (
    <Window
      theme="scp_terminal"
      title="SCP FOUNDATION - FACILITY MORALE"
      width={680}
      height={580}
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
              FACILITY MORALE PROGRAM
            </Box>
            <Box style={{ fontSize: '10px', color: C.textDim, marginTop: '2px' }}>
              PERSONNEL PSYCHOLOGICAL WELLNESS INDEX
            </Box>
          </Box>

          <Box
            style={{
              border: `1px solid ${labelColor}`,
              background: C.panel,
              padding: '12px',
              marginBottom: '12px',
              textAlign: 'center',
            }}
          >
            <Box
              style={{
                fontSize: '34px',
                fontWeight: 'bold',
                color: labelColor,
              }}
            >
              {Math.round(global_morale)}
            </Box>
            <Box
              style={{
                fontSize: '13px',
                fontWeight: 'bold',
                color: labelColor,
                letterSpacing: '2px',
              }}
            >
              {morale_label}
            </Box>
            <Box style={{ fontSize: '10px', color: C.textDim, marginTop: '4px' }}>
              TREND: {morale_trend > 0 ? '+' : ''}
              {morale_trend}
            </Box>
          </Box>

          <Box
            style={{
              border: `1px solid ${C.border}`,
              background: C.panel,
              padding: '10px',
              marginBottom: '12px',
            }}
          >
            <Box style={{ fontSize: '10px', color: C.textDim, marginBottom: '6px' }}>
              SITE EFFECTS
            </Box>
            {threshold_effects.length === 0 && (
              <Box style={{ fontSize: '10px', color: C.textDim }}>
                NO THRESHOLD EFFECTS ACTIVE
              </Box>
            )}
            {threshold_effects.map((effect, i) => (
              <Box key={i} style={{ fontSize: '11px', color: C.amber, padding: '2px 0' }}>
                {effect}
              </Box>
            ))}
            <Box
              style={{
                display: 'flex',
                justifyContent: 'space-between',
                marginTop: '8px',
                fontSize: '10px',
                color: C.textDim,
              }}
            >
              <span>SPEED x{speed_mult}</span>
              <span>RESEARCH x{research_mult}</span>
              <span>BREACH x{breach_mult}</span>
            </Box>
          </Box>

          <Box
            style={{
              border: `1px solid ${C.border}`,
              background: C.panel,
              padding: '10px',
              marginBottom: '12px',
            }}
          >
            <Box style={{ fontSize: '10px', color: C.textDim, marginBottom: '6px' }}>
              ZONE MORALE
            </Box>
            {zones.map((zone) => (
              <Box
                key={zone.name}
                style={{
                  display: 'flex',
                  alignItems: 'center',
                  gap: '8px',
                  padding: '4px 0',
                  borderTop:
                    zone.name !== zones[0].name ? `1px solid ${C.border}` : undefined,
                }}
              >
                <Box
                  style={{
                    width: '100px',
                    fontSize: '11px',
                    color: C.textBright,
                    flexShrink: 0,
                  }}
                >
                  {zone.name.toUpperCase()}
                </Box>
                <Box style={{ flex: '1' }}>
                  <ProgressBar
                    value={zone.morale / 100}
                    color={moraleColor(zone.morale)}
                    background={C.bg}
                  />
                </Box>
                <Box style={{ width: '30px', fontSize: '10px', color: C.text }}>
                  {Math.round(zone.morale)}
                </Box>
                <Button
                  style={{
                    padding: '4px 8px',
                    background: C.panel,
                    border: `1px solid ${C.border}`,
                    color: C.textBright,
                    fontFamily: C.mono,
                    fontSize: '9px',
                  }}
                  onClick={() => act('zone_boost', { zone: zone.name })}
                >
                  BOOST
                </Button>
              </Box>
            ))}
            <Box style={{ marginTop: '10px' }}>
              <Button
                fluid
                style={{
                  padding: '8px',
                  background: C.panel,
                  border: `1px solid ${C.border}`,
                  color: C.textBright,
                  fontFamily: C.mono,
                  fontSize: '11px',
                  fontWeight: 'bold',
                  letterSpacing: '1px',
                }}
                onClick={() => act('boost_morale')}
              >
                SITE-WIDE MORALE BOOST (+5 / 5 MINUTES)
              </Button>
            </Box>
          </Box>

          <Box
            style={{
              border: `1px solid ${C.border}`,
              background: C.panel,
              padding: '10px',
              marginBottom: '12px',
            }}
          >
            <Box style={{ fontSize: '10px', color: C.textDim, marginBottom: '6px' }}>
              ACTIVE MODIFIERS
            </Box>
            {active_modifiers.length === 0 && (
              <Box style={{ fontSize: '10px', color: C.textDim }}>
                NONE ACTIVE
              </Box>
            )}
            {active_modifiers.map((mod, i) => (
              <Box
                key={i}
                style={{
                  fontSize: '10px',
                  color: mod.amount >= 0 ? C.green : '#b4551a',
                  padding: '2px 0',
                  borderTop: i > 0 ? `1px solid ${C.border}` : undefined,
                }}
              >
                {mod.source}: {mod.amount > 0 ? '+' : ''}
                {mod.amount} [{mod.zone}] {mod.remaining}s remaining
              </Box>
            ))}
          </Box>

          <Box
            style={{
              border: `1px solid ${C.border}`,
              background: C.panel,
              padding: '10px',
            }}
          >
            <Box style={{ fontSize: '10px', color: C.textDim, marginBottom: '6px' }}>
              MORALE EVENTS
            </Box>
            {recent_events.map((entry, i) => (
              <Box
                key={i}
                style={{
                  fontSize: '10px',
                  color: C.text,
                  padding: '2px 0',
                  borderTop: i > 0 ? `1px solid ${C.border}` : undefined,
                }}
              >
                [{entry.time}] {entry.source}: {entry.amount > 0 ? '+' : ''}
                {entry.amount} [{entry.zone}]
              </Box>
            ))}
          </Box>
        </Box>
      </Window.Content>
    </Window>
  );
};
