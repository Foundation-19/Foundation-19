import { Fragment } from 'inferno';

import { useBackend } from '../backend';
import { Box, Section, Table } from '../components';
import { Window } from '../layouts';

export const PersonalGoals = (props, context) => {
  const { act, data } = useBackend(context);
  const { categories_values = [], categories_keys = [] } = data;
  const categories_map = new Map(
    categories_values.map((value, index) => {
      return [categories_keys[index], value];
    }),
  );
  return (
    <Window title="Personal Goals" width={675} height={700}>
      <Window.Content scrollable>
        <Section>
          {categories_values.map((value, index) => (
            <Fragment key={categories_keys[index]}>
              <GoalCategory goals={value} catname={categories_keys[index]} />
            </Fragment>
          ))}
        </Section>
      </Window.Content>
    </Window>
  );
};

const GoalCategory = (props) => {
  const { goals = [], catname } = props;
  return (
    <Table>
      <Table.Row>
        <Table.Cell>
          <h1>{catname}</h1>
        </Table.Cell>
      </Table.Row>
      {goals.map((goal_desc, index) => (
        <Table.Row key={index}>
          <Table.Cell>
            <Goal description={goal_desc} />
            <br />
          </Table.Cell>
        </Table.Row>
      ))}
    </Table>
  );
};

const Goal = (props) => {
  const { description } = props;
  return <Box>{description}</Box>;
};
