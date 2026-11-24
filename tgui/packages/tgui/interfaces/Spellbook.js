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

export const Spellbook = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    spell_points,
    mana_level,
    mana_level_max,
    categories,
    spells = [],
    selected,
  } = data;

  return (
    <Window width={460} height={520}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>SPELL BOOK</Box>
          </Box>

          <Section title="Spellcaster" style={{ border: '1px solid ' + C.border }}>
            <LabeledList>
              <LabeledList.Item label="Spell Power">{spell_points}</LabeledList.Item>
              <LabeledList.Item label="Mana Level">{mana_level} / {mana_level_max}</LabeledList.Item>
              <LabeledList.Item label="Applied Categories">
                {categories}
                <Button
                  inline
                  ml={1}
                  content="Edit"
                  onClick={() => act('categories')} />
              </LabeledList.Item>
            </LabeledList>
          </Section>

          {selected ? (
            <Section title={selected.name} style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
              <Box mb={1}>{selected.desc}</Box>
              <LabeledList>
                <LabeledList.Item label="Mana Cost">{selected.mana_cost}</LabeledList.Item>
                <LabeledList.Item label="Categories">{selected.categories}</LabeledList.Item>
              </LabeledList>
              {selected.needs_clothes ? (
                <Box mt={1} style={{ color: C.textDim }}>Requires wizard robes to cast.</Box>
              ) : null}
              {selected.no_somatic ? (
                <Box style={{ color: C.textDim }}>Can be cast while incapacitated.</Box>
              ) : null}

              {!selected.learned ? (
                <Box mt={1}>
                  <Button
                    inline
                    icon="book"
                    content={'Purchase (' + selected.purchase_cost + ' points)'}
                    onClick={() => act('purchase', { path: selected.path })} />
                </Box>
              ) : selected.has_upgrades ? (
                <Box mt={1}>
                  <Box style={{ color: C.textDim }}>
                    Maximum amount of upgrades: {selected.used_upgrades}/{selected.max_upgrades}.
                  </Box>
                  {(selected.upgrades || []).map((upgrade, i) => (
                    <Box key={i} mt={0.5}>
                      <Box inline mr={1}>
                        Current {upgrade.type} level: {upgrade.level}/{upgrade.max}.
                      </Box>
                      {upgrade.can_improve ? (
                        <Button
                          inline
                          content={'Improve ' + upgrade.type + ' (' + upgrade.cost + ' points)'}
                          onClick={() => act('upgrade', { path: selected.path, upgrade_type: upgrade.type })} />
                      ) : null}
                    </Box>
                  ))}
                </Box>
              ) : null}

              <Box mt={1}>
                <Button inline icon="arrow-left" content="Back" onClick={() => act('back')} />
              </Box>
            </Section>
          ) : (
            <Section title="Spells" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
              {spells.length === 0 ? (
                <Box style={{ color: C.textDim }}>No spells available.</Box>
              ) : (
                spells.map((spell, i) => (
                  <Box key={i} mb={0.5}>
                    <Button
                      inline
                      content={spell.name}
                      onClick={() => act('spell', { path: spell.path })} />
                  </Box>
                ))
              )}
            </Section>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
