import { useBackend } from '../backend';
import { Box, Button, LabeledList, NoticeBox, Section } from '../components';
import { Window } from '../layouts';

export const BodyScanner = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    scanEnabled,
    isCompatible,
    scan,
    html_scan_header,
    html_scan_health,
    html_scan_body,
    printEnabled,
    eraseEnabled,
    pushEnabled,
  } = data;

  return (
    <Window width={600} height={800} resizable>
      <Window.Content scrollable>
        <Section title="Body Scanner">
          <Button
            icon="search"
            content="Scan"
            disabled={!scanEnabled || !isCompatible}
            onClick={() => act('scan')} />
          <Button
            icon="print"
            content="Print"
            disabled={!printEnabled}
            onClick={() => act('print')} />
          <Button
            icon="share"
            content="Send to Displays"
            disabled={!pushEnabled}
            onClick={() => act('push')} />
          <Button
            icon="trash"
            content="Erase"
            disabled={!eraseEnabled}
            onClick={() => act('erase')} />
          {!isCompatible && scanEnabled && (
            <NoticeBox mt={1}>The body scanner cannot scan that lifeform.</NoticeBox>
          )}
        </Section>
        {scan && (
          <Section title="Scan Results">
            <Box dangerouslySetInnerHTML={{ __html: html_scan_header }} />
            <Box dangerouslySetInnerHTML={{ __html: html_scan_health }} />
            <Box dangerouslySetInnerHTML={{ __html: html_scan_body }} />
          </Section>
        )}
        {!scan && (
          <Section title="Scan Results">
            <Box color="label" textAlign="center" fontSize="16px">
              No scan loaded.
            </Box>
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
