import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const SongEditor = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    lines,
    active_line,
    max_lines,
    max_line_length,
    tick_lag,
    show_help,
    page_num,
    page_offset,
  } = data;
  return (
    <Window width={550} height={600} resizable>
      <Window.Content scrollable>
        <Section title="Song Editor" buttons={
          <>
            <Button content="New Line" onClick={() => act('newline')} />
            <Button content="Help" selected={show_help} onClick={() => act('help', { value: show_help ? 0 : 1 })} />
          </>
        }>
          <Box mb={1}>
            Page {page_num} | Line {active_line} | Max Lines: {max_lines} | Max Line Length: {max_line_length}
          </Box>
          {lines.map((line, i) => (
            <Box key={i} mb={1}>
              <Button
                content="Delete"
                color="bad"
                onClick={() => act('deleteline', { value: page_offset + i + 1 })} />
              <Button
                content="Edit"
                onClick={() => act('modifyline', { value: page_offset + i + 1 })} />
              <Box inline ml={1}>{line}</Box>
            </Box>
          ))}
        </Section>
        <Section title="Navigation">
          <Button content="First" onClick={() => act('first_page')} />
          <Button content="Prev" onClick={() => act('prev_page')} />
          <Button content="Next" onClick={() => act('next_page')} />
          <Button content="Last" onClick={() => act('last_page')} />
        </Section>
      </Window.Content>
    </Window>
  );
};
