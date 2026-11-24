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
  good: '#1a7a1a',
  bad: '#cc2222',
  mono: 'Consolas, monospace',
};

const InfoRows = ({ info }) => (
  <LabeledList>
    {info.map((item, i) => (
      <LabeledList.Item key={i} label={item.label}>
        {item.value}
      </LabeledList.Item>
    ))}
  </LabeledList>
);

const ButtonRows = ({ buttons }) => (
  <Box>
    {buttons.map((btn, i) => (
      <Button
        key={i}
        inline
        mr={0.5}
        mb={0.5}
        content={btn.label}
        onClick={() => actButton(btn)} />
    ))}
  </Box>
);

const ToggleRows = ({ toggles }) => (
  <Box>
    {toggles.map((tg, i) => (
      <Box key={i} mb={0.5}>
        <Button
          content={tg.value_text || (tg.value ? 'Yes' : 'No')}
          selected={tg.value}
          color={tg.value === false ? undefined : 'good'}
          onClick={() => actButton(tg)} />
        <Box inline ml={1} style={{ color: C.text }}>
          {tg.label}
        </Box>
      </Box>
    ))}
  </Box>
);

const OptionRows = ({ options }) => (
  <Box>
    {options.map((opt, oi) => (
      <Box key={oi} mb={1}>
        <Box style={{ color: C.textDim, fontSize: '10px', marginBottom: '2px' }}>
          {opt.label.toUpperCase()}
        </Box>
        <Box>
          {opt.values.map((val, vi) => (
            <Button
              key={vi}
              inline
              mr={0.5}
              mb={0.5}
              content={val}
              onClick={() => actOption(opt, val)} />
          ))}
        </Box>
      </Box>
    ))}
  </Box>
);

// act() is only reachable inside the component; use a module-level indirection
// set at render time (single UI instance at a time in BYOND).
let _act = null;
const actButton = (btn) => _act(btn.action, btn.params || {});
const actOption = (opt, val) => _act(opt.action, { [opt.param]: val });

const PanelBlock = ({ section, title }) => {
  if (!section || section.locked) {
    return (
      <Section title={title} style={{ border: '1px solid ' + C.border, background: C.panel, marginBottom: '8px' }}>
        <Box style={{ color: C.textDim }}>LOCKED</Box>
      </Section>
    );
  }
  return (
    <Section title={title} style={{ border: '1px solid ' + C.border, background: C.panel, marginBottom: '8px' }}>
      {section.info && section.info.length > 0 ? <InfoRows info={section.info} /> : null}
      {section.buttons && section.buttons.length > 0 ? (
        <Box mt={1}><ButtonRows buttons={section.buttons} /></Box>
      ) : null}
      {section.toggles && section.toggles.length > 0 ? (
        <Box mt={1}><ToggleRows toggles={section.toggles} /></Box>
      ) : null}
      {section.options && section.options.length > 0 ? (
        <Box mt={1}><OptionRows options={section.options} /></Box>
      ) : null}
    </Section>
  );
};

export const BotControl = (props, context) => {
  const { act, data } = useBackend(context);
  _act = act;
  const { title, status, panel, maintenance, on } = data;

  return (
    <Window width={420} height={560}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.border, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>BOT CONTROL</Box>
            {title ? (
              <Box mt={0.5} style={{ color: C.text }}>{title}</Box>
            ) : null}
          </Box>

          <Box mb={1}>
            <Button
              icon="power-off"
              content={on ? 'Power On' : 'Power Off'}
              color={on ? 'green' : 'red'}
              onClick={() => act('toggle')} />
          </Box>

          <PanelBlock section={status} title="Status" />
          <PanelBlock section={panel} title="Controls" />
          <PanelBlock section={maintenance} title="Maintenance" />
        </Box>
      </Window.Content>
    </Window>
  );
};
