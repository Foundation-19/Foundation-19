import { useBackend } from '../backend';
import { Box, Button, Flex, LabeledList, NoticeBox, Section } from '../components';
import { Window } from '../layouts';
import { ProgramExitButtons } from './common/ProgramExitButtons';

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
  const showExit = data && data.PC_showexitprogram;

  return (
    <Window theme="scp_terminal" width={720} height={660} buttons={showExit ? <ProgramExitButtons act={act} /> : undefined}>
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
              is_admin ? (
                <Box>
                  <Button icon="truck" content="Shuttle" mr={0.5} onClick={() => act('set_screen', { set_screen: 3 })} />
                  <Button icon="tasks" content="Statistics" mr={0.5} onClick={() => act('set_screen', { set_screen: 2 })} />
                  <Button icon="clipboard-list" content="Orders" onClick={() => act('set_screen', { set_screen: 4 })} />
                </Box>
              ) : null
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

          {screen === 3 ? (
            <Section title="Supply Shuttle Control" buttons={
              <Button icon="arrow-left" content="Back" onClick={() => act('set_screen', { set_screen: 1 })} />
            }>
              <LabeledList>
                <LabeledList.Item label="Shuttle">{data.shuttle_name || 'Unknown'}</LabeledList.Item>
                <LabeledList.Item label="Location">{data.shuttle_location || 'Unknown'}</LabeledList.Item>
                <LabeledList.Item label="Status">{data.shuttle_status || 'Unknown'}</LabeledList.Item>
              </LabeledList>
              <Button
                mt={1}
                icon="truck"
                content="Launch Shuttle"
                disabled={!data.shuttle_can_control || !is_admin}
                onClick={() => act('launch_shuttle')} />
            </Section>
          ) : null}

          {screen === 4 && is_admin ? (
            <Section title="Order Processing" buttons={
              <Button icon="arrow-left" content="Back" onClick={() => act('set_screen', { set_screen: 1 })} />
            }>
              <Section title={`Pending Requests (${(data.requests || []).length})`}>
                {(data.requests || []).length === 0 ? (
                  <Box style={{ color: C.textDim }}>No pending requests.</Box>
                ) : (
                  (data.requests || []).map((order) => (
                    <Box key={order.id} mb={0.5} style={{ borderBottom: `1px solid ${C.border}`, paddingBottom: '4px' }}>
                      <Box style={{ display: 'inline-block', width: '72%' }}>
                        <Box>#{order.id} — {order.object}</Box>
                        <Box style={{ color: C.textDim, fontSize: '10px' }}>by {order.orderer}</Box>
                      </Box>
                      <Box inline>
                        <Button
                          icon="check"
                          content="Approve"
                          color="good"
                          mr={0.5}
                          onClick={() => act('approve_order', { approve_order: order.id })} />
                        <Button
                          icon="times"
                          content="Deny"
                          color="bad"
                          onClick={() => act('deny_order', { deny_order: order.id })} />
                      </Box>
                    </Box>
                  ))
                )}
              </Section>
              <Section title={`Ordered — Awaiting Delivery (${(data.cart || []).length})`}>
                {(data.cart || []).length === 0 ? (
                  <Box style={{ color: C.textDim }}>Nothing ordered yet.</Box>
                ) : (
                  (data.cart || []).map((order) => (
                    <Box key={order.id} mb={0.5} style={{ borderBottom: `1px solid ${C.border}`, paddingBottom: '4px' }}>
                      <Box style={{ display: 'inline-block', width: '72%' }}>
                        <Box>#{order.id} — {order.object}</Box>
                        <Box style={{ color: C.textDim, fontSize: '10px' }}>by {order.orderer}</Box>
                      </Box>
                      <Box inline>
                        <Button
                          icon="undo"
                          content="Cancel"
                          onClick={() => act('cancel_order', { cancel_order: order.id })} />
                        <Button
                          icon="print"
                          content="Receipt"
                          onClick={() => act('print_receipt', { print_receipt: order.id, list_id: order.list_id })} />
                      </Box>
                    </Box>
                  ))
                )}
              </Section>
              <Section title={`Delivered (${(data.done || []).length})`}>
                {(data.done || []).length === 0 ? (
                  <Box style={{ color: C.textDim }}>Nothing delivered yet.</Box>
                ) : (
                  (data.done || []).map((order) => (
                    <Box key={order.id} mb={0.5}>
                      <Box style={{ display: 'inline-block', width: '72%' }}>
                        <Box>#{order.id} — {order.object}</Box>
                        <Box style={{ color: C.textDim, fontSize: '10px' }}>by {order.orderer}</Box>
                      </Box>
                      <Box inline>
                        <Button
                          icon="print"
                          content="Receipt"
                          onClick={() => act('print_receipt', { print_receipt: order.id, list_id: order.list_id })} />
                        <Button
                          icon="trash"
                          content="Delete"
                          color="bad"
                          onClick={() => act('delete_order', { delete_order: order.id })} />
                      </Box>
                    </Box>
                  ))
                )}
              </Section>
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
