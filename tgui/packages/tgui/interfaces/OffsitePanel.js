import { Window } from '../layouts';
import { useBackend, useLocalState } from '../backend';
import { Section, Button, Tabs, Flex, Collapsible, Box, BlockQuote } from '../components';

export const OffsitePanel = (props, context) => {
  const { act, data } = useBackend(context);
  const [openDataTab, setOpenDataTab] = useLocalState(
    context,
    'openDataTab',
    0
  );
  const [openOffsite, setOpenOffsite] = useLocalState(
    context,
    'openOffsite',
    0
  );
  const { offsites = [] } = data;

  return (
    <Window title={'Offsite Panel'} theme="admin">
      <Window.Content Scrollable>
        <Section fitted>
          <Tabs horizontal>
            {offsites.map((offsite_data = [], i) => {
              return (
                <Tabs.Tab
                  key={i}
                  selected={i === openOffsite}
                  onClick={() => setOpenOffsite(i)}>
                  {offsite_data[0]}
                </Tabs.Tab>
              );
            })}
          </Tabs>
        </Section>
        <OffsitePage current_offsite_data={offsites[openOffsite]} />
      </Window.Content>
    </Window>
  );
};

const OffsitePage = (props, context) => {
  const { act, data } = useBackend(context);
  const current_offsite_data = props.current_offsite_data || [];
  const name = current_offsite_data[0];
  const type = current_offsite_data[1];
  const comms_data = current_offsite_data[2];

  return (
    <Section>
      <h1>{name}</h1>
      <Flex direction="column-reverse">
        {comms_data &&
          comms_data.map((c_data = [], i) => {
            const [ log_time, log_ref, log_dept, log_user, log_type, log_time_pretty ] = c_data;
            return (
              <Flex.Item>
                {log_type} {log_user} {log_dept ? "(department: " + log_dept + ") " : ""}at round time {log_time_pretty}
                <Box ml={2}>
                  {(log_type.indexOf("fax") > -1)
                    ? <Button onClick={() => act('read_fax', { id: type, fax: log_time, fax_type: log_type })}>Read</Button>
                    : <Collapsible title="Message Contents"><BlockQuote>{log_ref}</BlockQuote></Collapsible>
                  }
                </Box>
              </Flex.Item>
            );
          })}
      </Flex>
      <Box mt={2}>
        <Button onClick={() => act('send_fax', { id: type })}>Send fax</Button>
        <Button onClick={() => act('send_msg', { id: type })}>
          Send message
        </Button>
      </Box>
    </Section>
  );
};
