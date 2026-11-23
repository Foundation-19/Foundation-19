import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, NoticeBox } from '../components';
import { Window } from '../layouts';

export const AirlockElectronics = (props, context) => {
  const { act, data } = useBackend(context);
  const { regions = [], oneAccess, locked, lockable, autoset } = data;

  if(locked && lockable) {
    return (
      <Window width={400} height={150} resizable>
        <Window.Content>
          <Section title="Access Controller">
            <NoticeBox info>Interface is locked.</NoticeBox>
            <Button fluid icon="unlock" content="Unlock" onClick={() => act('unlock')} />
          </Section>
        </Window.Content>
      </Window>
    );
  }

  return (
    <Window width={600} height={700} resizable>
      <Window.Content scrollable>
        <Section title="Access Configuration" buttons={
          <Box>
            {!!lockable && (
              <Button icon="lock" content="Lock" onClick={() => act('lock')} />
            )}
            <Button icon="undo" content="Clear All" onClick={() => act('clear')} />
          </Box>
        }>
          <LabeledList>
            <LabeledList.Item label="Access Mode">
              <Button
                content={oneAccess ? 'Require One' : 'Require All'}
                onClick={() => act('one_access')} />
            </LabeledList.Item>
            <LabeledList.Item label="Auto-set from Area">
              <Button
                icon={autoset ? 'toggle-on' : 'toggle-off'}
                content={autoset ? 'Enabled' : 'Disabled'}
                selected={autoset}
                onClick={() => act('autoset')} />
            </LabeledList.Item>
          </LabeledList>
        </Section>
        {regions.map((region) => (
          <Section key={region.name} title={region.name} level={2}>
            {region.accesses.map((access) => (
              <Button
                key={access.id}
                content={access.name}
                selected={access.req}
                onClick={() => act('access', { access: access.id })} />
            ))}
          </Section>
        ))}
      </Window.Content>
    </Window>
  );
};
