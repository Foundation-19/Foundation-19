import { useBackend } from '../backend';
import { Box, Button, Flex, LabeledList, NoticeBox, Section } from '../components';
import { Window } from '../layouts';

const C = {
  bg: '#0a0a0c',
  border: '#2a2a30',
  borderRed: '#6b0000',
  amber: '#d4a017',
  text: '#c8c8c8',
  textDim: '#6a6a70',
  good: '#0a6e0a',
  red: '#cc2222',
  mono: '"Consolas", "Courier New", monospace',
};

export const Supply = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    screen,
    is_admin,
    credits,
    currency,
    currency_short,
    categories = [],
    category,
    possible_purchases = [],
    request_length,
    shopping_cart_length,
    contents_of_order,
    point_breakdown = [],
  } = data;

  return (
    <Window theme="scp_terminal" width={720} height={660}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.borderRed, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>CARGO SUPPLY TERMINAL</Box>
            <Box style={{ color: C.textDim, fontSize: '9px' }}>
              BALANCE: {credits} {currency}
              {is_admin ? (' | SHOPPING: ' + (shopping_cart_length || 0) + ' | REQUESTS: ' + (request_length || 0)) : ''}
            </Box>
          </Box>

          {screen === 1 ? (
            <Section title="Order Supplies" buttons={
              is_admin ? <Button icon="truck" content="Statistics" onClick={() => act('set_screen', { set_screen: 2 })} /> : null
            }>
              <Flex wrap="wrap" mb={1}>
                {categories.map((cat) => (
                  <Flex.Item key={cat} mr={0.5} mb={0.5}>
                    <Button content={cat} selected={category === cat} onClick={() => act('select_category', { select_category: cat })} />
                  </Flex.Item>
                ))}
              </Flex>
              {category ? (
                <Box>
                  {possible_purchases.map((pack) => (
                    <Flex key={pack.ref} align="center" mb={0.5}>
                      <Box style={{ flex: 1 }}>{pack.name}</Box>
                      <Box mr={1} style={{ color: C.amber }}>{pack.cost} {currency_short}</Box>
                      <Button icon="cart-plus" content="Order" onClick={() => act('order', { order: pack.ref })} />
                      <Button icon="info" content="Contents" onClick={() => act('show_contents', { show_contents: pack.ref })} />
                    </Flex>
                  ))}
                </Box>
              ) : (
                <Box style={{ color: C.textDim }}>Select a category to view available crates.</Box>
              )}
            </Section>
          ) : null}

          {screen === 2 ? (
            <Section title="Supply Statistics" buttons={
              <Button icon="arrow-left" content="Back" onClick={() => act('set_screen', { set_screen: 1 })} />
            }>
              <LabeledList>
                {point_breakdown.map((pb) => (
                  <LabeledList.Item key={pb.desc} label={pb.desc}>{pb.points}</LabeledList.Item>
                ))}
              </LabeledList>
            </Section>
          ) : null}

          {contents_of_order ? (
            <Section title="Crate Contents" buttons={
              <Button icon="times" content="Close" onClick={() => act('hide_contents')} />
            }>
              <Box dangerouslySetInnerHTML={{ __html: contents_of_order }} />
            </Section>
          ) : null}
        </Box>
      </Window.Content>
    </Window>
  );
};
