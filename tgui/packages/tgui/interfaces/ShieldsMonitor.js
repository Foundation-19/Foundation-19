import { useBackend } from '../backend';
import { Box, Button, Flex, LabeledList, ProgressBar, Section } from '../components';
import { Window } from '../layouts';

export const ShieldsMonitor = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    running,
    overloaded,
    mitigation_max,
    mitigation_physical,
    mitigation_em,
    mitigation_heat,
    field_integrity,
    max_energy,
    current_energy,
    percentage_energy,
    modes = {},
  } = data;

  return (
    <Window theme="scp_terminal" width={560} height={620}>
      <Window.Content scrollable>
        <Box style={{ background: '#0a0a0c', minHeight: '100%', padding: '10px', fontFamily: '"Consolas", monospace', color: '#c8c8c8' }}>
          <Box style={{ borderBottom: '2px solid #6b0000', paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: '#d4a017', letterSpacing: '0.15em', fontWeight: 'bold' }}>SHIELD MONITOR</Box>
            <Box style={{ color: '#6a6a70', fontSize: '9px' }}>{overloaded ? 'WARNING: OVERLOADED' : running ? 'SHIELD ACTIVE' : 'SHIELD OFFLINE'}</Box>
          </Box>
          <Section title="Field Status">
            <LabeledList>
              <LabeledList.Item label="Integrity">
                <ProgressBar value={field_integrity || 0} minValue={0} maxValue={100}
                  ranges={{ good: [60, 100], average: [25, 60], bad: [0, 25] }}>
                  {round(field_integrity || 0)}%
                </ProgressBar>
              </LabeledList.Item>
              <LabeledList.Item label="Energy">
                <ProgressBar value={percentage_energy || 0} minValue={0} maxValue={100}
                  ranges={{ good: [50, 100], average: [20, 50], bad: [0, 20] }}>
                  {current_energy} / {max_energy} MJ
                </ProgressBar>
              </LabeledList.Item>
            </LabeledList>
          </Section>
          <Section title="Damage Mitigation">
            <LabeledList>
              <LabeledList.Item label="Max">{mitigation_max}%</LabeledList.Item>
              <LabeledList.Item label="Physical">{mitigation_physical}%</LabeledList.Item>
              <LabeledList.Item label="EM">{mitigation_em}%</LabeledList.Item>
              <LabeledList.Item label="Heat">{mitigation_heat}%</LabeledList.Item>
            </LabeledList>
          </Section>
          <Section title="Controls" buttons={
            <Button icon="refresh" content="Refresh" onClick={() => act('refresh')} />
          }>
            <Button icon="power-off" content={running ? 'Shields Running' : 'Activate Shields'} color={running ? 'bad' : 'good'} onClick={() => act('toggle')} />
            <Button icon="cog" content="Adjust Modes" onClick={() => act('ref')} />
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};

const round = (v) => Math.round(v * 10) / 10;
