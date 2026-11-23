import { useBackend } from '../backend';
import { Box, Button, NoticeBox, Section } from '../components';
import { Window } from '../layouts';

export const Scanner = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    scanner_name,
    scanner_enabled,
    can_view_scan,
    can_save_scan,
    using_scanner,
    check_scanning,
    data_buffer,
  } = data;

  return (
    <Window theme="scp_terminal" width={520} height={620}>
      <Window.Content scrollable>
        <Box style={{ background: '#0a0a0c', minHeight: '100%', padding: '10px', fontFamily: '"Consolas", monospace', color: '#c8c8c8' }}>
          <Box style={{ borderBottom: '2px solid #6b0000', paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: '#d4a017', letterSpacing: '0.15em', fontWeight: 'bold' }}>SCANNER PROGRAM</Box>
            <Box style={{ color: '#6a6a70', fontSize: '9px' }}>{scanner_name || 'NO SCANNER CONNECTED'}</Box>
          </Box>

          {!scanner_name ? (
            <NoticeBox danger>No scanner hardware detected on this computer.</NoticeBox>
          ) : (
            <Section title="Scanner Control">
              <LabeledList>
                <LabeledList.Item label="Status">
                  <Box color={scanner_enabled ? '#44ff44' : '#cc2222'}>{scanner_enabled ? 'ONLINE' : 'OFFLINE'}</Box>
                </LabeledList.Item>
              </LabeledList>
              <Box mt={1}>
                <Button
                  icon={using_scanner ? 'user-slash' : 'user-check'}
                  content={using_scanner ? 'Disconnect Patient' : 'Connect Patient'}
                  color={using_scanner ? 'bad' : 'good'}
                  onClick={() => act('connect_scanner')}
                />
                <Button
                  icon="heartbeat"
                  content="Scan"
                  disabled={!using_scanner || !scanner_enabled}
                  onClick={() => act('scan')}
                />
              </Box>
            </Section>
          )}

          {data_buffer ? (
            <Section title="Last Scan" buttons={
              <Box>
                <Button icon="save" content="Save" disabled={!can_save_scan} onClick={() => act('save')} />
              </Box>
            }>
              <Box dangerouslySetInnerHTML={{ __html: data_buffer }} />
            </Section>
          ) : null}
        </Box>
      </Window.Content>
    </Window>
  );
};
