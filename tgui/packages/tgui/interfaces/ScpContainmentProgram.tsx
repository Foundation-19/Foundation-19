import { useBackend } from '../backend';
import { Box, Button, ProgressBar, Section } from '../components';
import { Window } from '../layouts';

type Interaction = {
  id: string;
  name: string;
  desc: string;
  resource: string;
  cost: number;
};

type ResourceRow = {
  key: string;
  value: number;
};

type LogEntry = {
  name: string;
  time: string;
};

type StressData = {
  scp_id: string;
  stress_level: number;
  max_stress: number;
  stress_tier: number;
  stress_tier_name: string;
  work_in_progress: boolean;
  current_work_type: string | null;
  work_progress: number;
  available_work_types: Record<string, { effect: number; risk: number }>;
};

type ContainmentData = {
  scp_id: string | null;
  containment_integrity: number;
  containment_state: number;
  containment_state_name: string;
  cell_type: string | null;
  observer_count: number;
  resources: ResourceRow[];
  interactions: Interaction[];
  recent_log: LogEntry[];
  is_scp: boolean;
  containing_zone: string | null;
  stress?: StressData;
};

const C = {
  bg: '#08080a',
  panel: '#0c0c10',
  border: '#1e1e24',
  borderRed: '#6b0000',
  red: '#8b0000',
  redBright: '#cc2222',
  green: '#1a7a1a',
  text: '#b0b0b0',
  textBright: '#e0e0e8',
  textDim: '#555560',
  amber: '#d4a017',
  mono: '"Consolas", "Courier New", "Lucida Console", monospace',
};

const stateColor = (state: number) => {
  if (state === 0) return C.green;
  if (state === 1) return '#3a9a3a';
  if (state === 2) return C.amber;
  if (state === 3) return C.redBright;
  return C.red;
};

const RESOURCE_LABELS: Record<string, string> = {
  tension: 'Tension',
  corrosion: 'Corrosion',
  hack_progress: 'Hack Progress',
  adaptation: 'Adaptation',
  infection: 'Infection',
  fuel: 'Fuel',
  voice_data: 'Voice Data',
  offspring: 'Offspring',
  visibility: 'Visibility',
  hunger: 'Hunger',
};

export const ScpContainmentProgram = (props, context) => {
  const { act, data } = useBackend<ContainmentData>(context);
  const {
    scp_id,
    containment_integrity = 100,
    containment_state = 0,
    containment_state_name = 'Secure',
    cell_type,
    observer_count = 0,
    resources = [],
    interactions = [],
    recent_log = [],
  is_scp = false,
  containing_zone,
  stress,
} = data;

  return (
    <Window
      theme="scp_terminal"
      title="SCP FOUNDATION - CONTAINMENT TERMINAL"
      width={620}
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
              {scp_id ? `SCP-${scp_id} CONTAINMENT` : 'NO ENTITY LINKED'}
            </Box>
            <Box style={{ fontSize: '10px', color: C.textDim, marginTop: '2px' }}>
              {containing_zone
                ? `ZONE: ${containing_zone} | CELL TYPE: ${cell_type || 'STANDARD'}`
                : 'UNREGISTERED CONTAINMENT AREA'}
            </Box>
          </Box>

          {!scp_id ? (
            <Box
              style={{
                border: `1px solid ${C.border}`,
                background: C.panel,
                padding: '14px',
                textAlign: 'center',
                color: C.textDim,
              }}
            >
              NO CONTAINED ENTITY IN RANGE OF THIS TERMINAL
            </Box>
          ) : (
            <>
              <Box
                style={{
                  border: `1px solid ${stateColor(containment_state)}`,
                  background: C.panel,
                  padding: '10px',
                  marginBottom: '12px',
                  textAlign: 'center',
                }}
              >
                <Box
                  style={{
                    fontSize: '26px',
                    fontWeight: 'bold',
                    color: stateColor(containment_state),
                  }}
                >
                  {Math.round(containment_integrity)}%
                </Box>
                <Box
                  style={{
                    fontSize: '13px',
                    fontWeight: 'bold',
                    color: stateColor(containment_state),
                    letterSpacing: '2px',
                  }}
                >
                  CONTAINMENT {containment_state_name.toUpperCase()}
                </Box>
                <Box style={{ fontSize: '10px', color: C.textDim, marginTop: '4px' }}>
                  OBSERVERS: {observer_count}
                </Box>
              </Box>

              <Section
                title="RESOURCES"
                style={{
                  background: C.panel,
                  border: `1px solid ${C.border}`,
                  padding: '10px',
                  marginBottom: '12px',
                }}
              >
                {resources.map((res) => (
                  <Box key={res.key} mb={1}>
                    <Box
                      style={{
                        display: 'flex',
                        justifyContent: 'space-between',
                        fontSize: '10px',
                        color: C.textDim,
                        marginBottom: '2px',
                      }}
                    >
                      <span>
                        {(RESOURCE_LABELS[res.key] || res.key).toUpperCase()}
                      </span>
                      <span style={{ color: C.textBright }}>
                        {Math.round(res.value)}
                      </span>
                    </Box>
                    <ProgressBar
                      value={res.value / 100}
                      color={res.value > 60 ? C.redBright : C.amber}
                      background={C.bg}
                    />
                  </Box>
                ))}
              </Section>

              {!is_scp && stress && (
                <Box
                  style={{
                    border: `1px solid ${C.border}`,
                    background: C.panel,
                    padding: '10px',
                    marginBottom: '12px',
                  }}
                >
                  <Box
                    style={{
                      display: 'flex',
                      justifyContent: 'space-between',
                      fontSize: '10px',
                      color: C.textDim,
                      marginBottom: '4px',
                      letterSpacing: '1px',
                    }}
                  >
                    <span>CONTAINMENT STRESS</span>
                    <span style={{ color: stress.stress_level > 75 ? C.redBright : C.amber }}>
                      {stress.stress_tier_name.toUpperCase()} (
                      {Math.round(stress.stress_level)}/{stress.max_stress})
                    </span>
                  </Box>
                  <ProgressBar
                    value={stress.stress_level / stress.max_stress}
                    color={
                      stress.stress_level > 75
                        ? C.redBright
                        : stress.stress_level > 50
                          ? C.amber
                          : C.green
                    }
                    background={C.bg}
                  />
                  <Box style={{ fontSize: '9px', color: C.textDim, marginTop: '4px' }}>
                    {stress.work_in_progress
                      ? `WORK IN PROGRESS: ${stress.current_work_type || ''} — ${Math.round(stress.work_progress)}%`
                      : 'Perform work to reduce stress. Failure risk increases stress.'}
                  </Box>
                  <Box style={{ display: 'flex', gap: '6px', marginTop: '6px' }}>
                    {Object.keys(stress.available_work_types || {}).map((workType) => (
                      <Button
                        key={workType}
                        style={{
                          padding: '5px 10px',
                          background: C.panel,
                          border: `1px solid ${C.border}`,
                          color: C.textBright,
                          fontFamily: C.mono,
                          fontSize: '10px',
                          textTransform: 'capitalize',
                        }}
                        disabled={stress.work_in_progress}
                        onClick={() => act('do_work', { work_type: workType })}
                      >
                        {workType} (
                        {stress.available_work_types[workType]?.effect ?? 0 > 0 ? '+' : ''}
                        {stress.available_work_types[workType]?.effect ?? 0} |{' '}
                        {stress.available_work_types[workType]?.risk ?? 0}% risk)
                      </Button>
                    ))}
                  </Box>
                </Box>
              )}

              {is_scp && (
                <Box
                  style={{
                    border: `1px solid ${C.border}`,
                    background: C.panel,
                    padding: '10px',
                    marginBottom: '12px',
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
                    ENTITY ACTIONS
                  </Box>
                  {interactions.map((opt) => (
                    <Box
                      key={opt.id}
                      style={{
                        display: 'flex',
                        justifyContent: 'space-between',
                        alignItems: 'center',
                        padding: '6px 0',
                        borderTop: `1px solid ${C.border}`,
                      }}
                    >
                      <Box style={{ flex: '1', paddingRight: '8px' }}>
                        <Box
                          style={{
                            fontSize: '12px',
                            color: C.textBright,
                            fontWeight: 'bold',
                          }}
                        >
                          {opt.name}
                        </Box>
                        <Box style={{ fontSize: '10px', color: C.textDim }}>
                          {opt.desc}
                        </Box>
                      </Box>
                      <Button
                        style={{
                          padding: '5px 10px',
                          background: C.panel,
                          border: `1px solid ${C.border}`,
                          color: C.textBright,
                          fontFamily: C.mono,
                          fontSize: '10px',
                          flexShrink: 0,
                        }}
                        onClick={() => act('interact', { id: opt.id })}
                      >
                        {opt.cost > 0
                          ? `PERFORM (-${Math.round(opt.cost)})`
                          : 'PERFORM'}
                      </Button>
                    </Box>
                  ))}
                </Box>
              )}

              <Box
                style={{
                  border: `1px solid ${C.border}`,
                  background: C.panel,
                  padding: '10px',
                }}
              >
                <Box
                  style={{
                    fontSize: '10px',
                    color: C.textDim,
                    marginBottom: '6px',
                    letterSpacing: '1px',
                  }}
                >
                  INTERACTION LOG
                </Box>
                {recent_log.length === 0 ? (
                  <Box style={{ fontSize: '10px', color: C.textDim }}>
                    NO INTERACTIONS RECORDED
                  </Box>
                ) : (
                  recent_log.map((entry, i) => (
                    <Box
                      key={i}
                      style={{
                        fontSize: '10px',
                        color: C.text,
                        padding: '2px 0',
                        borderTop: i > 0 ? `1px solid ${C.border}` : undefined,
                      }}
                    >
                      [{entry.time}] {entry.name}
                    </Box>
                  ))
                )}
              </Box>
            </>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
