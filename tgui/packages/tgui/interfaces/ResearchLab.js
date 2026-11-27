import { useBackend, useLocalState } from '../backend';
import { Box, Button, LabeledList, NoticeBox, ProgressBar, Tabs } from '../components';
import { Window } from '../layouts';

const C = {
  bg: '#0a0a0c',
  panel: '#111114',
  border: '#2a2a30',
  amber: '#c2960e',
  text: '#c8c8c8',
  dim: '#7a7a80',
  mono: 'Consolas, monospace',
};

const tagColor = (tag) => {
  switch (tag) {
    case 'POINTS': return '#44ff44';
    case 'TECH': return '#4a9eff';
    case 'BONUS': return '#44ff44';
    case 'PROJECT': return C.amber;
    case 'TEAM': return C.text;
    case 'SAFETY': return '#cc2222';
    default: return C.dim;
  }
};

const Panel = (props) => {
  const { title, children } = props;

  return (
    <Box
      style={{
        background: C.panel,
        border: '1px solid ' + C.border,
        padding: '8px',
        marginBottom: '8px',
      }}>
      <Box
        style={{
          color: C.amber,
          letterSpacing: '0.1em',
          fontWeight: 'bold',
          marginBottom: '6px',
        }}>
        {title}
      </Box>
      {children}
    </Box>
  );
};

const ResearchOffline = () => (
  <NoticeBox danger>
    Research systems offline.
  </NoticeBox>
);

export const ResearchLab = (props, context) => {
  const { data } = useBackend(context);
  const [tab, setTab] = useLocalState(context, 'tab', 'tree');
  const director = data.director || {};

  return (
    <Window theme="scp_terminal" width={760} height={680}>
      <Window.Content scrollable>
        <Box
          style={{
            background: C.bg,
            minHeight: '100%',
            padding: '10px',
            fontFamily: C.mono,
            color: C.text,
          }}>
          <Box
            style={{
              borderBottom: '2px solid ' + C.border,
              paddingBottom: '6px',
              marginBottom: '10px',
            }}>
            <Box
              style={{
                color: C.amber,
                letterSpacing: '0.15em',
                fontWeight: 'bold',
                fontSize: '14px',
              }}>
              RESEARCH LABORATORY
            </Box>
            <Box style={{ color: C.dim, fontSize: '9px', letterSpacing: '0.1em' }}>
              SCP FOUNDATION SITE RESEARCH NETWORK
            </Box>
          </Box>
          <Panel title="SITE RESEARCH STATUS">
            <LabeledList>
              <LabeledList.Item label="SITE POOL">
                <Box style={{ color: C.amber }}>{director.pool || 0}</Box>
              </LabeledList.Item>
              <LabeledList.Item label="TOTAL EARNED">
                {director.total_earned || 0}
              </LabeledList.Item>
              <LabeledList.Item label="SAFETY RATING">
                {director.safety_rating || 0}%
              </LabeledList.Item>
              <LabeledList.Item label="RESEARCH MULTIPLIER">
                +{director.research_multiplier || 0}%
              </LabeledList.Item>
              <LabeledList.Item label="SANITY RESISTANCE">
                {director.sanity_resist || 0}%
              </LabeledList.Item>
              <LabeledList.Item label="CONTAINMENT FLOOR">
                {director.containment_floor || 0}%
              </LabeledList.Item>
            </LabeledList>
          </Panel>
          <Tabs>
            <Tabs.Tab selected={tab === 'tree'} onClick={() => setTab('tree')}>
              TREE
            </Tabs.Tab>
            <Tabs.Tab selected={tab === 'projects'} onClick={() => setTab('projects')}>
              PROJECTS
            </Tabs.Tab>
            <Tabs.Tab selected={tab === 'teams'} onClick={() => setTab('teams')}>
              TEAMS
            </Tabs.Tab>
            <Tabs.Tab selected={tab === 'log'} onClick={() => setTab('log')}>
              LOG
            </Tabs.Tab>
            <Tabs.Tab selected={tab === 'scps'} onClick={() => setTab('scps')}>
              SCPs
            </Tabs.Tab>
          </Tabs>
          <Box mt={1}>
            {tab === 'tree' && <TreeTab />}
            {tab === 'projects' && <ProjectsTab />}
            {tab === 'teams' && <TeamsTab />}
            {tab === 'log' && <LogTab />}
            {tab === 'scps' && <ScpsTab />}
          </Box>
        </Box>
      </Window.Content>
    </Window>
  );
};

const TreeTab = (props, context) => {
  const { act, data } = useBackend(context);
  const director = data.director || {};
  const nodes = director.tech_nodes || [];

  if (!director.tech_nodes) {
    return <ResearchOffline />;
  }

  const pool = director.pool || 0;
  const categories = ['Containment', 'Medical', 'Engineering', 'Cognitive', 'Analytical'];
  const catalog = director.catalog || [];
  const unlockedIds = nodes.filter((node) => node.unlocked).map((node) => node.id);

  return (
    <Box>
      {categories.map((category) => {
        const categoryNodes = nodes.filter((node) => node.category === category);
        if (!categoryNodes.length) {
          return null;
        }
        return (
          <Panel key={category} title={'TECH TREE :: ' + category.toUpperCase()}>
            {[1, 2, 3, 4, 5].map((tier) => {
              const tierNodes = categoryNodes.filter((node) => node.tier === tier);
              if (!tierNodes.length) {
                return null;
              }
              return (
                <Box key={tier} mb={1}>
                  <Box
                    style={{
                      color: C.dim,
                      fontSize: '10px',
                      letterSpacing: '0.1em',
                      marginBottom: '4px',
                    }}>
                    TIER {tier}
                  </Box>
                  {tierNodes.map((node) => {
                    const prereqMet = (node.prerequisites || []).every((id) => unlockedIds.includes(id));
                    const affordable = pool >= node.cost;
                    const canUnlock = prereqMet && affordable;
                    return (
                      <Box key={node.id} mb={1}>
                        <Button
                          selected={node.unlocked}
                          disabled={!node.unlocked && !canUnlock}
                          mr={0.5}
                          onClick={() => !node.unlocked && act('PRG_unlock_node', { node_id: node.id })}>
                          {node.name} [T{node.tier}] {node.cost}pt
                        </Button>
                        <Box style={{ color: C.dim, fontSize: '10px', marginTop: '2px' }}>
                          {node.description}
                        </Box>
                      </Box>
                    );
                  })}
                </Box>
              );
            })}
          </Panel>
        );
      })}
      <Panel title="RESEARCH CATALOG">
        {catalog.length === 0 ? (
          <Box style={{ color: C.dim }}>No catalog items unlocked.</Box>
        ) : (
          catalog.map((item, i) => (
            <Box key={i} mb={0.5}>
              <Button
                icon="print"
                content="Fabricate"
                mr={0.5}
                onClick={() => act('PRG_fabricate_catalog', { type: item.type })} />
              <Box inline style={{ color: C.text }}>{item.name}</Box>
            </Box>
          ))
        )}
      </Panel>
    </Box>
  );
};

const ProjectsTab = (props, context) => {
  const { act, data } = useBackend(context);
  const director = data.director || {};
  const currentCkey = data.user_ckey || data.ckey || null;

  if (!director.tech_nodes) {
    return <ResearchOffline />;
  }

  const projects = director.projects || [];

  const statusColor = (status) => {
    switch (status) {
      case 'proposed': return C.amber;
      case 'active': return '#44ff44';
      case 'completed': return '#4a9eff';
      case 'revoked': return '#cc2222';
      default: return C.dim;
    }
  };

  return (
    <Box>
      <Box mb={1}>
        <Button
          icon="plus"
          content="File New Project"
          color="good"
          mr={0.5}
          onClick={() => act('PRG_create_project', {})} />
      </Box>
      {projects.length === 0 ? (
        <Box style={{ color: C.dim }}>No research projects on file.</Box>
      ) : (
        projects.map((project) => (
          <Panel key={project.id} title={'PROJECT #' + project.id}>
            <Box style={{ color: C.text, fontWeight: 'bold' }}>{project.title}</Box>
            <Box
              style={{
                color: statusColor(project.status),
                fontSize: '10px',
                letterSpacing: '0.1em',
              }}>
              {String(project.status).toUpperCase()}
            </Box>
            <Box style={{ color: C.dim, fontSize: '10px', marginTop: '4px' }}>
              {project.description || 'No description.'}
            </Box>
            <LabeledList>
              <LabeledList.Item label="TARGETS">
                {(project.scp_targets && project.scp_targets.length)
                  ? project.scp_targets.map((designation) => `SCP-${designation}`).join(', ')
                  : 'Any SCP'}
              </LabeledList.Item>
              <LabeledList.Item label="PROPOSED BY">
                {project.proposed_by || 'Unknown'}
              </LabeledList.Item>
              {project.approved_by ? (
                <LabeledList.Item label="APPROVED BY">
                  {project.approved_by}
                </LabeledList.Item>
              ) : null}
              <LabeledList.Item label="PROGRESS">
                <ProgressBar
                  value={project.contributed_points}
                  minValue={0}
                  maxValue={Math.max(project.required_points || 0, 1)}
                  color="blue">
                  {project.contributed_points} / {project.required_points}
                </ProgressBar>
              </LabeledList.Item>
              <LabeledList.Item label="CONTRIBUTORS">
                {(project.contributors && project.contributors.length)
                  ? project.contributors.join(', ')
                  : 'None yet'}
              </LabeledList.Item>
            </LabeledList>
            <Box mt={1}>
              {/* Join/leave: open to ALL researchers on open projects */}
              {(project.status === 'proposed' || project.status === 'active') ? (
                (project.contributors_raw || []).includes(currentCkey) ? (
                  <Button
                    icon="sign-out"
                    content="Leave Project"
                    mr={0.5}
                    onClick={() => act('PRG_leave_project', { project_id: String(project.id) })} />
                ) : (
                  <Button
                    icon="sign-in"
                    content="Join Project"
                    color="good"
                    mr={0.5}
                    onClick={() => act('PRG_join_project', { project_id: String(project.id) })} />
                )
              ) : null}
              {project.status === 'proposed' ? (
                <Box>
                  <Button
                    icon="check"
                    content="Approve"
                    color="good"
                    mr={0.5}
                    onClick={() => act('PRG_approve_project', { project_id: String(project.id) })} />
                  <Button
                    icon="ban"
                    content="Revoke"
                    color="bad"
                    mr={0.5}
                    onClick={() => act('PRG_revoke_project', { project_id: String(project.id) })} />
                </Box>
              ) : null}
              {project.status === 'active' ? (
                <Button
                  icon="ban"
                  content="Revoke"
                  color="bad"
                  mr={0.5}
                  onClick={() => act('PRG_revoke_project', { project_id: String(project.id) })} />
              ) : null}
            </Box>
          </Panel>
        ))
      )}
    </Box>
  );
};

const TeamsTab = (props, context) => {
  const { act, data } = useBackend(context);
  const director = data.director || {};

  if (!director.tech_nodes) {
    return <ResearchOffline />;
  }

  const teams = director.teams || [];
  const currentCkey = data.user_ckey || data.ckey || null;

  return (
    <Box>
      <Box mb={1}>
        <Button
          icon="users"
          content="Form New Team"
          color="good"
          mr={0.5}
          onClick={() => act('PRG_create_team', {})} />
      </Box>
      {teams.length === 0 ? (
        <Box style={{ color: C.dim }}>No research teams formed.</Box>
      ) : (
        teams.map((team) => {
          const members = team.members || [];
          const membersRaw = team.members_raw || [];
          const joinRequests = team.join_requests || [];
          const isMember = currentCkey ? membersRaw.includes(currentCkey) : false;
          return (
            <Panel key={team.id} title={'TEAM ' + team.id}>
              <Box style={{ color: C.text, fontWeight: 'bold' }}>{team.name}</Box>
              <Box style={{ color: C.dim, fontSize: '10px' }}>
                LEADER: {team.leader || 'UNASSIGNED'}
              </Box>
              <Box style={{ color: C.dim, fontSize: '10px' }}>
                MEMBERS ({members.length}): {members.length ? members.join(', ') : 'NONE'}
              </Box>
              {joinRequests.length > 0 ? (
                <Box mt={1}>
                  <Box style={{ color: C.amber, fontSize: '10px', letterSpacing: '0.1em' }}>
                    JOIN REQUESTS
                  </Box>
                  {joinRequests.map((name, idx) => (
                    <Box key={name} mb={0.5}>
                      <Box inline style={{ color: C.text, marginRight: '4px' }}>{name}</Box>
                      <Button
                        icon="check"
                        content="Approve"
                        color="good"
                        mr={0.5}
                        onClick={() => act('PRG_approve_join', { team_id: team.id, ckey: (team.join_requests_raw || [])[idx] })} />
                      <Button
                        icon="times"
                        content="Deny"
                        color="bad"
                        mr={0.5}
                        onClick={() => act('PRG_deny_join', { team_id: team.id, ckey: (team.join_requests_raw || [])[idx] })} />
                    </Box>
                  ))}
                </Box>
              ) : null}
              {!isMember ? (
                <Box mt={1}>
                  <Button
                    icon="user-plus"
                    content="Request Join"
                    mr={0.5}
                    onClick={() => act('PRG_request_join', { team_id: team.id })} />
                </Box>
              ) : null}
            </Panel>
          );
        })
      )}
    </Box>
  );
};

const LogTab = (props, context) => {
  const { data } = useBackend(context);
  const director = data.director || {};
  const researchLog = director.research_log || [];
  const achievements = director.achievements || [];
  const recentLog = researchLog.slice(-40);

  return (
    <Box>
      <Panel title="RESEARCH LOG">
        {recentLog.length === 0 ? (
          <Box style={{ color: C.dim }}>No research activity logged.</Box>
        ) : (
          recentLog.map((entry, i) => (
            <Box key={i} mb={0.5} style={{ fontSize: '10px' }}>
              <Box inline style={{ color: tagColor(entry.tag), fontWeight: 'bold' }}>
                [{entry.tag}]
              </Box>
              <Box inline style={{ color: C.text, marginLeft: '4px' }}>{entry.text}</Box>
              <Box inline style={{ color: C.dim, marginLeft: '4px' }}>{entry.time}</Box>
            </Box>
          ))
        )}
      </Panel>
      <Panel title="ACHIEVEMENTS">
        {achievements.length === 0 ? (
          <Box style={{ color: C.dim }}>No achievements recorded.</Box>
        ) : (
          achievements.map((achievement, i) => (
            <Box key={i} mb={0.5} style={{ fontSize: '10px' }}>
              <Box inline style={{ color: C.amber }}>{achievement.name}</Box>
              <Box inline style={{ color: C.dim, marginLeft: '4px' }}>
                {achievement.type} — {achievement.by} — {achievement.time}
              </Box>
            </Box>
          ))
        )}
      </Panel>
    </Box>
  );
};

const ScpsTab = (props, context) => {
  const { act, data } = useBackend(context);
  const scpList = data.scp_list || [];
  const detail = data.scp_detail;
  const selected = data.selected_scp;

  return (
    <Box>
      {detail ? (
        <Panel title={'SCP-' + detail.designation + ' :: ' + detail.name}>
          <LabeledList>
            <LabeledList.Item label="CLASSIFICATION">
              {detail.classification}
            </LabeledList.Item>
            <LabeledList.Item label="CONTAINMENT">
              <Box
                style={{
                  color: detail.containment_status === 'Breached'
                    ? '#cc2222'
                    : detail.containment_status === 'Contained'
                      ? '#44ff44'
                      : C.amber,
                }}>
                {detail.containment_status}
              </Box>
            </LabeledList.Item>
            <LabeledList.Item label="RATING">
              {detail.containment_rating}
            </LabeledList.Item>
            <LabeledList.Item label="TIMES BREACHED">
              {detail.times_breached}
            </LabeledList.Item>
            {detail.research_points !== undefined ? (
              <LabeledList.Item label="RESEARCH POINTS">
                <ProgressBar
                  value={detail.research_points}
                  minValue={0}
                  maxValue={detail.next_threshold || detail.research_points || 1}
                  color="blue">
                  {detail.research_points} / {detail.next_threshold || 'MAX'}
                </ProgressBar>
              </LabeledList.Item>
            ) : null}
          </LabeledList>
          <Box mt={1}>
            <Button
              icon="times"
              content="Clear"
              mr={0.5}
              onClick={() => act('PRG_clear_selection')} />
          </Box>
        </Panel>
      ) : null}
      <Panel title="SITE ANOMALIES">
        {scpList.length === 0 ? (
          <Box style={{ color: C.dim }}>No anomalies registered.</Box>
        ) : (
          scpList.map((scp) => (
            <Box key={scp.designation} mb={0.5}>
              <Button
                selected={selected === scp.designation}
                color={scp.containment_status === 'Breached'
                  ? 'bad'
                  : scp.containment_status === 'Contained'
                    ? 'good'
                    : undefined}
                mr={0.5}
                onClick={() => act('PRG_select_scp', { designation: scp.designation })}>
                SCP-{scp.designation}
              </Button>
              <Box inline style={{ color: C.text }}>
                {scp.name} ({scp.classification}) — {scp.containment_status} — Lv {scp.research_level}
              </Box>
            </Box>
          ))
        )}
      </Panel>
    </Box>
  );
};
