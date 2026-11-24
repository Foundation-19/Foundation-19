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

export const FaxMachine = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    scan_name,
    authenticated,
    has_item,
    item_name,
    destination,
    boss_name,
  } = data;

  return (
    <Window width={400} height={420}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.amber, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>FAX MACHINE</Box>
          </Box>

          <Box mb={1}>
            <Box inline style={{ color: C.textDim }}>Confirm Identity: </Box>
            <Button
              inline
              content={scan_name}
              onClick={() => act('scan')} />
          </Box>

          <Box mb={1}>
            {authenticated ? (
              <Button
                icon="sign-out"
                content="Log Out"
                onClick={() => act('logout')} />
            ) : (
              <Button
                icon="sign-in"
                content="Log In"
                onClick={() => act('auth')} />
            )}
          </Box>

          <Section title="Connection" style={{ border: '1px solid ' + C.border }}>
            {authenticated ? (
              <>
                <Box style={{ color: C.textDim, marginBottom: '6px' }}>
                  Logged in to: {boss_name} Quantum Entanglement Network
                </Box>
                {has_item ? (
                  <>
                    <LabeledList>
                      <LabeledList.Item label="Currently sending">
                        {item_name}
                      </LabeledList.Item>
                      <LabeledList.Item label="Sending to">
                        <Button
                          content={destination}
                          onClick={() => act('dept')} />
                      </LabeledList.Item>
                    </LabeledList>
                    <Box mt={1}>
                      <Button
                        inline
                        mr={0.5}
                        icon="paper-plane"
                        content="Send"
                        onClick={() => act('send')} />
                      <Button
                        inline
                        icon="eject"
                        content="Remove Item"
                        onClick={() => act('remove')} />
                    </Box>
                  </>
                ) : (
                  <Box style={{ color: C.textDim }}>
                    Please insert paper to send via secure connection.
                  </Box>
                )}
              </>
            ) : (
              <>
                <Box style={{ color: C.textDim, marginBottom: '6px' }}>
                  Proper authentication is required to use this device.
                </Box>
                {has_item ? (
                  <Button
                    icon="eject"
                    content="Remove Item"
                    onClick={() => act('remove')} />
                ) : null}
              </>
            )}
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
