import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, ProgressBar } from '../components';
import { Window } from '../layouts';

export const ShieldWallGen = (props, context) => {
  const { act, data } = useBackend(context);
  const { draw, power, maxpower, current_draw, online } = data;
  return (
    <Window width={800} height={500}>
      <Window.Content>
        <Section title="Shield Generator">
          <LabeledList>
            <LabeledList.Item label="Status">
              <Button
                icon={online ? 'power-off' : 'power-off'}
                content={online ? 'Online' : 'Offline'}
                selected={online}
                onClick={() => act('toggle')} />
            </LabeledList.Item>
            <LabeledList.Item label="Stored Power">
              <ProgressBar value={power / maxpower}>
                {power} / {maxpower}
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Power Draw">{draw}</LabeledList.Item>
            <LabeledList.Item label="Current Draw">{current_draw}</LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
