import { useBackend, useSharedState } from '../backend';
import { Box, Button, Flex, Input, LabeledList, NoticeBox, Section, Tabs } from '../components';
import { Window } from '../layouts';

const C = {
  bg: '#0a0a0c',
  panel: '#111114',
  border: '#2a2a30',
  borderRed: '#6b0000',
  amber: '#d4a017',
  text: '#c8c8c8',
  textDim: '#6a6a70',
  red: '#cc2222',
  mono: '"Consolas", "Courier New", monospace',
};

export const Records = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    message,
    all_records = [],
    creation,
    dnasearch,
    fingersearch,
    uid,
    fields = [],
    access,
    access_edit,
  } = data;
  const recordOpen = uid !== undefined && fields.length > 0;

  return (
    <Window theme="scp_terminal" width={700} height={600}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          {message ? (
            <NoticeBox style={{ marginBottom: '8px' }}>{message}</NoticeBox>
          ) : null}
          {recordOpen ? (
            <Box>
              <Section title={"RECORD #" + uid} buttons={
                <Box>
                  <Button icon="print" content="Print" onClick={() => act('print_active')} />
                  <Button icon="arrow-left" content="Back" onClick={() => act('clear_active')} />
                </Box>
              }>
                <Flex align="flex-start">
                  <Flex.Item width="130px">
                    <Box style={{ textAlign: 'center' }}>
                      <img src={"front_" + uid + ".png"} style={{ width: '96px', imageRendering: 'pixelated' }} />
                      <img src={"side_" + uid + ".png"} style={{ width: '96px', imageRendering: 'pixelated' }} />
                    </Box>
                  </Flex.Item>
                  <Flex.Item grow={1}>
                    <LabeledList>
                      {fields.map((f, i) => (
                        <LabeledList.Item key={i} label={f.name} buttons={
                          f.access_edit && f.can_edit ? (
                            <Button icon="pen" content="Edit" onClick={() => act('edit_field', { edit_field: f.ID })} />
                          ) : null
                        }>
                          {f.ignore_value ? null : (f.value || '—')}
                        </LabeledList.Item>
                      ))}
                    </LabeledList>
                  </Flex.Item>
                </Flex>
              </Section>
            </Box>
          ) : (
            <Box>
              <Section title="CREW RECORDS — SEARCH" buttons={
                <Box>
                  {dnasearch ? <Button icon="dna" content="DNA" onClick={() => act('search', { search: 'DNA' })} /> : null}
                  {fingersearch ? <Button icon="fingerprint" content="Fingerprint" onClick={() => act('search', { search: 'Fingerprint' })} /> : null}
                  {creation ? <Button icon="plus" content="New Record" color="good" onClick={() => act('new_record')} /> : null}
                </Box>
              }>
                <SearchControls />
                <LabeledList>
                  {all_records.map((r) => (
                    <LabeledList.Item key={r.id} label={r.rank || '—'} buttons={
                      <Button content="Open" icon="folder-open" onClick={() => act('set_active', { set_active: r.id })} />
                    }>
                      {r.name}
                    </LabeledList.Item>
                  ))}
                  {all_records.length === 0 ? <Box color={C.textDim}>No records found.</Box> : null}
                </LabeledList>
              </Section>
            </Box>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};

const SearchControls = (props, context) => {
  const { act } = useBackend(context);
  const [name, setName] = useSharedState(context, 'records_search_name', '');
  return (
    <Flex mb={1}>
      <Flex.Item mr={1} grow={1}>
        <Input placeholder="Search by name..." value={name} onChange={(e, v) => setName(v)} style={{ width: '100%' }} />
      </Flex.Item>
      <Flex.Item>
        <Button icon="search" content="Search" onClick={() => act('search', { search: 'Name', value: name })} />
      </Flex.Item>
    </Flex>
  );
};
