import { useBackend } from '../backend';
import { Box, LabeledList, ProgressBar, Section } from '../components';
import { Window } from '../layouts';

export const InstrumentUsageInfo = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    channels_left,
    events_active,
    max_channels,
    max_events,
  } = data;
  return (
    <Window width={500} height={150}>
      <Window.Content>
        <Section title="Usage Info">
          <LabeledList>
            <LabeledList.Item label="Channels">
              <ProgressBar
                value={channels_left / max_channels}
                ranges={{ good: [0.5, Infinity], average: [0.15, 0.5], bad: [-Infinity, 0.15] }}>
                {channels_left} / {max_channels}
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Events">
              <ProgressBar
                value={events_active / max_events}
                ranges={{ good: [-Infinity, 0.5], average: [0.5, 0.8], bad: [0.8, Infinity] }}>
                {events_active} / {max_events}
              </ProgressBar>
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
