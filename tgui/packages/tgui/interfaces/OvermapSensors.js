import { useBackend } from '../backend';
import { Box, Button, LabeledList, ProgressBar, Section } from '../components';
import { Window } from '../layouts';

export const OvermapSensors = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    viewing,
    viewing_silicon,
    on,
    range,
    health,
    max_health,
    heat,
    critical_heat,
    status,
    contacts,
  } = data;
  return (
    <Window width={420} height={530}>
      <Window.Content scrollable>
        <Section title="Sensor Status">
          <LabeledList>
            <LabeledList.Item label="Status">{status}</LabeledList.Item>
            <LabeledList.Item label="Power">
              <Button
                icon={on ? 'power-off' : 'power-off'}
                content={on ? 'Online' : 'Offline'}
                selected={on}
                onClick={() => act('toggle')} />
            </LabeledList.Item>
            <LabeledList.Item label="Range">
              <Button content={range} onClick={() => act('range')} />
            </LabeledList.Item>
            <LabeledList.Item label="Health">
              <ProgressBar
                value={health / max_health}
                ranges={{ good: [0.5, Infinity], average: [0.25, 0.5], bad: [-Infinity, 0.25] }}>
                {health} / {max_health}
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Heat">
              <ProgressBar
                value={heat / critical_heat}
                ranges={{ good: [-Infinity, 0.5], average: [0.5, 0.8], bad: [0.8, Infinity] }}>
                {heat} / {critical_heat}
              </ProgressBar>
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Controls">
          <Button
            icon="eye"
            content={viewing ? 'Stop Viewing' : 'View Overmap'}
            selected={viewing}
            onClick={() => act('viewing')} />
          <Button content="Re-link Sensors" onClick={() => act('link')} />
        </Section>
        {!!contacts && contacts.length > 0 && (
          <Section title="Contacts">
            <LabeledList>
              {contacts.map(contact => (
                <LabeledList.Item key={contact.ref} label={contact.name}>
                  Bearing: {contact.bearing}°
                  <Button ml={1} content="Scan" onClick={() => act('scan', { scan: contact.ref })} />
                </LabeledList.Item>
              ))}
            </LabeledList>
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
