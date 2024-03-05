import { Window } from '../layouts';
import { useBackend, useLocalState } from '../backend';
import { Section, Button, Tabs } from '../components';

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

const OffsitePage = (current_offsite_data = [], context) => {
  const { act, data } = useBackend(context);
  const name = current_offsite_data[0];
  const type = current_offsite_data[1];
  const comms_data = current_offsite_data[2];

  return (
    <Section>
      <h1>{name}</h1>
      {comms_data &&
        comms_data.map((c_data = [], i) => {
          return (
            <Button key={i}>
              {c_data[3]} {c_data[2]} at world time {c_data[0]}.
            </Button>
          );
        })}
      <Button onClick={() => act('send_fax', { id: type })}>Send fax</Button>
      <Button onClick={() => act('send_msg', { id: type })}>
        Send message
      </Button>
    </Section>
  );
};
