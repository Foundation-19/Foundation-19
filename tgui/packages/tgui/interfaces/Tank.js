import { useBackend } from '../backend';
import { Box, Button, LabeledList, NumberInput, Section } from '../components';
import { Window } from '../layouts';

export const Tank = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    tankPressure,
    releasePressure,
    defaultReleasePressure,
    maxReleasePressure,
    valveOpen,
    maskConnected,
  } = data;

  return (
    <Window width={500} height={300} resizable>
      <Window.Content>
        <Section title="Tank">
          <LabeledList>
            <LabeledList.Item label="Tank Pressure">
              {tankPressure} kPa
            </LabeledList.Item>
            <LabeledList.Item label="Release Pressure">
              <NumberInput
                value={releasePressure}
                minValue={0}
                maxValue={maxReleasePressure}
                step={10}
                stepPixelSize={3}
                width="80px"
                onChange={(e, value) => act('dist_p', { dist_p: value - releasePressure })} />
              <Button
                icon="fast-backward"
                onClick={() => act('dist_p', { dist_p: 'reset' })} />
              <Button
                icon="backward"
                onClick={() => act('dist_p', { dist_p: -10 })} />
              <Button
                icon="forward"
                onClick={() => act('dist_p', { dist_p: 10 })} />
              <Button
                icon="fast-forward"
                onClick={() => act('dist_p', { dist_p: 'max' })} />
            </LabeledList.Item>
            <LabeledList.Item label="Valve">
              <Button
                icon={valveOpen ? 'toggle-on' : 'toggle-off'}
                content={valveOpen ? 'Open' : 'Closed'}
                selected={valveOpen}
                disabled={!maskConnected}
                onClick={() => act('stat')} />
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
