import { useBackend } from '../backend';
import { Box, Section } from '../components';
import { Window } from '../layouts';
import { ProgramExitButtons } from './common/ProgramExitButtons';

export const CrewManifest = (props, context) => {
  const { act, data } = useBackend(context);
  const { crew_manifest } = data;
  const showExit = data && data.PC_showexitprogram;

  return (
    <Window theme="scp_terminal" width={520} height={620} buttons={showExit ? <ProgramExitButtons act={act} /> : undefined}>
      <Window.Content scrollable>
        <Box style={{ background: '#0a0a0c', minHeight: '100%', padding: '10px', fontFamily: '"Consolas", monospace', color: '#c8c8c8' }}>
          <Box style={{ borderBottom: '2px solid #6b0000', paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: '#d4a017', letterSpacing: '0.15em', fontWeight: 'bold' }}>CREW MANIFEST</Box>
            <Box style={{ color: '#6a6a70', fontSize: '9px' }}>SITE-53 PERSONNEL ROSTER</Box>
          </Box>
          <Box dangerouslySetInnerHTML={{ __html: crew_manifest }} />
        </Box>
      </Window.Content>
    </Window>
  );
};
