import { useBackend } from '../backend';
import { Box, Button, Flex, Section } from '../components';
import { Window } from '../layouts';

export const CameraConsole = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    current_camera,
    current_network,
    networks = [],
    cameras = [],
  } = data;

  return (
    <Window theme="scp_terminal" width={620} height={640}>
      <Window.Content scrollable>
        <Box style={{ background: '#0a0a0c', minHeight: '100%', padding: '10px', fontFamily: '"Consolas", monospace', color: '#c8c8c8' }}>
          <Box style={{ borderBottom: '2px solid #6b0000', paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: '#d4a017', letterSpacing: '0.15em', fontWeight: 'bold' }}>CAMERA CONSOLE</Box>
            <Box style={{ color: '#6a6a70', fontSize: '9px' }}>
              {current_camera ? 'WATCHING: ' + current_camera.name : 'NETWORK: ' + (current_network || 'NONE')}
            </Box>
          </Box>

          {current_camera ? (
            <Section title="Active Feed" buttons={
              <Button icon="stop" content="Stop" onClick={() => act('reset')} />
            }>
              <Box style={{ color: '#44ff44' }}>Tracking: {current_camera.name}</Box>
              <Box style={{ color: '#6a6a70', fontSize: '10px' }}>
                Position: ({current_camera.x}, {current_camera.y}, {current_camera.z})
              </Box>
            </Section>
          ) : null}

          <Section title="Networks">
            <Flex wrap="wrap">
              {networks.map((n) => (
                <Flex.Item key={n.tag} mr={0.5} mb={0.5}>
                  <Button
                    content={n.tag}
                    disabled={!n.has_access}
                    selected={current_network === n.tag}
                    onClick={() => act('switch_network', { switch_network: n.tag })}
                  />
                </Flex.Item>
              ))}
            </Flex>
          </Section>

          {current_network && cameras.length > 0 ? (
            <Section title={'Cameras — ' + current_network}>
              {cameras.map((cam, i) => (
                <Flex key={i} align="center" mb={0.5}>
                  <Box style={{ flex: 1 }}>
                    {cam.name}
                    {cam.deact ? <Box inline ml={1} style={{ color: '#cc2222' }}>[OFFLINE]</Box> : null}
                  </Box>
                  <Button
                    icon="video"
                    content="Watch"
                    disabled={cam.deact}
                    onClick={() => act('switch_camera', { switch_camera: cam.camera })}
                  />
                </Flex>
              ))}
            </Section>
          ) : null}
        </Box>
      </Window.Content>
    </Window>
  );
};
