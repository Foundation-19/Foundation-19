import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const ShuttleConsole = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    shuttle_status,
    shuttle_state,
    has_docking,
    docking_status,
    docking_override,
    can_launch,
    can_cancel,
    can_force,
    timeleft,
    docking_codes,
  } = data;

  return (
    <Window width={470} height={450} resizable>
      <Window.Content>
        <Section title="Shuttle Status">
          <LabeledList>
            <LabeledList.Item label="Status">
              {shuttle_status}
            </LabeledList.Item>
            {has_docking && (
              <>
                <LabeledList.Item label="Docking Status">
                  {docking_status}
                </LabeledList.Item>
                <LabeledList.Item label="Docking Override">
                  <Box color={docking_override ? 'good' : 'bad'}>
                    {docking_override ? 'Enabled' : 'Disabled'}
                  </Box>
                </LabeledList.Item>
              </>
            )}
            {!!timeleft && (
              <LabeledList.Item label="Time Left">
                {timeleft}s
              </LabeledList.Item>
            )}
          </LabeledList>
        </Section>
        <Section title="Controls">
          <Button
            icon="rocket"
            content="Launch"
            disabled={!can_launch}
            onClick={() => act('move')} />
          <Button
            icon="fast-forward"
            content="Force Launch"
            disabled={!can_force}
            onClick={() => act('force')} />
          <Button
            icon="ban"
            content="Cancel Launch"
            disabled={!can_cancel}
            onClick={() => act('cancel')} />
          <Button
            icon="key"
            content="Set Docking Codes"
            onClick={() => act('set_codes')} />
        </Section>
      </Window.Content>
    </Window>
  );
};
