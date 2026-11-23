import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, ProgressBar, NoticeBox } from '../components';
import { Window } from '../layouts';

export const PortableGenerator = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    active,
    is_ai,
    output_set,
    output_max,
    output_safe,
    output_watts,
    temperature_current,
    temperature_max,
    temperature_overheat,
    fuel_stored,
    fuel_capacity,
    fuel_usage,
    fuel_type,
    uses_coolant,
    coolant_stored,
    coolant_capacity,
  } = data;
  return (
    <Window width={500} height={560}>
      <Window.Content scrollable>
        <Section title="Generator Control">
          <LabeledList>
            <LabeledList.Item label="Status">
              <Button
                icon={active ? 'power-off' : 'power-off'}
                content={active ? 'Online' : 'Offline'}
                selected={active}
                onClick={() => act(active ? 'disable' : 'enable')} />
            </LabeledList.Item>
            <LabeledList.Item label="Power Output">
              <Button icon="minus" disabled={output_set <= 1} onClick={() => act('lower_power')} />
              <Box inline mx={1}>{output_watts} W (Level {output_set}/{output_max})</Box>
              <Button icon="plus" disabled={output_set >= output_max} onClick={() => act('higher_power')} />
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Temperature">
          <LabeledList>
            <LabeledList.Item label="Operating Temperature">
              <ProgressBar
                value={temperature_current / temperature_max}
                ranges={{ good: [-Infinity, 0.5], average: [0.5, 0.8], bad: [0.8, Infinity] }}>
                {temperature_current}°C / {temperature_max}°C
              </ProgressBar>
            </LabeledList.Item>
            {!!temperature_overheat && (
              <LabeledList.Item label="Overheat">
                <ProgressBar value={temperature_overheat / 100} color="bad">
                  {temperature_overheat}%
                </ProgressBar>
              </LabeledList.Item>
            )}
          </LabeledList>
        </Section>
        <Section title="Fuel">
          <LabeledList>
            <LabeledList.Item label="Fuel Type">{fuel_type}</LabeledList.Item>
            <LabeledList.Item label="Fuel Stored">
              <ProgressBar value={fuel_stored / fuel_capacity}>
                {fuel_stored} / {fuel_capacity}
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Fuel Usage">{fuel_usage}</LabeledList.Item>
            <LabeledList.Item label="Eject Fuel">
              <Button content="Eject" disabled={active} onClick={() => act('eject')} />
            </LabeledList.Item>
          </LabeledList>
        </Section>
        {!!uses_coolant && (
          <Section title="Coolant">
            <LabeledList>
              <LabeledList.Item label="Coolant">
                <ProgressBar value={(coolant_stored || 0) / (coolant_capacity || 1)}>
                  {coolant_stored || 0} / {coolant_capacity || 0}
                </ProgressBar>
              </LabeledList.Item>
            </LabeledList>
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
