import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, Flex, NoticeBox } from '../components';
import { Window } from '../layouts';

export const Uplink = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    welcome,
    crystals,
    menu,
    discount_category,
    discount_name,
    discount_amount,
    offer_expiry,
    categories = [],
    items = [],
    exploit_records = [],
    exploit,
    exploit_exists,
  } = data;

  return (
    <Window width={450} height={600} resizable>
      <Window.Content scrollable>
        <Section title={welcome}>
          <LabeledList>
            <LabeledList.Item label="Telecrystals">
              {crystals}
            </LabeledList.Item>
          </LabeledList>
          {!!discount_name && (
            <NoticeBox mt={1}>
              Limited Offer: {discount_name} ({discount_category}) - {discount_amount}% off! Expires at {offer_expiry}
            </NoticeBox>
          )}
          <Box mt={1}>
            <Button
              icon="lock"
              content="Lock Uplink"
              color="bad"
              onClick={() => act('lock')} />
          </Box>
        </Section>
        {menu === 0 && (
          <Section title="Categories">
            {categories.map(cat => (
              <Button
                key={cat.ref}
                content={cat.name}
                onClick={() => act('menu', { menu: 1, category: cat.ref })} />
            ))}
            <Box mt={1}>
              <Button
                content="Exploit Records"
                onClick={() => act('menu', { menu: 2 })} />
            </Box>
          </Section>
        )}
        {menu === 1 && (
          <Section title="Items">
            <Button
              icon="arrow-left"
              content="Back"
              onClick={() => act('return')} />
            {items.map(item => (
              <Box key={item.ref} mt={1}>
                <LabeledList>
                  <LabeledList.Item label={item.name}>
                    {item.description}
                  </LabeledList.Item>
                </LabeledList>
                <Box mt={0.5}>
                  <Button
                    content={`Buy (${item.cost} TC)`}
                    disabled={!item.can_buy}
                    onClick={() => act('buy_item', { buy_item: item.ref })} />
                </Box>
              </Box>
            ))}
          </Section>
        )}
        {menu === 2 && (
          <Section title="Exploit Records">
            <Button
              icon="arrow-left"
              content="Back"
              onClick={() => act('return')} />
            {exploit_records.map(record => (
              <Button
                key={record.id}
                content={record.Name}
                onClick={() => act('menu', { menu: 21, id: record.id })} />
            ))}
          </Section>
        )}
        {menu === 21 && (
          <Section title="Exploit Record">
            <Button
              icon="arrow-left"
              content="Back"
              onClick={() => act('menu', { menu: 2 })} />
            {exploit_exists ? (
              <Box mt={1} dangerouslySetInnerHTML={{ __html: exploit }} />
            ) : (
              <Box color="bad" mt={1}>No exploit data found.</Box>
            )}
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
