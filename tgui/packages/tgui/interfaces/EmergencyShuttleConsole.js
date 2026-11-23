import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, NoticeBox } from '../components';
import { Window } from '../layouts';

export const EmergencyShuttleConsole = (props, context) => {
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
    auth_list = [],
    has_auth,
    emagged,
  } = data;

  return (
    <Window width={470} height={420} resizable>
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
          </LabeledList>
        </Section>
        <Section title="Authorization">
          {!has_auth && (
            <NoticeBox>
              {emagged ? 'SYSTEM ERROR' : `${auth_list.filter(a => a.auth_name).length}/${auth_list.length} authorizations required`}
            </NoticeBox>
          )}
          {has_auth && (
            <NoticeBox success>
              Authorization Confirmed
            </NoticeBox>
          )}
          <LabeledList>
            {auth_list.map((entry, i) => (
              <LabeledList.Item key={i} label={`Slot ${i + 1}`}>
                {entry.auth_name ? (
                  <Box>
                    <Box inline color={emagged ? 'bad' : 'default'}>
                      {entry.auth_name}
                    </Box>
                    {!emagged && (
                      <Button
                        ml={1}
                        icon="times"
                        content="Remove"
                        color="bad"
                        onClick={() => act('removeid', { removeid: entry.auth_hash })} />
                    )}
                  </Box>
                ) : (
                  <Button
                    icon="id-card"
                    content="Insert ID"
                    disabled={emagged}
                    onClick={() => act('scanid')} />
                )}
              </LabeledList.Item>
            ))}
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
        </Section>
      </Window.Content>
    </Window>
  );
};
