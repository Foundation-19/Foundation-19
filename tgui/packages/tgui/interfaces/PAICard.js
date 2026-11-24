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

export const PAICard = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    has_pai,
    looking_for_personality,
    has_radio,
    pai_name,
    pai_law0,
    pai_laws,
    can_set_dna,
    broadcasting,
    listening,
  } = data;

  return (
    <Window width={480} height={420}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>PERSONAL AI DEVICE</Box>
          </Box>

          {has_pai ? (
            <>
              <Section title="Installed Personality" style={{ border: '1px solid ' + C.border }}>
                <LabeledList>
                  <LabeledList.Item label="Installed Personality">{pai_name}</LabeledList.Item>
                  <LabeledList.Item label="Prime directive">{pai_law0}</LabeledList.Item>
                  <LabeledList.Item label="Additional directives">{pai_laws}</LabeledList.Item>
                </LabeledList>
                <Box mt={1}>
                  <Button
                    inline
                    mr={0.5}
                    icon="cog"
                    content="Configure Directives"
                    onClick={() => act('setlaws')} />
                  {can_set_dna ? (
                    <Button
                      inline
                      mr={0.5}
                      icon="dna"
                      content="Imprint Master DNA"
                      onClick={() => act('setdna')} />
                  ) : null}
                </Box>
              </Section>

              <Section title="Radio Uplink" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
                {has_radio ? (
                  <LabeledList>
                    <LabeledList.Item label="Transmit">
                      <Button
                        inline
                        content={broadcasting ? 'Enabled' : 'Disabled'}
                        color={broadcasting ? 'good' : 'bad'}
                        onClick={() => act('wires', { wires: 4 })} />
                    </LabeledList.Item>
                    <LabeledList.Item label="Receive">
                      <Button
                        inline
                        content={listening ? 'Enabled' : 'Disabled'}
                        color={listening ? 'good' : 'bad'}
                        onClick={() => act('wires', { wires: 2 })} />
                    </LabeledList.Item>
                  </LabeledList>
                ) : (
                  <Box style={{ color: '#cc2222' }}>Radio firmware not loaded. Please install a pAI personality to load firmware.</Box>
                )}
              </Section>

              <Section style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
                <Button
                  inline
                  color="bad"
                  icon="trash"
                  content="Wipe current pAI personality"
                  onClick={() => act('wipe')} />
              </Section>
            </>
          ) : looking_for_personality ? (
            <Section title="pAI Request Module" style={{ border: '1px solid ' + C.border }}>
              <Box>Requesting AI personalities from central database... If there are no entries, or if a suitable entry is not listed, check again later as more personalities may be added.</Box>
              <Box mt={1} style={{ color: C.amber }}>Searching for personalities</Box>
              <Box mt={1}>
                <Button
                  inline
                  icon="sync"
                  content="Refresh available personalities"
                  onClick={() => act('request')} />
              </Box>
            </Section>
          ) : (
            <Section title="pAI Request Module" style={{ border: '1px solid ' + C.border }}>
              <Box>No personality is installed.</Box>
              <Box mt={1}>
                <Button
                  inline
                  icon="download"
                  content="Request personality"
                  onClick={() => act('request')} />
              </Box>
              <Box mt={1} style={{ color: C.textDim }}>
                Each time this button is pressed, a request will be sent out to any available personalities. Check back often give plenty of time for personalities to respond. This process could take anywhere from 15 seconds to several minutes, depending on the available personalities' timeliness.
              </Box>
            </Section>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
