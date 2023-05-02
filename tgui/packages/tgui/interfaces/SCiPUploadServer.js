/* eslint react/no-danger: "off" */
import { useBackend } from '../backend';
import { Button, Section, Table } from '../components';
import { NtosWindow } from '../layouts';

export const SCiPUploadServer = (props, context) => {
  const { act, data } = useBackend(context);
  const { PC_device_theme, hosting, files = [] } = data;
  return (
    <NtosWindow resizable theme={PC_device_theme}>
      <NtosWindow.Content scrollable>
        <Section
          title="Server Settings"
          buttons={
            <Button.Checkbox
              checked={hosting}
              content="Active"
              onClick={() => act('PRG_togglehosting')}
            />
          }>
          <FileTable
            files={files}
            onToggle={(file) => act('PRG_togglefile', { name: file })}
          />
        </Section>
      </NtosWindow.Content>
    </NtosWindow>
  );
};

const FileTable = (props) => {
  const { files = [], onToggle } = props;
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
          <Table.Cell>
            <Button
              checked={!(file.req_acc === null)}
              onClick={() => onToggle(file.name)}
            />
          </Table.Cell>
        </Table.Row>
      ))}
    </Table>
  );
};
