import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, ProgressBar } from '../components';
import { Window } from '../layouts';

export const DNAScanner = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    scan_progress,
    scanning,
    bloodsamp,
    bloodsamp_desc,
    lidstate,
  } = data;
  return (
    <Window width={540} height={326}>
      <Window.Content>
        <Section title="QuikScan DNA Analyzer">
          <LabeledList>
            <LabeledList.Item label="Sample">
              {bloodsamp || "None"}
              {!!bloodsamp && <Box color="label" mt={1}>{bloodsamp_desc}</Box>}
            </LabeledList.Item>
            <LabeledList.Item label="Lid">
              <Button selected={lidstate} onClick={() => act('toggleLid')}>
                {lidstate ? "Closed" : "Open"}
              </Button>
            </LabeledList.Item>
            <LabeledList.Item label="Scan Progress">
              <ProgressBar value={scan_progress / 100}>
                {scanning ? `${scan_progress}%` : "Idle"}
              </ProgressBar>
            </LabeledList.Item>
          </LabeledList>
          <Button mt={1} fluid onClick={() => act('scanItem')} disabled={!bloodsamp || !lidstate}>
            {scanning ? "Cancel Scan" : "Start Scan"}
          </Button>
          <Button mt={1} fluid onClick={() => act('ejectItem')} disabled={!bloodsamp}>
            Eject Sample
          </Button>
        </Section>
      </Window.Content>
    </Window>
  );
};
