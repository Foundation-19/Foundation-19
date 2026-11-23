import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, ProgressBar, Flex, NoticeBox } from '../components';
import { Window } from '../layouts';

export const RigSuit = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    ai,
    seals,
    sealing,
    helmet,
    gauntlets,
    boots,
    chest,
    charge,
    maxcharge,
    chargestatus,
    emagged,
    coverlock,
    interfacelock,
    aicontrol,
    aioverride,
    securitycheck,
    malf,
    valveOpen,
    maskConnected,
    tankPressure,
    releasePressure,
    defaultReleasePressure,
    maxReleasePressure,
    tank,
    primarysystem,
    modules,
  } = data;
  return (
    <Window width={480} height={550}>
      <Window.Content scrollable>
        <Section title="Hardsuit Controller">
          <LabeledList>
            <LabeledList.Item label="Seals">
              {sealing ? "Sealing..." : seals === "1" ? "Unsealed" : "Sealed"}
              <Button ml={1} onClick={() => act('toggle_seals')} disabled={sealing}>
                {seals === "1" ? "Seal" : "Unseal"}
              </Button>
            </LabeledList.Item>
            <LabeledList.Item label="Charge">
              <ProgressBar value={chargestatus / 50}>
                {charge}/{maxcharge}
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Helmet">{helmet}
              <Button ml={1} onClick={() => act('toggle_piece', { toggle_piece: "helmet" })}>Toggle</Button>
            </LabeledList.Item>
            <LabeledList.Item label="Gauntlets">{gauntlets}
              <Button ml={1} onClick={() => act('toggle_piece', { toggle_piece: "gauntlets" })}>Toggle</Button>
            </LabeledList.Item>
            <LabeledList.Item label="Boots">{boots}
              <Button ml={1} onClick={() => act('toggle_piece', { toggle_piece: "boots" })}>Toggle</Button>
            </LabeledList.Item>
            <LabeledList.Item label="Chest">{chest}
              <Button ml={1} onClick={() => act('toggle_piece', { toggle_piece: "chest" })}>Toggle</Button>
            </LabeledList.Item>
            <LabeledList.Item label="Cover Lock">
              <Button selected={coverlock} onClick={() => act('toggle_suit_lock')}>
                {coverlock ? "Locked" : "Unlocked"}
              </Button>
            </LabeledList.Item>
            <LabeledList.Item label="AI Control">
              <Button selected={aicontrol} onClick={() => act('toggle_ai_control')}>
                {aicontrol ? "Overridden" : "Normal"}
              </Button>
              <Button ml={1} selected={aioverride} onClick={() => act('toggle_ai_control')}>
                AI Override: {aioverride ? "On" : "Off"}
              </Button>
            </LabeledList.Item>
          </LabeledList>
        </Section>
        {!!tank && (
          <Section title="Air Supply">
            <LabeledList>
              <LabeledList.Item label="Tank Pressure">{tankPressure} kPa</LabeledList.Item>
              <LabeledList.Item label="Release Pressure">{releasePressure} kPa</LabeledList.Item>
              <LabeledList.Item label="Valve">
                <Button selected={valveOpen} onClick={() => act('air_supply', { air_supply: valveOpen ? "close" : "open" })}>
                  {valveOpen ? "Open" : "Closed"}
                </Button>
              </LabeledList.Item>
            </LabeledList>
          </Section>
        )}
        {!!modules && modules.length > 0 && (
          <Section title="Modules">
            {primarysystem && <NoticeBox info>Primary: {primarysystem}</NoticeBox>}
            {modules.map((module, i) => (
              <Section key={i} title={module.name}>
                <Box color="label" mb={1}>{module.desc}</Box>
                <LabeledList>
                  <LabeledList.Item label="Status">
                    {module.is_active === "1" ? "Active" : "Inactive"}
                  </LabeledList.Item>
                  <LabeledList.Item label="Damage">{module.damage}</LabeledList.Item>
                </LabeledList>
                <Box mt={1}>
                  {module.can_toggle === "1" && (
                    <Button onClick={() => act('interact_module', { interact_module: module.index, module_mode: module.is_active === "1" ? "deactivate" : "activate" })}>
                      {module.is_active === "1" ? module.deactivatestring : module.activatestring}
                    </Button>
                  )}
                  {module.can_use === "1" && (
                    <Button ml={1} onClick={() => act('interact_module', { interact_module: module.index, module_mode: "engage" })}>
                      {module.engagestring} ({module.engagecost})
                    </Button>
                  )}
                  {module.can_select === "1" && (
                    <Button ml={1} selected={primarysystem === module.name} onClick={() => act('interact_module', { interact_module: module.index, module_mode: "select" })}>
                      Select
                    </Button>
                  )}
                </Box>
                {!!module.charges && module.charges.length > 0 && (
                  <Box mt={1}>
                    {module.charges.map((charge, j) => (
                      <Button key={j} selected={module.chargetype === charge.index} onClick={() => act('interact_module', { interact_module: module.index, module_mode: "select_charge_type", charge_type: charge.index })}>
                        {charge.caption}
                      </Button>
                    ))}
                  </Box>
                )}
              </Section>
            ))}
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
