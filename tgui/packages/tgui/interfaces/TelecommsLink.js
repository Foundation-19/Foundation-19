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

export const TelecommsLink = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    name,
    toggled,
    temp,
    overloaded,
    active,
    id,
    network,
    prefab,
    hide,
    links = [],
    frequencies = [],
    channel_tags = [],
    multitool,
    buffer,
    options,
  } = data;

  return (
    <Window width={520} height={600}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>{name} ACCESS</Box>
          </Box>

          {temp ? <Box mb={1} dangerouslySetInnerHTML={{ __html: temp }} /> : null}

          <Section title="Power" style={{ border: '1px solid ' + C.border, background: C.panel }}>
            Power Status:{' '}
            <Button inline icon="power-off" content={toggled ? 'On' : 'Off'} color={toggled ? 'green' : 'red'} onClick={() => act('toggle')} />
          </Section>

          {overloaded ? (
            <Section title="Warning" style={{ border: '1px solid #6b0000', background: C.panel, marginTop: '8px' }}>
              <Box style={{ color: '#cc2222' }}>
                Ion interference detected. System will automatically recover in {overloaded} seconds.
              </Box>
              <Box mt={1}>
                <Button icon="sync" content="Reset manually" onClick={() => act('resetoverload')} />
              </Box>
            </Section>
          ) : null}

          {active ? (
            <Box>
              <Section title="Configuration" style={{ border: '1px solid ' + C.border, background: C.panel, marginTop: '8px' }}>
                <Box mb={0.5}>
                  Identification String:{' '}
                  <Button inline icon="edit" content={id || 'NULL'} onClick={() => act('id')} />
                </Box>
                <Box mb={0.5}>
                  Network:{' '}
                  <Button inline icon="edit" content={network} onClick={() => act('network')} />
                </Box>
                <Box mb={0.5}>Prefabrication: {prefab ? 'TRUE' : 'FALSE'}</Box>
                {hide ? <Box style={{ color: C.amber }}>Shadow Link: ACTIVE</Box> : null}
                {options && options.change_frequency !== undefined ? (
                  <Box mt={1}>
                    Change Signal Frequency:{' '}
                    <Button
                      inline
                      content={options.change_frequency ? 'YES (' + options.change_frequency + ')' : 'NO'}
                      onClick={() => act('change_freq')} />
                  </Box>
                ) : null}
              </Section>

              <Section title="Linked Network Entities" style={{ border: '1px solid ' + C.border, background: C.panel, marginTop: '8px' }}>
                {links.length === 0 ? (
                  <Box style={{ color: C.textDim }}>None.</Box>
                ) : (
                  links.map((link) => (
                    <Box key={link.index} mb={0.5}>
                      {link.name} ({link.id}){' '}
                      <Button inline icon="times" color="red" content="Unlink" onClick={() => act('unlink', { index: link.index })} />
                    </Box>
                  ))
                )}
              </Section>

              <Section title="Filtering Frequencies" style={{ border: '1px solid ' + C.border, background: C.panel, marginTop: '8px' }}>
                {frequencies.length === 0 ? (
                  <Box style={{ color: C.textDim }}>NONE</Box>
                ) : (
                  frequencies.map((freq, i) => (
                    <Box key={i} mb={0.5}>
                      {freq.display} GHz{' '}
                      <Button inline icon="times" color="red" content="Remove" onClick={() => act('delete', { freq: freq.freq })} />
                    </Box>
                  ))
                )}
                <Box mt={1}>
                  <Button icon="plus" content="Add Filter" onClick={() => act('freq')} />
                </Box>
              </Section>

              <Section title="Channel Tagging Rules" style={{ border: '1px solid ' + C.border, background: C.panel, marginTop: '8px' }}>
                {channel_tags.length === 0 ? (
                  <Box style={{ color: C.textDim }}>None.</Box>
                ) : (
                  channel_tags.map((rule, i) => (
                    <Box key={i} mb={0.5}>
                      {rule.display} -&gt; {rule.tag} ({rule.color}){' '}
                      <Button inline icon="times" color="red" content="Remove" onClick={() => act('deletetagrule', { freq: rule.freq })} />
                    </Box>
                  ))
                )}
                <Box mt={1}>
                  <Button icon="plus" content="Add Rule" onClick={() => act('tagrule')} />
                </Box>
              </Section>

              {multitool ? (
                <Section title="Multitool Buffer" style={{ border: '1px solid ' + C.border, background: C.panel, marginTop: '8px' }}>
                  {buffer ? (
                    <Box>
                      {buffer.name} ({buffer.id})
                      <Box mt={1}>
                        <Button inline icon="link" content="Link" mr={0.5} onClick={() => act('link')} />
                        <Button inline icon="eraser" content="Flush" onClick={() => act('flush')} />
                      </Box>
                    </Box>
                  ) : (
                    <Button icon="plus" content="Add Machine" onClick={() => act('buffer')} />
                  )}
                </Section>
              ) : null}
            </Box>
          ) : null}
        </Box>
      </Window.Content>
    </Window>
  );
};
