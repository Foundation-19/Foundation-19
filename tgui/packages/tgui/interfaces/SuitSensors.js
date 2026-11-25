import { useBackend, useLocalState } from '../backend';
import { Box, Button, Flex, LabeledList, Section } from '../components';
import { Window } from '../layouts';
import { ProgramExitButtons } from './common/ProgramExitButtons';
import { resolveAsset } from '../assets';
import { useRef } from 'inferno';

const statColor = (stat) => {
  if (stat === 0) return '#44ff44';
  if (stat === 1) return '#d4a017';
  return '#cc2222';
};

const C = {
  bg: '#0a0a0c',
  border: '#2a2a30',
  borderRed: '#6b0000',
  amber: '#d4a017',
  text: '#c8c8c8',
  textDim: '#6a6a70',
  mono: '"Consolas", "Courier New", monospace',
};

// Map tab: station map with all tracked crew overlaid as dots.
// Pan: drag with the mouse. Zoom: mouse wheel, 1x..8x.
const CrewMap = (props, context) => {
  const { crewmembers, map_levels, map_prefix } = props;
  const z = props.selected_z;
  const mapName = `${map_prefix || 'site53'}-${z}.png`;
  const url = resolveAsset(mapName);
  // Map images are 480x480 (HOLOMAP_ICON_SIZE) covering the station bounds.
  const MAP_PX = 480;
  const offset = (MAP_PX - props.world_maxx) / 2;
  const offsetY = (MAP_PX - props.world_maxy) / 2;

  const MIN_ZOOM = 1;
  const MAX_ZOOM = 8;

  const [zoom, setZoom] = useLocalState(context, 'cm.zoom', 1);
  const [pan, setPan] = useLocalState(context, 'cm.pan_' + z, { x: 0, y: 0 });
  const drag = useRef(null);

  // Keep the viewport filled at zoom 1: pan cannot push the map edge inward.
  const clampPan = (p, zl) => {
    const limit = MAP_PX * (zl - 1) / 2;
    return {
      x: Math.max(-limit, Math.min(limit, p.x)),
      y: Math.max(-limit, Math.min(limit, p.y)),
    };
  };

  const handleWheel = (e) => {
    e.preventDefault();
    const factor = e.deltaY < 0 ? 1.25 : 0.8;
    setZoom((oldZoom) => {
      const next = Math.max(MIN_ZOOM, Math.min(MAX_ZOOM, oldZoom * factor));
      if (next === oldZoom) {
        return oldZoom;
      }
      // Zoom toward the cursor: keep the point under the mouse stationary.
      const rect = e.currentTarget.getBoundingClientRect();
      const cx = e.clientX - rect.left - rect.width / 2;
      const cy = e.clientY - rect.top - rect.height / 2;
      setPan((oldPan) => clampPan({
        x: cx - (cx - oldPan.x) * (next / oldZoom),
        y: cy - (cy - oldPan.y) * (next / oldZoom),
      }, next));
      return next;
    });
  };

  const handleMouseDown = (e) => {
    if (e.button !== 0) {
      return;
    }
    drag.current = { sx: e.clientX, sy: e.clientY, ox: pan.x, oy: pan.y };
    e.preventDefault();
  };

  const handleMouseMove = (e) => {
    if (!drag.current) {
      return;
    }
    const rect = e.currentTarget.getBoundingClientRect();
    // Scale client deltas into map-image pixels so panning speed matches
    // the visual scale of the map at the current zoom.
    const scale = (MAP_PX * zoom) / rect.width;
    setPan(clampPan({
      x: drag.current.ox - (e.clientX - drag.current.sx) * scale,
      y: drag.current.oy - (e.clientY - drag.current.sy) * scale,
    }, zoom));
  };

  const handleMouseUp = () => {
    drag.current = null;
  };

  // Reset view when switching levels (fresh pan per level, zoom kept).
  const prevZ = useRef(z);
  if (prevZ.current !== z) {
    prevZ.current = z;
    setPan({ x: 0, y: 0 });
  }

  const onLevel = crewmembers.filter(
    (m) => m.z === z && m.x >= 0 && m.sensor_type >= 3
  );
  // Marker screen size follows zoom so dots stay visible when zoomed out
  // and don't get gigantic when zoomed in.
  const dotPx = Math.max(4, Math.min(14, 8 * Math.sqrt(zoom)));

  return (
    <Box>
      <Box mb={1} style={{ display: 'flex', gap: '4px', flexWrap: 'wrap', alignItems: 'center' }}>
        {(map_levels || []).map((zl) => (
          <Button
            key={zl}
            selected={z === zl}
            content={`Z${zl}`}
            onClick={() => props.onSelectZ(zl)} />
        ))}
        <Button ml={2} icon="undo" content={`RESET (${Math.round(zoom * 100)}%)`} onClick={() => { setZoom(1); setPan({ x: 0, y: 0 }); }} />
      </Box>
      <Box
        style={{
          width: '100%',
          height: '420px',
          position: 'relative',
          border: '1px solid ' + C.border,
          overflow: 'hidden',
          background: '#050505',
          cursor: drag.current ? 'grabbing' : 'grab',
          userSelect: 'none',
        }}
        onWheel={handleWheel}
        onMouseDown={handleMouseDown}
        onMouseMove={handleMouseMove}
        onMouseUp={handleMouseUp}
        onMouseLeave={handleMouseUp}>
        <Box
          style={{
            position: 'absolute',
            left: '50%',
            top: '50%',
            width: MAP_PX + 'px',
            height: MAP_PX + 'px',
            transform: `translate(-50%, -50%) translate(${pan.x}px, ${pan.y}px) scale(${zoom})`,
            transformOrigin: 'center',
          }}>
          <img
            src={url}
            width={MAP_PX}
            height={MAP_PX}
            style={{ position: 'absolute', left: 0, top: 0, imageRendering: 'pixelated' }}
            onError={(e) => { e.target.style.display = 'none'; }} />
          {onLevel.map((m, i) => (
            <Box
              key={i}
              title={m.name + ' — ' + (m.area || '')}
              style={{
                position: 'absolute',
                left: offset + m.x + 'px',
                top: MAP_PX - (offsetY + m.y) + 'px',
                width: dotPx + 'px', height: dotPx + 'px',
                marginLeft: -(dotPx / 2) + 'px', marginTop: -(dotPx / 2) + 'px',
                borderRadius: '50%',
                background: statColor(m.stat),
                border: '1px solid #fff',
                boxShadow: '0 0 4px ' + statColor(m.stat),
                cursor: 'help',
                // Counter-scale so dots stay constant screen size while
                // the map image zooms under them.
                transform: `scale(${1 / zoom})`,
              }} />
          ))}
        </Box>
      </Box>
      <Box style={{ color: C.textDim, fontSize: '9px', marginTop: '4px' }}>
        {onLevel.length} tracked signal(s) on this level. Scroll to zoom, drag to pan. Green=conscious, amber=unconscious, red=deceased.
      </Box>
    </Box>
  );
};

export const SuitSensors = (props, context) => {
  const { act, data } = useBackend(context);
  const { crewmembers = [], map_levels = [], isAI } = data;
  const showExit = data && data.PC_showexitprogram;
  const [view, setView] = useLocalState(context, 'cm.view', 'list');
  const [selectedZ, setSelectedZ] = useLocalState(context, 'cm.z', 1);

  return (
    <Window theme="scp_terminal" width={640} height={660} buttons={showExit ? <ProgramExitButtons act={act} /> : undefined}>
      <Window.Content scrollable>
        <Box style={{ background: C.bg, minHeight: '100%', padding: '10px', fontFamily: C.mono, color: C.text }}>
          <Box style={{ borderBottom: '2px solid ' + C.borderRed, paddingBottom: '6px', marginBottom: '10px' }}>
            <Box style={{ color: C.amber, letterSpacing: '0.15em', fontWeight: 'bold' }}>CREW MONITOR</Box>
            <Box style={{ color: C.textDim, fontSize: '9px' }}>SUIT SENSOR TELEMETRY - {crewmembers.length} SIGNALS</Box>
          </Box>

          <Box mb={2} style={{ display: 'flex', gap: '6px' }}>
            <Button selected={view === 'list'} onClick={() => setView('list')}>LIST VIEW</Button>
            <Button selected={view === 'map'} onClick={() => setView('map')}>MAP VIEW</Button>
          </Box>

          {view === 'map' ? (
            <CrewMap
              context={context}
              crewmembers={crewmembers}
              map_levels={map_levels}
              map_prefix={data.map_prefix}
              selected_z={selectedZ}
              onSelectZ={setSelectedZ}
              world_maxx={data.world_maxx || 255}
              world_maxy={data.world_maxy || 255} />
          ) : (
            <Section title="Tracked Crew">
              {crewmembers.map((member, i) => (
                <Flex key={i} align="center" mb={0.5}>
                  <Box style={{ flex: 1, overflow: 'hidden', whiteSpace: 'nowrap', textOverflow: 'ellipsis' }}>
                    {member.name || 'Unknown'}
                    {member.area ? <Box inline ml={1} style={{ color: C.textDim }}>({member.area})</Box> : null}
                  </Box>
                  <Box mr={1} style={{ color: statColor(member.stat), whiteSpace: 'nowrap' }}>
                    {member.stat === 0 ? 'CONSCIOUS' : member.stat === 1 ? 'UNCONSCIOUS' : 'DECEASED'}
                  </Box>
                  <Box mr={1} style={{ whiteSpace: 'nowrap' }}>
                    <Box inline mr={1} style={{ color: member.oxygenation_span === 'bad' ? '#cc2222' : C.textDim }}>
                      {member.oxygenation ? 'O2: ' + member.oxygenation : ''}
                    </Box>
                    <Box inline style={{ color: C.textDim }}>
                      {member.pulse !== undefined && member.pulse !== 'N/A' ? member.pulse + ' BPM' : ''}
                    </Box>
                  </Box>
                  <Box style={{ whiteSpace: 'nowrap' }}>
                    <Box inline mr={1} style={{ color: C.textDim, fontSize: '10px' }}>
                      {member.bodytemp !== undefined ? Math.round(member.bodytemp) + '°C' : ''}
                    </Box>
                    <Box inline mr={1} style={{ color: member.oxygenation_span === 'bad' ? '#cc2222' : C.textDim, fontSize: '10px' }}>
                      {member.oxygenation ? 'O2 ' + member.oxygenation : ''}
                    </Box>
                    <Box inline style={{ color: C.textDim, fontSize: '10px' }}>
                      {member.pressure ? member.pressure + ' BP' : ''}
                    </Box>
                    <Button
                      icon="location-arrow"
                      disabled={!isAI || member.sensor_type < 3}
                      onClick={() => act('track', { track: member.ref })} />
                  </Box>
                </Flex>
              ))}
              {crewmembers.length === 0 ? <Box style={{ color: C.textDim }}>No suit sensor signals on this level.</Box> : null}
            </Section>
          )}
        </Box>
      </Window.Content>
    </Window>
  );
};
