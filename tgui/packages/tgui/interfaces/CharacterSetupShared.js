import { Box, Button, Dropdown, Input, NoticeBox, Flex, ColorBox, Tooltip } from '../components';

export const C = {
  bg: '#0a0a0c',
  panel: '#111114',
  border: '#2a2a30',
  borderRed: '#6b0000',
  accent: '#c2960e',
  red: '#8b0000',
  redBright: '#cc2222',
  green: '#0a6e0a',
  greenDim: '#0d4a0d',
  brightGreen: '#44ff44',
  text: '#c8c8c8',
  textBright: '#e8e8e8',
  textDim: '#6a6a70',
  amber: '#d4a017',
  mono: '"Consolas", "Courier New", "Lucida Console", monospace',
};

export const term = (overrides = {}) => ({
  fontFamily: C.mono,
  fontSize: '12px',
  color: C.text,
  ...overrides,
});

export const TermBox = (props) => (
  <Box style={term({ ...props.style })}>{props.children}</Box>
);

export const TermHeader = (props) => (
  <Box
    style={term({
      fontSize: '10px',
      color: C.textDim,
      letterSpacing: '0.18em',
      textTransform: 'uppercase',
      borderBottom: `1px solid ${C.border}`,
      paddingBottom: '4px',
      marginBottom: '8px',
      ...props.style,
    })}
  >
    {props.children}
  </Box>
);

export const TermLabel = (props) => (
  <Box
    as="span"
    style={term({
      color: C.textDim,
      fontSize: '10px',
      letterSpacing: '0.12em',
      textTransform: 'uppercase',
      width: '160px',
      minWidth: '160px',
      flexShrink: 0,
      ...props.style,
    })}
  >
    {props.children}
  </Box>
);

export const TermValue = (props) => (
  <Box
    as="span"
    style={term({
      color: props.color || C.textBright,
      fontWeight: props.bold ? 'bold' : 'normal',
      flex: 1,
      ...props.style,
    })}
  >
    {props.children}
  </Box>
);

export const TermRow = (props) => (
  <Flex align="center" mb={0.5}>
    {props.children}
  </Flex>
);

export const TermDivider = () => (
  <Box
    style={{
      color: C.borderRed,
      fontSize: '10px',
      letterSpacing: '0.3em',
      margin: '10px 0',
      userSelect: 'none',
      overflow: 'hidden',
      whiteSpace: 'nowrap',
    }}
  >
    {'─'.repeat(80)}
  </Box>
);

export const TermButton = (props) => {
  const selected = props.selected;
  const color = props.color;
  const bg = selected
    ? color === 'red'
      ? 'rgba(139,0,0,0.35)'
      : color === 'green'
        ? 'rgba(26,122,26,0.35)'
        : color === 'yellow'
          ? 'rgba(180,160,20,0.25)'
          : 'rgba(255,255,255,0.08)'
    : 'transparent';
  const borderColor = selected
    ? color === 'red'
      ? C.red
      : color === 'green'
        ? C.green
        : color === 'yellow'
          ? '#b0a020'
          : C.border
    : C.border;
  const { children, ...rest } = props;
  return (
    <Button
      {...rest}
      style={{
        fontFamily: C.mono,
        fontSize: '10px',
        letterSpacing: '0.1em',
        textTransform: 'uppercase',
        background: bg,
        border: `1px solid ${borderColor}`,
        borderRadius: 0,
        color: selected ? C.textBright : C.textDim,
        padding: '3px 8px',
        boxShadow: selected ? `0 0 6px ${borderColor}44` : 'none',
      }}
    >
      {children}
    </Button>
  );
};

export const PriorityButtons = ({ job, level, act }) => (
  <Box style={{ display: 'flex', gap: '2px' }}>
    <TermButton selected={!level} onClick={() => act('set_job', { job: job, set_level: 4 })}>
      OFF
    </TermButton>
    <TermButton color="red" selected={level === 3} onClick={() => act('set_job', { job: job, set_level: 3 })}>
      LOW
    </TermButton>
    <TermButton color="yellow" selected={level === 2} onClick={() => act('set_job', { job: job, set_level: 2 })}>
      MED
    </TermButton>
    <TermButton color="green" selected={level === 1} onClick={() => act('set_job', { job: job, set_level: 1 })}>
      HIGH
    </TermButton>
  </Box>
);
