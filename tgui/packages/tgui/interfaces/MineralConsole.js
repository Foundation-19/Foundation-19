import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

const C = {
  bg: '#0a0a0c',
  panel: '#111114',
  border: '#2a2a30',
  accent: '#c2960e',
  good: '#44aa44',
  bad: '#cc2222',
  text: '#c8c8c8',
  dim: '#7a7a80',
  mono: 'Consolas, monospace',
};

const panelStyle = {
  background: C.panel,
  border: '1px solid ' + C.border,
  marginBottom: '8px',
};

const MODE_COLORS = {
  0: '#cc2222',
  1: '#d4a017',
  2: '#4a90d9',
  3: '#9a9aa0',
};

export const MineralConsole = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    connected,
    connected_name,
    input,
    output,
    kind,
    active,
    report_all,
    ores = [],
    stack_amt = 0,
    stacks = [],
  } = data;

  return (
    <Window width={560} height={560}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.accent, letterSpacing: '0.15em', fontWeight: 'bold' }}>MINERAL PROCESSING CONSOLE</Box>
            {connected ? <Box style={{ color: C.dim, fontSize: '10px' }}>{connected_name}</Box> : null}
          </Box>

          {!connected ? (
            <Section title="Connection" style={panelStyle}>
              <Box mb={1} style={{ color: C.dim }}>No processing machine connected.</Box>
              <Button icon="search" content="Scan for Machine" onClick={() => act('scan_for_machine')} />
            </Section>
          ) : (
            <>
              <Section title="Input / Output" style={panelStyle}>
                <LabeledList>
                  <LabeledList.Item label="Input">{input || 'disabled'}</LabeledList.Item>
                  <LabeledList.Item label="Output">{output || 'disabled'}</LabeledList.Item>
                </LabeledList>
                <Box mt={1}>
                  <Button icon="cog" content="Configure" onClick={() => act('configure_input_output')} />
                </Box>
              </Section>

              {kind === 'processor' ? (
                <Section title="Mineral Processing" style={panelStyle}>
                  <Box mb={1}>
                    <Button
                      content={active ? 'Enabled' : 'Disabled'}
                      selected={active}
                      mr={0.5}
                      onClick={() => act('toggle_power')} />
                    <Button
                      content={report_all ? 'Show less' : 'Show more'}
                      ml={0.5}
                      onClick={() => act('toggle_ores')} />
                  </Box>
                  {ores.length === 0 ? (
                    <Box style={{ color: C.dim }}>No ore available.</Box>
                  ) : (
                    <LabeledList>
                      {ores.map((ore, i) => (
                        <LabeledList.Item key={i} label={ore.name}>
                          {ore.sheets} sheet{ore.sheets === 1 ? '' : 's'} ({ore.units}u)
                          <Button
                            content={ore.mode_text}
                            ml={1}
                            style={{ color: MODE_COLORS[ore.mode] || C.dim }}
                            onClick={() => act('toggle_smelting', { ore: ore.ref })} />
                        </LabeledList.Item>
                      ))}
                    </LabeledList>
                  )}
                </Section>
              ) : null}

              {kind === 'stacker' ? (
                <Section title="Sheet Stacking" style={panelStyle}>
                  <Box mb={1}>
                    Stacking: {stack_amt}
                    <Button content="Change" ml={1} onClick={() => act('change_stack')} />
                  </Box>
                  {stacks.length === 0 ? (
                    <Box style={{ color: C.dim }}>No sheets stored.</Box>
                  ) : (
                    <LabeledList>
                      {stacks.map((stack, i) => (
                        <LabeledList.Item key={i} label={stack.name}>
                          {stack.amount}
                          <Button
                            content="Release"
                            ml={1}
                            onClick={() => act('release_stack', { stack: stack.ref })} />
                        </LabeledList.Item>
                      ))}
                    </LabeledList>
                  )}
                </Section>
              ) : null}

              {kind === 'generic' ? (
                <Section title="Processing" style={panelStyle}>
                  <Box style={{ color: C.dim }}>This machine has no configurable processing options.</Box>
                </Section>
              ) : null}
            </>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
