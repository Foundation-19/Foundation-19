import { useBackend } from '../backend';
import { Box, Button, NoticeBox, ProgressBar, Section } from '../components';
import { Window } from '../layouts';
import { ProgramExitButtons } from './common/ProgramExitButtons';

export const AccessDecrypter = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    message,
    running,
    rate,
    dos_strings = [],
    regions = [],
    card_name,
  } = data;
  const showExit = data && data.PC_showexitprogram;

  return (
    <Window theme="scp_terminal" width={620} height={660} buttons={showExit ? <ProgramExitButtons act={act} /> : undefined}>
      <Window.Content scrollable>
        <Box style={{ background: '#0a0a0c', minHeight: '100%', padding: '10px', fontFamily: '"Consolas", monospace', color: '#c8c8c8' }}>
          <Box style={{ borderBottom: '2px solid #6b0000', paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: '#d4a017', letterSpacing: '0.15em', fontWeight: 'bold' }}>ACCESS DECRYPTER</Box>
            <Box style={{ color: '#6a6a70', fontSize: '9px' }}>UNAUTHORIZED RFID CLONING TOOL</Box>
          </Box>

          {message ? <NoticeBox danger>{message}</NoticeBox> : null}

          {running ? (
            <Section title="Decrypting...">
              <Box style={{ color: '#d4a017', mb: 1 }}>Rate: {rate}%</Box>
              {dos_strings.map((line, i) => (
                <Box key={i} style={{ fontFamily: '"Consolas", monospace', whiteSpace: 'pre', fontSize: '10px', color: '#44ff44' }}>{line}</Box>
              ))}
              <Button icon="stop" content="Halt" color="bad" onClick={() => act('PRG_reset')} />
            </Section>
          ) : card_name ? (
            <Section title={"Card: " + (card_name || "Unknown")} buttons={
              <Button icon="play" content="Execute Clone" color="good" onClick={() => act('PRG_execute')} />
            }>
              {regions.map((region, i) => (
                <Box key={i} mb={1}>
                  <Box style={{ color: '#d4a017', mb: 0.5 }}>{region.name}</Box>
                  <Box>
                    {region.accesses.map((acc, j) => (
                      <Box key={j} inline mr={1} style={{ color: acc.blocked ? '#cc2222' : acc.allowed ? '#44ff44' : '#6a6a70' }}>
                        {acc.allowed ? '[+] ' : acc.blocked ? '[x] ' : '[ ] '}{acc.desc}
                      </Box>
                    ))}
                  </Box>
                </Box>
              ))}
              <Button icon="stop" content="Reset" onClick={() => act('PRG_reset')} />
            </Section>
          ) : (
            <Section title="No Card">
              <Box style={{ color: '#6a6a70' }}>Insert an RFID card to begin decryption.</Box>
            </Section>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
