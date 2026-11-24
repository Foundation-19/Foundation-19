import { useBackend, useSharedState } from '../backend';
import { Box, Button, Dropdown, NoticeBox, Flex, ColorBox } from '../components';
import { Window } from '../layouts';
import { C, term, TermBox, TermHeader, TermLabel, TermValue, TermRow, TermDivider, TermButton, PriorityButtons } from './CharacterSetupShared';

const TABS = [
  { key: 'Physical', label: 'PHYSICAL' },
  { key: 'Background', label: 'BACKGROUND' },
  { key: 'Occupation', label: 'ASSIGNMENT' },
  { key: 'Roles', label: 'SCP' },
  { key: 'Loadout', label: 'EQUIP' },
  { key: 'Laws', label: 'LAWS' },
  { key: 'Global', label: 'SETTINGS' },
];

const CharacterSlots = (props, context) => {
  const { act } = useBackend(context);
  const { slots } = props;
  if (!slots || slots.length <= 1) return null;
  const activeSlot = slots.find(s => s.selected);
  return (
    <Flex justify="center" style={{ marginBottom: '4px' }}>
      <Flex.Item width="30%">
        <Dropdown
          width="100%"
          displayText={activeSlot?.name || 'SLOT 1'}
          options={slots.map((s) => ({ value: s.slot, displayText: s.name || `SLOT ${s.slot}` }))}
          onSelected={(val) => act('changeslot', { slot: val })}
        />
      </Flex.Item>
      <Flex.Item ml={1}>
        <Button icon="save" content="SAVE" color="good" onClick={() => act('save')} />
      </Flex.Item>
      <Flex.Item ml={1}>
        <Button icon="folder-open" content="LOAD" onClick={() => act('load')} />
      </Flex.Item>
      <Flex.Item ml={1}>
        <Button icon="trash" content="RESET" color="bad" onClick={() => act('resetslot')} />
      </Flex.Item>
    </Flex>
  );
};

const OverviewPage = (props, context) => {
  const { act, data } = useBackend(context);
  const d = data.tab_data;
  const basic = d?.Basic;
  const body = d?.Body;
  if (!basic && !body) return <TermBox><Box style={term({ color: C.textDim, fontStyle: 'italic' })}>NO DATA</Box></TermBox>;
  return (
    <TermBox>
      <TermHeader>PERSONNEL SUMMARY</TermHeader>
      <TermRow><TermLabel>DESIGNATION</TermLabel><TermValue bold color={C.amber}>{basic?.name || 'UNASSIGNED'}</TermValue></TermRow>
      <TermRow><TermLabel>SPECIES</TermLabel><TermValue>{body?.species || '—'}</TermValue></TermRow>
      <TermRow><TermLabel>GENDER</TermLabel><TermValue>{basic?.gender_text || '—'}</TermValue></TermRow>
      <TermRow><TermLabel>AGE</TermLabel><TermValue>{basic?.age || '—'}</TermValue></TermRow>
      <TermRow><TermLabel>BLOOD TYPE</TermLabel><TermValue>{body?.blood_type || '—'}</TermValue></TermRow>
      <TermRow><TermLabel>SPAWN POINT</TermLabel><TermValue>{basic?.spawnpoint || '—'}</TermValue></TermRow>
      <TermDivider />
      <Box style={{ display: 'flex', gap: '6px', flexWrap: 'wrap' }}>
        <TermButton onClick={() => act('rename')}>RENAME</TermButton>
        <TermButton color="yellow" onClick={() => act('random_name')}>RANDOMIZE</TermButton>
        <TermButton selected={basic?.be_random_name} onClick={() => act('always_random_name')}>ALWAYS RAND</TermButton>
        <TermButton onClick={() => act('gender')}>GENDER</TermButton>
        <TermButton onClick={() => act('age')}>AGE</TermButton>
        <TermButton onClick={() => act('spawnpoint')}>SPAWN</TermButton>
      </Box>
    </TermBox>
  );
};

const CustomizationPage = (props, context) => {
  const { act, data } = useBackend(context);
  const body = data.tab_data?.Body;
  if (!body) return <TermBox><Box style={term({ color: C.textDim, fontStyle: 'italic' })}>NO DATA</Box></TermBox>;
  return (
    <TermBox>
      <TermHeader>PERSONNEL IDENTIFICATION</TermHeader>
      <TermRow><TermLabel>SPECIES</TermLabel><TermValue bold color={C.amber}>{body.species}</TermValue></TermRow>
      <TermRow><TermLabel>BLOOD TYPE</TermLabel><TermValue>{body.blood_type}</TermValue></TermRow>
      {body.has_skin_tone ? <TermRow><TermLabel>SKIN TONE</TermLabel><TermValue>{body.skin_tone}/{body.max_skin_tone}</TermValue></TermRow> : null}
      {body.has_base_skin_colours ? <TermRow><TermLabel>BASE COLOUR</TermLabel><TermValue>{body.base_skin}</TermValue></TermRow> : null}
      <TermRow><TermLabel>NEEDS GLASSES</TermLabel><TermValue color={body.needs_glasses ? C.redBright : C.textDim}>{body.needs_glasses ? 'YES' : 'NO'}</TermValue></TermRow>
      <Box style={{ display: 'flex', gap: '4px', flexWrap: 'wrap', marginBottom: '8px' }}>
        <TermButton onClick={() => act('set_species')}>SPECIES</TermButton>
        <TermButton onClick={() => act('blood_type')}>BLOOD</TermButton>
        {body.has_skin_tone ? <TermButton onClick={() => act('skin_tone')}>SKIN TONE</TermButton> : null}
        {body.has_base_skin_colours ? <TermButton onClick={() => act('base_skin')}>BASE COLOUR</TermButton> : null}
        <TermButton selected={body.needs_glasses} onClick={() => act('char_nearsighted')}>GLASSES</TermButton>
        <TermButton color="yellow" onClick={() => act('random')}>RANDOMIZE ALL</TermButton>
      </Box>
      <TermDivider />
      <TermHeader>BIOMETRIC DATA</TermHeader>
      <TermRow>
        <TermLabel>HAIR</TermLabel>
        {body.has_hair_color ? <><ColorBox color={body.hair_color} mr={1} /><TermButton onClick={() => act('hair_color')}>CLR</TermButton></> : null}
        <TermButton onClick={() => act('hair_style', { direction: 'decrement' })}>{'<'}</TermButton>
        <TermValue mr={1}>{body.hair_style}</TermValue>
        <TermButton onClick={() => act('hair_style', { direction: 'increment' })}>{'>'}</TermButton>
        <TermButton onClick={() => act('hair_style')}>PICK</TermButton>
      </TermRow>
      <TermRow>
        <TermLabel>FACIAL</TermLabel>
        {body.has_hair_color ? <><ColorBox color={body.facial_color} mr={1} /><TermButton onClick={() => act('facial_color')}>CLR</TermButton></> : null}
        <TermButton onClick={() => act('facial_style', { direction: 'decrement' })}>{'<'}</TermButton>
        <TermValue mr={1}>{body.facial_style}</TermValue>
        <TermButton onClick={() => act('facial_style', { direction: 'increment' })}>{'>'}</TermButton>
        <TermButton onClick={() => act('facial_style')}>PICK</TermButton>
      </TermRow>
      {body.has_eye_color ? (
        <TermRow><TermLabel>EYES</TermLabel><ColorBox color={body.eye_color} mr={1} /><TermButton onClick={() => act('eye_color')}>COLOR</TermButton></TermRow>
      ) : null}
      {body.has_skin_color ? (
        <TermRow><TermLabel>SKIN</TermLabel><ColorBox color={body.skin_color} mr={1} /><TermButton onClick={() => act('skin_color')}>COLOR</TermButton></TermRow>
      ) : null}
      <TermDivider />
      <TermHeader>LIMBS & ORGANS</TermHeader>
      <Box style={{ display: 'flex', gap: '4px', marginBottom: '8px' }}>
        <TermButton onClick={() => act('limbs')}>ADJUST LIMBS</TermButton>
        <TermButton onClick={() => act('reset_limbs')}>RESET LIMBS</TermButton>
        <TermButton onClick={() => act('organs')}>ADJUST ORGANS</TermButton>
      </Box>
      {body.organs && body.organs.length > 0 && body.organs.map((organ, i) => (
        <TermRow key={i}><TermLabel>{organ.display}</TermLabel><TermValue color={organ.status === 'amputated' ? C.redBright : C.amber}>{organ.status}</TermValue></TermRow>
      ))}
      {body.body_descriptors && body.body_descriptors.map((desc, i) => (
        <TermRow key={i}><TermLabel>{desc.label}</TermLabel><TermValue>{desc.value}</TermValue>
          <TermButton onClick={() => act('change_descriptor', { descriptor_id: desc.id })}>CHANGE</TermButton>
        </TermRow>
      ))}
      <TermDivider />
      <TermHeader>BODY MARKINGS</TermHeader>
      <TermButton onClick={() => act('marking_style')}>ADD MARKING</TermButton>
      {body.body_markings && body.body_markings.map((marking, i) => (
        <TermRow key={i}>
          <ColorBox color={marking.color} mr={1} /><TermValue mr={1}>{marking.name}</TermValue>
          <TermButton onClick={() => act('marking_color', { marking: marking.name })}>CLR</TermButton>
          <TermButton color="red" onClick={() => act('marking_remove', { marking: marking.name })}>RM</TermButton>
        </TermRow>
      ))}
    </TermBox>
  );
};

const ClothingPage = (props, context) => {
  const { act, data } = useBackend(context);
  const d = data.tab_data?.Clothing;
  if (!d) return null;
  return (
    <TermBox>
      <TermHeader>EQUIPMENT CONFIGURATION</TermHeader>
      {d.underwear && d.underwear.map((uw, i) => (
        <TermRow key={i}>
          <TermLabel>{uw.category}</TermLabel><TermValue mr={1}>{uw.selected}</TermValue>
          <TermButton onClick={() => act('change_underwear', { category: uw.category })}>CHANGE</TermButton>
        </TermRow>
      ))}
      <TermDivider />
      <TermRow><TermLabel>BACKPACK</TermLabel><TermValue mr={1}>{d.backpack}</TermValue><TermButton onClick={() => act('change_backpack')}>CHANGE</TermButton></TermRow>
      <TermRow><TermLabel>SUIT SENSORS</TermLabel><TermValue mr={1}>{d.sensor_setting}</TermValue><TermButton onClick={() => act('change_sensor_setting')}>CHANGE</TermButton></TermRow>
      <TermRow><TermLabel>SENSORS LOCKED</TermLabel><TermValue color={d.sensors_locked ? C.redBright : C.green}>{d.sensors_locked ? 'YES' : 'NO'}</TermValue>
        <TermButton selected={d.sensors_locked} onClick={() => act('toggle_sensors_locked')}>TOGGLE</TermButton>
      </TermRow>
    </TermBox>
  );
};

const FlavorPage = (props, context) => {
  const { act, data } = useBackend(context);
  const d = data.tab_data?.Flavor;
  if (!d) return null;
  const slots = ['general', 'head', 'face', 'eyes', 'torso', 'arms', 'hands', 'legs', 'feet'];
  return (
    <TermBox>
      <TermHeader>FLAVOR TEXT</TermHeader>
      {slots.map(slot => (
        <TermRow key={slot}>
          <TermLabel>{slot.toUpperCase()}</TermLabel>
          <TermValue color={d[`flavor_${slot}`] ? C.amber : C.textDim}>{d[`flavor_${slot}`] ? 'SET' : 'EMPTY'}</TermValue>
          <TermButton onClick={() => act('set_flavor_text', { slot })}>EDIT</TermButton>
        </TermRow>
      ))}
      <TermDivider />
      <TermHeader>ROBOT FLAVOR TEXT</TermHeader>
      <TermButton onClick={() => act('set_flavour_robot', { slot: 'Default' })}>EDIT DEFAULT</TermButton>
      {d.robot_modules && d.robot_modules.map((mod, i) => (
        <TermButton key={i} onClick={() => act('set_flavour_robot', { slot: mod })}>{mod.toUpperCase()}</TermButton>
      ))}
    </TermBox>
  );
};

const PhysicalPage = (props, context) => {
  const { data } = useBackend(context);
  const d = data.tab_data;
  return (
    <TermBox>
      {d?.Basic ? <OverviewPage /> : null}
      {d?.Body ? <><TermDivider /><CustomizationPage /></> : null}
      {d?.Clothing ? <><TermDivider /><ClothingPage /></> : null}
      {d?.Flavor ? <><TermDivider /><FlavorPage /></> : null}
    </TermBox>
  );
};

const CulturePage = (props, context) => {
  const { act, data } = useBackend(context);
  const d = data.tab_data?.Culture;
  if (!d) return null;
  return (
    <TermBox>
      <TermHeader>CULTURAL PROFILE</TermHeader>
      {d.cultures && d.cultures.map((culture, i) => (
        <TermBox key={i} style={{ marginBottom: '8px' }}>
          <TermRow>
            <TermLabel>{culture.label}</TermLabel>
            <TermValue bold color={C.amber}>{culture.current}</TermValue>
            <TermButton onClick={() => act(`expand_options_${culture.token}`)}>{culture.expanded ? 'COLLAPSE' : 'EXPAND'}</TermButton>
          </TermRow>
          {culture.expanded && culture.values ? (
            <Box style={{ display: 'flex', flexWrap: 'wrap', gap: '4px', marginTop: '4px' }}>
              {culture.values.map((val, vi) => (
                <TermButton key={vi} selected={val === culture.current} onClick={() => act(`set_token_entry_${culture.token}`, { value: val.replace(/\+/g, 'PLUS') })}>{val}</TermButton>
              ))}
            </Box>
          ) : null}
        </TermBox>
      ))}
    </TermBox>
  );
};

const LanguagesPage = (props, context) => {
  const { act, data } = useBackend(context);
  const d = data.tab_data?.Languages;
  if (!d) return null;
  return (
    <TermBox>
      <TermHeader>LANGUAGE PROFICIENCY</TermHeader>
      {d.languages && d.languages.map((lang, i) => (
        <TermRow key={i}>
          <TermLabel>{lang.name}</TermLabel>
          {lang.required ? <TermValue color={C.green}>REQUIRED</TermValue> : <TermButton color="red" onClick={() => act('remove_language', { index: lang.index })}>REMOVE</TermButton>}
        </TermRow>
      ))}
      {d.can_add ? <TermButton color="green" onClick={() => act('add_language')}>ADD LANGUAGE</TermButton> : null}
    </TermBox>
  );
};

const RecordsPage = (props, context) => {
  const { act, data } = useBackend(context);
  const d = data.tab_data?.Records;
  if (!d) return null;
  const entries = [
    ['PUBLIC', d.public_record, 'set_public_record'],
    ['MEDICAL', d.med_record, 'set_medical_records'],
    ['EMPLOYMENT', d.gen_record, 'set_general_records'],
    ['SECURITY', d.sec_record, 'set_security_records'],
  ];
  return (
    <TermBox>
      <TermHeader>PERSONNEL RECORDS</TermHeader>
      {d.records_banned ? <NoticeBox danger>RECORDS ACCESS REVOKED</NoticeBox> : null}
      {entries.map(([label, value, actionName]) => (
        <TermRow key={label}>
          <TermLabel>{label}</TermLabel>
          <TermValue mr={1} color={value ? C.amber : C.textDim}>{value ? 'SET' : 'EMPTY'}</TermValue>
          <TermButton disabled={d.records_banned && actionName !== 'set_memory'} onClick={() => act(actionName)}>EDIT</TermButton>
        </TermRow>
      ))}
      <TermDivider />
      <TermRow><TermLabel>MEMORY</TermLabel><TermValue color={d.memory ? C.amber : C.textDim}>{d.memory ? 'SET' : 'EMPTY'}</TermValue>
        <TermButton onClick={() => act('set_memory')}>EDIT</TermButton>
      </TermRow>
      <TermRow><TermLabel>EMAIL PASS</TermLabel><TermValue>{d.email_pass || '(random)'}</TermValue>
        <TermButton onClick={() => act('set_email_pass')}>EDIT</TermButton>
      </TermRow>
    </TermBox>
  );
};

const BackgroundPage = (props, context) => {
  const { data } = useBackend(context);
  const d = data.tab_data;
  return (
    <TermBox>
      {d?.Culture ? <CulturePage /> : null}
      {d?.Languages ? <><TermDivider /><LanguagesPage /></> : null}
      {d?.Records ? <><TermDivider /><RecordsPage /></> : null}
    </TermBox>
  );
};

const OccupationPage = (props, context) => {
  const { act, data } = useBackend(context);
  const d = data.tab_data?.Occupation;
  if (!d) return <TermBox><Box style={term({ color: C.textDim, fontStyle: 'italic' })}>LOADING ASSIGNMENT DATA...</Box></TermBox>;
  const altLabels = { 0: 'RANDOM JOB', 1: 'CLASS-D', 2: 'RETURN TO LOBBY' };
  return (
    <TermBox>
      <TermHeader>ASSIGNMENT PREFERENCES</TermHeader>
      <Box style={{ marginBottom: '10px', display: 'flex', gap: '8px', alignItems: 'center' }}>
        <TermLabel>FALLBACK</TermLabel>
        <TermValue color={C.amber}>{altLabels[d.alternate_option] || 'UNKNOWN'}</TermValue>
        <TermButton onClick={() => act('job_alternative')}>CYCLE</TermButton>
      </Box>
      {d.maps && d.maps.map((mapData, mi) => (
        <TermBox key={mi} style={{ marginBottom: '10px' }}>
          <TermHeader style={{ color: C.amber }}>{mapData.name.toUpperCase()}</TermHeader>
          <Box style={{ display: 'flex', gap: '4px', marginBottom: '6px' }}>
            <TermButton onClick={() => act('toggle_map', { map: mapData.name })}>{mapData.hidden ? 'SHOW' : 'HIDE'}</TermButton>
          </Box>
          {!mapData.hidden && mapData.jobs && mapData.jobs.map((job, ji) => (
            <Box key={ji} style={{ marginBottom: '4px', display: 'flex', alignItems: 'center', gap: '8px', borderBottom: `1px solid ${C.border}`, paddingBottom: '4px' }}>
              <Box style={{ flex: 1, fontFamily: C.mono, fontSize: '10px', color: job.bad_message ? C.textDim : C.text }}>
                {job.bad_message ? <del>{job.title}</del> : job.alt_title || job.title}
              </Box>
              {job.bad_message ? (
                <Box style={{ fontFamily: C.mono, fontSize: '10px', color: C.redBright }}>{job.bad_message}</Box>
              ) : (
                <Box style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                  <PriorityButtons job={job.title} level={job.level} act={act} />
                  {job.has_alt_titles ? (
                    <TermButton onClick={() => act('select_alt_title', { job_ref: job.job_ref })}>
                      {job.alt_title || job.title}
                    </TermButton>
                  ) : null}
                  {job.level > 0 && job.has_skills ? (
                    <TermButton onClick={() => act('set_skills', { rank: job.title })}>SKILLS</TermButton>
                  ) : null}
                </Box>
              )}
            </Box>
          ))}
        </TermBox>
      ))}
      <TermDivider />
      <TermButton color="red" onClick={() => act('reset_jobs')}>RESET JOBS</TermButton>
    </TermBox>
  );
};

const RolesPage = (props, context) => {
  const { act, data } = useBackend(context);
  const candData = data.tab_data?.Candidacy;
  const setupData = data.tab_data?.Setup;
  return (
    <TermBox>
      <TermHeader>CLASSIFIED ROLE PREFERENCES</TermHeader>
      <Box style={{ display: 'flex', gap: '4px', marginBottom: '10px' }}>
        <TermButton color="green" onClick={() => act('select_all', { selection: 1 })}>ALL</TermButton>
        <TermButton color="red" onClick={() => act('select_all', { selection: 0 })}>NONE</TermButton>
      </Box>
      {candData && candData.antag_roles && candData.antag_roles.map((role, i) => (
        <Box key={i} style={{ marginBottom: '4px', display: 'flex', alignItems: 'center', gap: '8px', borderBottom: `1px solid ${C.border}`, paddingBottom: '4px' }}>
          <Box style={{ flex: 1, fontFamily: C.mono, fontSize: '10px', color: role.banned ? C.textDim : C.text }}>{role.name}</Box>
          {role.banned ? (
            <Box style={{ fontFamily: C.mono, fontSize: '10px', color: C.redBright }}>BANNED</Box>
          ) : (
            <Box style={{ display: 'flex', gap: '2px' }}>
              <TermButton selected={role.enabled} color="green" onClick={() => act('add_special', { id: role.id })}>ON</TermButton>
              <TermButton selected={!role.enabled} color="red" onClick={() => act('del_special', { id: role.id })}>OFF</TermButton>
            </Box>
          )}
        </Box>
      ))}
      {candData && candData.ghost_roles && candData.ghost_roles.map((role, i) => (
        <Box key={`g${i}`} style={{ marginBottom: '4px', display: 'flex', alignItems: 'center', gap: '8px', borderBottom: `1px solid ${C.border}`, paddingBottom: '4px' }}>
          <Box style={{ flex: 1, fontFamily: C.mono, fontSize: '10px', color: role.banned ? C.textDim : C.text }}>{role.name}</Box>
          {role.banned ? (
            <Box style={{ fontFamily: C.mono, fontSize: '10px', color: C.redBright }}>BANNED</Box>
          ) : !role.whitelisted ? (
            <Box style={{ fontFamily: C.mono, fontSize: '10px', color: C.amber }}>WHITELIST</Box>
          ) : (
            <Box style={{ display: 'flex', gap: '2px' }}>
              <TermButton selected={role.enabled} color="green" onClick={() => act('add_special', { id: role.id })}>ON</TermButton>
              <TermButton selected={!role.enabled} color="red" onClick={() => act('del_special', { id: role.id })}>OFF</TermButton>
            </Box>
          )}
        </Box>
      ))}
      {setupData && (<>
        <TermDivider />
        <TermHeader>ANTAG SETUP</TermHeader>
        <TermRow><TermLabel>UPLINK SOURCES</TermLabel><TermButton onClick={() => act('add_source')}>ADD</TermButton></TermRow>
        {setupData.uplink_sources && setupData.uplink_sources.map((src, i) => (
          <TermRow key={i}>
            <TermValue mr={1}>{src.name}</TermValue>
            <TermButton onClick={() => act('move_source_up', { source_ref: src.ref })}>UP</TermButton>
            <TermButton onClick={() => act('move_source_down', { source_ref: src.ref })}>DN</TermButton>
            <TermButton color="red" onClick={() => act('remove_source', { source_ref: src.ref })}>RM</TermButton>
          </TermRow>
        ))}
        {!setupData.has_sources ? <Box style={{ color: C.redBright, fontFamily: C.mono, fontSize: '10px', marginBottom: '8px' }}>NO UPLINK SOURCES CONFIGURED</Box> : null}
        <TermDivider />
        <TermRow><TermLabel>EXPLOIT INFO</TermLabel><TermValue color={setupData.exploit_record ? C.amber : C.textDim}>{setupData.exploit_record ? 'SET' : 'EMPTY'}</TermValue>
          <TermButton disabled={setupData.records_banned} onClick={() => act('exploitable_record')}>EDIT</TermButton>
        </TermRow>
      </>)}
    </TermBox>
  );
};

const LoadoutPage = (props, context) => {
  const { act, data } = useBackend(context);
  const d = data.tab_data?.Loadout;
  if (!d) return null;
  return (
    <TermBox>
      <TermHeader>EQUIPMENT LOADOUT</TermHeader>
      <Box style={{ display: 'flex', gap: '8px', marginBottom: '8px' }}>
        <TermButton onClick={() => act('prev_slot')}>{'<'}</TermButton>
        <TermValue bold color={C.amber}>SLOT {d.gear_slot} — {d.total_cost}/{d.max_gear_cost} PTS</TermValue>
        <TermButton onClick={() => act('next_slot')}>{'>'}</TermButton>
        <TermButton color="red" onClick={() => act('clear_loadout')}>CLEAR</TermButton>
      </Box>
      {d.categories && d.categories.map((cat, ci) => (
        <TermBox key={ci} style={{ marginBottom: '8px' }}>
          <TermHeader style={{ color: C.amber }}>{cat.name.toUpperCase()} ({cat.cost} pts)</TermHeader>
          {cat.gear && cat.gear.map((gear, gi) => (
            <Box key={gi} style={{ marginBottom: '4px', borderBottom: `1px solid ${C.border}`, paddingBottom: '4px' }}>
              <Box style={{ marginBottom: '4px', display: 'flex', alignItems: 'center', gap: '8px' }}>
                <TermButton selected={gear.selected} onClick={() => act('toggle_gear', { gear_ref: gear.ref })}>{gear.name}</TermButton>
                <TermValue color={C.textDim}>{gear.cost}pt</TermValue>
              </Box>
              {gear.selected && gear.tweaks && gear.tweaks.map((tweak, ti) => (
                <Box key={ti} style={{ marginBottom: '4px', marginLeft: '16px' }}>
                  {tweak.options ? (
                    <Box>
                      <Box style={{ fontSize: '10px', color: C.textDim, marginBottom: '2px' }}>{tweak.contents}</Box>
                      <Dropdown
                        width="100%"
                        displayText={tweak.current || 'SELECT'}
                        options={tweak.options.map((o) => ({ value: o.name, displayText: o.name }))}
                        onSelected={(val) => act('gear_tweak', { gear_ref: gear.ref, tweak_ref: tweak.ref, selected_path: val })}
                      />
                    </Box>
                  ) : (
                    <Box style={{ fontSize: '10px', color: C.textDim }}>{tweak.contents}</Box>
                  )}
                </Box>
              ))}
            </Box>
          ))}
        </TermBox>
      ))}
    </TermBox>
  );
};

const LawsPage = (props, context) => {
  const { act, data } = useBackend(context);
  const d = data.tab_data?.Laws;
  if (!d) return null;
  return (
    <TermBox>
      <TermHeader>SHACKLE CONFIGURATION</TermHeader>
      {!d.has_posibrain ? (
        <Box style={term({ color: C.textDim, fontStyle: 'italic' })}>SPECIES HAS NO SHACKLE CAPABILITY</Box>
      ) : (
        <>
          <Box style={{ display: 'flex', gap: '4px', marginBottom: '8px' }}>
            <TermButton selected={!d.is_shackled} onClick={() => act('toggle_shackle')}>OFF</TermButton>
            <TermButton selected={d.is_shackled} color="green" onClick={() => act('toggle_shackle')}>ON</TermButton>
          </Box>
          {d.is_shackled ? (<>
            <TermHeader>CURRENT LAWS</TermHeader>
            {d.laws && d.laws.length > 0 ? d.laws.map((law, i) => (
              <Box key={i} style={term({ fontSize: '11px' })}>{i + 1}) {law}</Box>
            )) : <Box style={term({ color: C.textDim, fontStyle: 'italic' })}>NO LAWS CONFIGURED</Box>}
            <TermButton style={{ marginTop: '8px' }} onClick={() => act('lawsets')}>LOAD LAWSET</TermButton>
          </>) : null}
        </>
      )}
    </TermBox>
  );
};

const GlobalPage = (props, context) => {
  const { act, data } = useBackend(context);
  const items = data.tab_data;
  return (
    <TermBox>
      {items?.UI && (<TermBox>
        <TermHeader>UI CONFIGURATION</TermHeader>
        <TermRow><TermLabel>UI STYLE</TermLabel><TermValue mr={1}>{items.UI.UI_style}</TermValue><TermButton onClick={() => act('select_style')}>CHANGE</TermButton></TermRow>
        <TermRow><TermLabel>UI COLOR</TermLabel><ColorBox color={items.UI.UI_style_color} mr={1} /><TermButton onClick={() => act('select_color')}>CHANGE</TermButton><TermButton onClick={() => act('reset', { reset: 'ui' })}>RESET</TermButton></TermRow>
        <TermRow><TermLabel>UI ALPHA</TermLabel><TermValue mr={1}>{items.UI.UI_style_alpha}</TermValue><TermButton onClick={() => act('select_alpha')}>CHANGE</TermButton><TermButton onClick={() => act('reset', { reset: 'alpha' })}>RESET</TermButton></TermRow>
        {items.UI.can_select_ooc_color ? <TermRow><TermLabel>OOC COLOR</TermLabel><TermButton onClick={() => act('select_ooc_color')}>CHANGE</TermButton>{!items.UI.ooccolor_is_default ? <TermButton onClick={() => act('reset', { reset: 'ooc' })}>RESET</TermButton> : null}</TermRow> : null}
        <TermRow><TermLabel>CLIENT FPS</TermLabel><TermValue mr={1}>{items.UI.clientfps}</TermValue><TermButton onClick={() => act('select_fps')}>CHANGE</TermButton></TermRow>
      </TermBox>)}
      {items?.Prefixes && (<TermBox style={{ marginTop: '10px' }}>
        <TermHeader>PREFIX KEYS</TermHeader>
        {items.Prefixes.prefixes && items.Prefixes.prefixes.map((prefix, i) => (
          <TermRow key={i}>
            <TermLabel>{prefix.name}</TermLabel><TermValue bold color={C.amber} mr={1}>{prefix.current_key}</TermValue>
            {!prefix.is_locked ? <TermButton onClick={() => act('change_prefix', { prefix_ref: prefix.ref })}>CHANGE</TermButton> : null}
            {!prefix.is_locked && prefix.current_key !== prefix.default_key ? <TermButton onClick={() => act('reset_prefix', { prefix_ref: prefix.ref })}>RESET</TermButton> : null}
          </TermRow>
        ))}
      </TermBox>)}
      {items?.pAI && (<TermBox style={{ marginTop: '10px' }}>
        <TermHeader>pAI CONFIGURATION</TermHeader>
        <TermRow><TermLabel>NAME</TermLabel><TermValue>{items.pAI.pai_name || 'NONE SET'}</TermValue><TermButton onClick={() => act('pai_name')}>EDIT</TermButton></TermRow>
        <TermRow><TermLabel>DESCRIPTION</TermLabel><TermValue>{items.pAI.pai_desc ? 'SET' : 'NONE'}</TermValue><TermButton onClick={() => act('pai_desc')}>EDIT</TermButton></TermRow>
        <TermRow><TermLabel>ROLE</TermLabel><TermValue>{items.pAI.pai_role || 'NONE SET'}</TermValue><TermButton onClick={() => act('pai_role')}>EDIT</TermButton></TermRow>
        <TermRow><TermLabel>CHASSIS</TermLabel><TermValue>{items.pAI.pai_chassis}</TermValue><TermButton onClick={() => act('pai_chassis')}>CHANGE</TermButton></TermRow>
        <TermRow><TermLabel>SAY VERB</TermLabel><TermValue>{items.pAI.pai_say_verb}</TermValue><TermButton onClick={() => act('pai_say')}>CHANGE</TermButton></TermRow>
      </TermBox>)}
      {items?.OOC && (<TermBox style={{ marginTop: '10px' }}>
        <TermHeader>OOC SETTINGS</TermHeader>
        {items.OOC.ignored_players && items.OOC.ignored_players.map((player, i) => (
          <TermRow key={i}><TermValue mr={1}>{player}</TermValue><TermButton color="red" onClick={() => act('unignore_player', { player })}>UNIGNORE</TermButton></TermRow>
        ))}
        <TermButton onClick={() => act('ignore_player')}>IGNORE PLAYER</TermButton>
      </TermBox>)}
      {items?.Settings && (<TermBox style={{ marginTop: '10px' }}>
        <TermHeader>SYSTEM PREFERENCES</TermHeader>
        {items.Settings.preferences && items.Settings.preferences.map((pref, i) => (
          <TermRow key={i}>
            <TermLabel>{pref.description}</TermLabel>
            <Box style={{ display: 'flex', gap: '2px' }}>
              {pref.options && pref.options.map((option, oi) => (
                <TermButton key={oi} selected={option === pref.selected} onClick={() => act('set_pref', { key: pref.key, value: option })}>{option.toUpperCase()}</TermButton>
              ))}
            </Box>
          </TermRow>
        ))}
      </TermBox>)}
    </TermBox>
  );
};

const TAB_PAGES = {
  Physical: PhysicalPage,
  Background: BackgroundPage,
  Occupation: OccupationPage,
  Roles: RolesPage,
  Loadout: LoadoutPage,
  Laws: LawsPage,
  Global: GlobalPage,
};

export const CharacterSetup = (props, context) => {
  const { act, data } = useBackend(context);
  const { slots, is_guest, load_failed } = data;
  const [active, setActive] = useSharedState(context, 'CS.activeTab', 'Physical');
  const PageComponent = TAB_PAGES[active];

  return (
    <Window title="SCP PERSONNEL CONFIGURATION TERMINAL v5.0" width={800} height={600} theme="scp_terminal">
      <Window.Content scrollable>
        <Box style={{ background: C.bg, border: `1px solid ${C.borderRed}`, padding: 0, fontFamily: C.mono, fontSize: '12px', color: C.text, minHeight: '100%' }}>
          <Box style={{ borderBottom: `2px solid ${C.borderRed}`, padding: '10px 14px 8px', background: 'linear-gradient(180deg, #0e0000 0%, #08080a 100%)' }}>
            <Box style={{ fontSize: '15px', fontWeight: 'bold', color: C.amber, letterSpacing: '0.18em' }}>SCP FOUNDATION — PERSONNEL CONFIGURATION</Box>
            <Box style={{ fontSize: '9px', color: C.textDim, letterSpacing: '0.12em', marginTop: '2px' }}>TERMINAL v5.0 | CLEARANCE LEVEL 2 | CLASSIFIED | ENCRYPTION: AES-512</Box>
          </Box>
          <Box style={{ padding: '6px 14px', borderBottom: `1px solid ${C.border}`, background: C.panel }}>
            {!is_guest && !load_failed ? <CharacterSlots slots={slots} /> : null}
            {is_guest ? <Box style={term({ color: C.textDim, fontSize: '9px', textAlign: 'center' })}>[ GUEST ACCOUNT — SAVE DISABLED ]</Box> : null}
            {load_failed ? <Box style={term({ color: C.redBright, fontSize: '9px', textAlign: 'center' })}>[ SAVEFILE LOAD FAILURE — ADMINHELP ]</Box> : null}
          </Box>
          <Box style={{ display: 'flex', borderBottom: `1px solid ${C.borderRed}`, overflowX: 'auto', background: C.panel }}>
            {TABS.map((t) => { const isActive = active === t.key; return (<Box key={t.key} style={{ padding: '6px 10px', cursor: 'pointer', background: isActive ? 'rgba(139,0,0,0.25)' : 'transparent', borderRight: `1px solid ${C.border}`, borderBottom: isActive ? `2px solid ${C.amber}` : '2px solid transparent', color: isActive ? C.textBright : C.textDim, fontSize: '9px', letterSpacing: '0.12em', textTransform: 'uppercase', fontFamily: C.mono, whiteSpace: 'nowrap' }} onClick={() => setActive(t.key)}>{isActive && '▸ '}{t.label}</Box>); })}
          </Box>
          <Box style={{ display: 'flex' }}>
            <Box style={{ flex: 1, padding: '16px', minHeight: '480px' }}>
              {PageComponent ? <PageComponent /> : <TermBox><Box style={term({ color: C.textDim, fontStyle: 'italic' })}>NO DATA</Box></TermBox>}
            </Box>
            <Box style={{ width: '300px', borderLeft: `1px solid ${C.border}`, background: C.panel, padding: '10px', flexShrink: 0 }}>
              <TermHeader>VISUAL RECORD</TermHeader>
              <Box style={{ height: '260px', marginBottom: '10px', display: 'flex', alignItems: 'center', justifyContent: 'center', overflow: 'hidden' }}>
                {data.preview_png ? (
                  <img
                    src={data.preview_png}
                    style={{ maxHeight: '100%', maxWidth: '100%', imageRendering: 'pixelated' }}
                  />
                ) : (
                  <Box style={term({ color: C.textDim, textAlign: 'center' })}>NO SIGNAL</Box>
                )}
              </Box>
              <TermButton fluid onClick={() => act('rotate')}>ROTATE</TermButton>
              <TermDivider />
              <TermHeader>PREVIEW MODE</TermHeader>
              <Box style={{ display: 'flex', gap: '2px', marginBottom: '8px' }}>
                {(data.preview_options || []).map((opt) => <TermButton key={opt} selected={data.preview_selection === opt} color={data.preview_selection === opt ? 'green' : undefined} onClick={() => act('set_preview_pref', { value: opt })}>{opt.toUpperCase()}</TermButton>)}
              </Box>
              <TermDivider />
              <TermHeader>SYSTEM</TermHeader>
              <Box style={term({ color: C.textDim, fontSize: '9px', lineHeight: '1.6' })}>
                <Box>LINK: NOMINAL</Box><Box>NET: SECURE</Box><Box>CRYPTO: AES-512</Box><Box>STATUS: <Box as="span" style={{ color: C.green }}>ONLINE</Box></Box>
              </Box>
            </Box>
          </Box>
          <Box style={{ borderTop: `1px solid ${C.border}`, padding: '4px 14px', background: C.panel }}>
            <Box style={term({ color: C.textDim, fontSize: '9px', letterSpacing: '0.1em' })}>SCP FOUNDATION | SECURE CONTAIN PROTECT | ALL ACTIVITY LOGGED | UNAUTHORIZED ACCESS IS A CLASS-B INFRACTION</Box>
          </Box>
        </Box>
      </Window.Content>
    </Window>
  );
};
