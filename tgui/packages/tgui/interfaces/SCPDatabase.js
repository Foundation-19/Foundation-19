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
      </Tabs>
      {tab === 'overview' && <OverviewTab />}
      {tab === 'detail' && <DetailTab />}
      {tab === 'breaches' && <BreachLogTab />}
      {tab === 'tests' && <TestLogTab />}
    </Box>
  );
};

const OverviewTab = (props, context) => {
  const { act, data } = useBackend(context);
  const { scp_list = [], active_breaches = [], total_breaches = 0 } = data;

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
