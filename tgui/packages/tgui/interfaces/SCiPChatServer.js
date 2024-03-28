/*
 * /// The base panel, shows some server-wide settings + links.
 * #define PAGE_BASE "base"
 * /// The history panel, shows the history of all channels.
 * #define PAGE_LOGS "logs"
 * /// The sysadmin access panel, allows editing of required accesses (for global channel administration).
 * #define PAGE_ACCESS_SYSADMIN "access_sysadmin"
 * /// The base channel panel, shows some channel-specific settings + links.
 * #define PAGE_CHANNEL_BASE "channel_base"
 * /// The user access panel, allows editing of required accesses.
 * #define PAGE_CHANNEL_ACCESS_USER "channel_access_user"
 * /// The amdmin access panel, allows editing of required accesses (for admining the channel).
 * #define PAGE_CHANNEL_ACCESS_ADMIN "channel_access_admin"
 * /// The messages panel, allows viewing the chatlog and sending system messages.
 * #define PAGE_CHANNEL_MESSAGES "channel_messages"
 */

import { useBackend } from '../backend';
import { Flex, Button, Section, Table } from '../components';
import { NtosWindow } from '../layouts';

export const SCiPChatServer = (props, context) => {
  const { act, data } = useBackend(context);
  const { PC_device_theme, current_page } = data;

  let body;

  switch (current_page) {
    case 'base':
      body = <BasePage />;
      break;
    case 'logs':
      body = <LogsPage />;
      break;
    case 'access_sysadmin':
      body = <AccessSysadminPage />;
      break;
    case 'channel_base':
      body = <ChannelBasePage />;
      break;
    case 'channel_access_user':
      body = <ChannelAccessUserPage />;
      break;
    case 'channel_access_admin':
      body = <ChannelAccessAdminPage />;
      break;
    case 'channel_messages':
      body = <ChannelMessagesPage />;
      break;
    default:
      body =
        'current_page in SCiPChatServer.js was an unexpected value - contact a coder!';
      break;
  }

  return (
    <NtosWindow resizable theme={PC_device_theme}>
      <NtosWindow.Content scrollable>{body}</NtosWindow.Content>
    </NtosWindow>
  );
};

const BasePage = (props, context) => {
  const { act, data } = useBackend(context);
  const { channel_list = [], hosting, server_name } = data;
  return (
    <Section>
      <Flex direction="row">
        <Button
          onClick={() => act('PRG_switch_page', { page: 'logs' })}
          align-items="start">
          Server Logs
        </Button>
        <Button.Checkbox
          checked={hosting}
          onClick={() => act('PRG_togglehosting')}
          align-items="end">
          Toggle hosting
        </Button.Checkbox>
        <Button
          icon="lock"
          onClick={() => act('PRG_setname')}
          align-items="end">
          Servername: {server_name}
        </Button>
        <Button
          onClick={() =>
            act('PRG_switch_page_and_channel', {
              page: 'access_sysadmin',
            })
          }>
          Sysadmin Access Settings
        </Button>
      </Flex>
      <Table>
        <Table.Row header>
          <Table.Cell>Channels</Table.Cell>
        </Table.Row>
        {channel_list.map((c_title, index) => (
          <Table.Row key={index}>
            <Table.Cell>{c_title}</Table.Cell>
            <Table.Cell>
              <Button
                onClick={() =>
                  act('PRG_switch_page_and_channel', {
                    page: 'channel_base',
                    channel: index,
                  })
                }>
                Settings
              </Button>
            </Table.Cell>
          </Table.Row>
        ))}
      </Table>
      <Flex direction="row">
        <Button onClick={() => act('PRG_addchannel')}>Add Channel</Button>
      </Flex>
    </Section>
  );
};

const LogsPage = (props, context) => {
  const { act, data } = useBackend(context);
  const { server_logs = [] } = data;
  return (
    <Section
      title={'Server Logs'}
      buttons={
        <Button onClick={() => act('PRG_switch_page', { page: 'base' })}>
          Return
        </Button>
      }>
      <ol>
        {server_logs.map((log, index) => (
          <li key={index}>{log}</li>
        ))}
      </ol>
    </Section>
  );
};

const AccessSysadminPage = (props, context) => {
  const { act, data } = useBackend(context);
  const { region_access = [], region_names = [] } = data;
  return (
    <Section
      title={'Global Accesses (Sysadmin)'}
      buttons={
        <Button onClick={() => act('PRG_switch_page', { page: 'base' })}>
          Return
        </Button>
      }>
      {region_access.map((region = [], index) => (
        <Section title={region_names[index]} key={index}>
          {region.map((access) => (
            <Button.Checkbox
              key={access.id}
              checked={access.required}
              onClick={() =>
                act('PRG_change_access_user', { access: access.id })
              }>
              {access.desc}
            </Button.Checkbox>
          ))}
        </Section>
      ))}
    </Section>
  );
};

const ChannelBasePage = (props, context) => {
  const { act, data } = useBackend(context);
  const { editing_channel } = data;
  return (
    <Section
      title={editing_channel + ' Settings'}
      buttons={
        <Button onClick={() => act('PRG_switch_page', { page: 'base' })}>
          Return
        </Button>
      }>
      <Flex direction="column">
        <Button
          onClick={() =>
            act('PRG_switch_page', { page: 'channel_access_user' })
          }>
          User Access Settings
        </Button>
        <Button
          onClick={() =>
            act('PRG_switch_page', { page: 'channel_access_admin' })
          }>
          Admin Access Settings
        </Button>
        <Button
          onClick={() => act('PRG_switch_page', { page: 'channel_messages' })}>
          Messages
        </Button>
        <Button onClick={() => act('PRG_rename_channel')}>
          Rename Channel
        </Button>
        <Button onClick={() => act('PRG_deletechannel')}>Delete Channel</Button>
      </Flex>
    </Section>
  );
};

const ChannelAccessUserPage = (props, context) => {
  const { act, data } = useBackend(context);
  const { editing_channel, region_access = [], region_names = [] } = data;
  return (
    <Section
      title={editing_channel + ' Accesses (User)'}
      buttons={
        <Button
          onClick={() => act('PRG_switch_page', { page: 'channel_base' })}>
          Return
        </Button>
      }>
      {region_access.map((region = [], index) => (
        <Section title={region_names[index]} key={index}>
          {region.map((access) => (
            <Button.Checkbox
              key={access.id}
              checked={access.required}
              onClick={() =>
                act('PRG_change_access_user', { access: access.id })
              }>
              {access.desc}
            </Button.Checkbox>
          ))}
        </Section>
      ))}
    </Section>
  );
};

const ChannelAccessAdminPage = (props, context) => {
  const { act, data } = useBackend(context);
  const { editing_channel, region_access = [], region_names = [] } = data;
  return (
    <Section
      title={editing_channel + ' Accesses (Admin)'}
      buttons={
        <Button
          onClick={() => act('PRG_switch_page', { page: 'channel_base' })}>
          Return
        </Button>
      }>
      {region_access.map((region = [], index) => (
        <Section title={region_names[index]} key={index}>
          {region.map((access) => (
            <Button.Checkbox
              key={access.id}
              checked={access.required}
              onClick={() =>
                act('PRG_change_access_admin', { access: access.id })
              }>
              {access.desc}
            </Button.Checkbox>
          ))}
        </Section>
      ))}
    </Section>
  );
};

const ChannelMessagesPage = (props, context) => {
  const { act, data } = useBackend(context);
  const { editing_channel, ed_channel_messages = [] } = data;
  return (
    <Section
      title={editing_channel + ' Messages'}
      buttons={
        <Button
          onClick={() => act('PRG_switch_page', { page: 'channel_base' })}>
          Return
        </Button>
      }>
      <ol>
        {ed_channel_messages.map((message, index) => (
          <li key={index}>{message}</li>
        ))}
      </ol>
      <Button onClick={() => act('PRG_save_log')}>Save log</Button>
    </Section>
  );
};
