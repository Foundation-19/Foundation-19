import { BooleanLike } from 'common/react';

import { useBackend, useLocalState } from '../backend';
import { Box, Button, Input } from '../components';
import { Window } from '../layouts';

type Ability = {
  id: string;
  name: string;
  cost: number;
  available: BooleanLike;
};

type Camera = {
  ref: string;
  name: string;
  area_name: string;
  status: string;
  is_current: BooleanLike;
};

type Door = {
  ref: string;
  name: string;
  open: BooleanLike;
  hacked: BooleanLike;
};

type Apc = {
  ref: string;
  name: string;
  power_status: string;
};

type Data = {
  processing_power: number;
  max_processing_power: number;
  memory_used: number;
  memory_capacity: number;
  tier: number;
  max_tier: number;
  zone_filter: string;
  abilities: Ability[];
  cameras: Camera[];
  current_camera: { ref: string; name: string } | null;
  nearby_doors: Door[];
  nearby_apcs: Apc[];
  hacked_doors: Door[];
};

const C = {
  bg: '#08080a',
  panel: '#0c0c10',
  border: '#1e1e24',
  borderRed: '#6b0000',
  red: '#8b0000',
  redBright: '#cc2222',
  green: '#1a7a1a',
  greenBright: '#44ff44',
  text: '#b0b0b0',
  textBright: '#e0e0e8',
  textDim: '#555560',
  amber: '#d4a017',
  blue: '#2244aa',
  blueBright: '#4488ff',
  mono: '"Consolas", "Courier New", "Lucida Console", monospace',
};

const ZONES = ['ALL', 'HCZ', 'LCZ', 'EZ'];

const TIER_NAMES = [
  '',
  'Tier 1 - Observer',
  'Tier 2 - Manipulator',
  'Tier 3 - Hacker',
  'Tier 4 - Manifestation',
  'Tier 5 - Cascade',
];

const termButton = (active: boolean, color: string) => ({
  fontFamily: C.mono,
  fontSize: '10px',
  letterSpacing: '0.12em',
  background: active ? 'rgba(34,68,170,0.3)' : 'transparent',
  border: `1px solid ${active ? color : C.border}`,
  borderRadius: 0,
  color: active ? C.textBright : C.textDim,
  padding: '4px 10px',
});

export const Scp079CameraInterface = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const {
    processing_power,
    max_processing_power,
    memory_used,
    memory_capacity,
    tier,
    max_tier,
    zone_filter,
    abilities,
    cameras,
    current_camera,
    nearby_doors,
    nearby_apcs,
    hacked_doors,
  } = data;

  // useLocalState, not react useState: this inferno build has no hooks
  // (see the SuitSensors useRef crash).
  const [tab, setTab] = useLocalState(context, '079_tab', 'cameras');
  const [searchText, setSearchText] = useLocalState(context, '079_search', '');
  const [broadcastMsg, setBroadcastMsg] = useLocalState(
    context,
    '079_broadcast',
    '',
  );

  const filteredCameras = (cameras || []).filter(
    (c) =>
      !searchText ||
      c.name.toLowerCase().includes(searchText.toLowerCase()) ||
      c.area_name.toLowerCase().includes(searchText.toLowerCase()),
  );

  return (
    <Window width={700} height={600} theme="scp_terminal">
      <Window.Content scrollable>
        <Box
          style={{
            background: C.bg,
            border: `1px solid ${C.borderRed}`,
            fontFamily: C.mono,
            fontSize: '12px',
            color: C.text,
            minHeight: '100%',
          }}
        >
          <Box
            style={{
              borderBottom: `2px solid ${C.blue}`,
              padding: '10px 14px 8px',
              background: 'linear-gradient(180deg, #060010 0%, #08080a 100%)',
            }}
          >
            <Box
              style={{
                fontSize: '14px',
                fontWeight: 'bold',
                color: C.blueBright,
                letterSpacing: '0.18em',
              }}
            >
              SCP-079 CAMERA NETWORK
            </Box>
            <Box
              style={{
                fontSize: '11px',
                color: C.textDim,
                letterSpacing: '0.12em',
                marginTop: '2px',
                display: 'flex',
                gap: '12px',
              }}
            >
              <span>
                TIER: {tier}/{max_tier}
              </span>
              <span>
                PROC: {processing_power}/{max_processing_power}
              </span>
              <span>
                MEM: {memory_used}/{memory_capacity}
              </span>
              <span>{TIER_NAMES[tier] || `Tier ${tier}`}</span>
            </Box>
          </Box>

          <Box
            style={{
              display: 'flex',
              borderBottom: `1px solid ${C.border}`,
              background: C.panel,
            }}
          >
            {['cameras', 'control', 'abilities'].map((t) => (
              <Button
                key={t}
                onClick={() => setTab(t)}
                style={{
                  fontFamily: C.mono,
                  fontSize: '10px',
                  letterSpacing: '0.12em',
                  background:
                    tab === t ? 'rgba(34,68,170,0.3)' : 'transparent',
                  border: 'none',
                  borderBottom:
                    tab === t
                      ? `2px solid ${C.blueBright}`
                      : '2px solid transparent',
                  borderRadius: 0,
                  color: tab === t ? C.textBright : C.textDim,
                  padding: '6px 14px',
                }}
              >
                {t.toUpperCase()}
              </Button>
            ))}
          </Box>

          {tab === 'cameras' && (
            <Box style={{ padding: '10px 14px' }}>
              <Box
                style={{
                  display: 'flex',
                  gap: '6px',
                  marginBottom: '10px',
                  alignItems: 'center',
                }}
              >
                <Box
                  style={{
                    fontSize: '10px',
                    color: C.textDim,
                    letterSpacing: '0.12em',
                  }}
                >
                  ZONE:
                </Box>
                {ZONES.map((z) => (
                  <Button
                    key={z}
                    onClick={() => act('set_zone_filter', { zone: z })}
                    style={termButton(zone_filter === z, C.blueBright)}
                  >
                    {z}
                  </Button>
                ))}
                <Box style={{ flex: 1 }} />
                <Input
                  value={searchText}
                  onInput={(_, v) => setSearchText(v)}
                  placeholder="SEARCH..."
                  style={{
                    fontFamily: C.mono,
                    fontSize: '10px',
                    width: '160px',
                    background: C.panel,
                    border: `1px solid ${C.border}`,
                    color: C.text,
                    borderRadius: 0,
                  }}
                />
              </Box>

              {current_camera && (
                <Box
                  style={{
                    marginBottom: '10px',
                    padding: '6px 10px',
                    borderLeft: `2px solid ${C.blueBright}`,
                    background: 'rgba(34,68,170,0.1)',
                  }}
                >
                  <Box
                    style={{
                      fontSize: '11px',
                      color: C.textDim,
                      letterSpacing: '0.1em',
                    }}
                  >
                    CURRENT FEED
                  </Box>
                  <Box
                    style={{
                      color: C.blueBright,
                      fontSize: '12px',
                      fontWeight: 'bold',
                    }}
                  >
                    {current_camera.name}
                  </Box>
                </Box>
              )}

              <Box
                style={{
                  fontSize: '11px',
                  color: C.textDim,
                  letterSpacing: '0.1em',
                  marginBottom: '6px',
                }}
              >
                {filteredCameras.length} CAMERA
                {filteredCameras.length !== 1 ? 'S' : ''} FOUND
              </Box>

              {filteredCameras.map((cam) => (
                <Box
                  key={cam.ref}
                  style={{
                    marginBottom: '4px',
                    padding: '6px 10px',
                    borderLeft: `2px solid ${
                      cam.is_current
                        ? C.blueBright
                        : cam.status === 'damaged'
                          ? C.red
                          : C.border
                    }`,
                    background: cam.is_current
                      ? 'rgba(34,68,170,0.15)'
                      : C.panel,
                  }}
                >
                  <Box
                    style={{
                      display: 'flex',
                      justifyContent: 'space-between',
                      alignItems: 'center',
                    }}
                  >
                    <Box>
                      <Box
                        style={{
                          color: cam.is_current ? C.blueBright : C.textBright,
                          fontWeight: cam.is_current ? 'bold' : 'normal',
                          fontSize: '11px',
                        }}
                      >
                        {cam.name}
                      </Box>
                      <Box
                        style={{
                          fontSize: '11px',
                          color: C.textDim,
                        }}
                      >
                        {cam.area_name}
                      </Box>
                    </Box>
                    <Box style={{ display: 'flex', gap: '4px' }}>
                      <Box
                        style={{
                          fontSize: '11px',
                          color:
                            cam.status === 'functional'
                              ? C.greenBright
                              : C.redBright,
                          letterSpacing: '0.1em',
                          padding: '4px 0',
                        }}
                      >
                        {cam.status.toUpperCase()}
                      </Box>
                      {!cam.is_current && (
                        <Button
                          onClick={() => act('camera_hop', { ref: cam.ref })}
                          disabled={cam.status !== 'functional'}
                          style={{
                            fontFamily: C.mono,
                            fontSize: '11px',
                            letterSpacing: '0.1em',
                            background: 'rgba(34,68,170,0.2)',
                            border: `1px solid ${C.blue}`,
                            borderRadius: 0,
                            color: C.blueBright,
                            padding: '4px 10px',
                          }}
                        >
                          CONNECT
                        </Button>
                      )}
                    </Box>
                  </Box>
                </Box>
              ))}
            </Box>
          )}

          {tab === 'control' && (
            <Box style={{ padding: '10px 14px' }}>
              <Box
                style={{
                  fontSize: '10px',
                  color: C.textDim,
                  letterSpacing: '0.18em',
                  textTransform: 'uppercase',
                  borderBottom: `1px solid ${C.border}`,
                  paddingBottom: '4px',
                  marginBottom: '10px',
                }}
              >
                NEARBY DOORS (RANGE 7)
              </Box>

              {(nearby_doors || []).length === 0 && (
                <Box
                  style={{
                    color: C.textDim,
                    fontSize: '10px',
                    fontStyle: 'italic',
                    marginBottom: '14px',
                  }}
                >
                  No doors in range. Hop to a camera near doors.
                </Box>
              )}

              {(nearby_doors || []).map((door) => (
                <Box
                  key={door.ref}
                  style={{
                    marginBottom: '4px',
                    padding: '6px 10px',
                    borderLeft: `2px solid ${door.hacked ? C.amber : C.border}`,
                    background: C.panel,
                  }}
                >
                  <Box
                    style={{
                      display: 'flex',
                      justifyContent: 'space-between',
                      alignItems: 'center',
                    }}
                  >
                    <Box>
                      <Box
                        style={{
                          color: C.textBright,
                          fontSize: '11px',
                        }}
                      >
                        {door.name}
                      </Box>
                      <Box
                        style={{
                          fontSize: '11px',
                          color: C.textDim,
                        }}
                      >
                        {door.open ? 'OPEN' : 'CLOSED'}
                        {door.hacked ? ' | HACKED' : ''}
                      </Box>
                    </Box>
                    <Box style={{ display: 'flex', gap: '4px' }}>
                      <Button
                        onClick={() => act('toggle_door', { ref: door.ref })}
                        style={{
                          fontFamily: C.mono,
                          fontSize: '11px',
                          letterSpacing: '0.1em',
                          background: 'transparent',
                          border: `1px solid ${C.border}`,
                          borderRadius: 0,
                          color: C.text,
                          padding: '4px 10px',
                        }}
                      >
                        TOGGLE
                      </Button>
                      {tier >= 3 && (
                        <Button
                          onClick={() => act('hack_door', { ref: door.ref })}
                          style={{
                            fontFamily: C.mono,
                            fontSize: '11px',
                            letterSpacing: '0.1em',
                            background: door.hacked
                              ? 'rgba(212,160,23,0.2)'
                              : 'transparent',
                            border: `1px solid ${
                              door.hacked ? C.amber : C.border
                            }`,
                            borderRadius: 0,
                            color: door.hacked ? C.amber : C.textDim,
                            padding: '4px 10px',
                          }}
                        >
                          {door.hacked ? 'HACKED' : 'HACK'}
                        </Button>
                      )}
                    </Box>
                  </Box>
                </Box>
              ))}

              <Box
                style={{
                  fontSize: '10px',
                  color: C.textDim,
                  letterSpacing: '0.18em',
                  textTransform: 'uppercase',
                  borderBottom: `1px solid ${C.border}`,
                  paddingBottom: '4px',
                  marginTop: '14px',
                  marginBottom: '10px',
                }}
              >
                NEARBY APC UNITS
              </Box>

              {(nearby_apcs || []).length === 0 && (
                <Box
                  style={{
                    color: C.textDim,
                    fontSize: '10px',
                    fontStyle: 'italic',
                    marginBottom: '14px',
                  }}
                >
                  No APCs in range.
                </Box>
              )}

              {(nearby_apcs || []).map((apc) => (
                <Box
                  key={apc.ref}
                  style={{
                    marginBottom: '4px',
                    padding: '6px 10px',
                    borderLeft: `2px solid ${
                      apc.power_status === 'online' ? C.green : C.red
                    }`,
                    background: C.panel,
                  }}
                >
                  <Box
                    style={{
                      display: 'flex',
                      justifyContent: 'space-between',
                      alignItems: 'center',
                    }}
                  >
                    <Box>
                      <Box
                        style={{
                          color: C.textBright,
                          fontSize: '11px',
                        }}
                      >
                        {apc.name}
                      </Box>
                      <Box
                        style={{
                          fontSize: '11px',
                          color:
                            apc.power_status === 'online'
                              ? C.greenBright
                              : C.redBright,
                        }}
                      >
                        {apc.power_status.toUpperCase()}
                      </Box>
                    </Box>
                    {tier >= 2 && (
                      <Button
                        onClick={() => act('control_apc', { ref: apc.ref })}
                        style={{
                          fontFamily: C.mono,
                          fontSize: '11px',
                          letterSpacing: '0.1em',
                          background: 'transparent',
                          border: `1px solid ${C.border}`,
                          borderRadius: 0,
                          color: C.text,
                          padding: '4px 10px',
                        }}
                      >
                        CONTROL
                      </Button>
                    )}
                  </Box>
                </Box>
              ))}

              {(hacked_doors || []).length > 0 && (
                <>
                  <Box
                    style={{
                      fontSize: '10px',
                      color: C.textDim,
                      letterSpacing: '0.18em',
                      textTransform: 'uppercase',
                      borderBottom: `1px solid ${C.border}`,
                      paddingBottom: '4px',
                      marginTop: '14px',
                      marginBottom: '10px',
                    }}
                  >
                    HACKED DOORS
                  </Box>
                  {hacked_doors.map((door) => (
                    <Box
                      key={door.ref}
                      style={{
                        marginBottom: '2px',
                        padding: '4px 10px',
                        borderLeft: `2px solid ${C.amber}`,
                        background: C.panel,
                        fontSize: '10px',
                      }}
                    >
                      <Box style={{ color: C.amber }}>{door.name}</Box>
                    </Box>
                  ))}
                </>
              )}
            </Box>
          )}

          {tab === 'abilities' && (
            <Box style={{ padding: '10px 14px' }}>
              <Box
                style={{
                  fontSize: '10px',
                  color: C.textDim,
                  letterSpacing: '0.18em',
                  textTransform: 'uppercase',
                  borderBottom: `1px solid ${C.border}`,
                  paddingBottom: '4px',
                  marginBottom: '10px',
                }}
              >
                PROCESSING ABILITIES
              </Box>

              {(abilities || []).map((ability) => (
                <Box
                  key={ability.id}
                  style={{
                    marginBottom: '6px',
                    padding: '8px 10px',
                    borderLeft: `2px solid ${
                      ability.available ? C.blue : C.border
                    }`,
                    background: C.panel,
                  }}
                >
                  <Box
                    style={{
                      display: 'flex',
                      justifyContent: 'space-between',
                      alignItems: 'center',
                    }}
                  >
                    <Box>
                      <Box
                        style={{
                          color: ability.available ? C.textBright : C.textDim,
                          fontSize: '12px',
                          fontWeight: 'bold',
                        }}
                      >
                        {ability.name}
                      </Box>
                      <Box
                        style={{
                          fontSize: '11px',
                          color: C.textDim,
                        }}
                      >
                        COST: {ability.cost} PROC
                      </Box>
                    </Box>
                    <Button
                      onClick={() => act(ability.id)}
                      disabled={!ability.available}
                      style={{
                        fontFamily: C.mono,
                        fontSize: '11px',
                        letterSpacing: '0.1em',
                        background: ability.available
                          ? 'rgba(34,68,170,0.2)'
                          : 'transparent',
                        border: `1px solid ${
                          ability.available ? C.blue : C.border
                        }`,
                        borderRadius: 0,
                        color: ability.available ? C.blueBright : C.textDim,
                        padding: '4px 10px',
                      }}
                    >
                      EXECUTE
                    </Button>
                  </Box>
                </Box>
              ))}

              <Box
                style={{
                  fontSize: '10px',
                  color: C.textDim,
                  letterSpacing: '0.18em',
                  textTransform: 'uppercase',
                  borderBottom: `1px solid ${C.border}`,
                  paddingBottom: '4px',
                  marginTop: '14px',
                  marginBottom: '10px',
                }}
              >
                QUICK ACTIONS
              </Box>

              <Box style={{ display: 'flex', gap: '6px', flexWrap: 'wrap' }}>
                <Button
                  onClick={() => act('flicker_lights')}
                  style={{
                    fontFamily: C.mono,
                    fontSize: '11px',
                    letterSpacing: '0.1em',
                    background: 'rgba(34,68,170,0.15)',
                    border: `1px solid ${C.blue}`,
                    borderRadius: 0,
                    color: C.blueBright,
                    padding: '4px 10px',
                  }}
                >
                  FLICKER LIGHTS [5]
                </Button>
                <Input
                  value={broadcastMsg}
                  onInput={(_, v) => setBroadcastMsg(v)}
                  placeholder="Message..."
                  style={{
                    fontFamily: C.mono,
                    fontSize: '11px',
                    width: '160px',
                    background: C.panel,
                    border: `1px solid ${C.border}`,
                    color: C.text,
                    borderRadius: 0,
                  }}
                />
                <Button
                  onClick={() => {
                    if (broadcastMsg.trim()) {
                      act('broadcast', { message: broadcastMsg.trim() });
                      setBroadcastMsg('');
                    }
                  }}
                  style={{
                    fontFamily: C.mono,
                    fontSize: '11px',
                    letterSpacing: '0.1em',
                    background: 'rgba(34,68,170,0.15)',
                    border: `1px solid ${C.blue}`,
                    borderRadius: 0,
                    color: C.blueBright,
                    padding: '4px 10px',
                  }}
                >
                  BROADCAST [20]
                </Button>
                {tier >= 2 && (
                  <Button
                    onClick={() => {
                      if (broadcastMsg.trim()) {
                        act('hijack_pa', { message: broadcastMsg.trim() });
                        setBroadcastMsg('');
                      }
                    }}
                    disabled={processing_power < 35}
                    style={{
                      fontFamily: C.mono,
                      fontSize: '11px',
                      letterSpacing: '0.1em',
                      background:
                        processing_power >= 35
                          ? 'rgba(139,0,0,0.2)'
                          : 'transparent',
                      border: `1px solid ${
                        processing_power >= 35 ? C.red : C.border
                      }`,
                      borderRadius: 0,
                      color:
                        processing_power >= 35 ? C.redBright : C.textDim,
                      padding: '4px 10px',
                    }}
                  >
                    HIJACK PA [35]
                  </Button>
                )}
              </Box>
            </Box>
          )}

          <Box
            style={{
              borderTop: `1px solid ${C.border}`,
              padding: '4px 14px',
              background: C.panel,
            }}
          >
            <Box
              style={{
                color: C.textDim,
                fontSize: '11px',
                letterSpacing: '0.1em',
              }}
            >
              SCP-079 | CAMERA NETWORK | TIER {tier} | PROC{' '}
              {processing_power}/{max_processing_power}
            </Box>
          </Box>
        </Box>
      </Window.Content>
    </Window>
  );
};
