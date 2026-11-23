import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, NumberInput, NoticeBox } from '../components';
import { Window } from '../layouts';

export const DisperserConsole = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    faillink,
    calibration,
    overmapdir,
    cal_accuracy,
    strength,
    range,
    next_shot,
    nopower,
    skill,
    chargeload,
  } = data;
  return (
    <Window width={400} height={550}>
      <Window.Content scrollable>
        {!!faillink && (
          <NoticeBox danger>Equipment link failure! Reconfigure parts.</NoticeBox>
        )}
        {!faillink && (
          <>
            <Section title="Disperser Status">
              <LabeledList>
                <LabeledList.Item label="Charge">{chargeload}</LabeledList.Item>
                <LabeledList.Item label="Direction">{overmapdir}</LabeledList.Item>
                <LabeledList.Item label="Calibration">{cal_accuracy}%</LabeledList.Item>
                <LabeledList.Item label="Strength">{strength}</LabeledList.Item>
                <LabeledList.Item label="Range">{range}</LabeledList.Item>
                <LabeledList.Item label="Cooldown">{next_shot}s</LabeledList.Item>
                {!!nopower && (
                  <LabeledList.Item label="Power">
                    <NoticeBox danger>Insufficient power!</NoticeBox>
                  </LabeledList.Item>
                )}
              </LabeledList>
            </Section>
            <Section title="Controls">
              <LabeledList>
                <LabeledList.Item label="Direction">
                  <NumberInput value={overmapdir} minValue={0} maxValue={9} onChange={(e, value) => act('choose', { choose: value })} />
                </LabeledList.Item>
                <LabeledList.Item label="Strength">
                  <NumberInput value={strength} minValue={1} maxValue={5} onChange={(e, value) => act('strength', { value: value })} />
                </LabeledList.Item>
                <LabeledList.Item label="Range">
                  <NumberInput value={range} minValue={1} maxValue={5} onChange={(e, value) => act('range', { value: value })} />
                </LabeledList.Item>
                <LabeledList.Item label="Calibrate">
                  {calibration.map((val, i) => (
                    <NumberInput key={i} value={val} minValue={0} maxValue={9} width="30px" onChange={(e, value) => act('calibration', { calibration: i, value: value })} />
                  ))}
                  {!!skill && (
                    <Button content="Auto-Calibrate" onClick={() => act('skill_calibration')} />
                  )}
                </LabeledList.Item>
              </LabeledList>
              <Button fluid content="FIRE" color="bad" onClick={() => act('fire')} />
            </Section>
          </>
        )}
      </Window.Content>
    </Window>
  );
};
