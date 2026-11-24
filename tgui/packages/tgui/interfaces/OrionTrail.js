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

export const OrionTrail = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    start,
    title,
    desc,
    info,
    distance,
    actions = [],
    nav = [],
    view,
    supplies = [],
    currency,
    currency_name,
    crew = [],
    emagged,
  } = data;

  const renderActions = (list) => list.map((action, i) => {
    const params = {};
    if (action.risky !== undefined) {
      params.risky = String(action.risky);
    }
    if (action.slow) {
      params.slow = 1;
    }
    if (action.fix !== undefined) {
      params.fix = String(action.fix);
    }
    if (action.food) {
      params.food = 1;
    }
    return (
      <Button
        key={i}
        inline
        mr={0.5}
        content={action.label}
        onClick={() => act(action.action, params)} />
    );
  });

  return (
    <Window width={460} height={420}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>
              ORION TRAIL{emagged ? ': REALISM EDITION' : ''}
            </Box>
          </Box>

          <Section title={title} style={{ border: '1px solid ' + C.border }}>
            {desc ? <Box dangerouslySetInnerHTML={{ __html: desc }} /> : null}
            {view === 0 && !start ? (
              <>
                <Box mt={1} style={{ color: C.textDim }}>Distance to next port: {distance}</Box>
                {info ? <Box mt={1} dangerouslySetInnerHTML={{ __html: info }} /> : null}
              </>
            ) : null}
            {start || view === 0 ? (
              <Box mt={1}>{renderActions(actions)}</Box>
            ) : null}
          </Section>

          {view === 1 ? (
            <Section title="Cargo" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
              <Box mb={1} style={{ color: C.textDim }}>
                You have {currency} {currency_name}.
              </Box>
              {supplies.map((supply, i) => (
                <Box key={i} mb={0.5}>
                  <Box inline mr={1}>{supply.amount} {supply.name}</Box>
                  {supply.can_buy ? (
                    <Button
                      inline
                      mr={0.5}
                      content={'Buy ' + supply.amount_step + ' for ' + supply.buy_cost + 'T'}
                      onClick={() => act('buy', { buy: supply.index })} />
                  ) : null}
                  {supply.can_sell ? (
                    <Button
                      inline
                      mr={0.5}
                      content={'Sell ' + supply.amount_step + ' for ' + supply.buy_cost + 'T'}
                      onClick={() => act('sell', { sell: supply.index })} />
                  ) : null}
                </Box>
              ))}
            </Section>
          ) : null}

          {view === 2 ? (
            <Section title="Settlers" style={{ border: '1px solid ' + C.border, marginTop: '8px' }}>
              {crew.map((member, i) => (
                <Box key={i} mb={0.5}>
                  <Box inline mr={1}>{member.name}</Box>
                  <Button
                    inline
                    content="Kill"
                    onClick={() => act('kill', { kill: member.index })} />
                </Box>
              ))}
            </Section>
          ) : null}

          {!start && nav.length > 0 ? (
            <Box mt={1}>
              {nav.map((entry, i) => (
                <Button
                  key={i}
                  inline
                  mr={0.5}
                  content={entry.label}
                  disabled={entry.active}
                  onClick={() => act(entry.action)} />
              ))}
            </Box>
          ) : null}
        </Box>
      </Window.Content>
    </Window>
  );
};
