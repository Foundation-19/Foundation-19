import { Window } from '../layouts';
import { useBackend, useLocalState } from '../backend';
import { Section, Button, Tabs, Flex, Collapsible, Box } from '../components';

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
            return (
              <Flex.Item>
                {c_data[4]} {c_data[3]} {c_data[2] ? "(department: " + c_data[2] + " " : ""}at world time {c_data[0]}
                <Box ml={2}>
                  {(c_data[4].indexOf("fax") > -1)
                    ? <Button onClick={() => act('read_fax', { id: type, fax: c_data[0], fax_type: c_data[4] })}>Read</Button>
                    : <Collapsible title="Message Contents">{c_data[1]}</Collapsible>
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
