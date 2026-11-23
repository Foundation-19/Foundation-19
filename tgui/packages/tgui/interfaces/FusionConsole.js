import { useBackend } from '../backend';
import { Box, Button, Flex, LabeledList, NumberInput, ProgressBar, Section } from '../components';
import { Window } from '../layouts';

const C = {
  bg: '#0a0a0c',
  border: '#2a2a30',
  borderRed: '#6b0000',
  amber: '#d4a017',
  text: '#c8c8c8',
  textDim: '#6a6a70',
  good: '#0a6e0a',
  red: '#cc2222',
  mono: '"Consolas", "Courier New", monospace',
};

const CoreRow = (props, context) => {
  const { act } = useBackend(context);
  const { core } = props;
  return (
    <Box mb={2} pb={1} style={{ borderBottom: '1px solid ' + C.border }}>
      <Flex align="center" mb={0.5}>
        <Box style={{ color: C.amber, fontWeight: 'bold', flex: 1 }}>Core {core.id}</Box>
        <Box mr={1} style={{ color: core.field ? C.good : C.red }}>
          {core.field ? 'FIELD ACTIVE' : 'FIELD OFFLINE'}
        </Box>
        <Button
          content={core.field ? 'Shut Down' : 'Start Up'}
          color={core.field ? 'bad' : 'good'}
          onClick={() => act('toggle_active', { machine: core.ref })}
        />
      </Flex>
      <LabeledList>
        <LabeledList.Item label="Power">{core.power}</LabeledList.Item>
        <LabeledList.Item label="Field Size">{core.size}</LabeledList.Item>
        <LabeledList.Item label="Instability">
          <ProgressBar
            value={parseFloat(core.instability) || 0}
            minValue={0}
            maxValue={100}
            ranges={{ good: [0, 40], average: [40, 70], bad: [70, 100] }}>
            {core.instability}
          </ProgressBar>
        </LabeledList.Item>
        <LabeledList.Item label="Temperature">{core.temperature}</LabeledList.Item>
        <LabeledList.Item label="Fuel">
          {core.fuel && core.fuel.length > 0 ? (
            <Box>
              {core.fuel.map((f, i) => (
                <Box key={i}>{f.name}: {f.amount}</Box>
              ))}
            </Box>
          ) : (
            <Box style={{ color: C.textDim }}>Nothing.</Box>
          )}
        </LabeledList.Item>
        <LabeledList.Item label="Field Strength">
          <Flex align="center">
            <Flex.Item mr={1}>
              <Button content="-100" onClick={() => act('str', { machine: core.ref, str: -100 })} />
            </Flex.Item>
            <Flex.Item mr={1}>
              <Button content="-10" onClick={() => act('str', { machine: core.ref, str: -10 })} />
            </Flex.Item>
            <Flex.Item grow={1} style={{ textAlign: 'center', color: C.text }}>
              {core.power}
            </Flex.Item>
            <Flex.Item mr={1}>
              <Button content="+10" onClick={() => act('str', { machine: core.ref, str: 10 })} />
            </Flex.Item>
            <Flex.Item mr={1}>
              <Button content="+100" onClick={() => act('str', { machine: core.ref, str: 100 })} />
            </Flex.Item>
            <Flex.Item>
              <Button icon="pen" content="Set" onClick={() => act('str', { machine: core.ref, str: 0 })} />
            </Flex.Item>
          </Flex>
        </LabeledList.Item>
      </LabeledList>
    </Box>
  );
};

const GyrotronRow = (props, context) => {
  const { act } = useBackend(context);
  const { gyro } = props;
  return (
    <Box mb={2} pb={1} style={{ borderBottom: '1px solid ' + C.border }}>
      <Flex align="center" mb={0.5}>
        <Box style={{ color: C.amber, fontWeight: 'bold', flex: 1 }}>Gyrotron {gyro.id}</Box>
        <Box mr={1} style={{ color: gyro.active ? C.good : C.red }}>
          {gyro.active ? 'EMITTING' : 'OFFLINE'}
        </Box>
        <Button
          content={gyro.active ? 'Deactivate' : 'Activate'}
          color={gyro.active ? 'bad' : 'good'}
          onClick={() => act('toggle', { machine: gyro.ref })}
        />
      </Flex>
      <LabeledList>
        <LabeledList.Item label="Emission Power">
          <Flex align="center">
            <Flex.Item grow={1}>{gyro.energy} MW</Flex.Item>
            <Flex.Item>
              <Button icon="pen" content="Set" onClick={() => act('modifypower', { machine: gyro.ref })} />
            </Flex.Item>
          </Flex>
        </LabeledList.Item>
        <LabeledList.Item label="Fire Delay">
          <Flex align="center">
            <Flex.Item grow={1}>{gyro.firedelay}s</Flex.Item>
            <Flex.Item>
              <Button icon="pen" content="Set" onClick={() => act('modifyrate', { machine: gyro.ref })} />
            </Flex.Item>
          </Flex>
        </LabeledList.Item>
      </LabeledList>
    </Box>
  );
};

const InjectorRow = (props, context) => {
  const { act } = useBackend(context);
  const { injector } = props;
  return (
    <Box mb={2} pb={1} style={{ borderBottom: '1px solid ' + C.border }}>
      <Flex align="center" mb={0.5}>
        <Box style={{ color: C.amber, fontWeight: 'bold', flex: 1 }}>Injector {injector.id}</Box>
        <Box mr={1} style={{ color: injector.injecting ? C.good : C.red }}>
          {injector.injecting ? 'INJECTING' : 'IDLE'}
        </Box>
        <Button
          content={injector.injecting ? 'Stop' : 'Inject'}
          color={injector.injecting ? 'bad' : 'good'}
          onClick={() => act('toggle_injecting', { machine: injector.ref })}
        />
      </Flex>
      <LabeledList>
        <LabeledList.Item label="Fuel">{injector.fueltype}</LabeledList.Item>
        <LabeledList.Item label="Depletion">{injector.depletion}</LabeledList.Item>
        <LabeledList.Item label="Rate">
          <Flex align="center">
            <Flex.Item grow={1}>{injector.injection_rate}</Flex.Item>
            <Flex.Item>
              <Button icon="pen" content="Set" onClick={() => act('injection_rate', { machine: injector.ref })} />
            </Flex.Item>
          </Flex>
        </LabeledList.Item>
      </LabeledList>
    </Box>
  );
};

export const FusionConsole = (props, context) => {
  const { act, data } = useBackend(context);
  const { id, name, cores = [], gyrotrons = [], injectors = [] } = data;

  return (
    <Window theme="scp_terminal" width={440} height={620}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.borderRed, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>{name || 'Fusion Console'}</Box>
            <Box style={{ color: C.textDim, fontSize: '9px' }}>R-UST NETWORK — ID TAG: {id}</Box>
          </Box>

          {cores.length > 0 ? (
            <Section title="Fusion Cores" buttons={
              <Box style={{ color: C.textDim, fontSize: '9px' }}>{cores.length} linked</Box>
            }>
              {cores.map((core, i) => <CoreRow key={i} core={core} />)}
            </Section>
          ) : null}

          {gyrotrons.length > 0 ? (
            <Section title="Gyrotrons" buttons={
              <Box style={{ color: C.textDim, fontSize: '9px' }}>{gyrotrons.length} linked</Box>
            }>
              {gyrotrons.map((gyro, i) => <GyrotronRow key={i} gyro={gyro} />)}
            </Section>
          ) : null}

          {injectors.length > 0 ? (
            <Section title="Fuel Injectors" buttons={
              <Button content="Toggle All" onClick={() => act('global_toggle')} />
            }>
              {injectors.map((injector, i) => <InjectorRow key={i} injector={injector} />)}
            </Section>
          ) : null}

          {cores.length === 0 && gyrotrons.length === 0 && injectors.length === 0 ? (
            <Section title="Network">
              <Box style={{ color: C.red }}>NO DEVICES LINKED — check network ID tag with a multitool.</Box>
            </Section>
          ) : null}
        </Box>
      </Window.Content>
    </Window>
  );
};
