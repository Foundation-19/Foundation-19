import { useBackend } from '../backend';
import { Box, Button, Section } from '../components';
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

export const Pandemic = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    has_beaker,
    has_blood,
    selected_symptom,
    diseases = [],
    vaccines = [],
  } = data;

  return (
    <Window width={400} height={600}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>PAN.D.E.M.I.C. 2200</Box>
          </Box>

          {!has_beaker ? (
            <Box style={{ color: '#cc2222' }}>No beaker installed.</Box>
          ) : !has_blood ? (
            <Box style={{ color: '#cc2222' }}>The beaker does not contain blood!</Box>
          ) : (
            <Box>
              {diseases.map((disease) => (
                <Section
                  key={disease.index}
                  title={'Disease #' + disease.index + ': ' + disease.name}
                  style={{ border: '1px solid ' + C.border, background: C.panel, marginBottom: '8px' }}>
                  {disease.can_rename ? (
                    <Box mb={0.5}>
                      <Button
                        inline
                        icon="edit"
                        content={'Rename "' + disease.name + '"'}
                        onClick={() => act('rename_disease', { index: disease.index })} />
                    </Box>
                  ) : null}
                  <Box mb={0.5}>{disease.description}</Box>
                  <Box mb={0.5}>Spread: {disease.spread}</Box>
                  <Box mb={0.5}>Cure: {disease.cure}</Box>

                  {disease.is_adv ? (
                    <Box mt={1}>
                      <Box style={{ color: C.textDim }}>Current stats:</Box>
                      <Box>- Stealth: {disease.stealth}</Box>
                      <Box>- Resistance: {disease.resistance}</Box>
                      <Box>- Stage Speed: {disease.stage_speed}</Box>
                      <Box>- Transmission: {disease.transmission}</Box>

                      <Box mt={1} style={{ color: C.textDim }}>Symptoms:</Box>
                      {(disease.symptoms || []).map((symptom) => (
                        <Box key={symptom.name} mt={0.5}>
                          <Button
                            inline
                            icon={selected_symptom === symptom.name ? 'minus' : 'plus'}
                            content={symptom.name}
                            onClick={() => act('choose_symptom', { name: selected_symptom === symptom.name ? 'none' : symptom.name })} />
                          {selected_symptom === symptom.name ? (
                            <Box mt={0.5} style={{ paddingLeft: '8px', borderLeft: '2px solid ' + C.amber }}>
                              <Box mb={0.5}>{symptom.desc}</Box>
                              <Box>- Level: {symptom.level}</Box>
                              <Box>- Stealth: {symptom.stealth}</Box>
                              <Box>- Resistance: {symptom.resistance}</Box>
                              <Box>- Stage Speed: {symptom.stage_speed}</Box>
                              <Box>- Transmission: {symptom.transmission}</Box>
                              {symptom.threshold_desc && Object.keys(symptom.threshold_desc).length ? (
                                <Box mt={0.5}>
                                  <Box style={{ color: C.textDim }}>Thresholds:</Box>
                                  {Object.keys(symptom.threshold_desc).map((threshold) => (
                                    <Box key={threshold}>- {threshold}: {symptom.threshold_desc[threshold]}</Box>
                                  ))}
                                </Box>
                              ) : null}
                            </Box>
                          ) : null}
                        </Box>
                      ))}
                    </Box>
                  ) : null}
                </Section>
              ))}

              {vaccines.length ? (
                <Section title="Antibodies detected for the following diseases" style={{ border: '1px solid ' + C.border, background: C.panel, marginBottom: '8px' }}>
                  {vaccines.map((vaccine, i) => (
                    <Box key={i} mb={0.5}>
                      <Button
                        inline
                        icon="flask"
                        content={vaccine.name}
                        onClick={() => act('create_vaccine_bottle', { id: vaccine.id })} />
                    </Box>
                  ))}
                </Section>
              ) : null}

              {!diseases.length && !vaccines.length ? (
                <Box style={{ color: C.textDim }}>Cannot detect any visible diseases or antibodies.</Box>
              ) : null}
            </Box>
          )}

          <Box mt={1}>
            <Button icon="eject" content="Remove beaker" onClick={() => act('remove_beacon')} />
          </Box>
        </Box>
      </Window.Content>
    </Window>
  );
};
