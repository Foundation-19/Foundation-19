import { useBackend } from '../backend';
import { Button, Box, Flex, ProgressBar, Section, LabeledList } from '../components';
import { Window } from '../layouts';

const C = {
  bg: '#0a0a0c',
  panel: '#111114',
  border: '#2a2a30',
  borderRed: '#6b0000',
  amber: '#c2960e',
  text: '#c8c8c8',
  textDim: '#7a7a80',
  mono: 'Consolas, monospace',
};

const term = (extra) => ({
  fontFamily: C.mono,
  ...extra,
});

export const Photocopier = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    has_item,
    item_name,
    copies,
    max_copies,
    toner,
    can_copy,
    is_silicon,
    templates = [],
  } = data;

  return (
    <Window theme="scp_terminal">
      <Window.Content>
        <Box style={{ background: C.bg, fontFamily: C.mono, fontSize: '12px', color: C.text, minHeight: '100%', padding: '10px' }}>
          <Box style={{ borderBottom: `2px solid ${C.borderRed}`, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>PHOTOCOPIER — DOCUMENT REPRODUCTION UNIT</Box>
            <Box style={{ color: C.textDim, fontSize: '9px', letterSpacing: '0.1em' }}>SCiPNET OFFICE HARDWARE v2.3</Box>
          </Box>

          <Section title="Document Feed" style={term({ border: `1px solid ${C.border}` })}>
            {has_item ? (
              <LabeledList>
                <LabeledList.Item label="Loaded">
                  <Box style={{ color: C.text }}>{item_name}</Box>
                </LabeledList.Item>
                <LabeledList.Item label="Controls">
                  <Flex mt={1}>
                    <Flex.Item mr={1}>
                      <Button
                        icon="eject"
                        content="Remove"
                        onClick={() => act('remove')} />
                    </Flex.Item>
                    <Flex.Item mr={1}>
                      <Button
                        icon="minus"
                        content="-"
                        disabled={copies <= 1}
                        onClick={() => act('min')} />
                    </Flex.Item>
                    <Flex.Item mr={1}>
                      <Button content={copies} onClick={() => act('copy')} color={can_copy ? 'good' : undefined} disabled={!can_copy} />
                    </Flex.Item>
                    <Flex.Item mr={1}>
                      <Button
                        icon="plus"
                        content="+"
                        disabled={copies >= max_copies}
                        onClick={() => act('add')} />
                    </Flex.Item>
                  </Flex>
                </LabeledList.Item>
                <LabeledList.Item label="Copy">
                  <Button
                    icon="copy"
                    content={can_copy ? `Run ${copies} cop${copies === 1 ? 'y' : 'ies'}` : 'Out of toner'}
                    color={can_copy ? 'good' : 'bad'}
                    disabled={!can_copy}
                    onClick={() => act('copy')} />
                </LabeledList.Item>
              </LabeledList>
            ) : (
              <Box style={term({ color: C.textDim })}>Please insert something to copy.</Box>
            )}
          </Section>

          {is_silicon && (
            <Section title="Silicon Access">
              <Button
                icon="camera"
                content="Print photo from database"
                disabled={toner < 5}
                onClick={() => act('aipic')} />
            </Section>
          )}

          <Section title="Form Templates" style={term({ border: `1px solid ${C.border}`, marginTop: '8px' })}>
            <Box style={term({ color: C.textDim, fontSize: '10px', marginBottom: '6px' })}>
              PRINTS A BLANK FORM — 1 TONER UNIT EACH
            </Box>
            <Box style={{ columns: '2', columnGap: '8px' }}>
              {templates.map((t, i) => (
                <Box key={i} style={{ breakInside: 'avoid', marginBottom: '3px' }}>
                  <Button
                    fluid
                    content={t.name}
                    disabled={toner <= 0}
                    onClick={() => act('print_template', { template: t.name })}
                    style={term({ fontSize: '11px', textAlign: 'left' })} />
                </Box>
              ))}
            </Box>
          </Section>

          <Section title="Toner" style={term({ border: `1px solid ${C.border}` })}>
            <ProgressBar
              value={toner}
              minValue={0}
              maxValue={30}
              ranges={{
                good: [20, 30],
                average: [8, 20],
                bad: [0, 8],
              }}>
              {toner} / 30 units
            </ProgressBar>
            {toner === 0 ? (
              <Box style={term({ color: '#cc2222', marginTop: '6px' })}>
                TONER DEPLETED — INSERT NEW CARTRIDGE
              </Box>
            ) : null}
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
