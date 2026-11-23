import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const BodyScanDisplay = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    scans,
    selected,
    scan_header,
    scan_health,
    scan_body,
  } = data;

  return (
    <Window width={600} height={800} resizable>
      <Window.Content scrollable>
        <Section title="Stored Scans">
          {(!scans || scans.length === 0) && (
            <Box color="label">No scans stored.</Box>
          )}
          {scans && scans.map((_, i) => (
            <Box key={i} mb={1}>
              <Button
                content={"Scan " + (i + 1)}
                selected={selected === i + 1}
                onClick={() => act('view', { view: i + 1 })} />
              <Button
                icon="trash"
                color="bad"
                content="Delete"
                onClick={() => act('delete', { delete: i + 1 })} />
            </Box>
          ))}
        </Section>
        {selected > 0 && (
          <Section title="Scan Details">
            <Box dangerouslySetInnerHTML={{ __html: scan_header }} />
            <Box dangerouslySetInnerHTML={{ __html: scan_health }} />
            <Box dangerouslySetInnerHTML={{ __html: scan_body }} />
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
