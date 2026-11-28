import { useBackend } from '../backend';
import { Box, Button, Flex, Section } from '../components';
import { Window } from '../layouts';
import { ProgramExitButtons } from './common/ProgramExitButtons';

const C = {
  bg: '#0a0a0c',
  border: '#2a2a30',
  borderRed: '#6b0000',
  amber: '#d4a017',
  textDim: '#6a6a70',
  mono: '"Consolas", "Courier New", monospace',
};

export const Reports = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    prog_state,
    report_data,
    view_only,
    printer,
    reports = [],
    report_fields = [],
  } = data;
  const showExit = data && data.PC_showexitprogram;

  return (
    <Window theme="scp_terminal" width={640} height={660} buttons={showExit ? <ProgramExitButtons act={act} /> : undefined}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: '#c8c8c8' }}>
          <Box style={{ borderBottom: '2px solid ' + C.borderRed, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>REPORTS MANAGER</Box>
            <Box style={{ color: C.textDim, fontSize: '9px' }}>SCiPNET SECURE REPORTING</Box>
          </Box>

          {prog_state === 1 && report_data ? (
            <Section title={report_data.name || 'Report'} buttons={
              <Box>
                {printer ? <Button icon="print" content="Print" onClick={() => act('print')} /> : null}
                <Button icon="arrow-left" content="Back" onClick={() => act('discard')} />
              </Box>
            }>
              {report_data.fields.map((f, i) => (
                <Box key={i} mb={1}>
                  <Flex align="center">
                    <Box style={{ color: C.textDim, width: '160px', flexShrink: 0 }}>{f.name}</Box>
                    <Box style={{ flex: 1, color: '#e8e8e8' }} dangerouslySetInnerHTML={{ __html: f.value }} />
                    {f.access_edit ? (
                      <Button icon="pen" content="Edit" onClick={() => act('edit', { ID: f.ID })} />
                    ) : null}
                  </Flex>
                </Box>
              ))}
              {!view_only ? (
                <Box mt={2}>
                  <Button icon="save" content="Save" onClick={() => act('save')} />
                  <Button icon="check" content="Submit" color="good" onClick={() => act('submit')} />
                </Box>
              ) : null}
            </Section>
          ) : prog_state === 2 ? (
            <Section title="Network Reports" buttons={
              <Button icon="arrow-left" content="Back" onClick={() => act('load')} />
            }>
              {reports.map((r) => (
                <Flex key={r.uid} align="center" mb={0.5}>
                  <Box style={{ flex: 1 }}>{r.name}</Box>
                  <Button icon="download" content="Download" onClick={() => act('load')} />
                </Flex>
              ))}
              {reports.length === 0 ? <Box style={{ color: '#6a6a70' }}>No reports on the network.</Box> : null}
            </Section>
          ) : (
            <Section title="Reports">
              <Box style={{ color: '#6a6a70', mb: 1 }}>Load a saved report from the local drive, or fetch reports from SCiPNET.</Box>
              <Button icon="folder-open" content="Load Local Report" onClick={() => act('load')} />
              <Button icon="download" content="Network Reports" onClick={() => act('load')} />
            </Section>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
