/* eslint react/no-danger: "off" */
import { useBackend } from '../backend';
import {
  Box,
  Button,
  LabeledList,
  ProgressBar,
  Section,
  Table,
} from '../components';
import { NtosWindow } from '../layouts';

export const SCiPUploadClient = (props, context) => {
  const { act, data } = useBackend(context);
  const { PC_device_theme, error, downloading, connected } = data;

  let body = <ServerBrowser />;

  if (error) {
    body = <Error />;
  } else if (downloading) {
    body = <FileDownload />;
  } else if (connected) {
    body = <FileBrowser />;
  }

  return (
    <NtosWindow width={575} height={700} resizable theme={PC_device_theme}>
      <NtosWindow.Content scrollable>{body}</NtosWindow.Content>
    </NtosWindow>
  );
};

const Error = (props, context) => {
  const { act, data } = useBackend(context);
  const { error } = data;
  return (
    <Section
      title="An error has occured during operation."
      buttons={
        <Button icon="undo" onClick={() => act('PRG_reset')}>
          Reset
        </Button>
      }
    >
      Additional Information: {error}
    </Section>
  );
};

const ServerBrowser = (props, context) => {
  const { act, data } = useBackend(context);
  const { servers = [] } = data;
  return (
    <Section title="Available Servers">
      {(servers.length && (
        <LabeledList>
          {servers.map((server) => (
            <LabeledList.Item label={server.uid} key={server.uid}>
              {server.name}&nbsp;
              <Button
                icon="server"
                onClick={() =>
                  act('PRG_connect_to_server', { uid: server.uid })
                }
              >
                Connect to Server
              </Button>
            </LabeledList.Item>
          ))}
        </LabeledList>
      )) || <Box>No upload servers found.</Box>}
    </Section>
  );
};

const FileBrowser = (props, context) => {
  const { act, data } = useBackend(context);
  const { files = [], remote_name, remote_uid } = data;
  return (
    <Section
      title={remote_uid + ' : ' + remote_name}
      buttons={
        <Button
          icon="sign-out"
          onClick={() => act('PRG_disconnect_from_server')}
        >
          Disconnect
        </Button>
      }
    >
      <Table>
        <Table.Row header>
          <Table.Cell>File</Table.Cell>
          <Table.Cell collapsing>Size</Table.Cell>
        </Table.Row>
        {files.map((file) => (
          <Table.Row key={file.name} className="candystripe">
            <Table.Cell>
              {file.name}.{file.type}
            </Table.Cell>
            <Table.Cell>{file.size}</Table.Cell>
            <Table.Cell>
              <Button
                onClick={() =>
                  act('PRG_downloadfile', { file_name: file.name })
                }
              >
                Download
              </Button>
            </Table.Cell>
          </Table.Row>
        ))}
      </Table>
    </Section>
  );
};

const FileDownload = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    download_name,
    download_type,
    download_progress,
    download_netspeed,
    download_size,
  } = data;
  return (
    <Section title="Download in progress">
      <LabeledList>
        <LabeledList.Item label="Downloading File">
          {download_name}.{download_type}
        </LabeledList.Item>
        <LabeledList.Item label="Progress">
          <ProgressBar value={download_progress} maxValue={download_size}>
            {download_progress} / {download_size} GQ
          </ProgressBar>
        </LabeledList.Item>
        <LabeledList.Item label="Transfer Speed">
          {download_netspeed} GQ/s
        </LabeledList.Item>
        <LabeledList.Item label="Controls">
          <Button icon="ban" onClick={() => act('PRG_cancel_download')}>
            Cancel Download
          </Button>
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};
