import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

const C = {
  bg: '#0a0a0c',
  panel: '#111114',
  border: '#2a2a30',
  amber: '#c2960e',
  text: '#c8c8c8',
  textDim: '#7a7a80',
  mono: 'Consolas, monospace',
};

export const TVCamera = (props, context) => {
  const { act, data } = useBackend(context);
  const { on, focus, channel, video, sound, frequency, frequency_name } = data;

  return (
    <Window width={360} height={390}>
      <Window.Content scrollable>
        <Box
          style={{
            background: C.bg,
            minHeight: '100%',
            padding: '10px',
            fontFamily: C.mono,
            color: C.text,
          }}>
          <Box
            style={{
              borderBottom: '2px solid ' + C.border,
              paddingBottom: '6px',
              marginBottom: '10px',
            }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>
              EYEBUDDY PRESS CAMERA
            </Box>
          </Box>

          <Section style={{ border: '1px solid ' + C.border }}>
            <LabeledList>
              <LabeledList.Item label="Photography Mode">
                <Button
                  inline
                  color={on ? 'green' : 'red'}
                  content={on ? 'On' : 'Off'}
                  onClick={() => act('photo')}
                />
              </LabeledList.Item>
              <LabeledList.Item label="Photography Focus">
                <Button inline content={focus} onClick={() => act('focus')} />
              </LabeledList.Item>
              <LabeledList.Item label="Channel Name">
                <Button inline content={channel} onClick={() => act('channel')} />
              </LabeledList.Item>
              <LabeledList.Item label="Video Streaming">
                <Button
                  inline
                  color={video ? 'green' : 'red'}
                  content={video ? 'Online' : 'Offline'}
                  onClick={() => act('video')}
                />
              </LabeledList.Item>
              <LabeledList.Item label="Microphone">
                <Button
                  inline
                  color={sound ? 'green' : 'red'}
                  content={sound ? 'Online' : 'Offline'}
                  onClick={() => act('sound')}
                />
              </LabeledList.Item>
            </LabeledList>
          </Section>

          <Box mt={1} style={{ color: C.textDim, fontSize: '10px' }}>
            Broadcasting on frequency {frequency} ({frequency_name})
          </Box>
        </Box>
      </Window.Content>
    </Window>
  );
};
