import { useBackend, useLocalState } from '../backend';
import { Box, Button, Input, Section } from '../components';
import { Window } from '../layouts';

type ScpEntry = {
  name: string;
  ref: string;
  icon: string | null;
  roleplay: boolean;
};

type ScpCategory = {
  name: string;
  entries: ScpEntry[];
};

type ScpSelectData = {
  categories: ScpCategory[];
  available: boolean;
};

const CATEGORY_COLOR: Record<string, string> = {
  Safe: 'rgba(114, 196, 255, 0.9)',
  Euclid: 'rgba(212, 160, 23, 0.9)',
  Keter: 'rgba(255, 96, 96, 0.9)',
};

const CATEGORY_ORDER_HINT = ['Keter', 'Euclid', 'Safe'];

export const ScpSelectMenu = (props, context) => {
  const { act, data } = useBackend<ScpSelectData>(context);
  const { categories = [] } = data;
  const [search, setSearch] = useLocalState<string>(
    context,
    'scpselect_search',
    ''
  );
  const [collapsed, setCollapsed] = useLocalState<Record<string, boolean>>(
    context,
    'scpselect_collapsed',
    {}
  );
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

  const ordered = [...filtered].sort((a, b) => {
    const ai = CATEGORY_ORDER_HINT.indexOf(a.name);
    const bi = CATEGORY_ORDER_HINT.indexOf(b.name);
    return (ai === -1 ? 99 : ai) - (bi === -1 ? 99 : bi);
  });

  const matchCount = filtered.reduce((n, cat) => n + cat.entries.length, 0);

  const toggleCollapsed = (name: string) => {
    setCollapsed({ ...collapsed, [name]: !collapsed[name] });
  };

  const allCollapsed =
    ordered.length > 0 && ordered.every((cat) => collapsed[cat.name]);

  const setAll = (value: boolean) => {
    const next: Record<string, boolean> = {};
    for (const cat of ordered) {
      next[cat.name] = value;
    }
    setCollapsed({ ...collapsed, ...next });
  };

  return (
    <Window width={420} height={580}>
      <Window.Content scrollable>
        <Box>
          <Section
            title={needle ? `${matchCount} MATCHES` : 'AVAILABLE SCPS'}
            buttons={
              <>
                <Input
                  width="140px"
                  value={search}
                  placeholder="Search..."
                  onInput={(e, value) => setSearch(value || '')}
                  alignSelf="center"
                />
                <Button
                  icon={allCollapsed ? 'expand' : 'compress'}
                  content={allCollapsed ? 'Expand' : 'Collapse'}
                  tooltip="Collapse or expand all classifications"
                  onClick={() => setAll(!allCollapsed)}
                />
                <Button
                  icon="sync"
                  content="Refresh"
                  tooltip="Rebuild the SCP list"
                  onClick={() => act('refresh')}
                />
              </>
            }
          >
            {ordered.length === 0 && (
              <Box color="label" p={1}>
                No SCPs available{needle ? ` for "${search}"` : ''}. Not all
                SCPs are available round start — more may open up later. Use
                Refresh to rebuild the list.
              </Box>
            )}
            {ordered.map((cat) => {
              const isCollapsed = !!collapsed[cat.name];
              return (
                <Box key={cat.name} mb={1}>
                  <Button
                    fluid
                    icon={isCollapsed ? 'chevron-right' : 'chevron-down'}
                    onClick={() => toggleCollapsed(cat.name)}
                    style={{
                      textAlign: 'left',
                      color: CATEGORY_COLOR[cat.name] || 'rgba(200,200,200,0.9)',
                      fontWeight: 'bold',
                      background: 'rgba(255,255,255,0.04)',
                    }}
                  >
                    {cat.name} ({cat.entries.length})
                  </Button>
                  {!isCollapsed &&
                    cat.entries.map((entry) => (
                      <Button
                        key={entry.ref}
                        fluid
                        onClick={() => act('select', { atom: entry.ref })}
                        style={{
                          textAlign: 'left',
                          paddingLeft: '14px',
                          background: 'rgba(255,255,255,0.02)',
                        }}
                      >
                        <Box
                          component="span"
                          dangerouslySetInnerHTML={{ __html: entry.icon || '' }}
                          style={{ marginRight: '4px' }}
                        />
                        {entry.name}
                        {entry.roleplay ? (
                          <Box
                            component="span"
                            color="violet"
                            style={{ marginLeft: '4px' }}
                          >
                            [Roleplay]
                          </Box>
                        ) : null}
                      </Button>
                    ))}
                </Box>
              );
            })}
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
