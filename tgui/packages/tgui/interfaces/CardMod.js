import { useBackend } from '../backend';
import { Box, Button, Flex, LabeledList, NoticeBox, Section } from '../components';
import { Window } from '../layouts';
import { ProgramExitButtons } from './common/ProgramExitButtons';

const DEPARTMENTS = [
  ['command_jobs', 'Command'],
  ['support_jobs', 'Support'],
  ['engineering_jobs', 'Engineering'],
  ['medical_jobs', 'Medical'],
  ['science_jobs', 'Science'],
  ['security_jobs', 'Security'],
];

export const CardMod = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    authenticated,
    have_id_slot,
    have_printer,
    has_id,
    id_owner,
    id_rank,
    id_account_number,
    mmode,
    manifest,
  } = data;
  const showExit = data && data.PC_showexitprogram;

  return (
    <Window theme="scp_terminal" width={620} height={640} buttons={showExit ? <ProgramExitButtons act={act} /> : undefined}>
      <Window.Content scrollable>
        <Box style={{ background: '#0a0a0c', minHeight: '100%', padding: '10px', fontFamily: '"Consolas", monospace', color: '#c8c8c8' }}>
          <Box style={{ borderBottom: '2px solid #6b0000', paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: '#d4a017', letterSpacing: '0.15em', fontWeight: 'bold' }}>ID CARD MODIFICATION PROGRAM</Box>
            <Box style={{ color: '#6a6a70', fontSize: '9px' }}>ACCESS CHANGE AUTHORITY — {authenticated ? 'AUTHENTICATED' : 'LOCKED'}</Box>
          </Box>

          {!have_id_slot || !have_printer ? (
            <NoticeBox danger>Card slot or printer hardware missing.</NoticeBox>
          ) : null}

          <Section title="Inserted Card">
            {has_id ? (
              <LabeledList>
                <LabeledList.Item label="Owner">{id_owner}</LabeledList.Item>
                <LabeledList.Item label="Assignment">{id_rank}</LabeledList.Item>
                <LabeledList.Item label="Account">{id_account_number}</LabeledList.Item>
                <LabeledList.Item label="Actions">
                  <Button icon="eject" content="Eject" onClick={() => act('eject')} />
                  <Button icon="print" content="Print" disabled={!have_printer} onClick={() => act('print')} />
                </LabeledList.Item>
              </LabeledList>
            ) : (
              <Box style={{ color: '#6a6a70' }}>No card inserted. Insert an ID to modify.</Box>
            )}
          </Section>

          {authenticated && has_id ? (
            <Section title="Job Assignment">
              {DEPARTMENTS.map(([key, label]) => (
                <Box key={key} mb={1}>
                  <Box style={{ color: '#d4a017', marginBottom: '4px' }}>{label}</Box>
                  <Flex wrap="wrap">
                    {(data[key] || []).map((job) => (
                      <Flex.Item key={job} mr={0.5} mb={0.5}>
                        <Button content={job} onClick={() => act('assign', { assign_target: job })} />
                      </Flex.Item>
                    ))}
                  </Flex>
                </Box>
              ))}
              <Box mt={1}>
                <Button icon="lock" content="Terminate" color="bad" onClick={() => act('terminate')} />
                <Button icon="wrench" content="Custom Assignment" onClick={() => act('assign', { assign_target: 'Custom' })} />
              </Box>
            </Section>
          ) : null}

          {authenticated ? (
            <Section title="Manifest">
              <Box dangerouslySetInnerHTML={{ __html: manifest }} />
            </Section>
          ) : (
            <Section title="Access">
              <Button icon="key" content="Log In" onClick={() => act('auth')} />
            </Section>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
