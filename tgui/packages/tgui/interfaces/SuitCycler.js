import { useBackend } from '../backend';
import { Box, Button, Section } from '../components';
import { Window } from '../layouts';

const C = {
  bg: '#0a0a0c',
  panel: '#111114',
  border: '#2a2a30',
  borderRed: '#6b0000',
  amber: '#c2960e',
  text: '#c8c8c8',
  textDim: '#7a7a80',
  danger: '#c0392b',
  ok: '#4caf50',
  mono: 'Consolas, monospace',
};

export const SuitCycler = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    active,
    locked,
    model_text,
    emagged,
    can_unlock,
    helmet,
    suit,
    can_repair,
    radiation_level,
    modifications = [],
    species = [],
    rad_levels = [],
  } = data;
  const label = model_text ? model_text + ' ' : '';

  return (
    <Window width={420} height={560}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.borderRed, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>SUIT CYCLER</Box>
          </Box>

          {active ? (
            <Section title="In Use" style={{ border: '1px solid ' + C.border }}>
              <Box style={{ color: C.danger }}>
                The {label}suit cycler is currently in use. Please wait...
              </Box>
            </Section>
          ) : locked ? (
            <Section title="Locked" style={{ border: '1px solid ' + C.border }}>
              <Box style={{ color: C.danger }}>
                The {label}suit cycler is currently locked. Please contact your system administrator.
              </Box>
              {can_unlock ? (
                <Button
                  mt={1}
                  content="Unlock Unit"
                  onClick={() => act('toggle_lock')} />
              ) : null}
            </Section>
          ) : (
            <>
              <Section title="Suit Cycler" style={{ border: '1px solid ' + C.border }}>
                <Box>Welcome to the {label}suit cycler control panel.</Box>
                <Button
                  mt={1}
                  content="Lock Unit"
                  onClick={() => act('toggle_lock')} />
              </Section>

              <Section title="Maintenance" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
                <Box mb={0.5}>
                  <Box inline mr={1}>Helmet:</Box>
                  {helmet || 'no helmet stored'}
                  {helmet && (
                    <Button
                      inline
                      ml={1}
                      content="Eject"
                      onClick={() => act('eject_helmet')} />
                  )}
                </Box>
                <Box mb={0.5}>
                  <Box inline mr={1}>Suit:</Box>
                  {suit || 'no suit stored'}
                  {suit && (
                    <Button
                      inline
                      ml={1}
                      content="Eject"
                      onClick={() => act('eject_suit')} />
                  )}
                  {can_repair ? (
                    <Button
                      inline
                      ml={1}
                      content="Repair"
                      onClick={() => act('repair_suit')} />
                  ) : null}
                </Box>
              </Section>

              <Section title="UV Decontamination" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
                <Box mb={0.5}>
                  <Box inline mr={1}>System:</Box>
                  <Box inline style={{ color: emagged ? C.danger : C.ok }}>
                    {emagged ? 'SYSTEM ERROR' : 'READY'}
                  </Box>
                </Box>
                <Box mb={0.5}>Output level: {radiation_level}</Box>
                <Box mb={0.5}>
                  {rad_levels.map((level) => (
                    <Button
                      key={level.level}
                      inline
                      mr={0.5}
                      mb={0.5}
                      content={'Level ' + level.level}
                      selected={level.selected}
                      onClick={() => act('select_rad_level', { level: level.level })} />
                  ))}
                </Box>
                <Button
                  mt={1}
                  content="Begin Decontamination Cycle"
                  onClick={() => act('begin_decontamination')} />
              </Section>

              <Section title="Customisation" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
                <Box mb={0.5}>Target Department:</Box>
                <Box mb={1}>
                  {modifications.map((modification) => (
                    <Button
                      key={modification.ref}
                      inline
                      mr={0.5}
                      mb={0.5}
                      content={modification.name}
                      selected={modification.selected}
                      onClick={() => act('select_department', { modification: modification.ref })} />
                  ))}
                </Box>
                <Box mb={0.5}>Target Species:</Box>
                <Box mb={1}>
                  {species.map((spec) => (
                    <Button
                      key={spec.name}
                      inline
                      mr={0.5}
                      mb={0.5}
                      content={spec.name}
                      selected={spec.selected}
                      onClick={() => act('select_species', { species: spec.name })} />
                  ))}
                </Box>
                <Button
                  content="Apply Customisation Routine"
                  onClick={() => act('apply_paintjob')} />
              </Section>
            </>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
