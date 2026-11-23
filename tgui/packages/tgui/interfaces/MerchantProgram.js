import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, NoticeBox, NumberInput } from '../components';
import { Window } from '../layouts';

export const MerchantProgram = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    temp,
    mode,
    last_comms,
    pad,
    bank,
    traderName,
    origin,
    hailed,
    trades,
  } = data;
  return (
    <Window width={575} height={700}>
      <Window.Content scrollable>
        {!!temp && (
          <NoticeBox>{temp}</NoticeBox>
        )}
        <Section title="Merchant List" buttons={
          <Box>
            <Button onClick={() => act('PRG_main_menu')}>Main Menu</Button>
            <Button onClick={() => act('PRG_merchant_list')}>Merchant List</Button>
          </Box>
        }>
          <LabeledList>
            <LabeledList.Item label="Pad">{pad ? "Connected" : "Not Connected"}</LabeledList.Item>
            <LabeledList.Item label="Bank">{bank}</LabeledList.Item>
          </LabeledList>
          <Button mt={1} onClick={() => act('PRG_connect_pad')}>Connect Pad</Button>
          <Button ml={1} onClick={() => act('PRG_transfer_to_bank')}>Transfer to Bank</Button>
          <Button ml={1} onClick={() => act('PRG_get_money')}>Withdraw Money</Button>
          <Button ml={1} onClick={() => act('PRG_test_fire')}>Test Fire</Button>
        </Section>
        {!!mode && traderName && (
          <Section title={traderName}>
            <Box color="label">Origin: {origin}</Box>
            {!!last_comms && <Box mt={1} color="notice">{last_comms}</Box>}
            <Box mt={1}>
              <Button onClick={() => act('PRG_scroll', { PRG_scroll: "left" })}>←</Button>
              <Button ml={1} onClick={() => act('PRG_scroll', { PRG_scroll: "right" })}>→</Button>
            </Box>
            {!hailed ? (
              <Button mt={1} fluid onClick={() => act('PRG_hail')}>Hail</Button>
            ) : (
              <Box mt={1}>
                <Button onClick={() => act('PRG_show_trades')}>Toggle Trades</Button>
                <Button ml={1} onClick={() => act('PRG_insult')}>Insult</Button>
                <Button ml={1} onClick={() => act('PRG_compliment')}>Compliment</Button>
                <Button ml={1} onClick={() => act('PRG_what_do_you_want')}>What Do You Want?</Button>
                <Button ml={1} onClick={() => act('PRG_sell_items')}>Sell Items</Button>
              </Box>
            )}
          </Section>
        )}
        {!!trades && trades.length > 0 && (
          <Section title="Trades">
            {trades.map((trade, i) => (
              <Box key={i} mb={1}>
                <Box>{trade}</Box>
                <Button mt={1} onClick={() => act('PRG_offer_item', { PRG_offer_item: i })}>Offer Item</Button>
                <Button ml={1} onClick={() => act('PRG_how_much_do_you_want', { PRG_how_much_do_you_want: i })}>How Much?</Button>
                <Button ml={1} onClick={() => act('PRG_offer_money_for_item', { PRG_offer_money_for_item: i })}>Offer Money</Button>
              </Box>
            ))}
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
