import { useBackend } from '../backend';
import { Box, Button } from '../components';
import { Window } from '../layouts';

type CountermeasureStage = {
  completed: boolean;
  current: boolean;
  index: number;
  name: string;
};

type RecontainmentData = {
  completed: boolean;
  countermeasure_stages: CountermeasureStage[];
  current_stage: number;
  failure_chance: number;
  hack_active: boolean;
  hack_progress: number;
  hack_threshold: number;
  processing_power: number;
  tier: number;
};

const C = {
  bg: '#08080a',
  panel: '#0c0c10',
  border: '#1e1e24',
  borderRed: '#6b0000',
  accent: '#c2960e',
  red: '#8b0000',
  redBright: '#cc2222',
  green: '#1a7a1a',
  greenDim: '#0d4a0d',
  text: '#b0b0b0',
  textBright: '#e0e0e0',
  textDim: '#555560',
  amber: '#d4a017',
  mono: '"Consolas", "Courier New", "Lucida Console", monospace',
};

const STAGE_LABELS: Record<string, string> = {
  isolate_network: 'NETWORK ISOLATION',
  block_camera_feeds: 'CAMERA FEED DISRUPTION',
  force_door_locks: 'DOOR LOCK OVERRIDE',
  cut_power_loop: 'POWER LOOP SEVERANCE',
  initiate_shutdown: 'SHUTDOWN SEQUENCE',
};

const progressColor = (pct: number, active: boolean) => {
  if (!active) return C.border;
  if (pct < 25) return C.redBright;
  if (pct < 50) return C.amber;
  if (pct < 75) return C.accent;
  return C.green;
};

export const Scp079Recontainment = (props, context) => {
  const { act, data } = useBackend<RecontainmentData>(context);
  const {
    hack_progress = 0,
    hack_threshold = 100,
    hack_active = false,
    completed = false,
    current_stage = 1,
    countermeasure_stages = [],
    failure_chance = 15,
    tier = 0,
    processing_power = 0,
  } = data;

  const pct = Math.min(100, Math.round((hack_progress / hack_threshold) * 100));

  const statusText = completed
    ? 'RECONTAINMENT COMPLETE'
    : hack_active
      ? `COUNTERMEASURE IN PROGRESS - ${pct}%`
      : 'AWAITING AUTHORIZATION';

  const statusColor = completed ? C.green : hack_active ? C.amber : C.textDim;

  return (
    <Window
      theme="scp_terminal"
      title="SCP FOUNDATION - SCP-079 RECONTAINMENT"
      width={600}
      height={500}
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
              SCP-079 RECONTAINMENT TERMINAL
            </Box>
            <Box style={{ fontSize: '10px', color: C.textDim, marginTop: '2px' }}>
              CLASSIFIED - LEVEL 3 CLEARANCE REQUIRED
            </Box>
          </Box>

          <Box style={{ display: 'flex', gap: '12px', marginBottom: '14px' }}>
            <Box
              style={{
                flex: '1',
                padding: '8px 10px',
                border: `1px solid ${C.border}`,
                background: C.panel,
              }}
            >
              <Box
                style={{ fontSize: '9px', color: C.textDim, letterSpacing: '1px' }}
              >
                SCP-079 TIER
              </Box>
              <Box
                style={{
                  fontSize: '18px',
                  color:
                    tier >= 4 ? C.redBright : tier >= 2 ? C.amber : C.textBright,
                }}
              >
                {tier > 0 ? tier : 'N/A'}
              </Box>
            </Box>
            <Box
              style={{
                flex: '1',
                padding: '8px 10px',
                border: `1px solid ${C.border}`,
                background: C.panel,
              }}
            >
              <Box
                style={{ fontSize: '9px', color: C.textDim, letterSpacing: '1px' }}
              >
                PROCESSING POWER
              </Box>
              <Box
                style={{
                  fontSize: '18px',
                  color:
                    processing_power > 60
                      ? C.redBright
                      : processing_power > 30
                        ? C.amber
                        : C.textBright,
                }}
              >
                {tier > 0 ? processing_power : 'N/A'}
              </Box>
            </Box>
            <Box
              style={{
                flex: '1',
                padding: '8px 10px',
                border: `1px solid ${C.border}`,
                background: C.panel,
              }}
            >
              <Box
                style={{ fontSize: '9px', color: C.textDim, letterSpacing: '1px' }}
              >
                FAILURE CHANCE
              </Box>
              <Box
                style={{
                  fontSize: '18px',
                  color:
                    failure_chance > 20
                      ? C.redBright
                      : failure_chance > 10
                        ? C.amber
                        : C.textBright,
                }}
              >
                {failure_chance}%
              </Box>
            </Box>
          </Box>

          <Box
            style={{
              border: `1px solid ${C.border}`,
              background: C.panel,
              padding: '10px',
              marginBottom: '14px',
            }}
          >
            <Box
              style={{
                fontSize: '10px',
                color: C.textDim,
                marginBottom: '8px',
                letterSpacing: '1px',
              }}
            >
              COUNTERMEASURE STAGES
            </Box>
            {countermeasure_stages.map((stage) => {
              const stageLabel =
                STAGE_LABELS[stage.name] || stage.name.toUpperCase();
              return (
                <Box
                  key={stage.index}
                  style={{
                    display: 'flex',
                    alignItems: 'center',
                    padding: '5px 0',
                    borderTop:
                      stage.index > 1 ? `1px solid ${C.border}` : undefined,
                  }}
                >
                  <Box
                    style={{
                      width: '18px',
                      height: '18px',
                      border: `1px solid ${
                        stage.completed
                          ? C.green
                          : stage.current
                            ? C.amber
                            : C.border
                      }`,
                      background: stage.completed
                        ? C.greenDim
                        : stage.current
                          ? C.panel
                          : 'transparent',
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      marginRight: '10px',
                      flexShrink: 0,
                    }}
                  >
                    {stage.completed && (
                      <Box
                        style={{ color: C.green, fontSize: '11px', lineHeight: 1 }}
                      >
                        ✓
                      </Box>
                    )}
                    {stage.current && !stage.completed && (
                      <Box
                        style={{ color: C.amber, fontSize: '11px', lineHeight: 1 }}
                      >
                        ▶
                      </Box>
                    )}
                  </Box>
                  <Box style={{ flex: '1' }}>
                    <Box
                      style={{
                        fontSize: '12px',
                        color: stage.completed
                          ? C.green
                          : stage.current
                            ? C.amber
                            : C.textDim,
                        fontWeight: stage.current ? 'bold' : 'normal',
                      }}
                    >
                      STAGE {stage.index}: {stageLabel}
                    </Box>
                  </Box>
                  <Box
                    style={{
                      fontSize: '10px',
                      color: stage.completed
                        ? C.green
                        : stage.current
                          ? C.amber
                          : C.textDim,
                      letterSpacing: '1px',
                    }}
                  >
                    {stage.completed
                      ? 'COMPLETE'
                      : stage.current
                        ? 'ACTIVE'
                        : 'PENDING'}
                  </Box>
                </Box>
              );
            })}
          </Box>

          <Box
            style={{
              border: `1px solid ${C.border}`,
              background: C.panel,
              padding: '10px',
              marginBottom: '14px',
            }}
          >
            <Box
              style={{
                display: 'flex',
                justifyContent: 'space-between',
                marginBottom: '6px',
              }}
            >
              <Box
                style={{ fontSize: '10px', color: C.textDim, letterSpacing: '1px' }}
              >
                OVERALL PROGRESS
              </Box>
              <Box
                style={{
                  fontSize: '12px',
                  color: C.textBright,
                  fontWeight: 'bold',
                }}
              >
                {pct}%
              </Box>
            </Box>
            <Box
              style={{
                height: '16px',
                background: C.bg,
                border: `1px solid ${C.border}`,
                position: 'relative',
                overflow: 'hidden',
              }}
            >
              <Box
                style={{
                  height: '100%',
                  width: `${pct}%`,
                  background: progressColor(pct, hack_active || completed),
                  transition: 'width 0.3s ease',
                  boxShadow: hack_active
                    ? `0 0 8px ${progressColor(pct, true)}`
                    : 'none',
                }}
              />
            </Box>
            <Box
              style={{
                display: 'flex',
                justifyContent: 'space-between',
                marginTop: '4px',
                fontSize: '9px',
                color: C.textDim,
              }}
            >
              <span>0%</span>
              <span>{hack_threshold}%</span>
            </Box>
          </Box>

          <Box
            style={{
              border: `1px solid ${
                completed ? C.greenDim : hack_active ? C.borderRed : C.border
              }`,
              background: C.panel,
              padding: '10px 12px',
              marginBottom: '14px',
              textAlign: 'center',
            }}
          >
            <Box
              style={{
                fontSize: '13px',
                fontWeight: 'bold',
                color: statusColor,
                letterSpacing: '2px',
              }}
            >
              {statusText}
            </Box>
            {hack_active && !completed && (
              <Box style={{ fontSize: '10px', color: C.textDim, marginTop: '4px' }}>
                STAGE {current_stage}/{countermeasure_stages.length} IN PROGRESS
              </Box>
            )}
          </Box>

          {!hack_active && !completed && (
            <Button
              fluid
              style={{
                padding: '12px',
                background: C.red,
                border: `1px solid ${C.borderRed}`,
                color: C.textBright,
                fontFamily: C.mono,
                fontSize: '13px',
                fontWeight: 'bold',
                letterSpacing: '2px',
              }}
              onClick={() => act('initiate')}
            >
              INITIATE RECONTAINMENT PROTOCOL
            </Button>
          )}

          {completed && (
            <Box
              style={{
                border: `1px solid ${C.greenDim}`,
                background: C.panel,
                padding: '12px',
                textAlign: 'center',
              }}
            >
              <Box
                style={{ fontSize: '12px', color: C.green, letterSpacing: '1px' }}
              >
                SCP-079 HAS BEEN SUCCESSFULLY RECONTAINED
              </Box>
              <Box
                style={{ fontSize: '10px', color: C.textDim, marginTop: '4px' }}
              >
                All countermeasure stages complete. Network stability restored.
              </Box>
            </Box>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
