import { useBackend } from '../backend';
import { Box, Button, LabeledList, NoticeBox, Section } from '../components';
import { Window } from '../layouts';

export const VendingMachine = (props, context) => {
  const { act, data } = useBackend(context);
  const { mode, product, price, message, message_err, products = [], coin, panel, speaker } = data;

  return (
    <Window width={440} height={600} resizable>
      <Window.Content scrollable>
        {mode === 0 && (
          <ProductListing
            products={products}
            coin={coin}
            onVend={(key) => act('vend', { key })}
            onRemoveCoin={() => act('remove_coin')} />
        )}
        {mode === 1 && (
          <PaymentScreen
            product={product}
            price={price}
            message={message}
            message_err={message_err}
            onCancel={() => act('cancel_purchase')} />
        )}
        {!!panel && (
          <Section title="Maintenance Panel">
            <Button
              fluid
              icon={speaker ? 'volume-up' : 'volume-mute'}
              content={speaker ? 'Speaker Enabled' : 'Speaker Disabled'}
              selected={speaker}
              onClick={() => act('toggle_voice')} />
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};

const ProductListing = (props, context) => {
  const { products, coin, onVend, onRemoveCoin } = props;

  return (
    <Box>
      <Section title="Items Available">
        {products.length === 0 && (
          <Box color="label">No items available!</Box>
        )}
        {products.map((item) => (
          <Box key={item.key} mb={1}>
            <Button
              fluid
              disabled={item.amount <= 0}
              onClick={() => onVend(item.key)}>
              <Box inline
                color={item.color || undefined}
                bold={item.amount <= 0}>
                {item.name}
              </Box>
              {' '}
              <Box inline color="label">
                ({item.amount > 0 ? item.amount : 'NONE LEFT'})
              </Box>
              {item.price > 0 && (
                <Box inline color="gold" ml={2}>
                  {item.price} cr
                </Box>
              )}
              {item.price <= 0 && (
                <Box inline color="good" ml={2}>
                  Vend
                </Box>
              )}
            </Button>
          </Box>
        ))}
      </Section>
      {!!coin && (
        <Section title="Coin">
          <Button
            fluid
            icon="eject"
            content={`Eject ${coin}`}
            onClick={() => onRemoveCoin()} />
        </Section>
      )}
    </Box>
  );
};

const PaymentScreen = (props, context) => {
  const { product, price, message, message_err, onCancel } = props;

  return (
    <Section title="Item Selected">
      <LabeledList>
        <LabeledList.Item label="Item">
          {product}
        </LabeledList.Item>
        <LabeledList.Item label="Charge">
          {price} cr
        </LabeledList.Item>
      </LabeledList>
      {message && (
        <NoticeBox mt={1} danger={!!message_err}>
          {message}
        </NoticeBox>
      )}
      <Button
        fluid
        mt={1}
        icon="arrow-left"
        content="Cancel"
        onClick={() => onCancel()} />
    </Section>
  );
};
