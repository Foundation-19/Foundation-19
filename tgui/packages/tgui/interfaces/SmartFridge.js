import { useBackend } from '../backend';
import { Box, Button, Section, NoticeBox } from '../components';
import { Window } from '../layouts';

export const SmartFridge = (props, context) => {
  const { act, data } = useBackend(context);
  const { contents, secure, locked } = data;

  return (
    <Window width={400} height={500} resizable>
      <Window.Content scrollable>
        {secure && (
          <NoticeBox info>
            {locked === -1
              ? "Sec.re ACC_** //):securi_nt.diag=>##'or 1=1'%($..."
              : "Secure Access: Please have your identification ready."}
          </NoticeBox>
        )}
        <Section title="Storage">
          {!contents ? (
            <Box color="average">No products loaded.</Box>
          ) : (
            contents.map((item) => (
              <Box key={item.vend} mb={1}>
                <Box inline bold mr={1}>
                  {item.display_name}
                </Box>
                <Box inline color="label" mr={2}>
                  ({item.quantity} available)
                </Box>
                <Button
                  inline
                  content="x1"
                  onClick={() => act('vend', { vend: item.vend, amount: 1 })} />
                {item.quantity >= 5 && (
                  <Button
                    inline
                    content="x5"
                    onClick={() => act('vend', { vend: item.vend, amount: 5 })} />
                )}
                {item.quantity >= 10 && (
                  <Button
                    inline
                    content="x10"
                    onClick={() => act('vend', { vend: item.vend, amount: 10 })} />
                )}
                {item.quantity >= 25 && (
                  <Button
                    inline
                    content="x25"
                    onClick={() => act('vend', { vend: item.vend, amount: 25 })} />
                )}
                {item.quantity > 1 && (
                  <Button
                    inline
                    content="All"
                    onClick={() => act('vend', { vend: item.vend, amount: item.quantity })} />
                )}
              </Box>
            ))
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
