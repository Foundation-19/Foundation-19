import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const ChorusBrowser = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    buildings,
    resources,
    has_selected,
    selected,
  } = data;
  return (
    <Window width={650} height={600}>
      <Window.Content scrollable>
        <Section title="Resources">
          {resources && resources.map((res, i) => (
            <Box key={i} inline mr={2}>
              {res.print}: {res.amount}
            </Box>
          ))}
        </Section>
        <Section title="Buildings">
          {buildings && buildings.map((tier, tierIdx) => (
            <Box key={tierIdx} mb={1}>
              <Box bold mb={1}>Tier {tierIdx + 1}</Box>
              {tier.map((building, buildIdx) => (
                <Button key={buildIdx} mr={1} onClick={() => act('select_building', { state: building.state })}>
                  {building.image}
                </Button>
              ))}
            </Box>
          ))}
        </Section>
        {!!has_selected && selected && (
          <Section title="Selected Building">
            <Box>{selected.name || "Building"}</Box>
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
