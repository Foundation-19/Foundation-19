import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, NumberInput } from '../components';
import { Window } from '../layouts';

export const KineticHarvester = (props, context) => {
  const { act, data } = useBackend(context);
  const { id, status, materials } = data;
  return (
    <Window width={400} height={600}>
      <Window.Content scrollable>
        <Section title="Kinetic Harvester">
          <LabeledList>
            <LabeledList.Item label="Network">{id}</LabeledList.Item>
            <LabeledList.Item label="Status">
              <Button
                icon={status ? 'power-off' : 'power-off'}
                content={status ? 'Active' : 'Standby'}
                selected={status}
                onClick={() => act('toggle_power')} />
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Stored Materials">
          <LabeledList>
            {materials.map(mat => (
              <LabeledList.Item key={mat.material} label={mat.material}>
                {mat.amount} sheet(s) | Raw: {mat.rawamount}
                <Button ml={1}
                  icon={mat.harvest ? 'toggle-on' : 'toggle-off'}
                  content={mat.harvest ? 'Harvesting' : 'Idle'}
                  selected={mat.harvest}
                  onClick={() => act('toggle_harvest', { toggle_harvest: mat.material })} />
                <Button content="Eject" disabled={mat.amount <= 0} onClick={() => act('remove_mat', { remove_mat: mat.material })} />
              </LabeledList.Item>
            ))}
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
