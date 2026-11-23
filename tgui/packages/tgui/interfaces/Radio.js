import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, NumberInput } from '../components';
import { Window } from '../layouts';

export const Radio = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    power,
    mic_status,
    speaker,
    freq,
    default_freq,
    rawfreq,
    charge,
    mic_cut,
    spk_cut,
    chan_list,
    chan_list_len,
    useSyndMode,
    has_loudspeaker,
    loudspeaker,
    has_subspace,
    subspace,
  } = data;
  return (
    <Window width={400} height={430}>
      <Window.Content scrollable>
        <Section>
          <LabeledList>
            <LabeledList.Item label="Power">
              <Button selected={power} onClick={() => act('power')}>
                {power ? "On" : "Off"}
              </Button>
            </LabeledList.Item>
            <LabeledList.Item label="Microphone">
              <Button selected={mic_status} disabled={mic_cut} onClick={() => act('talk')}>
                {mic_cut ? "CUT" : mic_status ? "On" : "Off"}
              </Button>
            </LabeledList.Item>
            <LabeledList.Item label="Speaker">
              <Button selected={speaker} disabled={spk_cut} onClick={() => act('listen')}>
                {spk_cut ? "CUT" : speaker ? "On" : "Off"}
              </Button>
            </LabeledList.Item>
            <LabeledList.Item label="Frequency">
              {freq} kHz
              <Button ml={1} onClick={() => act('freq', { freq: -2 })}>-</Button>
              <Button ml={1} onClick={() => act('freq', { freq: 2 })}>+</Button>
              {!!default_freq && <Button ml={1} onClick={() => act('default_freq')}>Reset</Button>}
            </LabeledList.Item>
            {!!charge && <LabeledList.Item label="Battery">{charge}</LabeledList.Item>}
            {!!has_loudspeaker && (
              <LabeledList.Item label="Loudspeaker">
                <Button selected={loudspeaker} onClick={() => act('shutup', { shutup: loudspeaker ? 0 : 1 })}>
                  {loudspeaker ? "On" : "Off"}
                </Button>
              </LabeledList.Item>
            )}
            {!!has_subspace && (
              <LabeledList.Item label="Subspace">
                <Button selected={subspace} onClick={() => act('mode', { mode: subspace ? 0 : 1 })}>
                  {subspace ? "On" : "Off"}
                </Button>
              </LabeledList.Item>
            )}
          </LabeledList>
        </Section>
        {!!chan_list && chan_list_len > 0 && (
          <Section title="Channels">
            {chan_list.map((ch, i) => (
              <Box key={i} mb={1}>
                {!!ch.sec_channel_listen ? (
                  <Button onClick={() => act('listen', { ch_name: ch.chan })}>
                    {ch.chan} {ch.sec_channel_listen ? "[Locked]" : ""}
                  </Button>
                ) : (
                  <Button selected={!ch.sec_channel_listen} onClick={() => act('listen', { ch_name: ch.chan })}>
                    {ch.chan}
                  </Button>
                )}
                {!!ch.sec_channel && (
                  <Button ml={1} icon={ch.sec_channel_listen ? "lock" : "unlock"} onClick={() => act('listen', { ch_name: ch.chan })}>
                    Listen
                  </Button>
                )}
              </Box>
            ))}
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
