import { useBackend, useLocalState } from '../backend';
import { Box, Button, Input, LabeledList, Section } from '../components';
import { Window } from '../layouts';

const C = {
  bg: '#0a0a0c',
  panel: '#111114',
  border: '#2a2a30',
  amber: '#c2960e',
  text: '#c8c8c8',
  textDim: '#7a7a80',
  bad: '#d04040',
  mono: 'Consolas, monospace',
};

const inputStyle = {
  background: '#1a1a1e',
  color: C.text,
  border: '1px solid ' + C.border,
  fontFamily: C.mono,
};

export const ATM = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    screen = 0,
    machine_id,
    has_card,
    card_name,
    emagged,
    locked_down,
    security_required = 0,
    logged_in,
    owner_name,
    money = 0,
    suspended,
    security_level = 0,
    currency = '',
    transactions = [],
  } = data;

  const [accountNum, setAccountNum] = useLocalState(context, 'accountNum', '');
  const [accountPin, setAccountPin] = useLocalState(context, 'accountPin', '');
  const [transferTarget, setTransferTarget] = useLocalState(context, 'transferTarget', '');
  const [transferAmount, setTransferAmount] = useLocalState(context, 'transferAmount', '');
  const [transferPurpose, setTransferPurpose] = useLocalState(context, 'transferPurpose', 'Funds transfer');
  const [withdrawAmount, setWithdrawAmount] = useLocalState(context, 'withdrawAmount', '');

  return (
    <Window width={420} height={560}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.amber, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>AUTOMATIC TELLER</Box>
            <Box style={{ color: C.textDim, fontSize: '10px' }}>{machine_id}</Box>
          </Box>

          <Box mb={1}>
            {logged_in
              ? `Welcome ${owner_name}.`
              : 'Welcome. Please login below.'}
          </Box>

          <Section title="Card" style={{ border: '1px solid ' + C.border }}>
            {emagged ? (
              <Box style={{ color: C.bad }}>
                <Box style={{ fontWeight: 'bold' }}>LOCKED</Box>
                Unauthorized terminal access detected!
                <br />
                This ATM has been locked down.
              </Box>
            ) : (
              <Button
                icon="id-card"
                content={has_card ? card_name : 'No card inserted'}
                onClick={() => act('insert_card')} />
            )}
          </Section>

          {!emagged && locked_down ? (
            <Box mt={1} style={{ color: C.bad }}>
              Maximum number of pin attempts exceeded! Access to this ATM has been temporarily disabled.
            </Box>
          ) : null}

          {!emagged && !locked_down && logged_in && suspended ? (
            <Box mt={1} style={{ color: C.bad, fontWeight: 'bold' }}>
              Access to this account has been suspended, and the funds within frozen.
            </Box>
          ) : null}

          {!emagged && !locked_down && logged_in && !suspended && screen === 0 ? (
            <Section title="Account" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
              <LabeledList>
                <LabeledList.Item label="Balance">
                  {currency}{money}
                </LabeledList.Item>
              </LabeledList>

              <Box mt={1} style={{ color: C.textDim }}>WITHDRAWAL AMOUNT</Box>
              <Input
                fluid
                monospace
                value={withdrawAmount}
                placeholder="Amount"
                style={inputStyle}
                onInput={(e, value) => setWithdrawAmount(value)} />
              <Box mt={1}>
                <Button
                  inline
                  mr={0.5}
                  icon="money-bill-wave"
                  content="Withdraw Cash"
                  onClick={() => act('withdrawal', { funds_amount: withdrawAmount })} />
                <Button
                  inline
                  icon="credit-card"
                  content="Charge Card"
                  onClick={() => act('e_withdrawal', { funds_amount: withdrawAmount })} />
              </Box>

              <Box mt={1}>
                <Button
                  inline
                  mr={0.5}
                  icon="lock"
                  content="Change Security Level"
                  onClick={() => act('goto', { screen: 1 })} />
                <Button
                  inline
                  icon="exchange-alt"
                  content="Make Transfer"
                  onClick={() => act('goto', { screen: 2 })} />
              </Box>
              <Box mt={0.5}>
                <Button
                  inline
                  mr={0.5}
                  icon="list"
                  content="View Transaction Log"
                  onClick={() => act('goto', { screen: 3 })} />
                <Button
                  inline
                  icon="print"
                  content="Print Balance Statement"
                  onClick={() => act('balance_statement')} />
              </Box>

              <Box mt={1}>
                <Button
                  icon="sign-out"
                  content="Logout"
                  onClick={() => act('logout')} />
              </Box>
            </Section>
          ) : null}

          {!emagged && !locked_down && logged_in && !suspended && screen === 1 ? (
            <Section title="Account Security" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
              <Box mb={1} style={{ color: C.textDim }}>
                Select a new security level for this account.
              </Box>

              <Box mb={1}>
                <Button
                  inline
                  mr={0.5}
                  content="Minimum"
                  selected={security_level === 0}
                  onClick={() => act('change_security_level', { new_security_level: 0 })} />
                <Box inline style={{ color: security_level === 0 ? C.amber : C.textDim }}>
                  {security_level === 0
                    ? 'Minimum security set'
                    : 'Either the account number or card is required to access this account.'}
                </Box>
              </Box>

              <Box mb={1}>
                <Button
                  inline
                  mr={0.5}
                  content="Moderate"
                  selected={security_level === 1}
                  onClick={() => act('change_security_level', { new_security_level: 1 })} />
                <Box inline style={{ color: security_level === 1 ? C.amber : C.textDim }}>
                  {security_level === 1
                    ? 'Moderate security set'
                    : 'An account number and pin must be manually entered to access this account.'}
                </Box>
              </Box>

              <Box mb={1}>
                <Button
                  inline
                  mr={0.5}
                  content="Maximum"
                  selected={security_level === 2}
                  onClick={() => act('change_security_level', { new_security_level: 2 })} />
                <Box inline style={{ color: security_level === 2 ? C.bad : C.textDim }}>
                  {security_level === 2
                    ? 'Maximum security set'
                    : 'In addition to account number, a pin and a card is required to access this account.'}
                </Box>
              </Box>

              <Button
                icon="arrow-left"
                content="Back"
                onClick={() => act('goto', { screen: 0 })} />
            </Section>
          ) : null}

          {!emagged && !locked_down && logged_in && !suspended && screen === 2 ? (
            <Section title="Transfer Funds" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
              <LabeledList>
                <LabeledList.Item label="Balance">
                  {currency}{money}
                </LabeledList.Item>
              </LabeledList>

              <Box mt={1} style={{ color: C.textDim }}>TARGET ACCOUNT NUMBER</Box>
              <Input
                fluid
                monospace
                value={transferTarget}
                style={inputStyle}
                onInput={(e, value) => setTransferTarget(value)} />

              <Box mt={1} style={{ color: C.textDim }}>FUNDS TO TRANSFER</Box>
              <Input
                fluid
                monospace
                value={transferAmount}
                style={inputStyle}
                onInput={(e, value) => setTransferAmount(value)} />

              <Box mt={1} style={{ color: C.textDim }}>TRANSACTION PURPOSE</Box>
              <Input
                fluid
                monospace
                value={transferPurpose}
                style={inputStyle}
                onInput={(e, value) => setTransferPurpose(value)} />

              <Box mt={1}>
                <Button
                  inline
                  mr={0.5}
                  icon="exchange-alt"
                  content="Transfer Funds"
                  onClick={() => act('transfer', {
                    target_acc_number: transferTarget,
                    funds_amount: transferAmount,
                    purpose: transferPurpose,
                  })} />
                <Button
                  inline
                  icon="arrow-left"
                  content="Back"
                  onClick={() => act('goto', { screen: 0 })} />
              </Box>
            </Section>
          ) : null}

          {!emagged && !locked_down && logged_in && !suspended && screen === 3 ? (
            <Section title="Transaction Logs" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
              {transactions.length === 0 ? (
                <Box style={{ color: C.textDim }}>No transactions on record.</Box>
              ) : (
                transactions.map((trx, i) => (
                  <Box
                    key={i}
                    mb={0.5}
                    style={{ borderBottom: '1px solid ' + C.border, paddingBottom: '2px' }}>
                    <Box inline style={{ color: C.textDim }}>{trx.date} {trx.time}</Box>
                    {' — '}{trx.target} / {trx.purpose} / {currency}{trx.amount} [{trx.source}]
                  </Box>
                ))
              )}

              <Box mt={1}>
                <Button
                  inline
                  mr={0.5}
                  icon="print"
                  content="Print"
                  onClick={() => act('print_transaction')} />
                <Button
                  inline
                  icon="arrow-left"
                  content="Back"
                  onClick={() => act('goto', { screen: 0 })} />
              </Box>
            </Section>
          ) : null}

          {!emagged && !locked_down && !logged_in ? (
            <Section title="Login" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
              {security_required === 0 ? (
                <Box style={{ color: C.textDim }}>
                  To log in to your savings account, press 'Submit' with your ID clearly displayed.
                  If you wish to log into another account, please enter the account number into
                  the field below or insert a registered ID card into the slot above and then
                  press 'Submit'.
                </Box>
              ) : null}
              {security_required === 1 ? (
                <Box style={{ color: C.textDim }}>
                  This account requires a PIN to access. For security reasons the account # will
                  need re-entered or ID bound to this account re-scanned.
                </Box>
              ) : null}
              {security_required >= 2 ? (
                <Box style={{ color: C.bad, fontWeight: 'bold' }}>
                  Due to the security settings on this account, all information needs to be
                  re-entered and the ID bound to this account placed in the slot above.
                </Box>
              ) : null}

              <Box mt={1} style={{ color: C.textDim }}>ACCOUNT NUMBER</Box>
              <Input
                fluid
                monospace
                value={accountNum}
                style={inputStyle}
                onInput={(e, value) => setAccountNum(value)} />

              {security_required > 0 ? (
                <>
                  <Box mt={1} style={{ color: C.textDim }}>PIN</Box>
                  <Input
                    fluid
                    monospace
                    value={accountPin}
                    style={inputStyle}
                    onInput={(e, value) => setAccountPin(value)} />
                </>
              ) : null}

              <Box mt={1}>
                <Button
                  icon="sign-in"
                  content="Submit"
                  onClick={() => act('attempt_auth', {
                    account_num: accountNum,
                    account_pin: accountPin,
                  })} />
              </Box>
            </Section>
          ) : null}
        </Box>
      </Window.Content>
    </Window>
  );
};
