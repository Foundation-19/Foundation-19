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

const RecipeEntry = ({ entry, sublist, singularName, act }) => {
  if (entry.type === 'sublist') {
    return (
      <Section title={entry.title} style={{ border: '1px solid ' + C.border, marginTop: '6px' }}>
        {(entry.recipes || []).map((child, i) => (
          <RecipeEntry
            key={i}
            entry={child}
            sublist={entry.index}
            singularName={singularName}
            act={act} />
        ))}
      </Section>
    );
  }

  const title = entry.res_amount > 1
    ? `${entry.res_amount}x ${entry.title}s`
    : entry.title;

  return (
    <Box mb={1}>
      <Box>
        {entry.skill_label ? (
          <Box inline mr={0.5} style={{ color: '#cc2222' }}>{entry.skill_label}</Box>
        ) : null}
        <Box inline style={{ color: entry.can_build ? C.text : C.textDim }}>
          {title} ({entry.req_amount} {singularName}s)
        </Box>
      </Box>
      {(entry.multipliers || []).length > 0 ? (
        <Box mt={0.5}>
          {entry.multipliers.map((mult) => (
            <Button
              key={mult}
              inline
              mr={0.5}
              content={`${mult * entry.res_amount}x`}
              onClick={() => act('make', sublist
                ? { make: entry.index, multiplier: mult, sublist: sublist }
                : { make: entry.index, multiplier: mult })} />
          ))}
        </Box>
      ) : null}
    </Box>
  );
};

export const StackCrafting = (props, context) => {
  const { act, data } = useBackend(context);
  const { amount, singular_name, recipes = [] } = data;
  const singularName = singular_name || 'item';

  return (
    <Window width={420} height={520}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>
              CONSTRUCTIONS FROM {singularName.toUpperCase()}
            </Box>
            <Box style={{ color: C.amber }}>Amount Left: {amount}</Box>
          </Box>

          <Section style={{ border: '1px solid ' + C.border }}>
            {recipes.length === 0 ? (
              <Box style={{ color: C.textDim }}>No recipes available.</Box>
            ) : (
              recipes.map((entry, i) => (
                <RecipeEntry
                  key={i}
                  entry={entry}
                  sublist={null}
                  singularName={singularName}
                  act={act} />
              ))
            )}
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
