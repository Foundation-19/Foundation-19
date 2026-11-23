import { useBackend } from '../backend';
import { Window } from '../layouts';
import { Section, Button, LabeledList, NoticeBox, Box, Table, Flex } from '../components';

const JobRow = (props, context) => {
  const { act } = useBackend(context);
  const { job } = props;
  const { title, available, head_position, current_positions, total_positions, unavailable_reasons } = job;
  const slotsText = total_positions < 0
    ? current_positions
    : `${current_positions}/${total_positions}`;
  return (
    <Table.Row>
      <Table.Cell bold={head_position} color={head_position ? 'gold' : 'label'}>
        {title}
      </Table.Cell>
      <Table.Cell collapsing textAlign="center">
        {slotsText}
      </Table.Cell>
      <Table.Cell collapsing>
        <Button
          fluid
          content={available ? 'Join' : 'Unavailable'}
          color={available ? 'good' : 'bad'}
          disabled={!available}
          onClick={() => act('SelectedJob', { SelectedJob: title })}
        />
      </Table.Cell>
    </Table.Row>
  );
};

const JobCategory = (props, context) => {
  const { name, jobs } = props;
  return (
    <Section title={name}>
      <Table>
        <Table.Row header>
          <Table.Cell>Position</Table.Cell>
          <Table.Cell collapsing textAlign="center">Slots</Table.Cell>
          <Table.Cell collapsing>Join</Table.Cell>
        </Table.Row>
        {jobs.map(job => (
          <JobRow key={job.title} job={job} />
        ))}
      </Table>
    </Section>
  );
};

export const LateJoin = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    round_duration,
    station_name,
    evacuation_status,
    show_invalid_jobs,
    player_name,
    categories,
    hidden_reasons,
    submaps,
  } = data;

  const evacuationText = evacuation_status === 'evacuated'
    ? `${station_name} has been evacuated.`
    : evacuation_status === 'emergency'
      ? `${station_name} is currently undergoing evacuation procedures.`
      : evacuation_status === 'transfer'
        ? `${station_name} is currently undergoing crew transfer procedures.`
        : null;

  return (
    <Window resizable>
      <Window.Content scrollable>
        <Section>
          <LabeledList>
            <LabeledList.Item label="Welcome">
              {player_name}
            </LabeledList.Item>
            <LabeledList.Item label="Round Duration">
              {round_duration}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        {evacuationText && (
          <NoticeBox danger>
            {evacuationText}
          </NoticeBox>
        )}
        <Flex mb={1}>
          <Flex.Item>
            <Button
              content={show_invalid_jobs ? 'Hide unavailable jobs' : 'Show unavailable jobs'}
              onClick={() => act('invalid_jobs')}
            />
          </Flex.Item>
        </Flex>
        {hidden_reasons && Object.keys(hidden_reasons).length > 0 && (
          <NoticeBox info>
            <b>Some roles have been hidden for the following reasons:</b>
            <br />
            {Object.keys(hidden_reasons).map(reason => (
              <Box key={reason}>{reason}</Box>
            ))}
          </NoticeBox>
        )}
        {categories && Object.entries(categories).map(([name, jobs]) => (
          <JobCategory key={name} name={name} jobs={jobs} />
        ))}
        {submaps && submaps.length > 0 && submaps.map(submap => (
          <JobCategory
            key={submap.name}
            name={`${submap.name} (${submap.descriptor})`}
            jobs={submap.jobs}
          />
        ))}
      </Window.Content>
    </Window>
  );
};
