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
            onToggle={(file) => act('PRG_togglefile', { file_name: file })}
            onEdit={(file) => act('PRG_editfile', { file_name: file })}
          />
        </Section>
      </NtosWindow.Content>
    </NtosWindow>
  );
};

const FileTable = (props) => {
  const { files = [], onToggle, onEdit } = props;
  return (
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
              checked={file.enabled}
              onClick={() => onToggle(file.name)}
            />
          </Table.Cell>
          <Table.Cell>
            <Button icon="id-card" onClick={() => onEdit(file.name)}>
              Edit Access
            </Button>
          </Table.Cell>
        </Table.Row>
      ))}
    </Table>
  );
};
