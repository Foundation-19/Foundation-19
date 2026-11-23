import { useBackend } from '../backend';
import { Box, Button, Flex, NoticeBox, Section } from '../components';
import { Window } from '../layouts';

const WarrantRow = (props, context) => {
  const { act } = useBackend(context);
  const { warrant } = props;
  return (
    <Flex align="center" mb={0.5}>
      <Box style={{ flex: 1 }}>
        <Box style={{ color: '#e8e8e8' }}>{warrant.warrantname || 'Unnamed warrant'}</Box>
        <Box style={{ color: '#6a6a70', fontSize: '10px' }}>{warrant.charges || 'No charges listed'}</Box>
      </Box>
      <Box mr={1} style={{ color: warrant.arrestsearch ? '#cc2222' : '#d4a017', fontSize: '10px' }}>
        {warrant.arrestsearch ? 'ARREST' : 'SEARCH'}
      </Box>
      <Button icon="folder-open" content="Open" onClick={() => act('editwarrant', { editwarrant: warrant.id })} />
      {warrant.archived ? (
        <Button icon="undo" content="Restore" onClick={() => act('restore', { restore: warrant.id })} />
      ) : (
        <Button icon="archive" content="Archive" onClick={() => act('sendtoarchive', { sendtoarchive: warrant.id })} />
      )}
    </Flex>
  );
};

export const DigitalWarrant = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    warrantname,
    warrantjob,
    warrantcharges,
    warrantauth,
    arrestwarrants = [],
    searchwarrants = [],
    archivedwarrants = [],
  } = data;

  const editing = warrantname !== undefined;

  return (
    <Window theme="scp_terminal" width={640} height={660}>
      <Window.Content scrollable>
        <Box style={{ background: '#0a0a0c', minHeight: '100%', padding: '10px', fontFamily: '"Consolas", monospace', color: '#c8c8c8' }}>
          <Box style={{ borderBottom: '2px solid #6b0000', paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: '#d4a017', letterSpacing: '0.15em', fontWeight: 'bold' }}>DIGITAL WARRANT CONSOLE</Box>
            <Box style={{ color: '#6a6a70', fontSize: '9px' }}>SECURITY DIRECTIVE MANAGEMENT</Box>
          </Box>

          {editing ? (
            <Section title="Warrant Editor" buttons={
              <Button icon="save" content="Save" color="good" onClick={() => act('savewarrant')} />
            }>
              <Box style={{ color: '#e8e8e8' }}>{warrantname}</Box>
              <Box style={{ color: '#6a6a70', fontSize: '10px' }}>{warrantjob}</Box>
              <Box mt={1}>{warrantcharges}</Box>
              <Box mt={1} style={{ color: warrantauth ? '#44ff44' : '#d4a017' }}>
                {warrantauth ? 'AUTHORIZED: ' + warrantauth : 'PENDING AUTHORIZATION'}
              </Box>
              <Box mt={2}>
                <Button icon="signature" content="Authorize" onClick={() => act('editwarrantname')} />
                <Button icon="print" content="Print" onClick={() => act('printwarrant')} />
                <Button icon="trash" content="Delete" color="bad" onClick={() => act('deletewarrant')} />
                <Button icon="arrow-left" content="Back" onClick={() => act('sw_menu')} />
              </Box>
            </Section>
          ) : (
            <Box>
              <Section title="Arrest Warrants" buttons={
                <Button icon="plus" content="New Warrant" color="good" onClick={() => act('addwarrant', { type: 'arrest' })} />
              }>
                {arrestwarrants.map((w, i) => <WarrantRow key={i} warrant={w} />)}
                {arrestwarrants.length === 0 ? <Box style={{ color: '#6a6a70' }}>No active arrest warrants.</Box> : null}
              </Section>
              <Section title="Search Warrants" buttons={
                <Button icon="plus" content="New Warrant" color="good" onClick={() => act('addwarrant', { type: 'search' })} />
              }>
                {searchwarrants.map((w, i) => <WarrantRow key={i} warrant={w} />)}
                {searchwarrants.length === 0 ? <Box style={{ color: '#6a6a70' }}>No active search warrants.</Box> : null}
              </Section>
              <Section title="Archived">
                {archivedwarrants.map((w, i) => <WarrantRow key={i} warrant={w} />)}
                {archivedwarrants.length === 0 ? <Box style={{ color: '#6a6a70' }}>Archive empty.</Box> : null}
              </Section>
            </Box>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
