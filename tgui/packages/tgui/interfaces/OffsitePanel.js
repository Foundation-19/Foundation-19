import { Window } from '../layouts';
import { useBackend, useLocalState } from '../backend';
import { Section, Tabs } from '../components';

export const OffsitePanel = (props, context) => {
  const { act, data } = useBackend(context);
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

const OffsitePage = (current_offsite_data) => {
  const {
    name,
    recieved_fax = [],
    sent_faxes = [],
    recieved_messages = [],
    sent_messages = [],
  } = current_offsite_data;

  return (
    <Section>
      <h1>{name}</h1>
    </Section>
  );
};
