import { useBackend, useLocalState } from '../backend';
import { Box, Button, Input, Section } from '../components';
import { Window } from '../layouts';

type OrbitEntry = {
  name: string;
  ref: string;
  icon: string | null;
  status: string | null;
};

type OrbitCategory = {
  name: string;
  entries: OrbitEntry[];
};

type OrbitData = {
  categories: OrbitCategory[];
  following: string | null;
};

const CATEGORY_COLOR: Record<string, string> = {
  Crew: 'rgba(114, 196, 255, 0.9)',
  Antagonists: 'rgba(255, 96, 96, 0.9)',
  SCP: 'rgba(212, 160, 23, 0.9)',
  'Simple Mobs': 'rgba(150, 200, 120, 0.9)',
  Silicons: 'rgba(170, 170, 255, 0.9)',
  Ghosts: 'rgba(200, 200, 200, 0.6)',
};

export const OrbitMenu = (props, context) => {
  const { act, data } = useBackend<OrbitData>(context);
  const { categories = [], following = null } = data;
  const [search, setSearch] = useLocalState<string>(context, 'orbit_search', '');
  const needle = search.toLowerCase().trim();

  const filtered = categories
    .map((cat) => ({
      ...cat,
      entries: needle
        ? cat.entries.filter((entry) =>
            entry.name.toLowerCase().includes(needle)
          )
        : cat.entries,
    }))
    .filter((cat) => cat.entries.length > 0);

  const matchCount = filtered.reduce(
    (n, cat) => n + cat.entries.length,
    0
  );

  return (
    <Window width={430} height={620}>
      <Window.Content scrollable>
        <Box>
          <Section
            title={needle ? `${matchCount} MATCHES` : 'ORBIT TARGETS'}
            buttons={
              <>
                <Input
                  width="150px"
                  value={search}
                  placeholder="Search..."
                  onInput={(e, value) => setSearch(value || '')}
                  alignSelf="center"
                />
                <Button
                  icon="sync"
                  content="Refresh"
                  tooltip="Rebuild the target list"
                  onClick={() => act('refresh')}
                />
                {following ? (
                  <Button
                    icon="ban"
                    color="bad"
                    content="Stop"
                    tooltip="Stop following the current target"
                    onClick={() => act('stop')}
                  />
                ) : null}
              </>
            }
          >
            {filtered.length === 0 && (
              <Box color="label" p={1}>
                No orbitable targets found{needle ? ` for "${search}"` : ''}.
                Use Refresh to rebuild the list.
              </Box>
            )}
            {filtered.map((cat) => (
              <Box key={cat.name} mb={1}>
                <Box
                  bold
                  mb={0.5}
                  color={
                    CATEGORY_COLOR[cat.name] || 'label'
                  }
                >
                  {cat.name} ({cat.entries.length})
                </Box>
                {cat.entries.map((entry) => (
                  <Button
                    key={entry.ref}
                    fluid
                    selected={following === entry.ref}
                    onClick={() => act('orbit', { atom: entry.ref })}
                    style={{ textAlign: 'left' }}
                  >
                    <Box
                      component="span"
                      dangerouslySetInnerHTML={{ __html: entry.icon || '' }}
                      style={{ marginRight: '4px' }}
                    />
                    {entry.name}
                    {entry.status ? (
                      <Box
                        component="span"
                        color="label"
                        style={{ marginLeft: '4px' }}
                      >
                        [{entry.status}]
                      </Box>
                    ) : null}
                  </Button>
                ))}
              </Box>
            ))}
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
