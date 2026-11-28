import { useBackend } from '../backend';
import { Box, Button, LabeledList, ProgressBar, Section } from '../components';
import { Window } from '../layouts';

const C = {
  bg: '#0a0a0c',
  panel: '#111114',
  border: '#2a2a30',
  borderRed: '#6b0000',
  amber: '#c2960e',
  text: '#c8c8c8',
  textBright: '#e0e0e8',
  textDim: '#7a7a80',
  good: '#1a7a1a',
  goodBright: '#44ff44',
  bad: '#cc2222',
  mono: 'Consolas, monospace',
};

const MenuButton = (props, context) => {
  const { act } = useBackend(context);
  const { screen, label, ...rest } = props;
  return (
    <Button
      inline
      mr={0.5}
      mb={0.5}
      content={label}
      onClick={() => act('menu', { menu: screen })}
      {...rest} />
  );
};

const MainMenu = ({ data }) => (
  <Section title="Main Menu">
    <LabeledList>
      <LabeledList.Item label="Loaded disk">
        {data.t_disk ? 'Technology storage disk' : (data.d_disk ? 'Design storage disk' : 'None')}
      </LabeledList.Item>
    </LabeledList>
    <Box mt={1}>
      <MenuButton screen="1.1" label="Learning Matrix Status" />
      <MenuButton screen="5.0" label="View Available Designs" />
      {data.t_disk ? <MenuButton screen="1.2" label="Tech Disk Operations" /> : null}
      {data.d_disk ? <MenuButton screen="1.4" label="Design Disk Operations" /> : null}
      {data.has_destroy ? <MenuButton screen="2.2" label="Destructive Analyzer Menu" /> : null}
      {data.has_lathe ? <MenuButton screen="3.1" label="Protolathe Construction Menu" /> : null}
      {data.has_imprinter ? <MenuButton screen="4.1" label="Circuit Construction Menu" /> : null}
      <MenuButton screen="1.6" label="Settings" />
    </Box>
  </Section>
);

const Settings = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Section title="R&D Console Settings">
      <Box mb={1}>
        {data.sync ? (
          <>
            <Button inline mr={0.5} mb={0.5} content="Sync Database with Network" onClick={() => act('sync')} />
            <Button inline mb={0.5} content="Disconnect from Fabrication Network" onClick={() => act('togglesync')} />
          </>
        ) : (
          <Button content="Connect to Fabrication Network" onClick={() => act('togglesync')} />
        )}
      </Box>
      <Box mb={1}>
        <Button inline mr={0.5} content="Device Linkage Menu" onClick={() => act('menu', { menu: '1.7' })} />
        <Button inline mr={0.5} content="Lock Console" onClick={() => act('lock', { lock: '0.2' })} />
        <Button inline content="Reset R&D Database" color="red" onClick={() => act('reset')} />
      </Box>
      <Button content="< Main Menu" onClick={() => act('menu', { menu: '1.0' })} />
    </Section>
  );
};

const DeviceLinkage = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Section title="Device Linkage">
      <Box mb={1}>
        <Button content="Re-sync with Nearby Devices" onClick={() => act('find_device')} />
      </Box>
      <Box mb={1}>
        <Box style={{ color: C.textDim, marginBottom: '4px' }}>LINKED DEVICES:</Box>
        {data.has_destroy ? (
          <Box mb={0.5}>
            Destructive Analyzer <Button inline ml={1} content="(Disconnect)" onClick={() => act('disconnect', { device: 'destroy' })} />
          </Box>
        ) : data.can_analyze ? (
          <Box mb={0.5}>(No Destructive Analyzer Linked)</Box>
        ) : null}
        {data.has_lathe ? (
          <Box mb={0.5}>
            Protolathe <Button inline ml={1} content="(Disconnect)" onClick={() => act('disconnect', { device: 'lathe' })} />
          </Box>
        ) : (
          <Box mb={0.5}>(No Protolathe Linked)</Box>
        )}
        {data.has_imprinter ? (
          <Box mb={0.5}>
            Circuit Imprinter <Button inline ml={1} content="(Disconnect)" onClick={() => act('disconnect', { device: 'imprinter' })} />
          </Box>
        ) : (
          <Box mb={0.5}>(No Circuit Imprinter Linked)</Box>
        )}
      </Box>
      <Button content="< Main Menu" onClick={() => act('menu', { menu: '1.0' })} />
    </Section>
  );
};

const TechDisk = (props, context) => {
  const { act, data } = useBackend(context);
  const disk = data.tech_disk || {};
  return (
    <Section title="Technology Disk">
      {disk.name ? (
        <>
          <LabeledList>
            <LabeledList.Item label="Name">{disk.name}</LabeledList.Item>
            <LabeledList.Item label="Level">{disk.level}</LabeledList.Item>
            <LabeledList.Item label="Description">{disk.desc}</LabeledList.Item>
          </LabeledList>
          <Box mt={1}>
            <Button inline mr={0.5} content="Upload to Database" onClick={() => act('updt_tech')} />
            <Button inline mr={0.5} content="Clear Disk" onClick={() => act('clear_tech')} />
            <Button content="Eject Disk" onClick={() => act('eject_tech')} />
          </Box>
        </>
      ) : (
        <Box>
          <Box mb={1} style={{ color: C.textDim }}>The disk has no data stored on it.</Box>
          <Button inline mr={0.5} content="Load Tech to Disk" onClick={() => act('menu', { menu: '1.3' })} />
          <Button content="Eject Disk" onClick={() => act('eject_tech')} />
        </Box>
      )}
    </Section>
  );
};

const TechDiskLoad = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Section title="Load Technology to Disk">
      <Box mb={1}>
        {(data.copyable_techs || []).map((tech) => (
          <Box key={tech.id} mb={0.5}>
            {tech.name} <Button inline ml={1} content="[copy to disk]" onClick={() => act('copy_tech', { copy_tech_ID: tech.id })} />
          </Box>
        ))}
      </Box>
      <Button content="< Disk Operations" onClick={() => act('menu', { menu: '1.2' })} />
    </Section>
  );
};

const DesignDisk = (props, context) => {
  const { act, data } = useBackend(context);
  const disk = data.design_disk || {};
  return (
    <Section title="Design Disk">
      {disk.name ? (
        <>
          <LabeledList>
            <LabeledList.Item label="Name">{disk.name}</LabeledList.Item>
            {disk.lathe_type ? <LabeledList.Item label="Lathe Type">{disk.lathe_type}</LabeledList.Item> : null}
          </LabeledList>
          <Box mt={1} mb={1}>
            <Box style={{ color: C.textDim }}>Required Materials:</Box>
            {(disk.materials || []).map((mat, i) => (
              <Box key={i}>* {mat.name} x {mat.amount}</Box>
            ))}
          </Box>
          <Box>
            <Button inline mr={0.5} content="Upload to Database" onClick={() => act('updt_design')} />
            <Button inline mr={0.5} content="Clear Disk" onClick={() => act('clear_design')} />
            <Button content="Eject Disk" onClick={() => act('eject_design')} />
          </Box>
        </>
      ) : (
        <Box>
          <Box mb={1} style={{ color: C.textDim }}>The disk has no data stored on it.</Box>
          <Button inline mr={0.5} content="Load Design to Disk" onClick={() => act('menu', { menu: '1.5' })} />
          <Button content="Eject Disk" onClick={() => act('eject_design')} />
        </Box>
      )}
    </Section>
  );
};

const DesignDiskLoad = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Section title="Load Design to Disk">
      <Box mb={1}>
        {(data.copyable_designs || []).map((design) => (
          <Box key={design.id} mb={0.5}>
            {design.name} <Button inline ml={1} content="[copy to disk]" onClick={() => act('copy_design', { copy_design_ID: design.id })} />
          </Box>
        ))}
      </Box>
      <Button content="< Disk Operations" onClick={() => act('menu', { menu: '1.4' })} />
    </Section>
  );
};

const DestroyScreen = (props, context) => {
  const { act, data } = useBackend(context);
  const destroy = data.destroy || {};
  if (!destroy.item_name) {
    return (
      <Section title="Deconstruction Menu">
        <Box mb={1} style={{ color: C.textDim }}>No Item Loaded. Standing-by...</Box>
        <Button content="< Main Menu" onClick={() => act('menu', { menu: '1.0' })} />
      </Section>
    );
  }
  return (
    <Section title="Deconstruction Menu">
      <LabeledList>
        <LabeledList.Item label="Name">{destroy.item_name}</LabeledList.Item>
      </LabeledList>
      <Box mt={1} mb={1}>
        <Box style={{ color: C.textDim }}>Origin Tech:</Box>
        {(destroy.origin_tech || []).map((tech, i) => (
          <Box key={i} style={{ color: C.text }}>
            {tech.name}: {tech.value}{tech.current !== null && tech.current !== undefined ? ` (Current: ${tech.current})` : ''}
          </Box>
        ))}
      </Box>
      <Box mb={1}>
        <Button inline mr={0.5} content="Deconstruct Item" color="red" onClick={() => act('deconstruct')} />
        <Button content="Eject Item" onClick={() => act('eject_item')} />
      </Box>
      <Button content="< Main Menu" onClick={() => act('menu', { menu: '1.0' })} />
    </Section>
  );
};

const LatheImprinter = (props, context) => {
  const { act } = useBackend(context);
  const { device, d, isLathe } = props;
  const buildAction = isLathe ? 'build' : 'imprint';
  const removeAction = isLathe ? 'removeP' : 'removeI';
  const disposeAction = isLathe ? 'disposeP' : 'disposeI';
  const disposeAllAction = isLathe ? 'disposeallP' : 'disposeallI';
  const ejectAction = isLathe ? 'lathe_ejectsheet' : 'imprinter_ejectsheet';
  return (
    <>
      <Section title={isLathe ? 'Protolathe Menu' : 'Circuit Imprinter Menu'}>
        <LabeledList>
          <LabeledList.Item label="Materials">{d.materials} cm³</LabeledList.Item>
          <LabeledList.Item label="Chemicals">{d.chem_volume} / {d.chem_max}</LabeledList.Item>
        </LabeledList>
        <Box mt={1}>
          <MenuButton screen={isLathe ? '3.4' : '4.4'} label="View Queue" />
          <MenuButton screen={isLathe ? '3.2' : '4.3'} label="Material Storage" />
          <MenuButton screen={isLathe ? '3.3' : '4.2'} label="Chemical Storage" />
        </Box>
        <Box mt={1}>
          {(d.buildables || []).map((design) => (
            <Box key={design.id} mb={0.5}>
              {design.can_build ? (
                <Button inline content={design.name} onClick={() => act(buildAction, { [buildAction]: design.id })} />
              ) : (
                <Box inline style={{ color: C.textDim }}>{design.name}</Box>
              )}
              <Box inline ml={1} style={{ color: C.textDim, fontSize: '10px' }}>[{design.cost}]</Box>
            </Box>
          ))}
        </Box>
        <Box mt={1}>
          <Button content="< Main Menu" onClick={() => act('menu', { menu: '1.0' })} />
        </Box>
      </Section>
      <LatheSubScreens device={device} d={d} removeAction={removeAction} disposeAction={disposeAction} disposeAllAction={disposeAllAction} ejectAction={ejectAction} />
    </>
  );
};

const LatheSubScreens = (props, context) => {
  const { act, data } = useBackend(context);
  const { device, d, removeAction, disposeAction, disposeAllAction, ejectAction } = props;
  const screen = String(data.screen);
  const queueScreen = device === 'lathe' ? '3.4' : '4.4';
  const matsScreen = device === 'lathe' ? '3.2' : '4.3';
  const chemScreen = device === 'lathe' ? '3.3' : '4.2';
  if (screen === queueScreen) {
    return (
      <Section title="Queue">
        {(d.queue || []).length === 0 ? (
          <Box style={{ color: C.textDim }}>Empty</Box>
        ) : (
          d.queue.map((item) => (
            <Box key={item.index} mb={0.5}>
              {item.busy ? (
                <Box inline bold>{item.index}: {item.name}</Box>
              ) : (
                <>
                  <Box inline bold>{item.index}: {item.name}</Box>
                  {' '}
                  <Button inline ml={1} content="(Remove)" onClick={() => act(removeAction, { remove: item.index })} />
                </>
              )}
            </Box>
          ))
        )}
        <Box mt={1}>
          <MenuButton screen={device === 'lathe' ? '3.1' : '4.1'} label="< Lathe Menu" />
        </Box>
      </Section>
    );
  }
  if (screen === matsScreen) {
    return (
      <Section title="Material Storage">
        {(d.mat_list || []).map((mat, i) => (
          <Box key={i} mb={0.5}>
            <Box bold>{mat.name}: {mat.amount} cm³</Box>
            {mat.ejects.length > 0 ? (
              <Box>
                <Box inline style={{ color: C.textDim }}>Eject: </Box>
                {mat.ejects.map((count, ci) => (
                  <Button key={ci} inline mr={0.5} content={count} onClick={() => act(ejectAction, { mat: mat.key, amount: count })} />
                ))}
                <Button inline content="max (50)" onClick={() => act(ejectAction, { mat: mat.key, amount: 50 })} />
              </Box>
            ) : null}
          </Box>
        ))}
        <Box mt={1}>
          <MenuButton screen={device === 'lathe' ? '3.1' : '4.1'} label="< Lathe Menu" />
        </Box>
      </Section>
    );
  }
  if (screen === chemScreen) {
    return (
      <Section title="Chemical Storage">
        {(d.chems || []).map((chem, i) => (
          <Box key={i} mb={0.5}>
            {chem.name} — {chem.volume}u{' '}
            <Button inline ml={1} content="(Purge)" onClick={() => act(disposeAction, { chem: chem.key })} />
          </Box>
        ))}
        <Button mt={1} content="Dispose of ALL Chemicals" color="red" onClick={() => act(disposeAllAction)} />
        <Box mt={1}>
          <MenuButton screen={device === 'lathe' ? '3.1' : '4.1'} label="< Lathe Menu" />
        </Box>
      </Section>
    );
  }
  return null;
};

export const RDConsole = (props, context) => {
  const { act, data } = useBackend(context);
  const screen = String(data.screen);

  let body = null;
  if (screen === '0' || screen === '0.0' || screen === '0.1') {
    body = <Section title="Fabrication Network"><Box style={{ color: C.amber }}>Updating Database...</Box></Section>;
  } else if (screen === '0.2') {
    body = (
      <Section title="Locked">
        <Box mb={1} style={{ color: C.bad }}>SYSTEM LOCKED</Box>
        <Button content="Unlock" onClick={() => act('lock', { lock: '1' })} />
      </Section>
    );
  } else if (screen === '0.3') {
    body = <Section title="Building"><Box style={{ color: C.amber }}>Constructing Prototype. Please Wait...</Box></Section>;
  } else if (screen === '0.4') {
    body = <Section title="Imprinting"><Box style={{ color: C.amber }}>Imprinting Circuit. Please Wait...</Box></Section>;
  } else if (screen === '0.5') {
    body = <Section title="Printing"><Box style={{ color: C.amber }}>Printing. Please Wait...</Box></Section>;
  } else if (screen === '1' || screen === '1.0') {
    // Screen '1' is the legacy "device missing" state from the CHECK_
    // macros; it falls through to the main menu, which is what the legacy
    // console did after a failed linkage.
    body = <MainMenu data={data} />;
  } else if (screen === '1.1') {
    body = (
      <Section title="Learning Matrix Proficiency Levels">
        {(data.techs || []).map((tech, i) => (
          <Box key={i} mb={1}>
            <Box bold>{tech.name}</Box>
            <Box ml={2}>Level: {tech.level}</Box>
            <Box ml={2} style={{ color: C.textDim }}>{tech.desc}</Box>
          </Box>
        ))}
        <Box mt={1}>
          <Button inline mr={0.5} content="Print This Page" onClick={() => act('print', { print: '1' })} />
          <Button content="< Main Menu" onClick={() => act('menu', { menu: '1.0' })} />
        </Box>
      </Section>
    );
  } else if (screen === '1.2') {
    body = <TechDisk />;
  } else if (screen === '1.3') {
    body = <TechDiskLoad />;
  } else if (screen === '1.4') {
    body = <DesignDisk />;
  } else if (screen === '1.5') {
    body = <DesignDiskLoad />;
  } else if (screen === '1.6') {
    body = <Settings />;
  } else if (screen === '1.7') {
    body = <DeviceLinkage />;
  } else if (screen === '2.0' || screen === '2.1' || screen === '2.2') {
    body = data.has_destroy ? <DestroyScreen /> : (
      <Section title="Destructive Analyzer"><Box style={{ color: C.bad }}>NO DESTRUCTIVE ANALYZER LINKED TO CONSOLE</Box><Button content="< Main Menu" onClick={() => act('menu', { menu: '1.0' })} /></Section>
    );
  } else if (screen === '3.0') {
    body = <Section title="Protolathe"><Box style={{ color: C.bad }}>NO PROTOLATHE LINKED TO CONSOLE</Box><Button content="< Main Menu" onClick={() => act('menu', { menu: '1.0' })} /></Section>;
  } else if (screen >= '3' && screen <= '3.9') {
    body = data.has_lathe ? <LatheImprinter device="lathe" d={data.lathe || {}} isLathe /> : (
      <Section title="Protolathe"><Box style={{ color: C.bad }}>NO PROTOLATHE LINKED TO CONSOLE</Box><Button content="< Main Menu" onClick={() => act('menu', { menu: '1.0' })} /></Section>
    );
  } else if (screen === '4.0') {
    body = <Section title="Circuit Imprinter"><Box style={{ color: C.bad }}>NO CIRCUIT IMPRINTER LINKED TO CONSOLE</Box><Button content="< Main Menu" onClick={() => act('menu', { menu: '1.0' })} /></Section>;
  } else if (screen >= '4' && screen <= '4.9') {
    body = data.has_imprinter ? <LatheImprinter device="imprinter" d={data.imprinter || {}} isLathe={false} /> : (
      <Section title="Circuit Imprinter"><Box style={{ color: C.bad }}>NO CIRCUIT IMPRINTER LINKED TO CONSOLE</Box><Button content="< Main Menu" onClick={() => act('menu', { menu: '1.0' })} /></Section>
    );
  } else if (screen === '5.0') {
    body = (
      <Section title="Available Designs">
        {(data.known_designs || []).map((design, i) => (
          <Box key={i} mb={0.5}>
            <Box bold>{design.name}</Box>
            <Box ml={2} style={{ color: C.textDim }}>{design.desc}</Box>
          </Box>
        ))}
        <Box mt={1}>
          <Button inline mr={0.5} content="Print This Page" onClick={() => act('print', { print: '2' })} />
          <Button content="< Main Menu" onClick={() => act('menu', { menu: '1.0' })} />
        </Box>
      </Section>
    );
  } else {
    body = <Section title="Fabrication Console"><Box style={{ color: C.textDim }}>Unknown screen: {screen}</Box><Button content="Main Menu" onClick={() => act('menu', { menu: '1.0' })} /></Section>;
  }

  return (
    <Window width={760} height={640}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.borderRed, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>CORE FABRICATOR CONSOLE</Box>
            <Box style={{ color: C.textDim, fontSize: '9px' }}>R&D SELF-LEARNING MATRIX | SCREEN {screen}</Box>
          </Box>
          {body}
        </Box>
      </Window.Content>
    </Window>
  );
};
