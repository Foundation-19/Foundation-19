import { useBackend, useLocalState } from '../backend';
import { Box, Button, Input, LabeledList, Section } from '../components';
import { Window } from '../layouts';
import { ProgramExitButtons } from './common/ProgramExitButtons';

type TaxData = {
  authenticated: boolean;
  PC_showexitprogram: number;
};

const C = {
  bg: '#0a0a0c',
  border: '#2a2a30',
  borderRed: '#6b0000',
  amber: '#d4a017',
  text: '#c8c8c8',
  textDim: '#6a6a70',
  good: '#0a6e0a',
  mono: '"Consolas", "Courier New", monospace',
};

export const TaxQuickly = (props, context) => {
  const { act, data } = useBackend<TaxData>(context);
  const { authenticated = false } = data;
  const showExit = data && data.PC_showexitprogram;
  const [code, setCode] = useLocalState<string>(context, 'tax_code', '');
  const [deductions, setDeductions] = useLocalState<string>(
    context,
    'tax_deductions',
    ''
  );
  const [field2, setField2] = useLocalState<string>(
    context,
    'tax_field2',
    ''
  );

  return (
    <Window
      theme="scp_terminal"
      width={480}
      height={420}
      buttons={showExit ? <ProgramExitButtons act={act} /> : undefined}
    >
      <Window.Content scrollable>
        <Box
          style={{
            background: C.bg,
            minHeight: '100%',
            padding: '10px',
            fontFamily: C.mono,
            color: C.text,
          }}
        >
          <Box
            style={{
              borderBottom: '2px solid ' + C.borderRed,
              paddingBottom: '6px',
              marginBottom: '10px',
            }}
          >
            <Box
              style={{
                color: C.amber,
                letterSpacing: '0.15em',
                fontWeight: 'bold',
              }}
            >
              TAXQUICKLY 1.45b
            </Box>
            <Box style={{ color: C.textDim, fontSize: '9px' }}>
              ONLINE TAX FILING SOLUTION — GET YOUR REFUND IN MINUTES
            </Box>
          </Box>

          {authenticated ? (
            <Section title="Welcome Back">
              <Box mb={2} style={{ color: C.text }}>
                Your session is still active. Resume your filing, or close
                and secure the connection.
              </Box>
              <LabeledList>
                <LabeledList.Item label="Status">
                  <Box style={{ color: C.good }}>AUTHENTICATED</Box>
                </LabeledList.Item>
              </LabeledList>
              <Box mt={2}>
                <Button
                  icon="play"
                  content="Resume"
                  color="good"
                  mr={1}
                  onClick={() => act('resume')}
                />
                <Button
                  icon="lock"
                  content="Close and Secure"
                  onClick={() => act('secure')}
                />
              </Box>
            </Section>
          ) : (
            <Section title="Authenticate">
              <Box mb={2} style={{ color: C.textDim, fontSize: '10px' }}>
                Welcome to TaxQuickly 1.45b — the galaxy's leading tax
                preparation suite. Please enter your unique tax ID to
                continue your session.
              </Box>
              <LabeledList>
                <LabeledList.Item label="Tax ID">
                  <Input
                    value={code}
                    onInput={(e, value) => setCode(value || '')}
                    style={{
                      background: C.bg,
                      color: C.text,
                      fontFamily: C.mono,
                      border: `1px solid ${C.border}`,
                      padding: '4px 6px',
                    }}
                  />
                </LabeledList.Item>
                <LabeledList.Item label="Deductions">
                  <Input
                    value={deductions}
                    onInput={(e, value) => setDeductions(value || '')}
                    style={{
                      background: C.bg,
                      color: C.text,
                      fontFamily: C.mono,
                      border: `1px solid ${C.border}`,
                      padding: '4px 6px',
                    }}
                  />
                </LabeledList.Item>
                <LabeledList.Item label="Dependents">
                  <Input
                    value={field2}
                    onInput={(e, value) => setField2(value || '')}
                    style={{
                      background: C.bg,
                      color: C.text,
                      fontFamily: C.mono,
                      border: `1px solid ${C.border}`,
                      padding: '4px 6px',
                    }}
                  />
                </LabeledList.Item>
              </LabeledList>
              <Box mt={2}>
                <Button
                  icon="file-invoice-dollar"
                  content="File Taxes"
                  color="good"
                  onClick={() => act('submit_code', { code })}
                />
              </Box>
              <Box mt={2} style={{ color: C.textDim, fontSize: '9px' }}>
                TaxQuickly is a registered trademark. Not affiliated with
                any government, Foundation, or insurgency.
              </Box>
            </Section>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
