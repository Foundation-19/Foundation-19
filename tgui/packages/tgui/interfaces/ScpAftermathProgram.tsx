import { useBackend, useLocalState } from '../backend';
import { Box, Button, Input, ProgressBar } from '../components';
import { Window } from '../layouts';

type Aftermath = {
  id: string;
  scp_id: string;
  zone: string;
  breach_duration: number;
  structural_damage: number;
  contamination_level: number;
  personnel_casualties: number;
  lessons_count: number;
  repairs_done: number;
  debrief_done: boolean;
};

type AftermathData = {
  active_aftermaths: Aftermath[];
  total_debriefs: number;
  log: {
    event: string;
    scp_id: string;
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
  greenDim: '#0d4a0d',
  text: '#b0b0b0',
  textBright: '#e0e0e0',
  textDim: '#555560',
  mono: '"Consolas", "Courier New", "Lucida Console", monospace',
};

export const ScpAftermathProgram = (props, context) => {
  const { act, data } = useBackend<AftermathData>(context);
  const {
    active_aftermaths = [],
    total_debriefs = 0,
    log = [],
  } = data;

  const [lessonDraft, setLessonDraft] = useLocalState<string>(
    context,
    'aftermath_lesson_draft',
    ''
  );
  const [newScp, setNewScp] = useLocalState<string>(
    context,
    'aftermath_new_scp',
    ''
  );
  const [newZone, setNewZone] = useLocalState<string>(
    context,
    'aftermath_new_zone',
    ''
  );

  return (
    <Window
      theme="scp_terminal"
      title="SCP FOUNDATION - BREACH AFTERMATH"
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
              BREACH AFTERMATH MANAGEMENT
            </Box>
            <Box style={{ fontSize: '10px', color: C.textDim, marginTop: '2px' }}>
              CLASSIFIED - LEVEL 2 SECURITY - DEBRIEFS COMPLETED: {total_debriefs}
            </Box>
          </Box>

          {active_aftermaths.length === 0 && (
            <Box
              style={{
                border: `1px solid ${C.border}`,
                background: C.panel,
                padding: '14px',
                textAlign: 'center',
                color: C.textDim,
              }}
            >
              NO ACTIVE AFTERMATH RECORDS
            </Box>
          )}

          {active_aftermaths.map((a) => (
            <Box
              key={a.id}
              style={{
                border: `1px solid ${a.debrief_done ? C.greenDim : C.borderRed}`,
                background: C.panel,
                padding: '10px',
                marginBottom: '12px',
              }}
            >
              <Box
                style={{
                  display: 'flex',
                  justifyContent: 'space-between',
                  marginBottom: '8px',
                }}
              >
                <Box
                  style={{
                    fontSize: '13px',
                    fontWeight: 'bold',
                    color: C.textBright,
                  }}
                >
                  SCP-{a.scp_id} - {a.zone}
                </Box>
                <Box
                  style={{
                    fontSize: '10px',
                    color: a.debrief_done ? C.green : C.amber,
                    letterSpacing: '1px',
                  }}
                >
                  {a.debrief_done ? 'DEBRIEFED' : 'OPEN'}
                </Box>
              </Box>

              <Box style={{ marginBottom: '6px' }}>
                <Box style={{ fontSize: '9px', color: C.textDim, marginBottom: '2px' }}>
                  STRUCTURAL DAMAGE: {a.structural_damage}
                </Box>
                <ProgressBar
                  value={a.structural_damage / 50}
                  color={a.structural_damage > 30 ? C.red : C.amber}
                  background={C.bg}
                />
              </Box>

              <Box style={{ marginBottom: '6px' }}>
                <Box style={{ fontSize: '9px', color: C.textDim, marginBottom: '2px' }}>
                  CONTAMINATION: {a.contamination_level}
                </Box>
                <ProgressBar
                  value={a.contamination_level / 30}
                  color={a.contamination_level > 15 ? C.red : C.amber}
                  background={C.bg}
                />
              </Box>

              <Box style={{ fontSize: '10px', color: C.textDim, marginBottom: '8px' }}>
                CASUALTIES: {a.personnel_casualties} | LESSONS: {a.lessons_count} |
                REPAIRS DONE: {a.repairs_done} |
                DURATION: {a.breach_duration || 0} min
              </Box>

              <Box style={{ display: 'flex', gap: '8px' }}>
                <Button
                  style={{
                    padding: '6px 10px',
                    background: C.panel,
                    border: `1px solid ${C.border}`,
                    color: C.textBright,
                    fontFamily: C.mono,
                    fontSize: '10px',
                  }}
                  onClick={() => act('repair', { aftermath_id: a.id, amount: 10 })}
                >
                  REPAIR (-10)
                </Button>
                <Button
                  style={{
                    padding: '6px 10px',
                    background: C.panel,
                    border: `1px solid ${C.border}`,
                    color: C.textBright,
                    fontFamily: C.mono,
                    fontSize: '10px',
                  }}
                  onClick={() =>
                    act('decontaminate', { aftermath_id: a.id, amount: 10 })
                  }
                >
                  DECON (-10)
                </Button>
                <Button
                  style={{
                    padding: '6px 10px',
                    background: C.panel,
                    border: `1px solid ${C.border}`,
                    color: C.textBright,
                    fontFamily: C.mono,
                    fontSize: '10px',
                  }}
                  onClick={() =>
                    act('submit_lesson', {
                      aftermath_id: a.id,
                      lesson: lessonDraft || 'Observation noted.',
                    })
                  }
                >
                  SUBMIT LESSON
                </Button>
                <Button
                  style={{
                    padding: '6px 10px',
                    background: C.red,
                    border: `1px solid ${C.borderRed}`,
                    color: C.textBright,
                    fontFamily: C.mono,
                    fontSize: '10px',
                    fontWeight: 'bold',
                  }}
                  onClick={() => act('complete_debrief', { aftermath_id: a.id })}
                >
                  COMPLETE DEBRIEF
                </Button>
              </Box>
            </Box>
          ))}

          <Box
            style={{
              border: `1px solid ${C.border}`,
              background: C.panel,
              padding: '10px',
              marginBottom: '12px',
            }}
          >
            <Box style={{ fontSize: '10px', color: C.textDim, marginBottom: '6px' }}>
              LESSON TEXT (applies to submit button above)
            </Box>
            <Input
              value={lessonDraft}
              onInput={(e, value) => setLessonDraft(value || '')}
              style={{
                width: '100%',
                background: C.bg,
                color: C.textBright,
                fontFamily: C.mono,
                border: `1px solid ${C.border}`,
                padding: '6px',
              }}
            />
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
              MANUAL RECORD CREATION
            </Box>
            <Box style={{ display: 'flex', gap: '8px', alignItems: 'center' }}>
              <Input
                value={newScp}
                placeholder="SCP ID"
                onInput={(e, value) => setNewScp(value || '')}
                style={{
                  background: C.bg,
                  color: C.textBright,
                  fontFamily: C.mono,
                  border: `1px solid ${C.border}`,
                  padding: '4px 6px',
                }}
              />
              <Input
                value={newZone}
                placeholder="Zone"
                onInput={(e, value) => setNewZone(value || '')}
                style={{
                  background: C.bg,
                  color: C.textBright,
                  fontFamily: C.mono,
                  border: `1px solid ${C.border}`,
                  padding: '4px 6px',
                }}
              />
              <Button
                style={{
                  padding: '6px 10px',
                  background: C.panel,
                  border: `1px solid ${C.border}`,
                  color: C.textBright,
                  fontFamily: C.mono,
                  fontSize: '10px',
                }}
                onClick={() =>
                  act('create_aftermath', {
                    scp_id: newScp || 'Unknown',
                    zone: newZone || 'HCZ',
                  })
                }
              >
                CREATE RECORD
              </Button>
            </Box>
          </Box>

          <Box
            style={{
              border: `1px solid ${C.border}`,
              background: C.panel,
              padding: '10px',
            }}
          >
            <Box style={{ fontSize: '10px', color: C.textDim, marginBottom: '6px' }}>
              AFTERMATH LOG
            </Box>
            {log.map((entry, i) => (
              <Box
                key={i}
                style={{
                  fontSize: '10px',
                  color: C.text,
                  padding: '2px 0',
                  borderTop: i > 0 ? `1px solid ${C.border}` : undefined,
                }}
              >
                [{entry.time}] {entry.event.toUpperCase()} - SCP-{entry.scp_id}
              </Box>
            ))}
          </Box>
        </Box>
      </Window.Content>
    </Window>
  );
};
