import { useBackend } from '../backend';
import { Box, Button, LabeledList, NoticeBox, ProgressBar, Section } from '../components';
import { Window } from '../layouts';

export const OrganPrinter = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    special_data,
    print_time,
    stored_matter,
    max_matter,
    printing,
    product_list,
  } = data;

  const matterPct = max_matter > 0 ? stored_matter / max_matter : 0;

  return (
    <Window width={550} height={700} resizable>
      <Window.Content scrollable>
        <Section title="Organ Printer">
          {special_data && (
            <Box mb={1} dangerouslySetInnerHTML={{ __html: special_data }} />
          )}
          <LabeledList>
            <LabeledList.Item label="Matter">
              <ProgressBar
                value={matterPct}
                content={stored_matter + "/" + max_matter} />
            </LabeledList.Item>
            <LabeledList.Item label="Print Time">
              {print_time <= 0 ? "Instant" : print_time + "s"}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Products">
          {printing && (
            <NoticeBox info>Currently printing. Please wait...</NoticeBox>
          )}
          {!printing && product_list && product_list.map((product, i) => (
            <Box key={i} mb={1}>
              <Button
                content={"Print " + product.parsed_name}
                disabled={!product.can_print}
                onClick={() => act('to_print', { to_print: product.product })} />
              <Box inline ml={1} color={product.can_print ? "label" : "bad"}>
                {stored_matter}/{product.req_matter}
                {!product.can_print && " [INSUFFICIENT]"}
              </Box>
            </Box>
          ))}
        </Section>
      </Window.Content>
    </Window>
  );
};
