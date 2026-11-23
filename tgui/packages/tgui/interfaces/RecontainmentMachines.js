import { useBackend } from '../backend';
import { Box, Button, LabeledList, ProgressBar, Section } from '../components';
import { Window } from '../layouts';

// Shared frame for all simple recontainment devices.
const RecontainmentWindow = (props, context) => {
  const { act, data } = useBackend(context);
  const { title, subtitle, children, active, time_left, status_label, status } = props;

  return (
    <Window theme="scp_terminal" width={420} height={480}>
      <Window.Content scrollable>
        <Box style={{ background: '#0a0a0c', minHeight: '100%', padding: '10px', fontFamily: '"Consolas", monospace', color: '#c8c8c8' }}>
          <Box style={{ borderBottom: '2px solid #6b0000', paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: '#d4a017', letterSpacing: '0.15em', fontWeight: 'bold' }}>{title}</Box>
            <Box style={{ color: '#6a6a70', fontSize: '9px' }}>{subtitle}</Box>
          </Box>
          <Section title="Device Status">
            <LabeledList>
              <LabeledList.Item label="Cycle">
                {active ? (
                  <ProgressBar value={1 - time_left / 60} minValue={0} maxValue={1} color="good">
                    RUNNING — {time_left}s remaining
                  </ProgressBar>
                ) : (
                  <Box color="#6a6a70">Standby</Box>
                )}
              </LabeledList.Item>
              <LabeledList.Item label={status_label || 'Target Status'}>
                <Box color={status === 'contained' ? '#44ff44' : status === 'breached' ? '#cc2222' : '#d4a017'}>
                  {status ? String(status).toUpperCase() : 'UNKNOWN'}
                </Box>
              </LabeledList.Item>
            </LabeledList>
            {!active ? (
              <Box mt={2}>
                <Button icon="play" content="Activate Cycle" color="good" onClick={() => act('activate')} />
              </Box>
            ) : null}
          </Section>
          {children}
        </Box>
      </Window.Content>
    </Window>
  );
};

export const ScpFemurBreaker = (props, context) => {
  const { act, data } = useBackend(context);
  const { occupied, victim_name, victim_health, scp106_status } = data;
  return (
    <RecontainmentWindow
      title="SCP-106 FEMUR BREAKER"
      subtitle="RECONTAINMENT PROTOCOL 106-A"
      active={data.active}
      time_left={data.time_left || 0}
      status={scp106_status}
    >
      <Section title="Subject Bay">
        {occupied ? (
          <LabeledList>
            <LabeledList.Item label="Subject">{victim_name}</LabeledList.Item>
            <LabeledList.Item label="Vitals">
              <ProgressBar value={victim_health} minValue={0} maxValue={100}
                ranges={{ good: [60, 100], average: [30, 60], bad: [0, 30] }}>
                {victim_health}%
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Controls">
              <Button icon="sign-out-alt" content="Release Subject" onClick={() => act('exit')} />
            </LabeledList.Item>
          </LabeledList>
        ) : (
          <Box>
            <Box style={{ color: '#6a6a70' }} mb={1}>No subject. A human subject is required to operate the lure.</Box>
            <Button icon="sign-in-alt" content="Enter Device" color="bad" onClick={() => act('enter')} />
          </Box>
        )}
      </Section>
      {occupied && !data.active ? (
        <Section title="Lure Protocol">
          <Button icon="warning" content="ACTIVATE FEMUR BREAKER" color="bad" onClick={() => act('activate')} />
          <Box style={{ color: '#6a6a70', fontSize: '10px', mt: 1 }}>
            WARNING: Subject will sustain severe injury. SCP-106 will be drawn to this device.
          </Box>
        </Section>
      ) : null}
    </RecontainmentWindow>
  );
};

export const ScpCureStation = (props, context) => {
  const { data } = useBackend(context);
  return (
    <RecontainmentWindow
      title="SCP-049 CURE STATION"
      subtitle="RECONTAINMENT PROTOCOL 049-A"
      active={data.active}
      time_left={data.time_left || 0}
      status={data.scp049_status}
    >
      <Section title="Broadcast">
        <Box style={{ color: '#6a6a70' }}>
          Broadcasts a corrupted-cure signal across the local network. SCP-049 will be drawn to this station for 'treatment'.
        </Box>
      </Section>
    </RecontainmentWindow>
  );
};

export const ScpSuppression = (props, context) => {
  const { data } = useBackend(context);
  return (
    <RecontainmentWindow
      title="SCP-457 SUPPRESSION SYSTEM"
      subtitle="FUEL STARVATION PROTOCOL 457-A"
      active={data.active}
      time_left={data.time_left || 0}
      status={data.scp457_status}
    >
      <Section title="Suppression">
        <Box style={{ color: '#6a6a70' }}>
          Floods the local sector with fuel-starved atmosphere. SCP-457 will contract and follow the suppression gradient back to this unit.
        </Box>
      </Section>
    </RecontainmentWindow>
  );
};

export const ScpDampener = (props, context) => {
  const { data } = useBackend(context);
  return (
    <RecontainmentWindow
      title="SCP-939 SOUND DAMPENER"
      subtitle="ACOUSTIC LURE PROTOCOL 939-A"
      active={data.active}
      time_left={data.time_left || 0}
      status={data.scp939_status}
    >
      <Section title="Acoustic Lure">
        <Box style={{ color: '#6a6a70' }}>
          Simulates pack vocalizations. SCP-939 instances will follow the call back to this pen.
        </Box>
      </Section>
    </RecontainmentWindow>
  );
};

export const ScpIncinerator = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <RecontainmentWindow
      title="SCP-008 DECONTAMINATION INCINERATOR"
      subtitle="BIOHAZARD PROTOCOL 008-C"
      active={data.active}
      time_left={data.time_left || 0}
      status="n/a"
    >
      <Section title="Burn Cycle">
        <Box style={{ color: '#6a6a70' }} mb={1}>
          High-heat interior cycle. Destroys infected remains and biohazards placed inside.
        </Box>
        {!data.active ? <Button icon="fire" content="Ignite Burners" color="bad" onClick={() => act('activate')} /> : null}
      </Section>
    </RecontainmentWindow>
  );
};

export const ScpSpeaker = (props, context) => {
  const { data } = useBackend(context);
  return (
    <RecontainmentWindow
      title="SCP-1507 PACIFICATION SPEAKER"
      subtitle="AVIAN HERDING PROTOCOL 1507-A"
      active={data.active}
      time_left={data.time_left || 0}
      status="n/a"
    >
      <Section title="Herding Call">
        <Box style={{ color: '#6a6a70' }}>
          Territorial squawk broadcast. Scatters and herds instances toward their enclosure.
        </Box>
      </Section>
    </RecontainmentWindow>
  );
};
