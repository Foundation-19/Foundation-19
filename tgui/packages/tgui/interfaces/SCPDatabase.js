import { useBackend } from '../backend';
import { Button, Section, Box, Flex, ProgressBar, Tabs, LabeledList, NoticeBox } from '../components';
import { NtosWindow } from '../layouts';

export const SCPDatabase = (props, context) => {
  const { act, data } = useBackend(context);
  const { tab, PC_device_theme } = data;

  return (
    <NtosWindow resizable theme={PC_device_theme} width={700} height={600}>
      <NtosWindow.Content scrollable>
        <SCPDatabaseContent />
      </NtosWindow.Content>
    </NtosWindow>
  );
};

const SCPDatabaseContent = (props, context) => {
  const { act, data } = useBackend(context);
  const { tab = 'overview' } = data;

  return (
    <Box>
      <Tabs>
        <Tabs.Tab
          selected={tab === 'overview'}
          onClick={() => act('PRG_switch_tab', { tab: 'overview' })}>
          Overview
        </Tabs.Tab>
        <Tabs.Tab
          selected={tab === 'detail'}
          onClick={() => act('PRG_switch_tab', { tab: 'detail' })}>
          SCP Detail
        </Tabs.Tab>
        <Tabs.Tab
          selected={tab === 'breaches'}
          onClick={() => act('PRG_switch_tab', { tab: 'breaches' })}>
          Breach Log
        </Tabs.Tab>
        <Tabs.Tab
          selected={tab === 'tests'}
          onClick={() => act('PRG_switch_tab', { tab: 'tests' })}>
          Test Log
        </Tabs.Tab>
        <Tabs.Tab
          selected={tab === 'tree'}
          onClick={() => act('PRG_switch_tab', { tab: 'tree' })}>
          Tech Tree
        </Tabs.Tab>
        <Tabs.Tab
          selected={tab === 'projects'}
          onClick={() => act('PRG_switch_tab', { tab: 'projects' })}>
          Projects
        </Tabs.Tab>
        <Tabs.Tab
          selected={tab === 'teams'}
          onClick={() => act('PRG_switch_tab', { tab: 'teams' })}>
          Teams
        </Tabs.Tab>
        <Tabs.Tab
          selected={tab === 'safety'}
          onClick={() => act('PRG_switch_tab', { tab: 'safety' })}>
          Safety
        </Tabs.Tab>
        <Tabs.Tab
          selected={tab === 'interactions'}
          onClick={() => act('PRG_switch_tab', { tab: 'interactions' })}>
          Interactions
        </Tabs.Tab>
      </Tabs>
      {tab === 'overview' && <OverviewTab />}
      {tab === 'detail' && <DetailTab />}
      {tab === 'breaches' && <BreachLogTab />}
      {tab === 'tests' && <TestLogTab />}
      {tab === 'tree' && <TechTreeTab />}
      {tab === 'projects' && <ProjectsTab />}
      {tab === 'teams' && <TeamsTab />}
      {tab === 'safety' && <SafetyTab />}
      {tab === 'interactions' && <InteractionsTab />}
    </Box>
  );
};

const ResearchOffline = () => (
  <NoticeBox danger>
    Research systems offline.
  </NoticeBox>
);

const tagColor = (tag) => {
  switch (tag) {
    case 'POINTS': return 'good';
    case 'TECH': return 'blue';
    case 'BONUS': return 'good';
    case 'PROJECT': return 'average';
    case 'TEAM': return 'label';
    case 'SAFETY': return 'bad';
    default: return 'label';
  }
};

const TechTreeTab = (props, context) => {
  const { act, data } = useBackend(context);
  const { director } = data;

  if (!director || !director.tech_nodes) {
    return <ResearchOffline />;
  }

  const {
    pool = 0,
    safety_rating = 0,
    research_multiplier = 0,
    sanity_resist = 0,
    containment_floor = 0,
    tech_nodes = [],
    catalog = [],
  } = director;

  const categories = ['Containment', 'Medical', 'Engineering', 'Cognitive', 'Analytical'];
  const unlockedIds = tech_nodes.filter((node) => node.unlocked).map((node) => node.id);

  return (
    <Box>
      <Section title="Site Research Status">
        <LabeledList>
          <LabeledList.Item label="Site Pool">{pool}</LabeledList.Item>
          <LabeledList.Item label="Safety Rating">{safety_rating}%</LabeledList.Item>
          <LabeledList.Item label="Research Multiplier">+{research_multiplier}%</LabeledList.Item>
          <LabeledList.Item label="Sanity Resist">{sanity_resist}%</LabeledList.Item>
          <LabeledList.Item label="Containment Floor">{containment_floor}%</LabeledList.Item>
        </LabeledList>
      </Section>
      {categories.map((category) => {
        const categoryNodes = tech_nodes.filter((node) => node.category === category);
        if (!categoryNodes.length) {
          return null;
        }
        return (
          <Section key={category} title={category}>
            {[1, 2, 3, 4, 5].map((tier) => {
              const tierNodes = categoryNodes.filter((node) => node.tier === tier);
              if (!tierNodes.length) {
                return null;
              }
              return (
                <Box key={tier} mb={1}>
                  <Box bold color="label" mb={0.5}>Tier {tier}</Box>
                  {tierNodes.map((node) => {
                    const prereqMet = (node.prerequisites || []).every((id) => unlockedIds.includes(id));
                    const affordable = pool >= node.cost;
                    const canUnlock = prereqMet && affordable;
                    return (
                      <Box key={node.id} mb={1}>
                        <Button
                          fluid
                          selected={node.unlocked}
                          disabled={!node.unlocked && !canUnlock}
                          onClick={() => !node.unlocked && act('PRG_unlock_node', { node_id: node.id })}>
                          {node.name} (T{node.tier}) — {node.cost} pts
                        </Button>
                        <Box color="label" mt={0.5}>{node.description}</Box>
                      </Box>
                    );
                  })}
                </Box>
              );
            })}
          </Section>
        );
      })}
      <Section title="Research Catalog">
        {catalog.length === 0 ? (
          <Box color="label">No catalog items unlocked.</Box>
        ) : (
          <LabeledList>
            {catalog.map((item, i) => (
              <LabeledList.Item key={i} label={item.name}>
                <Button
                  icon="print"
                  content="Fabricate"
                  onClick={() => act('PRG_fabricate_catalog', { type: item.type })} />
              </LabeledList.Item>
            ))}
          </LabeledList>
        )}
      </Section>
    </Box>
  );
};

const ProjectsTab = (props, context) => {
  const { act, data } = useBackend(context);
  const { director } = data;

  if (!director || !director.tech_nodes) {
    return <ResearchOffline />;
  }

  const projects = director.projects || [];

  const statusColor = (status) => {
    switch (status) {
      case 'proposed': return 'average';
      case 'active': return 'good';
      case 'completed': return 'blue';
      case 'revoked': return 'bad';
      default: return 'label';
    }
  };

  return (
    <Box>
      <Box mb={1}>
        <Button
          icon="plus"
          content="File New Project"
          color="good"
          onClick={() => act('PRG_create_project', {})} />
      </Box>
      {projects.length === 0 ? (
        <Box color="label">No research projects on file.</Box>
      ) : (
        projects.map((project) => (
          <Box key={project.id} mb={1} p={1} style={{ border: '1px solid #444' }}>
            <Flex>
              <Flex.Item grow={1} bold>{project.title}</Flex.Item>
              <Flex.Item color={statusColor(project.status)} bold>
                {String(project.status).toUpperCase()}
              </Flex.Item>
            </Flex>
            <Box color="label" mt={1}>{project.description || 'No description.'}</Box>
            <LabeledList>
              <LabeledList.Item label="Targets">
                {(project.scp_targets && project.scp_targets.length)
                  ? project.scp_targets.map((designation) => `SCP-${designation}`).join(', ')
                  : 'Any SCP'}
              </LabeledList.Item>
              <LabeledList.Item label="Proposed By">
                {project.proposed_by || 'Unknown'}
              </LabeledList.Item>
              {project.approved_by ? (
                <LabeledList.Item label="Approved By">
                  {project.approved_by}
                </LabeledList.Item>
              ) : null}
              <LabeledList.Item label="Progress">
                <ProgressBar
                  value={project.contributed_points}
                  minValue={0}
                  maxValue={Math.max(project.required_points || 0, 1)}
                  color="blue">
                  {project.contributed_points} / {project.required_points}
                </ProgressBar>
              </LabeledList.Item>
            </LabeledList>
            <Box mt={1}>
              {project.status === 'proposed' ? (
                <Box>
                  <Button
                    icon="check"
                    content="Approve"
                    color="good"
                    onClick={() => act('PRG_approve_project', { project_id: String(project.id) })} />
                  <Button
                    icon="ban"
                    content="Revoke"
                    color="bad"
                    ml={1}
                    onClick={() => act('PRG_revoke_project', { project_id: String(project.id) })} />
                </Box>
              ) : null}
              {project.status === 'active' ? (
                <Button
                  icon="ban"
                  content="Revoke"
                  color="bad"
                  onClick={() => act('PRG_revoke_project', { project_id: String(project.id) })} />
              ) : null}
            </Box>
          </Box>
        ))
      )}
    </Box>
  );
};

const TeamsTab = (props, context) => {
  const { act, data } = useBackend(context);
  const { director } = data;

  if (!director || !director.tech_nodes) {
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
          onClick={() => act('PRG_create_team', {})} />
      </Box>
      {teams.length === 0 ? (
        <Box color="label">No research teams formed.</Box>
      ) : (
        teams.map((team) => {
          const members = team.members || [];
          const membersRaw = team.members_raw || [];
          const joinRequests = team.join_requests || [];
          const isMember = currentCkey ? membersRaw.includes(currentCkey) : false;
          return (
            <Box key={team.id} mb={1} p={1} style={{ border: '1px solid #444' }}>
              <Flex>
                <Flex.Item grow={1} bold>{team.name}</Flex.Item>
                <Flex.Item color="label">{team.id}</Flex.Item>
              </Flex>
              <LabeledList>
                <LabeledList.Item label="Leader">
                  {team.leader || 'Unassigned'}
                </LabeledList.Item>
                <LabeledList.Item label={`Members (${members.length})`}>
                  {members.length ? members.join(', ') : 'None'}
                </LabeledList.Item>
              </LabeledList>
              {joinRequests.length > 0 ? (
                <Box mt={1}>
                  <Box bold color="label" mb={0.5}>Join Requests</Box>
                  {joinRequests.map((name, idx) => (
                    <Flex key={name} mb={0.5} align="center">
                      <Flex.Item grow={1}>{name}</Flex.Item>
                      <Flex.Item>
                        <Button
                          icon="check"
                          content="Approve"
                          color="good"
                          onClick={() => act('PRG_approve_join', { team_id: team.id, ckey: (team.join_requests_raw || [])[idx] })} />
                        <Button
                          icon="times"
                          content="Deny"
                          color="bad"
                          ml={0.5}
                          onClick={() => act('PRG_deny_join', { team_id: team.id, ckey: (team.join_requests_raw || [])[idx] })} />
                      </Flex.Item>
                    </Flex>
                  ))}
                </Box>
              ) : null}
              {!isMember ? (
                <Box mt={1}>
                  <Button
                    icon="user-plus"
                    content="Request Join"
                    onClick={() => act('PRG_request_join', { team_id: team.id })} />
                </Box>
              ) : null}
            </Box>
          );
        })
      )}
    </Box>
  );
};

const SafetyTab = (props, context) => {
  const { data } = useBackend(context);
  const { director } = data;

  if (!director || !director.tech_nodes) {
    return <ResearchOffline />;
  }

  const {
    safety_rating = 0,
    achievements = [],
    research_log = [],
  } = director;
  const safetyColor = safety_rating > 75 ? 'good' : safety_rating > 50 ? 'average' : 'bad';
  const recentLog = research_log.slice(-40);

  return (
    <Box>
      <Section title="Safety Rating">
        <LabeledList>
          <LabeledList.Item label="Rating">
            <Box color={safetyColor} bold>{safety_rating}%</Box>
          </LabeledList.Item>
          <LabeledList.Item label="Protocol Status">
            <Box color={safetyColor}>
              {safety_rating > 75
                ? 'Nominal — protocols observed.'
                : safety_rating > 50
                  ? 'Caution — protocol violations logged.'
                  : 'Critical — containment protocols compromised.'}
            </Box>
          </LabeledList.Item>
        </LabeledList>
      </Section>
      <Section title="Achievements">
        {achievements.length === 0 ? (
          <Box color="label">No achievements recorded.</Box>
        ) : (
          <LabeledList>
            {achievements.map((achievement, i) => (
              <LabeledList.Item key={i} label={achievement.name}>
                {achievement.type} — {achievement.by} — {achievement.time}
              </LabeledList.Item>
            ))}
          </LabeledList>
        )}
      </Section>
      <Section title="Research Log">
        {recentLog.length === 0 ? (
          <Box color="label">No research activity logged.</Box>
        ) : (
          recentLog.map((entry, i) => (
            <Box key={i} mb={0.5}>
              <Box inline bold color={tagColor(entry.tag)}>[{entry.tag}]</Box>
              <Box inline ml={1}>{entry.text}</Box>
              <Box inline ml={1} color="label">{entry.time}</Box>
            </Box>
          ))
        )}
      </Section>
    </Box>
  );
};

const OverviewTab = (props, context) => {
  const { act, data } = useBackend(context);
  const { scp_list = [], active_breaches = [], total_breaches = 0, dclass_requests = [] } = data;

  const statusColor = (status) => {
    switch (status) {
      case 'Contained': return 'good';
      case 'Breached': return 'bad';
      case 'Unknown': return 'average';
      default: return 'average';
    }
  };

  return (
    <Box>
      {active_breaches.length > 0 && (
        <NoticeBox danger>
          ACTIVE BREACHES: {active_breaches.length} | Total This Round: {total_breaches}
        </NoticeBox>
      )}
      <Section title="SCP Containment Status">
        {scp_list.map((scp) => (
          <Flex key={scp.designation} mb={1} align="center">
            <Flex.Item grow={1}>
              <Button
                fluid
                color={statusColor(scp.containment_status)}
                onClick={() => act('PRG_select_scp', { designation: scp.designation })}>
                SCP-{scp.designation} ({scp.classification}) - {scp.containment_status}
              </Button>
            </Flex.Item>
            <Flex.Item ml={1} width="120px">
              <ProgressBar
                value={scp.research_level}
                minValue={0}
                maxValue={5}
                color="blue">
                {['None', 'Prelim', 'Basic', 'Advanced', 'Expert', 'Full'][scp.research_level]}
              </ProgressBar>
            </Flex.Item>
          </Flex>
        ))}
      </Section>
      <Section title="Open D-Class Requests">
        {dclass_requests.length === 0 ? (
          <Box color="average">No open requests.</Box>
        ) : (
          <LabeledList>
            {dclass_requests.map((request) => (
              <LabeledList.Item
                key={request.id}
                label={`#${request.id} SCP-${request.designation}`}>
                {request.status} — {request.risk} risk — {request.location} — {request.minutes_left}m left
              </LabeledList.Item>
            ))}
          </LabeledList>
        )}
      </Section>
    </Box>
  );
};

const DetailTab = (props, context) => {
  const { act, data } = useBackend(context);
  const { scp_detail, can_test, test_cooldown_remaining = 0, zone_data, can_verify, verify_cooldown_remaining = 0, open_request, dclass_requests = [], countermeasure, known_codes, personality_traits = [], codex_entry, codex_progress } = data;

  if (!scp_detail) {
    return (
      <NoticeBox info>
        Select an SCP from the Overview tab to view details.
      </NoticeBox>
    );
  }

  const tierThresholds = [50, 150, 350, 700, 1500];
  const nextThreshold = scp_detail.research_level < 5
    ? tierThresholds[scp_detail.research_level]
    : 0;

  return (
    <Box>
      <Section title={`SCP-${scp_detail.designation} - ${scp_detail.name}`}>
        <LabeledList>
          <LabeledList.Item label="Classification">
            {scp_detail.classification}
          </LabeledList.Item>
          <LabeledList.Item label="Containment Status">
            <Box color={scp_detail.containment_status === 'Breached' ? 'bad' : 'good'}>
              {scp_detail.containment_status}
            </Box>
          </LabeledList.Item>
          <LabeledList.Item label="Containment Rating">
            {scp_detail.containment_rating}
          </LabeledList.Item>
          <LabeledList.Item label="Times Breached">
            {scp_detail.times_breached}
          </LabeledList.Item>
        </LabeledList>
      </Section>
      <Section title="Research Progress">
        <LabeledList>
          <LabeledList.Item label="Current Tier">
            {['None', 'Preliminary', 'Basic', 'Advanced', 'Expert', 'Full'][scp_detail.research_level]}
          </LabeledList.Item>
          <LabeledList.Item label="Research Points">
            <ProgressBar
              value={scp_detail.research_points}
              minValue={0}
              maxValue={nextThreshold || scp_detail.research_points}
              color="blue">
              {scp_detail.research_points} / {nextThreshold || 'MAX'}
            </ProgressBar>
          </LabeledList.Item>
        </LabeledList>
      </Section>
      <Section title="Log Test" buttons={
        <Button
          icon="times"
          content="Clear Selection"
          onClick={() => act('PRG_clear_selection')} />
      }>
        {can_test ? (
          <Flex wrap={1}>
            <Flex.Item m={1}>
              <Button
                icon="eye"
                content="Observation"
                onClick={() => act('PRG_log_test', { test_type: 'observation', risk: 'low' })} />
            </Flex.Item>
            <Flex.Item m={1}>
              <Button
                icon="hand-paper"
                content="Interaction"
                onClick={() => act('PRG_log_test', { test_type: 'interaction', risk: 'medium' })} />
            </Flex.Item>
            <Flex.Item m={1}>
              <Button
                icon="user"
                content="D-Class Test"
                color="warning"
                onClick={() => act('PRG_log_test', { test_type: 'dclass', risk: 'high' })} />
            </Flex.Item>
            <Flex.Item m={1}>
              <Button
                icon="flask"
                content="Cross-Test"
                color="danger"
                onClick={() => act('PRG_log_test', { test_type: 'crosstest', risk: 'extreme' })} />
            </Flex.Item>
          </Flex>
        ) : (
          <Box color="average">
            Test cooldown active: {test_cooldown_remaining}s remaining
          </Box>
        )}
      </Section>
      <Section title="D-Class Request">
        {open_request ? (
          <Box>
            <LabeledList>
              <LabeledList.Item label="Request #{open_request.id}">
                {open_request.status} — {open_request.risk} risk — {open_request.minutes_left}m left
              </LabeledList.Item>
            </LabeledList>
            <Button
              icon="times"
              content="Cancel Request"
              mt={1}
              color="danger"
              onClick={() => act('PRG_cancel_dclass')} />
          </Box>
        ) : (
          <Box>
            <Box color="average" mb={1}>
              File a request for security to escort a Class-D subject to this chamber.
            </Box>
            <Flex wrap={1}>
              <Flex.Item m={1}>
                <Button
                  icon="user-plus"
                  content="Request D-Class (High Risk)"
                  color="warning"
                  onClick={() => act('PRG_request_dclass', { risk: 'high' })} />
              </Flex.Item>
              <Flex.Item m={1}>
                <Button
                  icon="user-shield"
                  content="Request D-Class (Extreme Risk)"
                  color="danger"
                  onClick={() => act('PRG_request_dclass', { risk: 'extreme' })} />
              </Flex.Item>
            </Flex>
          </Box>
        )}
      </Section>
      <Section title="Containment Verification">
        {zone_data ? (
          <Box>
            <LabeledList>
              <LabeledList.Item label="Zone">
                {zone_data.area_name}
              </LabeledList.Item>
              <LabeledList.Item label="Zone Power">
                {zone_data.has_power ? (
                  <Box color="good">ONLINE</Box>
                ) : (
                  <Box color="bad">OFFLINE</Box>
                )}
              </LabeledList.Item>
              <LabeledList.Item label="Integrity">
                <ProgressBar
                  value={zone_data.integrity}
                  minValue={0}
                  maxValue={100}
                  ranges={{
                    good: [70, 100],
                    average: [40, 70],
                    bad: [0, 40],
                  }}>
                  {zone_data.integrity}%
                </ProgressBar>
              </LabeledList.Item>
            </LabeledList>
            {can_verify ? (
              <Button
                icon="check"
                content="Run Verification Scan"
                mt={1}
                color="good"
                onClick={() => act('PRG_verify_containment')} />
            ) : (
              <Box color="average" mt={1}>
                Scanner recharging: {verify_cooldown_remaining}s remaining
              </Box>
            )}
          </Box>
        ) : (
          <Box color="average">No containment zone registered for this anomaly.</Box>
        )}
      </Section>
      <Section title="Countermeasures">
        {countermeasure ? (
          <Box>
            <LabeledList>
              <LabeledList.Item label="Program">
                {countermeasure.name}
              </LabeledList.Item>
              <LabeledList.Item label="Required Tier">
                {['None', 'Preliminary', 'Basic', 'Advanced', 'Expert', 'Full'][countermeasure.required_tier]}
              </LabeledList.Item>
              <LabeledList.Item label="Status">
                {countermeasure.unlocked ? (
                  <Box color="good">UNLOCKED</Box>
                ) : (
                  <Box color="average">
                    Locked - current tier: {['None', 'Preliminary', 'Basic', 'Advanced', 'Expert', 'Full'][countermeasure.current_tier]}
                  </Box>
                )}
              </LabeledList.Item>
            </LabeledList>
            {countermeasure.unlocked ? (
              <Button
                icon="print"
                content="Fabricate Countermeasure"
                mt={1}
                color="good"
                onClick={() => act('PRG_fabricate_countermeasure')} />
            ) : null}
          </Box>
        ) : (
          <Box color="average">No countermeasure program exists for this anomaly.</Box>
        )}
      </Section>
      <Section title="Personal Codex Entry">
        {codex_entry ? (
          <Box>
            <LabeledList>
              <LabeledList.Item label="Anomaly">
                <Box style={{ color: codex_entry.unlock_state > 0 ? '#d4a017' : '#6a6a70' }}>{codex_entry.name}</Box>
              </LabeledList.Item>
              <LabeledList.Item label="Class">
                {codex_entry.unlock_state > 0 ? codex_entry.classification : 'UNKNOWN'}
              </LabeledList.Item>
              <LabeledList.Item label="Threat">
                {codex_entry.unlock_state > 0 ? codex_entry.threat_level : 'UNKNOWN'}
              </LabeledList.Item>
              <LabeledList.Item label="Summary">
                <Box style={{ color: codex_entry.unlock_state >= 2 ? '#e8e8e8' : '#6a6a70' }}>{codex_entry.description}</Box>
              </LabeledList.Item>
              <LabeledList.Item label="Containment">
                <Box style={{ color: codex_entry.unlock_state >= 3 ? '#e8e8e8' : '#6a6a70' }}>{codex_entry.containment_procedures}</Box>
              </LabeledList.Item>
              {codex_entry.unlock_state >= 3 ? (
                <LabeledList.Item label="Lore">
                  <Box>{codex_entry.lore}</Box>
                </LabeledList.Item>
              ) : null}
            </LabeledList>
            {codex_progress ? (
              <Box style={{ color: '#6a6a70', marginTop: '6px', fontSize: '10px' }}>
                YOUR ARCHIVE: {codex_progress.unlocked}/{codex_progress.total} entries unlocked
              </Box>
            ) : null}
          </Box>
        ) : (
          <Box color="average">No codex entry exists for this designation.</Box>
        )}
      </Section>
      <Section title="Behavioral Traits">
        {personality_traits.length > 0 ? (
          <LabeledList>
            {personality_traits.map((trait, i) => (
              <LabeledList.Item key={i} label={trait.state === 3 ? trait.name : trait.state === 2 ? trait.name + ' (?)' : trait.state === 1 ? '?????' : trait.name}>
                <Box style={{ color: trait.state === 3 ? '#e8e8e8' : trait.state === 2 ? '#d4a017' : '#6a6a70' }}>
                  {trait.description}
                </Box>
              </LabeledList.Item>
            ))}
          </LabeledList>
        ) : (
          <Box color="average">No behavioral traits assigned to this anomaly this round.</Box>
        )}
      </Section>
      {known_codes && known_codes.length > 0 && (
        <Section title="Known Combinations">
          <Box color="average" mb={1}>
            Codes identified via dimensional research. Resonant codes always yield contents.
          </Box>
          <LabeledList>
            {known_codes.map((code, i) => (
              <LabeledList.Item key={i} label={`#${i + 1}`}>
                {code}
              </LabeledList.Item>
            ))}
          </LabeledList>
        </Section>
      )}
    </Box>
  );
};

const BreachLogTab = (props, context) => {
  const { data } = useBackend(context);
  const { breach_log = [] } = data;

  return (
    <Section title="Breach Log">
      {breach_log.length === 0 ? (
        <Box color="good">No breaches recorded this round.</Box>
      ) : (
        breach_log.map((entry, i) => (
          <Box key={i} mb={1} pb={1} borderBottom="1px solid #444">
            <Flex>
              <Flex.Item color="bad" bold>
                SCP-{entry.designation} ({entry.classification})
              </Flex.Item>
              <Flex.Item ml={2} color="label">
                {entry.time}
              </Flex.Item>
            </Flex>
            <Box color="label" mt={1}>Area: {entry.area}</Box>
          </Box>
        ))
      )}
    </Section>
  );
};

const TestLogTab = (props, context) => {
  const { data } = useBackend(context);
  const { test_log = [] } = data;

  return (
    <Section title="Test Log">
      {test_log.length === 0 ? (
        <Box color="label">No tests recorded this round.</Box>
      ) : (
        test_log.map((entry, i) => (
          <Box key={i} mb={1} pb={1} borderBottom="1px solid #444">
            <Flex>
              <Flex.Item bold>
                SCP-{entry.designation}
              </Flex.Item>
              <Flex.Item ml={2} color="label">
                {entry.time}
              </Flex.Item>
            </Flex>
            <Box color="label" mt={1}>
              Type: {entry.test_type} | Tester: {entry.tester} | {entry.result}
            </Box>
          </Box>
        ))
      )}
    </Section>
  );
};

const InteractionsTab = (props, context) => {
  const { act, data } = useBackend(context);
  const { interactions = [], discovered_count = 0, total_count = 0 } = data;

  const tierColor = (tier) => {
    switch (tier) {
      case 5: return 'bad';
      case 4: return 'average';
      case 3: return 'violet';
      default: return 'label';
    }
  };

  return (
    <Section
      title={'CROSS-ANOMALY INTERACTION REGISTRY — ' + discovered_count + '/' + total_count + ' DISCOVERED'}>
      {interactions.length === 0 ? (
        <Box color="label">No cross-anomaly interactions registered.</Box>
      ) : (
        interactions.map((I) => (
          <Box key={I.id} mb={1} p={0.5} style={{ border: '1px solid rgba(255,255,255,0.08)' }}>
            <Box bold>
              <span style={{ color: I.discovered ? '#7ec97e' : '#a04040' }}>
                {I.discovered ? '● DISCOVERED' : '○ UNKNOWN'}
              </span>
              {' '}{I.name} — SCP-{I.scp1} × SCP-{I.scp2}{' '}
              <span style={{ color: '#9a9ab0' }}>(Tier {I.tier})</span>
            </Box>
            {I.discovered ? (
              <>
                <Box mt={0.5} color="label">{I.description}</Box>
                <Box mt={0.5} color="label" fontSize={0.9}>
                  Triggers: {I.trigger_count} | Req. research: L{I.req1}/L{I.req2}
                  {I.discovered_by ? (' | Found by: ' + I.discovered_by) : ''}
                </Box>
              </>
            ) : (
              <Box mt={0.5} color="label" fontSize={0.9}>
                Undocumented interaction. Raise research on both anomalies to discover.
              </Box>
            )}
          </Box>
        ))
      )}
    </Section>
  );
};
