/* eslint react/no-danger: "off" */
import { Fragment } from 'inferno';

import { useBackend } from '../backend';
import { Button, Section, Table } from '../components';
import { NtosWindow } from '../layouts';

export const SCiPUploadServer = (props, context) => {
  const { act, data } = useBackend(context);
  const { PC_device_theme, editing_file } = data;

  let body = <ServerSettings />;

  if (editing_file) {
    body = <AccessEditor />;
  }

  return (
    <NtosWindow resizable theme={PC_device_theme}>
      <NtosWindow.Content scrollable>{body}</NtosWindow.Content>
    </NtosWindow>
  );
};

const ServerSettings = (props, context) => {
  const { act, data } = useBackend(context);
  const { hosting, files = [] } = data;
  return (
    <Section
      title="Server Settings"
      buttons={
        <Fragment>
          <Button.Checkbox
            checked={hosting}
            onClick={() => act('PRG_togglehosting')}
          >
            Toggle hosting
          </Button.Checkbox>
          <Button icon="lock" onClick={() => act('PRG_setname')}>
            Set Name
          </Button>
        </Fragment>
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
              <Button.Checkbox
                checked={file.enabled}
                onClick={() => act('PRG_togglefile', { file_name: file.name })}
              >
                Available
              </Button.Checkbox>
            </Table.Cell>
            <Table.Cell>
              <Button
                icon="id-card"
                onClick={() => act('PRG_editfile', { file_name: file.name })}
              >
                Edit
              </Button>
            </Table.Cell>
          </Table.Row>
        ))}
      </Table>
    </Section>
  );
};

const AccessEditor = (props, context) => {
  const { act, data } = useBackend(context);
  const { editing_file, region_access = [], region_names = [] } = data;
  return (
    <Section
      title={'Editing ' + editing_file}
      buttons={
        <Button icon="sign-out-alt" onClick={() => act('PRG_exit')}>
          Exit
        </Button>
      }
    >
      {region_access.map((region = [], index) => (
        <Section title={region_names[index]} key={index}>
          {region.map((access) => (
            <Button.Checkbox
              key={access.id}
              checked={access.required}
              onClick={() =>
                act('PRG_file_change_access', { access: access.id })
              }
            >
              {access.desc}
            </Button.Checkbox>
          ))}
        </Section>
      ))}
    </Section>
  );
};
