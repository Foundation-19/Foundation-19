import { useBackend } from '../backend';
import { Box, Button, LabeledList, NoticeBox, Section } from '../components';
import { Window } from '../layouts';

const TEMPERATURE_COLOR = {
  good: '#4caf50',
  average: '#ff9800',
  bad: '#f44336',
};

export const CryoCell = (props, context) => {
  const { act, data } = useBackend(context);
  const { isOperating, hasOccupant, occupant, cellTemperature, cellTemperatureStatus, isBeakerLoaded, beakerLabel, beakerVolume } = data;

  return (
    <Window width={520} height={410} resizable>
      <Window.Content scrollable>
        <Section title="Cryo Cell Control">
          <LabeledList>
            <LabeledList.Item label="System">
              {!isOperating ? (
                <Button
                  icon="power-off"
                  content="Activate"
                  color="good"
                  onClick={() => act('switchOn')} />
              ) : (
                <Button
                  icon="power-off"
                  content="Deactivate"
                  color="bad"
                  onClick={() => act('switchOff')} />
              )}
            </LabeledList.Item>
            <LabeledList.Item label="Temperature">
              <Box inline color={TEMPERATURE_COLOR[cellTemperatureStatus] || 'label'}>
                {cellTemperature} K
              </Box>
            </LabeledList.Item>
            <LabeledList.Item label="Beaker">
              {isBeakerLoaded ? (
                <Box>
                  {beakerLabel} ({beakerVolume} units)
                  <Button
                    ml={1}
                    icon="eject"
                    content="Eject"
                    onClick={() => act('ejectBeaker')} />
                </Box>
              ) : (
                <Box color="label">No beaker loaded</Box>
              )}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Occupant">
          {hasOccupant ? (
            <Box>
              <Box dangerouslySetInnerHTML={{ __html: occupant }} />
              <Button
                mt={1}
                icon="user"
                content="Eject Occupant"
                color="danger"
                onClick={() => act('ejectOccupant')} />
            </Box>
          ) : (
            <Box color="label">No occupant detected.</Box>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
