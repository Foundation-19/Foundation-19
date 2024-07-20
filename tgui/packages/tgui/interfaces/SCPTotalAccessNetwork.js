import { round } from 'common/math';
import { useBackend } from '../backend';
import { Button, Section, Box, Flex, ProgressBar, Icon } from '../components';
import { NtosWindow } from '../layouts';

export const SCPTotalAccessNetwork = (props, context) => {
  const { act, data } = useBackend(context);
  const { device_id, device_files = [], PC_device_theme } = data;

  let body = <FindDevice />;

  if (device_id) {
    if (device_files.length) {
      body = <HackingFromDevice />;
    } else {
      body = <WaitingForDevice />;
    }
  }

  return (
    <NtosWindow resizable theme={PC_device_theme}>
      <NtosWindow.Content scrollable>{body}</NtosWindow.Content>
    </NtosWindow>
  );
};

const FindDevice = (props, context) => {
  const { act, data } = useBackend(context);

  return (
    <Section>
      <Button.Input
        content={'Enter Device Network ID:'}
        onCommit={(e, value) =>
          act('PRG_entered_id', {
            net_id: value,
          })
        }
      />
    </Section>
  );
};

const WaitingForDevice = (props, context) => {
  const { act, data } = useBackend(context);
  const { device_id } = data;

  return (
    <Section>
      Device {device_id} is temporarily inaccessible. Please wait for the user
      to deactivate their computer.
      <Button
        content={'Close Connection'}
        icon="sign-out-alt"
        onClick={() => act('PRG_close_connection')}
      />
    </Section>
  );
};

const HackingFromDevice = (props, context) => {
  const { act, data } = useBackend(context);
  const { device_id, device_files = [] } = data;

  return (
    <Section>
      Connected to device {device_id}.
      <Button
        content={'Close Connection'}
        icon="sign-out-alt"
        onClick={() => act('PRG_close_connection')}
      />
      {device_files.map((file) => (
        <File key={file.filename} file={file} />
      ))}
    </Section>
  );
};

const File = (props, context) => {
  const { file } = props;
  const { act, data } = useBackend(context);
  const {
    disk_size,
    disk_used,
    downloadcompletion,
    downloadname,
    downloadsize,
    downloadspeed,
    downloads_queue,
  } = data;
  const disk_free = disk_size - disk_used;
  return (
    <Box mb={3}>
      <Flex align="baseline">
        <Flex.Item bold grow={1}>
          {file.filename}.{file.filetype}
        </Flex.Item>
        <Flex.Item color="label" nowrap>
          {file.size} GQ
        </Flex.Item>
        <Flex.Item ml={2} width="94px" textAlign="center">
          {(file.filename === downloadname && (
            <ProgressBar
              color="green"
              minValue={0}
              maxValue={downloadsize}
              value={downloadcompletion}>
              {round((downloadcompletion / downloadsize) * 100, 1)}% (
              {downloadspeed}GQ/s)
            </ProgressBar>
          )) ||
            (downloads_queue.indexOf(file.filename) !== -1 && (
              <Button
                icon="ban"
                color="bad"
                onClick={() =>
                  act('PRG_removequeued', {
                    filename: file.filename,
                  })
                }>
                Queued...
              </Button>
            )) || (
              <Button
                fluid
                icon="download"
                content="Download"
                disabled={file.size > disk_free}
                onClick={() =>
                  act('PRG_downloadfile', {
                    filename: file.filename,
                  })
                }
              />
            )}
        </Flex.Item>
      </Flex>
      {file.size > disk_free && (
        <Box mt={1} italic fontSize="12px" position="relative">
          <Icon mx={1} color="red" name="times" />
          Not enough disk space!
        </Box>
      )}
    </Box>
  );
};
