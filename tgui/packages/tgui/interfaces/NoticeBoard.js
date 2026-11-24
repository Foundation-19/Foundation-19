import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

const C = {
  bg: '#0a0a0c',
  panel: '#111114',
  border: '#2a2a30',
  borderRed: '#6b0000',
  amber: '#c2960e',
  text: '#c8c8c8',
  textDim: '#7a7a80',
  mono: 'Consolas, monospace',
};

export const NoticeBoard = (props, context) => {
  const { act, data } = useBackend(context);
  const { notices = [] } = data;

  return (
    <Window width={420} height={360}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.borderRed, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>NOTICE BOARD</Box>
          </Box>

          <Section title="Pinned Notices" style={{ border: '1px solid ' + C.border }}>
            {notices.length === 0 ? (
              <Box style={{ color: C.textDim }}>No notices pinned.</Box>
            ) : (
              <LabeledList>
                {notices.map((notice, i) => (
                  <LabeledList.Item key={i} label={notice.name}>
                    {notice.paper && (
                      <>
                        <Button
                          inline
                          mr={0.5}
                          content="Read"
                          onClick={() => act('read', { ref: notice.ref })} />
                        <Button
                          inline
                          mr={0.5}
                          content="Write"
                          onClick={() => act('write', { ref: notice.ref })} />
                      </>
                    )}
                    {notice.photo && (
                      <Button
                        inline
                        mr={0.5}
                        content="Look"
                        onClick={() => act('look', { ref: notice.ref })} />
                    )}
                    <Button
                      inline
                      mr={0.5}
                      content="Remove"
                      onClick={() => act('remove', { ref: notice.ref })} />
                  </LabeledList.Item>
                ))}
              </LabeledList>
            )}
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
