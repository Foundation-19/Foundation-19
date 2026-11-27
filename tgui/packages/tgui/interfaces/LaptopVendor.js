import { useBackend } from '../backend';
import { Box, Button, Flex, LabeledList, NumberInput, Section } from '../components';
import { Window } from '../layouts';

const C = {
  bg: '#0a0a0c',
  border: '#2a2a30',
  borderRed: '#6b0000',
  amber: '#d4a017',
  text: '#c8c8c8',
  textDim: '#6a6a70',
  good: '#0a6e0a',
  mono: '"Consolas", "Courier New", monospace',
};

// Option row: label + OFF/1/2/3-style buttons
const OptionRow = (props, context) => {
  const { act } = useBackend(context);
  const { label, action, value, options } = props;
  return (
    <LabeledList.Item label={label}>
      <Flex>
        {options.map((opt) => (
          <Flex.Item key={opt.value} mr={1}>
            <Button
              selected={value === opt.value}
              color={value === opt.value ? 'good' : undefined}
              content={opt.label}
              onClick={() => act(action, { [action]: opt.value })}
            />
          </Flex.Item>
        ))}
      </Flex>
    </LabeledList.Item>
  );
};

export const LaptopVendor = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    state,
    devtype,
    hw_battery = 1,
    hw_disk = 1,
    hw_netcard = 0,
    hw_tesla = 0,
    hw_nanoprint = 0,
    hw_card = 0,
    hw_cpu = 1,
    hw_aislot = 0,
    totalprice = 0,
  } = data;

  return (
    <Window theme="scp_terminal" width={520} height={520}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.borderRed, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>PERSONAL COMPUTER VENDOR</Box>
            <Box style={{ color: C.textDim, fontSize: '9px' }}>MICROFABRICATOR UNIT — SCiPNET CERTIFIED HARDWARE</Box>
          </Box>

          {state === 0 ? (
            <Section title="Select Device">
              <Box mb={1} style={{ color: C.textDim }}>Choose the device chassis to fabricate:</Box>
              <Flex direction="column">
                <Flex.Item mb={1}>
                  <Button fluid icon="laptop" content="LAPTOP — General purpose workstation" textAlign="center" onClick={() => act('pick_device', { pick_device: 1 })} />
                </Flex.Item>
                <Flex.Item mb={1}>
                  <Button fluid icon="tablet-alt" content="TABLET — Portable tablet computer" textAlign="center" onClick={() => act('pick_device', { pick_device: 2 })} />
                </Flex.Item>
              </Flex>
              <Box mt={2}>
                <Button icon="sync" content="Force Reset Vendor" tooltip="Clears any half-finished order left by a previous user" onClick={() => act('clean_order')} />
              </Box>
            </Section>
          ) : null}

          {state === 1 ? (
            <Section title="Configure Hardware" buttons={
              <Button icon="times" content="Reset" color="bad" onClick={() => act('clean_order')} />
            }>
              <LabeledList>
                <OptionRow
                  label="CPU"
                  action="hw_cpu"
                  value={hw_cpu}
                  options={[{ value: 1, label: 'Standard' }, { value: 2, label: 'Upgraded' }]} />
                <OptionRow
                  label="Battery"
                  action="hw_battery"
                  value={hw_battery}
                  options={[{ value: 1, label: 'Standard' }, { value: 2, label: 'Upgraded' }, { value: 3, label: 'Advanced' }]} />
                <OptionRow
                  label="Hard Drive"
                  action="hw_disk"
                  value={hw_disk}
                  options={[{ value: 1, label: 'Standard' }, { value: 2, label: 'Upgraded' }, { value: 3, label: 'Advanced' }]} />
                <OptionRow
                  label="Network Card"
                  action="hw_netcard"
                  value={hw_netcard}
                  options={[{ value: 0, label: 'None' }, { value: 1, label: 'Basic' }, { value: 2, label: 'Long-Range' }]} />
                {devtype === 1 ? (
                  <OptionRow
                    label="Tesla Link"
                    action="hw_tesla"
                    value={hw_tesla}
                    options={[{ value: 0, label: 'None' }, { value: 1, label: 'Standard' }]} />
                ) : null}
                <OptionRow
                  label="Nano Printer"
                  action="hw_nanoprint"
                  value={hw_nanoprint}
                  options={[{ value: 0, label: 'None' }, { value: 1, label: 'Standard' }]} />
                <OptionRow
                  label="ID Card Slot"
                  action="hw_card"
                  value={hw_card}
                  options={[{ value: 0, label: 'None' }, { value: 1, label: 'Standard' }]} />
                <OptionRow
                  label="Intellicard Slot"
                  action="hw_aislot"
                  value={hw_aislot}
                  options={[{ value: 0, label: 'None' }, { value: 1, label: 'Standard' }]} />
              </LabeledList>
              <Box mt={2} style={{ borderTop: '1px solid ' + C.border, paddingTop: '8px' }}>
                <Flex align="center">
                  <Box style={{ flex: 1, color: C.amber, fontSize: '14px' }}>TOTAL: {totalprice} cr</Box>
                  <Button icon="check" content="Confirm Order" color="good" onClick={() => act('confirm_order')} />
                </Flex>
              </Box>
            </Section>
          ) : null}

          {state === 2 ? (
            <Section title="Payment">
              <Box mb={1}>Total cost: <Box inline style={{ color: C.amber }}>{totalprice} cr</Box></Box>
              <Box mb={2} style={{ color: C.textDim }}>Swipe your ID card on the vendor to complete the purchase.</Box>
              <Button icon="undo" content="Cancel Order" onClick={() => act('clean_order')} />
            </Section>
          ) : null}

          {state === 3 ? (
            <Section title="Thank You">
              <Box style={{ color: C.good }}>Device fabricated. Please take your computer from the vendor.</Box>
              <Box mt={1}><Button icon="undo" content="Order Another" onClick={() => act('clean_order')} /></Box>
            </Section>
          ) : null}
        </Box>
      </Window.Content>
    </Window>
  );
};
