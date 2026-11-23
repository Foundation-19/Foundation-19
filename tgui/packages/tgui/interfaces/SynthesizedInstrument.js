import { useBackend } from '../backend';
import { Box, Button, LabeledList, NumberInput, Section, ProgressBar, Flex } from '../components';
import { Window } from '../layouts';

export const SynthesizedInstrument = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    playback,
    basic_options,
    advanced_options,
    sustain,
    show,
    status,
  } = data;
  return (
    <Window width={600} height={800} resizable>
      <Window.Content scrollable>
        <Section title="Playback">
          <LabeledList>
            <LabeledList.Item label="Status">
              <Button
                icon={playback.playing ? 'pause' : 'play'}
                content={playback.playing ? 'Stop' : 'Play'}
                selected={playback.playing}
                onClick={() => act('play', { value: playback.playing ? 0 : 1 })} />
              <Button
                icon="repeat"
                content={playback.autorepeat ? 'Repeat ON' : 'Repeat OFF'}
                selected={playback.autorepeat}
                onClick={() => act('autorepeat', { value: playback.autorepeat ? 0 : 1 })} />
            </LabeledList.Item>
            <LabeledList.Item label="Tempo">
              <Button icon="minus" onClick={() => act('tempo', { value: -1 })} />
              <Box inline mx={1}>{basic_options.BPM} BPM</Box>
              <Button icon="plus" onClick={() => act('tempo', { value: 1 })} />
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Basic Options">
          <LabeledList>
            <LabeledList.Item label="Instrument">
              <Button content={basic_options.cur_instrument} onClick={() => act('instrument')} />
            </LabeledList.Item>
            <LabeledList.Item label="Volume">
              <Button icon="minus" onClick={() => act('volume', { value: -5 })} />
              <Box inline mx={1}>{basic_options.volume}</Box>
              <Button icon="plus" onClick={() => act('volume', { value: 5 })} />
            </LabeledList.Item>
            <LabeledList.Item label="Transposition">
              <Button icon="minus" onClick={() => act('transposition', { value: -1 })} />
              <Box inline mx={1}>{basic_options.transposition}</Box>
              <Button icon="plus" onClick={() => act('transposition', { value: 1 })} />
            </LabeledList.Item>
            <LabeledList.Item label="Octave Range">
              <Button icon="minus" onClick={() => act('min_octave', { value: -1 })} />
              <Box inline mx={1}>{basic_options.octave_range.min} - {basic_options.octave_range.max}</Box>
              <Button icon="plus" onClick={() => act('max_octave', { value: 1 })} />
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Song" buttons={
          <>
            <Button content="New Song" onClick={() => act('newsong')} />
            <Button content="Import" onClick={() => act('import')} />
          </>
        }>
          <Button content="Song Editor" onClick={() => act('show_song_editor')} />
          <Button content="Usage Info" onClick={() => act('show_usage')} />
        </Section>
        <Section title="Sustain">
          <LabeledList>
            <LabeledList.Item label="Linear Decay">
              <Button
                icon={sustain.linear_decay_active ? 'toggle-on' : 'toggle-off'}
                content={sustain.linear_decay_active ? 'On' : 'Off'}
                selected={sustain.linear_decay_active}
                onClick={() => act('decay', { value: sustain.linear_decay_active ? 0 : 1 })} />
            </LabeledList.Item>
            <LabeledList.Item label="Sustain Timer">
              <Button icon="minus" onClick={() => act('sustain_timer', { value: -1 })} />
              <Box inline mx={1}>{sustain.sustain_timer}</Box>
              <Button icon="plus" onClick={() => act('sustain_timer', { value: 1 })} />
            </LabeledList.Item>
            <LabeledList.Item label="Softness">
              <Button content={sustain.soft_coeff} onClick={() => act('soft_coeff')} />
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Advanced">
          <LabeledList>
            <LabeledList.Item label="Echo">
              <Button
                icon={advanced_options.apply_echo ? 'toggle-on' : 'toggle-off'}
                content={advanced_options.apply_echo ? 'On' : 'Off'}
                selected={advanced_options.apply_echo}
                onClick={() => act('echo', { value: advanced_options.apply_echo ? 0 : 1 })} />
              <Button content="Echo Editor" onClick={() => act('show_echo_editor')} />
            </LabeledList.Item>
            <LabeledList.Item label="Environment">
              <Button content={advanced_options.selected_environment} onClick={() => act('select_env')} />
              {!!show.env_settings && (
                <Button content="Env Editor" onClick={() => act('show_env_editor')} />
              )}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Status">
          <LabeledList>
            <LabeledList.Item label="Channels">
              <ProgressBar
                value={status.channels / status.max_channels}
                ranges={{ good: [-Infinity, 0.5], average: [0.5, 0.8], bad: [0.8, Infinity] }}>
                {status.channels} / {status.max_channels}
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Events">
              <ProgressBar
                value={status.events / status.max_events}
                ranges={{ good: [-Infinity, 0.5], average: [0.5, 0.8], bad: [0.8, Infinity] }}>
                {status.events} / {status.max_events}
              </ProgressBar>
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
