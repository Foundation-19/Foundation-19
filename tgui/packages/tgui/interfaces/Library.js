import { useBackend } from '../backend';
import { Box, Button, Flex, NoticeBox, Section } from '../components';
import { Window } from '../layouts';

export const Library = (props, context) => {
  const { act, data } = useBackend(context);
  const { error, current_book, all_entries = [], sort_by } = data;

  return (
    <Window theme="scp_terminal" width={640} height={660}>
      <Window.Content scrollable>
        <Box style={{ background: '#0a0a0c', minHeight: '100%', padding: '10px', fontFamily: '"Consolas", monospace', color: '#c8c8c8' }}>
          <Box style={{ borderBottom: '2px solid #6b0000', paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: '#d4a017', letterSpacing: '0.15em', fontWeight: 'bold' }}>EXTERNAL ARCHIVE</Box>
            <Box style={{ color: '#6a6a70', fontSize: '9px' }}>SCiPNET LIBRARY PROGRAM</Box>
          </Box>

          {error ? (
            <NoticeBox danger>{error}</NoticeBox>
          ) : current_book ? (
            <Section title={current_book.title || 'Untitled'} buttons={
              <Box>
                <Button icon="print" content="Print" onClick={() => act('printbook')} />
                <Button icon="arrow-left" content="Back" onClick={() => act('closebook')} />
              </Box>
            }>
              <Box style={{ color: '#6a6a70', mb: 1 }}>by {current_book.author || 'Unknown'}</Box>
              <Box dangerouslySetInnerHTML={{ __html: current_book.content }} />
            </Section>
          ) : (
            <Section title="Archive Catalogue" buttons={
              <Box>
                <Button content="Sort: ID" selected={sort_by === 'id'} onClick={() => act('sortby', { sortby: 'id' })} />
                <Button content="Sort: Title" selected={sort_by === 'title'} onClick={() => act('sortby', { sortby: 'title' })} />
                <Button content="Sort: Author" selected={sort_by === 'author'} onClick={() => act('sortby', { sortby: 'author' })} />
                <Button icon="rotate" content="Refresh" onClick={() => act('reseterror')} />
              </Box>
            }>
              {all_entries.map((book) => (
                <Flex key={book.id} align="center" mb={0.5}>
                  <Box style={{ flex: 1 }}>
                    <Box inline style={{ color: '#e8e8e8' }}>{book.title}</Box>
                    <Box inline ml={1} style={{ color: '#6a6a70' }}>by {book.author}</Box>
                  </Box>
                  <Button icon="book-open" content="Read" onClick={() => act('viewbook', { id: book.id })} />
                </Flex>
              ))}
              {all_entries.length === 0 ? <Box style={{ color: '#6a6a70' }}>Archive empty or unreachable.</Box> : null}
            </Section>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
