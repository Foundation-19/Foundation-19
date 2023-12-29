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

// TODO: timesort instead of type categories
const OffsitePage = (current_offsite_data) => {
  const {
    name,
    received_faxes = [],
    sent_faxes = [],
    received_messages = [],
    sent_messages = [],
  } = current_offsite_data;

  return (
    <Section>
      <h1>{name}</h1>
      <Tabs vertical>
        <Tabs.Tab
          selected={openDataTab === 0}
          onClick={() => setOpenDataTab(0)}>
          Faxes
        </Tabs.Tab>
        <Tabs.Tab
          selected={openDataTab === 1}
          onClick={() => setOpenDataTab(1)}>
          Messages
        </Tabs.Tab>
      </Tabs>
      {}
    </Section>
  );
};

const FaxSection = (received_faxes, sent_faxes) => {
  return (
    <Section>
      <h3>Received Faxes</h3>
      {received_faxes.map((fax_data = [], i) => {
        return (
          <Button key={i}>
            Received Fax from {fax_data[1]} at {fax_data[2]}
          </Button>
        );
      })}
    </Section>
  );
};
