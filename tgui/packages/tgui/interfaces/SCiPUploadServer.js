/* eslint react/no-danger: "off" */
import { useBackend } from '../backend';
import { Section, Table } from '../components';
import { NtosWindow } from '../layouts';

export const SCiPUploadServer = (props, context) => {
  const { act, data } = useBackend(context);
  const { PC_device_theme, files = [] } = data;
  return (
    <NtosWindow resizable theme={PC_device_theme}>
      <NtosWindow.Content scrollable>
        <Section>
          <FileTable files={files} />
        </Section>
      </NtosWindow.Content>
    </NtosWindow>
  );
};

const FileTable = (props) => {
  const { files = [] } = props;
  return (
    <Table>
      <Table.Row header>
        <Table.Cell>File</Table.Cell>
        <Table.Cell collapsing>Type</Table.Cell>
        <Table.Cell collapsing>Size</Table.Cell>
      </Table.Row>
      {files.map((file) => (
        <Table.Row key={file.name} className="candystripe">
          <Table.Cell>{file.name}</Table.Cell>
          <Table.Cell>{file.type}</Table.Cell>
          <Table.Cell>{file.size}</Table.Cell>
        </Table.Row>
      ))}
    </Table>
  );
};
