import { useBackend, useLocalState } from '../backend';
import { Box, Button, LabeledList, Section, NumberInput, Flex, NoticeBox } from '../components';
import { Window } from '../layouts';

export const AccountsDB = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    id_inserted,
    id_card,
    access_level,
    machine_id,
    creating_new_account,
    detailed_account_view,
    station_account_number,
    accounts = [],
    account_number,
    owner_name,
    money,
    suspended,
    transactions = [],
  } = data;

  const [holderName, setHolderName] = useLocalState(context, 'holderName', '');
  const [startingFunds, setStartingFunds] = useLocalState(context, 'startingFunds', 0);

  return (
    <Window width={400} height={640} resizable>
      <Window.Content scrollable>
        <Section title="Terminal">
          <LabeledList>
            <LabeledList.Item label="Terminal ID">
              {machine_id}
            </LabeledList.Item>
            <LabeledList.Item label="Station Account">
              #{station_account_number}
            </LabeledList.Item>
            <LabeledList.Item label="ID Card">
              <Button
                content={id_inserted ? id_card : '-----'}
                icon="id-card"
                onClick={() => act('insert_card')} />
            </LabeledList.Item>
            <LabeledList.Item label="Access Level">
              {access_level ? `Level ${access_level}` : 'None'}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        {creating_new_account ? (
          <Section title="Create Account">
            <LabeledList>
              <LabeledList.Item label="Holder Name">
                <Button
                  content={holderName || 'Enter Name...'}
                  onClick={() => setHolderName(prompt('Enter holder name:', '') || holderName)} />
              </LabeledList.Item>
              <LabeledList.Item label="Starting Funds">
                <NumberInput
                  value={startingFunds}
                  minValue={0}
                  maxValue={1000000}
                  step={100}
                  stepPixelSize={3}
                  width="100px"
                  onChange={(e, value) => setStartingFunds(value)} />
              </LabeledList.Item>
            </LabeledList>
            <Box mt={1}>
              <Button
                content="Create"
                icon="check"
                disabled={!holderName}
                onClick={() => act('finalise_create_account', { holder_name: holderName, starting_funds: startingFunds })} />
              <Button
                content="Cancel"
                onClick={() => act('view_accounts_list')} />
            </Box>
          </Section>
        ) : detailed_account_view ? (
          <Section title={`Account #${account_number}`}>
            <LabeledList>
              <LabeledList.Item label="Owner">
                {owner_name}
              </LabeledList.Item>
              <LabeledList.Item label="Balance">
                ${money}
              </LabeledList.Item>
              <LabeledList.Item label="Status">
                <Button
                  content={suspended ? 'Suspended' : 'Active'}
                  color={suspended ? 'bad' : 'good'}
                  onClick={() => act('toggle_suspension')} />
              </LabeledList.Item>
            </LabeledList>
            <Box mt={1}>
              <Button
                icon="arrow-left"
                content="Back"
                onClick={() => act('view_accounts_list')} />
              <Button
                icon="print"
                content="Print"
                onClick={() => act('print')} />
              <Button
                icon="money-bill-wave"
                content="Revoke Payroll"
                color="bad"
                onClick={() => act('revoke_payroll')} />
            </Box>
            {transactions.length > 0 && (
              <Section title="Transactions" mt={1}>
                <LabeledList>
                  {transactions.map((trx, i) => (
                    <LabeledList.Item key={i} label={trx.date + ' ' + trx.time}>
                      {trx.target_name} - {trx.purpose} (${trx.amount}) [{trx.source_terminal}]
                    </LabeledList.Item>
                  ))}
                </LabeledList>
              </Section>
            )}
          </Section>
        ) : (
          <Section title="Accounts">
            <Box mb={1}>
              <Button
                icon="plus"
                content="New Account"
                onClick={() => act('create_account')} />
              <Button
                icon="print"
                content="Print List"
                onClick={() => act('print')} />
            </Box>
            {accounts.map(acc => (
              <Box key={acc.account_index} mb={0.5}>
                <Button
                  content={`#${acc.account_number} - ${acc.owner_name} ${acc.suspended}`}
                  onClick={() => act('view_account_detail', { account_index: acc.account_index })} />
              </Box>
            ))}
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
