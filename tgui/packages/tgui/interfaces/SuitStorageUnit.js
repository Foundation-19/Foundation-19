import { useBackend } from '../backend';
import { Box, Button, LabeledList, NoticeBox, Section } from '../components';
import { Window } from '../layouts';

export const SuitStorageUnit = (props, context) => {
  const { act, data } = useBackend(context);
  const { panelopen, uv, superuv, safeties, open, locked, helmet, suit, boots, tank, mask, occupant } = data;

  if (panelopen) {
    return (
      <Window width={400} height={300} resizable>
        <Window.Content>
          <Section title="Maintenance Panel">
            <LabeledList>
              <LabeledList.Item label="UV Wavelength">
                <Button
                  icon="sun"
                  content={superuv ? 'Turn towards 185nm' : 'Turn towards 15nm'}
                  onClick={() => act('toggleUV')} />
              </LabeledList.Item>
              <LabeledList.Item label="Safeties">
                <Box inline color={safeties ? 'good' : 'bad'}>
                  {safeties ? 'GREEN' : 'RED'} LED
                </Box>
                <Button
                  ml={1}
                  icon="exclamation-triangle"
                  content="Press Button"
                  onClick={() => act('togglesafeties')} />
              </LabeledList.Item>
            </LabeledList>
          </Section>
        </Window.Content>
      </Window>
    );
  }

  if (uv) {
    return (
      <Window width={400} height={200} resizable>
        <Window.Content>
          <NoticeBox info>
            Sterilization In Progress
          </NoticeBox>
          <Box textAlign="center" italic mt={1}>
            Unit is sterilizing contents with selected UV ray intensity. Please wait.
          </Box>
        </Window.Content>
      </Window>
    );
  }

  return (
    <Window width={400} height={500} resizable>
      <Window.Content>
        <Section title="Control Panel">
          <LabeledList>
            <LabeledList.Item label="Hatch">
              <Button
                icon={open ? 'lock-open' : 'lock'}
                content={open ? 'Close Hatch' : 'Open Hatch'}
                onClick={() => act('toggle_open')} />
            </LabeledList.Item>
            <LabeledList.Item label="Locks">
              <Button
                icon={locked ? 'lock' : 'unlock'}
                content={locked ? 'Unlock' : 'Lock'}
                onClick={() => act('toggle_lock')} />
            </LabeledList.Item>
            <LabeledList.Item label="Sterilization">
              <Button
                icon="radiation"
                content="Initiate Sterilization"
                onClick={() => act('start_UV')} />
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Equipment Panel">
          <LabeledList>
            <LabeledList.Item label="Helmet">
              <Box inline color={helmet ? 'good' : 'label'}>
                {helmet || 'Empty'}
              </Box>
              {!!helmet && (
                <Button
                  ml={1}
                  icon="eject"
                  content="Eject"
                  onClick={() => act('dispense_helmet')} />
              )}
            </LabeledList.Item>
            <LabeledList.Item label="Suit">
              <Box inline color={suit ? 'good' : 'label'}>
                {suit || 'Empty'}
              </Box>
              {!!suit && (
                <Button
                  ml={1}
                  icon="eject"
                  content="Eject"
                  onClick={() => act('dispense_suit')} />
              )}
            </LabeledList.Item>
            <LabeledList.Item label="Boots">
              <Box inline color={boots ? 'good' : 'label'}>
                {boots || 'Empty'}
              </Box>
              {!!boots && (
                <Button
                  ml={1}
                  icon="eject"
                  content="Eject"
                  onClick={() => act('dispense_boots')} />
              )}
            </LabeledList.Item>
            <LabeledList.Item label="Tank">
              <Box inline color={tank ? 'good' : 'label'}>
                {tank || 'Empty'}
              </Box>
              {!!tank && (
                <Button
                  ml={1}
                  icon="eject"
                  content="Eject"
                  onClick={() => act('dispense_tank')} />
              )}
            </LabeledList.Item>
            <LabeledList.Item label="Mask">
              <Box inline color={mask ? 'good' : 'label'}>
                {mask || 'Empty'}
              </Box>
              {!!mask && (
                <Button
                  ml={1}
                  icon="eject"
                  content="Eject"
                  onClick={() => act('dispense_mask')} />
              )}
            </LabeledList.Item>
            {!!occupant && (
              <LabeledList.Item label="Occupant">
                <Button
                  icon="user"
                  content="Eject Occupant"
                  color="danger"
                  onClick={() => act('eject_guy')} />
              </LabeledList.Item>
            )}
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
