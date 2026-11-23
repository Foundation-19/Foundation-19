import { useBackend } from '../backend';
import { Box, Button, Flex, LabeledList, ProgressBar, Section } from '../components';
import { Window } from '../layouts';

const SmesRow = (props, context) => {
  const { act } = useBackend(context);
  const { smes } = props;
  return (
    <Box mb={2} pb={1} style={{ borderBottom: '1px solid #2a2a30' }}>
      <Flex align="center" mb={0.5}>
        <Box style={{ color: '#d4a017', fontWeight: 'bold', flex: 1 }}>{smes.RCON_tag}</Box>
        <ProgressBar
          value={smes.charge}
          minValue={0}
          maxValue={100}
          ranges={{ good: [70, 100], average: [30, 70], bad: [0, 30] }}
          style={{ width: '160px' }}>
          {smes.charge}%
        </ProgressBar>
      </Flex>
      <LabeledList>
        <LabeledList.Item label="Input">
          <Flex align="center">
            <Box mr={1} style={{ color: smes.input_set ? '#44ff44' : '#cc2222' }}>{smes.input_set ? 'ON' : 'OFF'}</Box>
            <Box mr={1}>{smes.input_load} / {smes.input_val} kW</Box>
            <Button content="Toggle" onClick={() => act('smes_in_toggle', { smes_in_toggle: smes.RCON_tag })} />
            <Button content="Set" onClick={() => act('smes_in_set', { smes_in_set: smes.RCON_tag })} />
          </Flex>
        </LabeledList.Item>
        <LabeledList.Item label="Output">
          <Flex align="center">
            <Box mr={1} style={{ color: smes.output_set ? '#44ff44' : '#cc2222' }}>{smes.output_set ? 'ON' : 'OFF'}</Box>
            <Box mr={1}>{smes.output_load} / {smes.output_val} kW</Box>
            <Button content="Toggle" onClick={() => act('smes_out_toggle', { smes_out_toggle: smes.RCON_tag })} />
            <Button content="Set" onClick={() => act('smes_out_set', { smes_out_set: smes.RCON_tag })} />
          </Flex>
        </LabeledList.Item>
      </LabeledList>
    </Box>
  );
};

export const RconConsole = (props, context) => {
  const { data } = useBackend(context);
  const { smes_info = [], breaker_info = [], hide_smes, hide_breakers } = data;

  return (
    <Window theme="scp_terminal" width={560} height={660}>
      <Window.Content scrollable>
        <Box style={{ background: '#0a0a0c', minHeight: '100%', padding: '10px', fontFamily: '"Consolas", monospace', color: '#c8c8c8' }}>
          <Box style={{ borderBottom: '2px solid #6b0000', paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: '#d4a017', letterSpacing: '0.15em', fontWeight: 'bold' }}>RAPID POWER CONTROL</Box>
            <Box style={{ color: '#6a6a70', fontSize: '9px' }}>REMOTE POWER GRID INTERFACE</Box>
          </Box>
          {!hide_smes ? (
            <Section title="SMES Units">
              {smes_info.map((s, i) => <SmesRow key={i} smes={s} />)}
              {smes_info.length === 0 ? <Box style={{ color: '#6a6a70' }}>No SMES units on RCON network.</Box> : null}
            </Section>
          ) : null}
          {!hide_breakers ? (
            <Section title="Breaker Boxes">
              {breaker_info.map((b, i) => (
                <Flex key={i} align="center" mb={0.5}>
                  <Box style={{ flex: 1 }}>{b.RCON_tag}</Box>
                  <Box mr={1} style={{ color: b.enabled ? '#44ff44' : '#cc2222' }}>{b.enabled ? 'ON' : 'OFF'}</Box>
                  <Button content="Toggle" onClick={() => act('toggle_breaker', { toggle_breaker: b.RCON_tag })} />
                </Flex>
              ))}
              {breaker_info.length === 0 ? <Box style={{ color: '#6a6a70' }}>No breaker boxes on RCON network.</Box> : null}
            </Section>
          ) : null}
        </Box>
      </Window.Content>
    </Window>
  );
};
