import { useBackend } from '../backend';
import { Box, Button, LabeledList, NoticeBox, ProgressBar, Section } from '../components';
import { Window } from '../layouts';

export const AIRestorer = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    skill_fail,
    terminal,
    error,
    ai_name,
    ai_integrity,
    ai_capacitor,
    ai_isdamaged,
    ai_isdead,
    ai_laws = [],
  } = data;

  return (
    <Window theme="scp_terminal" width={560} height={600}>
      <Window.Content scrollable>
        <Box style={{ background: '#0a0a0c', minHeight: '100%', padding: '10px', fontFamily: '"Consolas", monospace', color: '#c8c8c8' }}>
          <Box style={{ borderBottom: '2px solid #6b0000', paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: '#d4a017', letterSpacing: '0.15em', fontWeight: 'bold' }}>AI INTEGRITY RESTORER</Box>
            <Box style={{ color: '#6a6a70', fontSize: '9px' }}>HARDWARE DIAGNOSTICS AND RECONSTRUCTION</Box>
          </Box>

          {skill_fail ? (
            <NoticeBox danger>SKILL CHECK FAILED — data displayed may be corrupted.</NoticeBox>
          ) : null}
          {!terminal ? (
            <NoticeBox danger>No computer terminal detected.</NoticeBox>
          ) : null}

          {error ? (
            <Section title="Target">
              <Box style={{ color: '#cc2222' }}>{error}</Box>
            </Section>
          ) : (
            <Box>
              <Section title={"Target: " + (ai_name || "None")}>
                <LabeledList>
                  <LabeledList.Item label="Hardware Integrity">
                    <ProgressBar value={ai_integrity} minValue={0} maxValue={100}
                      ranges={{ good: [70, 100], average: [40, 70], bad: [0, 40] }}>
                      {ai_integrity}%
                    </ProgressBar>
                  </LabeledList.Item>
                  <LabeledList.Item label="Backup Capacitor">
                    <ProgressBar value={ai_capacitor} minValue={0} maxValue={100}
                      ranges={{ good: [70, 100], average: [40, 70], bad: [0, 40] }}>
                      {ai_capacitor}%
                    </ProgressBar>
                  </LabeledList.Item>
                  <LabeledList.Item label="Status">
                    {ai_isdead ? <Box color="#cc2222">UNIT DEAD</Box> : ai_isdamaged ? <Box color="#d4a017">DAMAGED</Box> : <Box color="#44ff44">NOMINAL</Box>}
                  </LabeledList.Item>
                </LabeledList>
                <Box mt={1}>
                  <Button icon="wrench" content="Begin Reconstruction" disabled={ai_isdead || !ai_isdamaged} onClick={() => act('PRG_beginReconstruction')} />
                </Box>
              </Section>
              <Section title="Laws" buttons={
                <Box>
                  <Button icon="undo" content="Reset Laws" onClick={() => act('PRG_resetLaws')} />
                  <Button icon="upload" content="Upload Default" onClick={() => act('PRG_uploadDefault')} />
                  <Button icon="trash" content="Purge" color="bad" onClick={() => act('PRG_purgeAiLaws')} />
                </Box>
              }>
                {ai_laws.map((law, i) => (
                  <Box key={i} mb={0.5}>{law.index}: {law.text}</Box>
                ))}
                {ai_laws.length === 0 ? <Box style={{ color: '#6a6a70' }}>No laws loaded.</Box> : null}
              </Section>
            </Box>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
