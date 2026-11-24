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

export const Blueprints = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    station_name,
    company_name,
    outpost,
    is_space,
    is_station,
    area_name,
    has_apc,
  } = data;

  return (
    <Window width={340} height={300}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>
              {outpost ? 'EXOPLANETARY OUTPOST BLUEPRINTS' : `${station_name || ''} BLUEPRINTS`}
            </Box>
            <Box style={{ color: C.textDim, fontSize: '9px' }}>
              Property of {company_name || 'the facility'}.{outpost ? '' : ' For heads of staff only. Store in high-secure storage.'}
            </Box>
          </Box>

          <Section title="Current Location" style={{ border: '1px solid ' + C.border }}>
            {is_space ? (
              <>
                <Box>According to the blueprints, you are now outside the facility.</Box>
                <Box mt={1}>
                  <Button
                    inline
                    icon="plus"
                    content="Mark this place as new area."
                    onClick={() => act('create_area')} />
                </Box>
              </>
            ) : is_station ? (
              <>
                <Box>According to the blueprints, you are now in "{area_name || ''}".</Box>
                <Box mt={1}>
                  <Button
                    inline
                    icon="pen"
                    content="Move an amendment"
                    onClick={() => act('edit_area')} />
                </Box>
                {has_apc ? (
                  <Box mt={1} style={{ color: C.textDim }}>You can't erase this area, because it has an APC.</Box>
                ) : (
                  <Box mt={1}>
                    <Button
                      inline
                      icon="eraser"
                      content="Erase a part of it"
                      onClick={() => act('delete_area')} />
                  </Box>
                )}
              </>
            ) : (
              <Box>This place isn't noted on the blueprints.</Box>
            )}
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
