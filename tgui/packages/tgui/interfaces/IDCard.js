import { useBackend } from '../backend';
import { Box, LabeledList, Section } from '../components';
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

export const IDCard = (props, context) => {
  const { data } = useBackend(context);
  const {
    registered_name,
    sex,
    age,
    class: cardClass,
    assignment,
    fingerprint_hash,
    blood_type,
    dna_hash,
    has_photo,
  } = data;

  return (
    <Window width={600} height={250}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>IDENTIFICATION CARD</Box>
          </Box>

          <Section title="Card Details" style={{ border: '1px solid ' + C.border }}>
            <LabeledList>
              <LabeledList.Item label="Name">{registered_name || '-'}</LabeledList.Item>
              <LabeledList.Item label="Sex">{sex || '-'}</LabeledList.Item>
              <LabeledList.Item label="Age">{age == null ? '-' : age}</LabeledList.Item>
              <LabeledList.Item label="Class">{cardClass || '-'}</LabeledList.Item>
              <LabeledList.Item label="Assignment">{assignment || '-'}</LabeledList.Item>
              <LabeledList.Item label="Fingerprint">{fingerprint_hash || '-'}</LabeledList.Item>
              <LabeledList.Item label="Blood Type">{blood_type || '-'}</LabeledList.Item>
              <LabeledList.Item label="DNA Hash">{dna_hash || '-'}</LabeledList.Item>
            </LabeledList>
          </Section>

          {has_photo ? (
            <Section title="Photo" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
              <Box inline mr={1}>
                <img src="front.png" style={{ width: '70px', imageRendering: 'pixelated' }} />
              </Box>
              <Box inline>
                <img src="side.png" style={{ width: '70px', imageRendering: 'pixelated' }} />
              </Box>
            </Section>
          ) : null}
        </Box>
      </Window.Content>
    </Window>
  );
};
