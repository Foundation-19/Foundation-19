import { useBackend, useLocalState } from '../backend';
import { Box, Button, Dropdown, Input } from '../components';
import { Window } from '../layouts';

type Evidence = {
  evidence_id: string;
  submitter: string;
  type: string;
  description: string;
  zone: string;
  time: string;
  linked_investigation: string | null;
  verified: boolean;
};

type Investigation = {
  id: string;
  title: string;
  scp_id: string;
  investigator: string;
  evidence_count: number;
  status: string;
  conclusion: string | null;
};

type EvidenceData = {
  evidence: Evidence[];
  investigations: Investigation[];
  total_evidence: number;
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

const EVIDENCE_TYPES = ['observation', 'physical', 'audio', 'trace'];

export const ScpEvidenceBoardProgram = (props, context) => {
  const { act, data } = useBackend<EvidenceData>(context);
  const {
    evidence = [],
    investigations = [],
    total_evidence = 0,
  } = data;

  const [submitType, setSubmitType] = useLocalState<string>(
    context,
    'evidence_submit_type',
    'observation'
  );
  const [submitDesc, setSubmitDesc] = useLocalState<string>(
    context,
    'evidence_submit_desc',
    ''
  );
  const [invTitle, setInvTitle] = useLocalState<string>(
    context,
    'evidence_inv_title',
    ''
  );
  const [invScp, setInvScp] = useLocalState<string>(
    context,
    'evidence_inv_scp',
    ''
  );

  return (
    <Window
      theme="scp_terminal"
      title="SCP FOUNDATION - EVIDENCE BOARD"
      width={720}
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
              FORENSIC EVIDENCE BOARD
            </Box>
            <Box style={{ fontSize: '10px', color: C.textDim, marginTop: '2px' }}>
              CLASSIFIED - LEVEL 2 SECURITY - TOTAL EVIDENCE: {total_evidence}
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
              SUBMIT EVIDENCE
            </Box>
            <Box
              style={{ display: 'flex', gap: '8px', alignItems: 'center', marginBottom: '6px' }}
            >
              <Dropdown
                options={EVIDENCE_TYPES}
                selected={submitType}
                onSelected={(value) => setSubmitType(value)}
                displayText={submitType.toUpperCase()}
                style={{
                  background: C.bg,
                  color: C.textBright,
                  fontFamily: C.mono,
                  border: `1px solid ${C.border}`,
                  padding: '4px 8px',
                }}
              />
              <Input
                value={submitDesc}
                placeholder="Description"
                onInput={(e, value) => setSubmitDesc(value || '')}
                style={{
                  flex: '1',
                  background: C.bg,
                  color: C.textBright,
                  fontFamily: C.mono,
                  border: `1px solid ${C.border}`,
                  padding: '4px 6px',
                }}
              />
            </Box>
            <Button
              style={{
                padding: '6px 12px',
                background: C.panel,
                border: `1px solid ${C.border}`,
                color: C.textBright,
                fontFamily: C.mono,
                fontSize: '10px',
                fontWeight: 'bold',
              }}
              onClick={() =>
                act('submit_evidence', {
                  evidence_type: submitType,
                  description: submitDesc || 'No description',
                })
              }
            >
              SUBMIT
            </Button>
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
              CREATE INVESTIGATION
            </Box>
            <Box style={{ display: 'flex', gap: '8px', alignItems: 'center' }}>
              <Input
                value={invTitle}
                placeholder="Title"
                onInput={(e, value) => setInvTitle(value || '')}
                style={{
                  background: C.bg,
                  color: C.textBright,
                  fontFamily: C.mono,
                  border: `1px solid ${C.border}`,
                  padding: '4px 6px',
                }}
              />
              <Input
                value={invScp}
                placeholder="SCP ID"
                onInput={(e, value) => setInvScp(value || '')}
                style={{
                  width: '90px',
                  background: C.bg,
                  color: C.textBright,
                  fontFamily: C.mono,
                  border: `1px solid ${C.border}`,
                  padding: '4px 6px',
                }}
              />
              <Button
                style={{
                  padding: '6px 12px',
                  background: C.panel,
                  border: `1px solid ${C.border}`,
                  color: C.textBright,
                  fontFamily: C.mono,
                  fontSize: '10px',
                }}
                onClick={() =>
                  act('create_investigation', {
                    title: invTitle || 'Investigation',
                    scp_id: invScp || 'Unknown',
                  })
                }
              >
                CREATE
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
              INVESTIGATIONS
            </Box>
            {investigations.map((inv) => (
              <Box
                key={inv.id}
                style={{
                  border: `1px solid ${inv.status === 'closed' ? C.greenDim : C.border}`,
                  background: C.bg,
                  padding: '8px',
                  marginBottom: '6px',
                }}
              >
                <Box
                  style={{
                    display: 'flex',
                    justifyContent: 'space-between',
                    marginBottom: '4px',
                  }}
                >
                  <Box style={{ fontSize: '11px', fontWeight: 'bold', color: C.textBright }}>
                    {inv.title} (SCP-{inv.scp_id})
                  </Box>
                  <Box
                    style={{
                      fontSize: '9px',
                      color: inv.status === 'closed' ? C.green : C.amber,
                      letterSpacing: '1px',
                    }}
                  >
                    {inv.status.toUpperCase()} - {inv.evidence_count} ITEMS
                  </Box>
                </Box>
                <Box style={{ fontSize: '9px', color: C.textDim, marginBottom: '4px' }}>
                  INVESTIGATOR: {inv.investigator}
                  {inv.conclusion ? ` | CONCLUSION: ${inv.conclusion}` : ''}
                </Box>
                {inv.status !== 'closed' && (
                  <Input
                    placeholder="Conclusion, then press Enter"
                    onEnter={(e, value) =>
                      act('close_investigation', {
                        investigation_id: inv.id,
                        conclusion: value || 'Resolved',
                      })
                    }
                    style={{
                      width: '100%',
                      background: C.bg,
                      color: C.textBright,
                      fontFamily: C.mono,
                      border: `1px solid ${C.border}`,
                      padding: '4px 6px',
                    }}
                  />
                )}
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
              EVIDENCE LOG (LATEST 30)
            </Box>
            {evidence.map((ev, i) => (
              <Box
                key={ev.evidence_id}
                style={{
                  fontSize: '10px',
                  color: C.text,
                  padding: '4px 0',
                  borderTop: i > 0 ? `1px solid ${C.border}` : undefined,
                  display: 'flex',
                  justifyContent: 'space-between',
                  alignItems: 'center',
                }}
              >
                <Box style={{ flex: '1' }}>
                  <Box style={{ color: C.textBright }}>
                    [{ev.type.toUpperCase()}] {ev.description}
                  </Box>
                  <Box style={{ color: C.textDim }}>
                    {ev.zone} - {ev.submitter} - {ev.time}
                    {ev.linked_investigation ? ` - LINKED: ${ev.linked_investigation}` : ''}
                  </Box>
                </Box>
                <Box style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
                  <Box
                    style={{
                      fontSize: '9px',
                      color: ev.verified ? C.green : C.amber,
                      letterSpacing: '1px',
                    }}
                  >
                    {ev.verified ? 'VERIFIED' : 'UNVERIFIED'}
                  </Box>
                  {!ev.verified && (
                    <Button
                      style={{
                        padding: '3px 8px',
                        background: C.panel,
                        border: `1px solid ${C.border}`,
                        color: C.textBright,
                        fontFamily: C.mono,
                        fontSize: '9px',
                      }}
                      onClick={() => act('verify_evidence', { evidence_id: ev.evidence_id })}
                    >
                      VERIFY
                    </Button>
                  )}
                </Box>
              </Box>
            ))}
          </Box>
        </Box>
      </Window.Content>
    </Window>
  );
};
