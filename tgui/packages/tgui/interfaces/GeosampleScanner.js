import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, ProgressBar, NumberInput, Flex } from '../components';
import { Window } from '../layouts';

export const GeosampleScanner = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    scanned_item,
    scanned_item_desc,
    last_scan_data,
    scan_progress,
    scanning,
    scanner_seal_integrity,
    scanner_rpm,
    scanner_temperature,
    coolant_usage_rate,
    unused_coolant_abs,
    unused_coolant_per,
    coolant_purity,
    optimal_wavelength,
    maser_wavelength,
    maser_efficiency,
    radiation,
    t_left_radspike,
    rad_shield_on,
  } = data;
  return (
    <Window width={900} height={825}>
      <Window.Content scrollable>
        <Section title="High Res Radiocarbon Spectrometer">
          <LabeledList>
            <LabeledList.Item label="Scanned Item">
              {scanned_item || "None"}
              {!!scanned_item && <Box color="label" mt={1}>{scanned_item_desc}</Box>}
            </LabeledList.Item>
            <LabeledList.Item label="Scan Progress">
              <ProgressBar value={scan_progress / 100}>
                {scanning ? `${scan_progress}%` : "Idle"}
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Seal Integrity">
              <ProgressBar value={scanner_seal_integrity / 100} ranges={{ good: [0.5, Infinity], average: [0.25, 0.5], bad: [-Infinity, 0.25] }}>
                {scanner_seal_integrity}%
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Temperature">{scanner_temperature}K</LabeledList.Item>
            <LabeledList.Item label="RPM">{scanner_rpm}</LabeledList.Item>
          </LabeledList>
          <Flex mt={1} wrap>
            <Flex.Item>
              <Button onClick={() => act('scanItem')}>
                {scanning ? "Cancel" : "Scan"}
              </Button>
            </Flex.Item>
            <Flex.Item ml={1}>
              <Button onClick={() => act('ejectItem')}>Eject</Button>
            </Flex.Item>
            <Flex.Item ml={1}>
              <Button selected={rad_shield_on} onClick={() => act('toggle_rad_shield')}>
                Rad Shield: {rad_shield_on ? "On" : "Off"}
              </Button>
            </Flex.Item>
          </Flex>
        </Section>
        <Section title="Maser Controls">
          <LabeledList>
            <LabeledList.Item label="Wavelength">
              {maser_wavelength}
              <Button ml={1} onClick={() => act('maserWavelength', { maserWavelength: -1 })}>-</Button>
              <Button ml={1} onClick={() => act('maserWavelength', { maserWavelength: 1 })}>+</Button>
            </LabeledList.Item>
            <LabeledList.Item label="Optimal Wavelength">{optimal_wavelength}</LabeledList.Item>
            <LabeledList.Item label="Efficiency">{maser_efficiency}%</LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Coolant">
          <LabeledList>
            <LabeledList.Item label="Usage Rate">{coolant_usage_rate}</LabeledList.Item>
            <LabeledList.Item label="Coolant">{unused_coolant_abs}u ({unused_coolant_per}%)</LabeledList.Item>
            <LabeledList.Item label="Purity">{coolant_purity}%</LabeledList.Item>
            <LabeledList.Item label="Rate">
              <Button onClick={() => act('coolantRate', { coolantRate: -1 })}>-</Button>
              <Button ml={1} onClick={() => act('coolantRate', { coolantRate: 1 })}>+</Button>
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Radiation">
          <LabeledList>
            <LabeledList.Item label="Level">{radiation} mSv</LabeledList.Item>
            <LabeledList.Item label="Next Spike In">{t_left_radspike}</LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Last Scan Data">
          <Box dangerouslySetInnerHTML={{ __html: last_scan_data }} />
        </Section>
      </Window.Content>
    </Window>
  );
};
