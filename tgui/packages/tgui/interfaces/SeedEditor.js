import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, ProgressBar } from '../components';
import { Window } from '../layouts';

export const SeedEditor = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    activity,
    degradation,
    disk,
    sourceName,
    locus,
    loaded,
  } = data;
  return (
    <Window width={470} height={450}>
      <Window.Content>
        <Section title="Bioballistic Delivery System">
          <LabeledList>
            <LabeledList.Item label="Status">
              {activity ? "Active" : "Idle"}
            </LabeledList.Item>
            <LabeledList.Item label="Loaded Seed">
              {loaded || "None"}
            </LabeledList.Item>
            <LabeledList.Item label="Degradation">
              <ProgressBar
                value={degradation / 100}
                ranges={{
                  good: [-Infinity, 0.5],
                  average: [0.5, 0.8],
                  bad: [0.8, Infinity],
                }}
              >
                {degradation}%
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Disk">
              {disk ? (
                <Box>
                  {sourceName}
                  {locus && <Box color="label">Locus: {locus}</Box>}
                </Box>
              ) : "No disk loaded"}
            </LabeledList.Item>
          </LabeledList>
          <Button mt={1} fluid onClick={() => act('apply_gene')} disabled={!disk || !loaded}>
            Apply Gene
          </Button>
          <Button mt={1} fluid onClick={() => act('eject_packet')} disabled={!loaded}>
            Eject Seed
          </Button>
          <Button mt={1} fluid onClick={() => act('eject_disk')} disabled={!disk}>
            Eject Disk
          </Button>
        </Section>
      </Window.Content>
    </Window>
  );
};
