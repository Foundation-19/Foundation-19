import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, ProgressBar } from '../components';
import { Window } from '../layouts';

export const PAISoftwareModules = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    module,
    master,
    dna,
    prime,
    supplemental,
    listening,
    frequency,
    channels,
    crew_manifest,
    cable,
    machine,
    inprogress,
    progress_a,
    progress_b,
    aborted,
    reading,
    pressure,
    temperature,
    temperatureC,
    gas,
  } = data;
  return (
    <Window width={450} height={600}>
      <Window.Content scrollable>
        {module === "directives" && (
          <Section title="Directives">
            <LabeledList>
              <LabeledList.Item label="Master">{master || "None"}</LabeledList.Item>
              <LabeledList.Item label="Master DNA">{dna || "None"}</LabeledList.Item>
              <LabeledList.Item label="Prime Directive">{prime}</LabeledList.Item>
              <LabeledList.Item label="Supplemental Directives">{supplemental}</LabeledList.Item>
            </LabeledList>
            <Button mt={1} fluid onClick={() => act('getdna')}>Request DNA Sample</Button>
          </Section>
        )}
        {module === "radio" && (
          <Section title="Radio Configuration">
            <LabeledList>
              <LabeledList.Item label="Frequency">{frequency}</LabeledList.Item>
              <LabeledList.Item label="Broadcasting">
                <Button selected={listening} onClick={() => act('broadcast')}>{listening ? "On" : "Off"}</Button>
              </LabeledList.Item>
            </LabeledList>
            {channels && channels.map((ch, i) => (
              <Button key={i} mt={1} selected={ch.listening} onClick={() => act('channel', { channel: ch.name })}>
                {ch.name}
              </Button>
            ))}
          </Section>
        )}
        {module === "manifest" && (
          <Section title="Crew Manifest">
            <Box dangerouslySetInnerHTML={{ __html: crew_manifest }} />
          </Section>
        )}
        {module === "door_jack" && (
          <Section title="Door Jack">
            <LabeledList>
              <LabeledList.Item label="Cable">{cable ? "Deployed" : "Retracted"}</LabeledList.Item>
              <LabeledList.Item label="Machine">{machine ? "Connected" : "None"}</LabeledList.Item>
              <LabeledList.Item label="Progress">
                {inprogress ? `${progress_a}.${progress_b}%` : "Idle"}
              </LabeledList.Item>
            </LabeledList>
            <Button mt={1} fluid onClick={() => act('jack')} disabled={!cable || !machine}>Hack</Button>
            <Button mt={1} fluid onClick={() => act('cancel')} disabled={!inprogress}>Cancel</Button>
            <Button mt={1} fluid onClick={() => act('cable')} disabled={cable}>Deploy Cable</Button>
          </Section>
        )}
        {module === "atmos_sense" && (
          <Section title="Atmosphere Sensor">
            {!reading ? (
              <Box color="bad">No reading available.</Box>
            ) : (
              <LabeledList>
                <LabeledList.Item label="Pressure">{pressure} kPa</LabeledList.Item>
                <LabeledList.Item label="Temperature">{temperature}K ({temperatureC}C)</LabeledList.Item>
                <LabeledList.Item label="Gas Composition">
                  {gas && gas.map((g, i) => (
                    <Box key={i}>{g.name}: {g.percent}%</Box>
                  ))}
                </LabeledList.Item>
              </LabeledList>
            )}
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
