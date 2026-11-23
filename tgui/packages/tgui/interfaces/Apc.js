import { useBackend } from '../backend';
import { Box, Button, Flex, LabeledList, NoticeBox, ProgressBar, Section } from '../components';
import { Window } from '../layouts';

const POWERCHAN_OFF = 0;
const POWERCHAN_OFF_TEMP = 1;
const POWERCHAN_OFF_AUTO = 2;
const POWERCHAN_ON = 3;
const POWERCHAN_ON_AUTO = 4;

const statusToColor = (status) => {
  switch (status) {
    case POWERCHAN_ON:
    case POWERCHAN_ON_AUTO:
      return 'good';
    case POWERCHAN_OFF_TEMP:
      return 'average';
    case POWERCHAN_OFF:
    case POWERCHAN_OFF_AUTO:
      return 'bad';
    default:
      return 'label';
  }
};

const statusToText = (status) => {
  switch (status) {
    case POWERCHAN_ON: return 'On';
    case POWERCHAN_ON_AUTO: return 'Auto (On)';
    case POWERCHAN_OFF: return 'Off';
    case POWERCHAN_OFF_AUTO: return 'Auto (Off)';
    case POWERCHAN_OFF_TEMP: return 'Auto (Off/Temp)';
    default: return 'Unknown';
  }
};

const channelKeyMap = { Equipment: 'eqp', Lighting: 'lgt', Environment: 'env' };

export const Apc = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    locked,
    isOperating,
    externalPower,
    powerCellStatus,
    chargeMode,
    chargingStatus,
    totalLoad,
    totalCharging,
    coverLocked,
    failTime,
    siliconUser,
    powerChannels = [],
  } = data;

  return (
    <Window width={520} height={siliconUser ? 530 : 500} resizable>
      <Window.Content scrollable>
        {!!failTime && (
          <NoticeBox danger>
            System will reboot in {failTime}s
            <Button icon="redo" content="Reboot Now" ml={1} onClick={() => act('reboot')} />
          </NoticeBox>
        )}
        <Section title="Power Cell">
          {powerCellStatus !== null ? (
            <LabeledList>
              <LabeledList.Item label="Cell Charge">
                <ProgressBar
                  value={powerCellStatus / 100}
                  ranges={{ good: [0.5, Infinity], average: [0.15, 0.5], bad: [-Infinity, 0.15] }}>
                  {powerCellStatus}%
                </ProgressBar>
              </LabeledList.Item>
            </LabeledList>
          ) : (
            <Box color="bad">No cell inserted.</Box>
          )}
        </Section>
        <Section title="Main Breaker">
          <LabeledList>
            <LabeledList.Item label="Operating">
              <Button
                icon={isOperating ? 'toggle-on' : 'toggle-off'}
                content={isOperating ? 'On' : 'Off'}
                selected={isOperating}
                disabled={locked && !siliconUser}
                onClick={() => act('breaker')} />
            </LabeledList.Item>
            <LabeledList.Item label="External Power">
              <Box color={externalPower === 2 ? 'good' : externalPower === 1 ? 'average' : 'bad'}>
                {externalPower === 2 ? 'Good' : externalPower === 1 ? 'Low' : 'None'}
              </Box>
            </LabeledList.Item>
            <LabeledList.Item label="Charge Mode">
              <Button
                icon={chargeMode ? 'toggle-on' : 'toggle-off'}
                content={chargeMode ? 'Auto' : 'Off'}
                selected={chargeMode}
                disabled={locked && !siliconUser}
                onClick={() => act('cmode')} />
            </LabeledList.Item>
            <LabeledList.Item label="Charging">
              {chargingStatus === 1 ? 'Charging' : chargingStatus === 2 ? 'Fully Charged' : 'Not Charging'}
            </LabeledList.Item>
            <LabeledList.Item label="Total Load">
              {totalLoad} W
            </LabeledList.Item>
            <LabeledList.Item label="Total Charging">
              {totalCharging} W
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Power Channels">
          {powerChannels.map((channel) => {
            const key = channelKeyMap[channel.title] || channel.title.toLowerCase();
            return (
              <Section key={channel.title} title={channel.title} level={2}>
                <LabeledList>
                  <LabeledList.Item label="Status">
                    <Box color={statusToColor(channel.status)}>
                      {statusToText(channel.status)}
                    </Box>
                  </LabeledList.Item>
                  <LabeledList.Item label="Load">
                    {channel.powerLoad} W
                  </LabeledList.Item>
                  <LabeledList.Item label="Set">
                    <Flex>
                      <Flex.Item>
                        <Button
                          content="Off"
                          disabled={locked && !siliconUser}
                          onClick={() => act(key, { [key]: 0 })} />
                      </Flex.Item>
                      <Flex.Item>
                        <Button
                          content="On"
                          disabled={locked && !siliconUser}
                          onClick={() => act(key, { [key]: 1 })} />
                      </Flex.Item>
                      <Flex.Item>
                        <Button
                          content="Auto"
                          disabled={locked && !siliconUser}
                          onClick={() => act(key, { [key]: 2 })} />
                      </Flex.Item>
                    </Flex>
                  </LabeledList.Item>
                </LabeledList>
              </Section>
            );
          })}
        </Section>
        {!!siliconUser && (
          <Section title="Silicon Actions">
            <LabeledList>
              <LabeledList.Item label="Cover Lock">
                <Button
                  icon={coverLocked ? 'lock' : 'unlock'}
                  content={coverLocked ? 'Locked' : 'Unlocked'}
                  selected={coverLocked}
                  onClick={() => act('lock')} />
              </LabeledList.Item>
              <LabeledList.Item label="Interface">
                <Button
                  icon={locked ? 'lock' : 'unlock'}
                  content={locked ? 'Unlock' : 'Lock'}
                  onClick={() => act('toggleaccess')} />
              </LabeledList.Item>
              <LabeledList.Item label="Emergency">
                <Button
                  icon="exclamation-triangle"
                  content="Overload Lighting"
                  color="bad"
                  onClick={() => act('overload')} />
              </LabeledList.Item>
            </LabeledList>
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
