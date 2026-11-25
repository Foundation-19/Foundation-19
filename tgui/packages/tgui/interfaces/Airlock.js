import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, NoticeBox } from '../components';
import { Window } from '../layouts';

export const Airlock = (props, context) => {
  const { act, data } = useBackend(context);
  const { main_power_loss, backup_power_loss, electrified, open, commands = [] } = data;

  return (
    <Window width={450} height={350} resizable>
      <Window.Content scrollable>
        <Section title="Airlock Controls">
          <LabeledList>
            <LabeledList.Item label="Main Power">
              <Box color={main_power_loss > 0 ? 'bad' : 'good'}>
                {main_power_loss > 0 ? `Lost (${main_power_loss}s)` : 'Online'}
              </Box>
              {!!main_power_loss && (
                <Button ml={1} icon="bolt" content="Cut" color="bad" onClick={() => act('main_power', { activate: 1 })} />
              )}
            </LabeledList.Item>
            <LabeledList.Item label="Backup Power">
              <Box color={backup_power_loss > 0 ? 'bad' : 'good'}>
                {backup_power_loss > 0 ? `Lost (${backup_power_loss}s)` : 'Online'}
              </Box>
              {!!backup_power_loss && (
                <Button ml={1} icon="bolt" content="Cut" color="bad" onClick={() => act('backup_power', { activate: 1 })} />
              )}
            </LabeledList.Item>
            <LabeledList.Item label="Electrified">
              <Box color={electrified !== 0 ? 'bad' : 'good'}>
                {electrified === -1 ? 'PERMANENTLY' : electrified > 0 ? `${electrified}s` : 'No'}
              </Box>
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Commands">
          {commands.map((cmd) => (
            <LabeledList key={cmd.name}>
              <LabeledList.Item label={cmd.name}>
                <Box inline color={cmd.active ? (cmd.danger ? 'bad' : 'good') : 'label'}>
                  {cmd.active ? cmd.enabled : cmd.disabled}
                </Box>
                <Button
                  ml={1}
                  content={cmd.act ? (cmd.active ? 'Disable' : 'Enable') : (cmd.active ? 'Deactivate' : 'Activate')}
                  color={cmd.danger && !cmd.active ? 'bad' : 'default'}
                  // Toggling semantics: for act commands, sending the NEXT
                  // state makes sense (Enable sends 1). For state-flip
                  // commands like "open" (Door State), the server flips on
                  // the bit itself; what we send must be the state we want
                  // AFTER the click. Door State: active=1 means Closed —
                  // clicking "Activate" (on an open door) should CLOSE it,
                  // and clicking "Deactivate" (on a closed door) should
                  // OPEN it. So invert the current state as the target.
                  onClick={() => act(cmd.command, { activate: cmd.act ? (cmd.active ? 0 : 1) : (cmd.active ? 0 : 1) })} />
              </LabeledList.Item>
            </LabeledList>
          ))}
        </Section>
      </Window.Content>
    </Window>
  );
};
