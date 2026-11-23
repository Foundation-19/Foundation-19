import { useBackend, useLocalState } from '../backend';
import { Box, Button, LabeledList, Section, NumberInput, Flex, NoticeBox } from '../components';
import { Window } from '../layouts';

const CHEMMASTER_OPTIONS_BASE = 'BASE';
const CHEMMASTER_SWITCH_SPRITE_PILL = 'PILL';
const CHEMMASTER_SWITCH_SPRITE_BOTTLE = 'BOTTLE';
const BOTTLE_SPRITES = ['bottle-1', 'bottle-2', 'bottle-3', 'bottle-4'];
const MAX_PILL_SPRITE = 25;

const PillSpriteSelector = (props, context) => {
  const { act, data } = useBackend(context);
  const { pillSprite } = data;
  const pills = [];
  for (let i = 1; i <= MAX_PILL_SPRITE; i++) {
    pills.push(i);
  }
  return (
    <Section title="Select Pill Sprite">
      <Flex wrap={1}>
        {pills.map(i => (
          <Flex.Item key={i} m={0.5}>
            <Button
              content={`Pill ${i}`}
              selected={String(pillSprite) === String(i)}
              onClick={() => act('pill_sprite', { pill_sprite: String(i) })} />
          </Flex.Item>
        ))}
      </Flex>
      <Box mt={1}>
        <Button
          icon="arrow-left"
          content="Back"
          onClick={() => act('main')} />
      </Box>
    </Section>
  );
};

const BottleSpriteSelector = (props, context) => {
  const { act, data } = useBackend(context);
  const { bottleSprite } = data;
  return (
    <Section title="Select Bottle Sprite">
      <Flex wrap={1}>
        {BOTTLE_SPRITES.map(sprite => (
          <Flex.Item key={sprite} m={0.5}>
            <Button
              content={sprite}
              selected={bottleSprite === sprite}
              onClick={() => act('bottle_sprite', { bottle_sprite: sprite })} />
          </Flex.Item>
        ))}
      </Flex>
      <Box mt={1}>
        <Button
          icon="arrow-left"
          content="Back"
          onClick={() => act('main')} />
      </Box>
    </Section>
  );
};

const ReagentSection = (props, context) => {
  const { reagents, source, actType, customActType } = props;
  const { act } = useBackend(context);
  return (
    <LabeledList>
      {reagents.map(reagent => (
        <LabeledList.Item key={reagent.ref} label={reagent.name}>
          {reagent.volume}u
          <Box inline ml={1}>
            {source === 'container' ? (
              <>
                <Button
                  content="1u"
                  onClick={() => act(actType, { [actType]: reagent.ref, amount: 1 })} />
                <Button
                  content="5u"
                  onClick={() => act(actType, { [actType]: reagent.ref, amount: 5 })} />
                <Button
                  content="10u"
                  onClick={() => act(actType, { [actType]: reagent.ref, amount: 10 })} />
                <Button
                  content="All"
                  onClick={() => act(actType, { [actType]: reagent.ref, amount: reagent.volume })} />
                <Button
                  content="Custom"
                  onClick={() => act(customActType, { [customActType]: reagent.ref })} />
              </>
            ) : (
              <>
                <Button
                  content="1u"
                  onClick={() => act(actType, { [actType]: reagent.ref, amount: 1 })} />
                <Button
                  content="5u"
                  onClick={() => act(actType, { [actType]: reagent.ref, amount: 5 })} />
                <Button
                  content="10u"
                  onClick={() => act(actType, { [actType]: reagent.ref, amount: 10 })} />
                <Button
                  content="All"
                  onClick={() => act(actType, { [actType]: reagent.ref, amount: reagent.volume })} />
                <Button
                  content="Custom"
                  onClick={() => act(customActType, { [customActType]: reagent.ref })} />
              </>
            )}
            <Button
              icon="search"
              content="Analyze"
              onClick={() => act('analyze', { analyze: reagent.ref })} />
          </Box>
        </LabeledList.Item>
      ))}
    </LabeledList>
  );
};

export const ChemMaster = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    analyzedReagent,
    analyzedName,
    analyzedDesc,
    analyzedIsBlood,
    analyzedBloodSpecies,
    analyzedBloodType,
    analyzedBloodDNA,
    loadedContainer,
    loadedPillBottle,
    pillBottleCount,
    pillBottleMax,
    isSloppy,
    isTransferringToBeaker,
    productionOptions,
    containerChemicals = [],
    bufferChemicals = [],
    pillDosage,
    bottleDosage,
    pillSprite,
    bottleSprite,
    switchingSprite,
    maxPillSprite,
    bottleSprites = [],
  } = data;

  if (switchingSprite === CHEMMASTER_SWITCH_SPRITE_PILL) {
    return (
      <Window width={575} height={600} resizable>
        <Window.Content scrollable>
          <PillSpriteSelector />
        </Window.Content>
      </Window>
    );
  }

  if (switchingSprite === CHEMMASTER_SWITCH_SPRITE_BOTTLE) {
    return (
      <Window width={575} height={600} resizable>
        <Window.Content scrollable>
          <BottleSpriteSelector />
        </Window.Content>
      </Window>
    );
  }

  return (
    <Window width={575} height={600} resizable>
      <Window.Content scrollable>
        {!!analyzedReagent && (
          <Section title={analyzedName}>
            {analyzedIsBlood ? (
              <LabeledList>
                <LabeledList.Item label="Species">
                  {analyzedBloodSpecies}
                </LabeledList.Item>
                <LabeledList.Item label="Blood Type">
                  {analyzedBloodType}
                </LabeledList.Item>
                <LabeledList.Item label="DNA Hash">
                  {analyzedBloodDNA}
                </LabeledList.Item>
              </LabeledList>
            ) : (
              <Box>{analyzedDesc}</Box>
            )}
            <Button
              mt={1}
              icon="arrow-left"
              content="Back"
              onClick={() => act('main')} />
          </Section>
        )}
        <Section title="Beaker">
          {loadedContainer ? (
            <>
              <ReagentSection
                reagents={containerChemicals}
                source="container"
                actType="add"
                customActType="addcustom" />
              <Box mt={1}>
                <Button
                  icon="eject"
                  content="Eject Beaker"
                  onClick={() => act('eject')} />
              </Box>
            </>
          ) : (
            <Box color="label">No beaker loaded.</Box>
          )}
        </Section>
        <Section title="Buffer">
          {bufferChemicals.length > 0 ? (
            <>
              <LabeledList>
                <LabeledList.Item label="Transfer Mode">
                  <Button
                    content={isTransferringToBeaker ? 'To Beaker' : 'Discard'}
                    icon={isTransferringToBeaker ? 'arrow-left' : 'trash'}
                    selected={isTransferringToBeaker}
                    onClick={() => act('toggle')} />
                </LabeledList.Item>
                <LabeledList.Item label="Sloppy Transfer">
                  <Button
                    content={isSloppy ? 'Sloppy' : 'Precise'}
                    color={isSloppy ? 'bad' : 'good'}
                    onClick={() => act('toggle_sloppy')} />
                </LabeledList.Item>
              </LabeledList>
              <Box mt={1}>
                <ReagentSection
                  reagents={bufferChemicals}
                  source="buffer"
                  actType="remove"
                  customActType="removecustom" />
              </Box>
            </>
          ) : (
            <Box color="label">Buffer is empty.</Box>
          )}
        </Section>
        {bufferChemicals.length > 0 && productionOptions === CHEMMASTER_OPTIONS_BASE && (
          <Section title="Production">
            <LabeledList>
              <LabeledList.Item label="Pill Dosage">
                <Button
                  content={`${pillDosage}u`}
                  onClick={() => act('pill_dosage')} />
              </LabeledList.Item>
              <LabeledList.Item label="Bottle Dosage">
                <Button
                  content={`${bottleDosage}u`}
                  onClick={() => act('bottle_dosage')} />
              </LabeledList.Item>
              <LabeledList.Item label="Pill Sprite">
                <Button
                  content={`Pill ${pillSprite}`}
                  onClick={() => act('change_pill')} />
              </LabeledList.Item>
              <LabeledList.Item label="Bottle Sprite">
                <Button
                  content={bottleSprite}
                  onClick={() => act('change_bottle')} />
              </LabeledList.Item>
            </LabeledList>
            <Box mt={1}>
              <Button
                icon="tablet-alt"
                content="Create Pill"
                onClick={() => act('createpill')} />
              <Button
                icon="tablets"
                content="Create Multiple Pills"
                onClick={() => act('createpill_multiple')} />
              <Button
                icon="flask"
                content="Create Bottle"
                onClick={() => act('createbottle')} />
            </Box>
          </Section>
        )}
        {bufferChemicals.length > 0 && productionOptions !== CHEMMASTER_OPTIONS_BASE && (
          <Section title="Production">
            <Button
              icon="flask"
              content="Create Condiment Bottle"
              onClick={() => act('createbottle')} />
          </Section>
        )}
        {!!loadedPillBottle && (
          <Section title="Pill Bottle">
            <Button
              icon="eject"
              content={`Eject Pill Bottle [${pillBottleCount}/${pillBottleMax}]`}
              onClick={() => act('ejectp')} />
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
