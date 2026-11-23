import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, Tabs } from '../components';
import { Window } from '../layouts';

export const LawManager = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    ion_law_nr,
    ion_law,
    zeroth_law,
    inherent_law,
    supplied_law,
    supplied_law_position,
    zeroth_laws,
    ion_laws,
    inherent_laws,
    supplied_laws,
    isAI,
    isMalf,
    isSlaved,
    isAdmin,
    view,
    channel,
    channels,
    law_sets,
    has_zeroth_laws,
    has_ion_laws,
    has_inherent_laws,
    has_supplied_laws,
  } = data;
  return (
    <Window width={800} height={isMalf ? 600 : 400}>
      <Window.Content scrollable>
        <Section title="Law Manager">
          <LabeledList>
            <LabeledList.Item label="Channel">
              {channels.map(ch => (
                <Button
                  key={ch.channel}
                  selected={ch.channel === channel}
                  onClick={() => act('law_channel', { law_channel: ch.channel })}
                >
                  {ch.channel}
                </Button>
              ))}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Current Laws" buttons={
          <Button onClick={() => act('notify_laws')}>
            Notify Laws
          </Button>
        }>
          <LabeledList>
            {!!has_zeroth_laws && zeroth_laws.map((law, i) => (
              <LabeledList.Item key={i} label={"Law " + law.index}>
                {law.law}
                <Button ml={1} icon={law.state ? "eye-slash" : "eye"} onClick={() => act('state_law', { ref: law.ref, state_law: law.state ? 0 : 1 })} />
                {!!isMalf && <Button ml={1} icon="pencil" onClick={() => act('edit_law', { edit_law: law.ref })} />}
                {!!isMalf && <Button ml={1} icon="trash" onClick={() => act('delete_law', { delete_law: law.ref })} />}
              </LabeledList.Item>
            ))}
            {!!has_ion_laws && ion_laws.map((law, i) => (
              <LabeledList.Item key={i} label={"Law " + law.index}>
                {law.law}
                <Button ml={1} icon={law.state ? "eye-slash" : "eye"} onClick={() => act('state_law', { ref: law.ref, state_law: law.state ? 0 : 1 })} />
                {!!isMalf && <Button ml={1} icon="pencil" onClick={() => act('edit_law', { edit_law: law.ref })} />}
                {!!isMalf && <Button ml={1} icon="trash" onClick={() => act('delete_law', { delete_law: law.ref })} />}
              </LabeledList.Item>
            ))}
            {!!has_inherent_laws && inherent_laws.map((law, i) => (
              <LabeledList.Item key={i} label={"Law " + law.index}>
                {law.law}
                <Button ml={1} icon={law.state ? "eye-slash" : "eye"} onClick={() => act('state_law', { ref: law.ref, state_law: law.state ? 0 : 1 })} />
                {!!isMalf && <Button ml={1} icon="pencil" onClick={() => act('edit_law', { edit_law: law.ref })} />}
                {!!isMalf && <Button ml={1} icon="trash" onClick={() => act('delete_law', { delete_law: law.ref })} />}
              </LabeledList.Item>
            ))}
            {!!has_supplied_laws && supplied_laws.map((law, i) => (
              <LabeledList.Item key={i} label={"Law " + law.index}>
                {law.law}
                <Button ml={1} icon={law.state ? "eye-slash" : "eye"} onClick={() => act('state_law', { ref: law.ref, state_law: law.state ? 0 : 1 })} />
                {!!isMalf && <Button ml={1} icon="pencil" onClick={() => act('edit_law', { edit_law: law.ref })} />}
                {!!isMalf && <Button ml={1} icon="trash" onClick={() => act('delete_law', { delete_law: law.ref })} />}
              </LabeledList.Item>
            ))}
          </LabeledList>
        </Section>
        {!!isMalf && (
          <Section title="Add Laws">
            <LabeledList>
              <LabeledList.Item label="Ion Law">
                <Button onClick={() => act('change_ion_law')}>Set: {ion_law || "Not Set"}</Button>
                <Button onClick={() => act('add_ion_law')}>Add</Button>
              </LabeledList.Item>
              {!!isAdmin && (
                <LabeledList.Item label="Zeroth Law">
                  <Button onClick={() => act('change_zeroth_law')}>Set: {zeroth_law || "Not Set"}</Button>
                  <Button onClick={() => act('add_zeroth_law')}>Add</Button>
                </LabeledList.Item>
              )}
              <LabeledList.Item label="Inherent Law">
                <Button onClick={() => act('change_inherent_law')}>Set: {inherent_law || "Not Set"}</Button>
                <Button onClick={() => act('add_inherent_law')}>Add</Button>
              </LabeledList.Item>
              <LabeledList.Item label="Supplied Law">
                <Button onClick={() => act('change_supplied_law')}>Set: {supplied_law || "Not Set"}</Button>
                <Button onClick={() => act('change_supplied_law_position')}>Position: {supplied_law_position}</Button>
                <Button onClick={() => act('add_supplied_law')}>Add</Button>
              </LabeledList.Item>
            </LabeledList>
          </Section>
        )}
        {!!law_sets && law_sets.length > 0 && (
          <Section title="Law Sets">
            {law_sets.map((set, i) => (
              <Box key={i} mb={1}>
                <Button onClick={() => act('transfer_laws', { transfer_laws: set.ref })}>
                  {set.name}
                </Button>
                <Button ml={1} onClick={() => act('state_law_set', { state_law_set: set.ref })}>
                  State
                </Button>
              </Box>
            ))}
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
