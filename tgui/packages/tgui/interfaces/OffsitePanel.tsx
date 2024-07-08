import { useBackend, useLocalState } from '../backend';
import { Section, Button, Tabs, Flex, Collapsible, Box, BlockQuote } from '../components';
import { Window } from '../layouts';

type OffsiteHistoryItem = {
  time: number;
  ref: string;
  department: string;
  user: string;
}

type OffsiteInfo = {
  name: string;
  type: string;
  data: {[time: number] : OffsiteHistoryItem};
};

type Data = {
  offsites: OffsiteInfo[];
};

export const OffsitePanel = (props, context) => {
  const { act, data } = useBackend<Data>(context);
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
            {offsites.map((offsite_data, i) => {
              return (
                <Tabs.Tab
                  key={i}
                  selected={i === openOffsite}
                  onClick={() => setOpenOffsite(i)}>
                  {offsite_data.name}
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
  const { act } = useBackend(context);
  const current_offsite_data: OffsiteInfo = props.current_offsite_data;
  const name = current_offsite_data.name;
  const type = current_offsite_data.type;
  const comms_data = current_offsite_data.data;

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
