import { useBackend } from '../backend';
import {
  Box,
  Button,
  Fragment,
  Input,
  LabeledList,
  Section,
  Table,
} from '../components';
import { NtosWindow } from '../layouts';

export const SCiPChatClient = (props, context) => {
  const { act, data } = useBackend(context);
  const { PC_device_theme, error, servername, editing_access } = data;

  let body;

  if (error) {
    body = <Error />;
  } else if (!servername) {
    body = <ServerSelect />;
  } else if (editing_access === 1) {
    body = <UserAccess />;
  } else if (editing_access === 2) {
    body = <AdminAccess />;
  } else {
    body = <Messages />;
  }

  return (
    <NtosWindow width={900} height={675} resizable theme={PC_device_theme}>
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

const ServerSelect = (props, context) => {
  const { act, data } = useBackend(context);
  const { servers = [] } = data;
  return (
    <Section title="Available Servers">
      {servers.length ? (
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
                {server.sysadmin
                  ? 'Connect to Server (sysadmin)'
                  : 'Connect to Server'}
              </Button>
            </LabeledList.Item>
          ))}
        </LabeledList>
      ) : (
        <Box>No upload servers found.</Box>
      )}
    </Section>
  );
};

const Messages = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    servername,
    channels = [],
    sysadmin,
    channel_open,
    messages = [],
  } = data;
  return (
    <Section height="600px">
      <Table height="580px">
        <Table.Row>
          <Table.Cell
            verticalAlign="top"
            style={{
              width: '200px',
            }}
          >
            <Box height="560px" overflowY="scroll">
              {servername}
              {sysadmin && (
                <Button.Input
                  fluid
                  content="New Channel..."
                  onCommit={(e, value) =>
                    act('PRG_new_channel', {
                      new_channel_name: value,
                    })
                  }
                />
              )}
              {channels.map((channel) => (
                <Button
                  fluid
                  key={channel.name}
                  content={channel.name}
                  selected={channel.active}
                  icon={channel.admin ? 'shield-alt' : null}
                  color={channel.unread ? 'red' : 'transparent'}
                  onClick={() => act('PRG_open_channel', { id: channel.index })}
                />
              ))}
            </Box>
          </Table.Cell>
          <Table.Cell>
            <Box height="560px" overflowY="scroll">
              {channel_open &&
                messages.map((message, index) => (
                  <Box key={index}>{message}</Box>
                ))}
            </Box>
            <Input
              fluid
              selfClear
              mt={1}
              onEnter={(e, value) =>
                act('PRG_post', {
                  message: value,
                })
              }
            />
          </Table.Cell>
          <Table.Cell
            verticalAlign="top"
            style={{
              width: '150px',
            }}
          >
            {channel_open && (
              <Button.Input
                fluid
                content="Save log..."
                defaultValue="new_log"
                onCommit={(e, value) =>
                  act('PRG_save_log', {
                    log_name: value,
                  })
                }
              />
            )}
            {channel_open & sysadmin && (
              <Fragment>
                <Button.Confirm fluid onClick={() => act('PRG_delete_channel')}>
                  Delete Channel
                </Button.Confirm>
                <Button
                  fluid
                  content="Rename Channel"
                  onClick={() => act('PRG_rename_channel')}
                />
                <Button
                  fluid
                  content="Set User Access"
                  onClick={() => act('PRG_set_editing_access', { value: 1 })}
                />
                <Button
                  fluid
                  content="Set Admin Access"
                  onClick={() => act('PRG_set_editing_access', { value: 2 })}
                />
              </Fragment>
            )}
          </Table.Cell>
        </Table.Row>
      </Table>
    </Section>
  );
};

const UserAccess = (props, context) => {
  const { act, data } = useBackend(context);
  const { editing_channel, region_access = [], region_names = [] } = data;
  return (
    <Section
      title={editing_channel + ' Accesses (User)'}
      buttons={
        <Button onClick={() => act('PRG_set_editing_access', { value: 0 })}>
          Return
        </Button>
      }
    >
      {region_access.map((region = [], index) => (
        <Section title={region_names[index]} key={region_names[index]}>
          {region.map((access) => (
            <Button.Checkbox
              key={access.id}
              checked={access.required}
              onClick={() =>
                act('PRG_change_access_user', { access: access.id })
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

const AdminAccess = (props, context) => {
  const { act, data } = useBackend(context);
  const { editing_channel, region_access = [], region_names = [] } = data;
  return (
    <Section
      title={editing_channel + ' Accesses (Admin)'}
      buttons={
        <Button onClick={() => act('PRG_set_editing_access', { value: 0 })}>
          Return
        </Button>
      }
    >
      {region_access.map((region = [], index) => (
        <Section title={region_names[index]} key={region_names[index]}>
          {region.map((access) => (
            <Button.Checkbox
              key={access.id}
              checked={access.required}
              onClick={() =>
                act('PRG_change_access_admin', { access: access.id })
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
