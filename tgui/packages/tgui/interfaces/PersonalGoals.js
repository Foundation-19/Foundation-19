import { Window } from '../layouts';
import { useBackend } from '../backend';
import { Section, Table } from '../components';

export const PersonalGoals = (props, context) => {
  const { act, data } = useBackend(context);
  const { goalcategories = [] } = data;
  <Window title="Personal Goals" width={675} height={700}>
    <Window.Content scrollable>
      <Section>
        {goalcategories.map((value, index) => {
          <GoalCategory ley={index} goals={value} catname={index} />;
        })}
        ;
      </Section>
    </Window.Content>
  </Window>;
};

const GoalCategory = (props, context) => {
  const { goals, catname } = props;
  return (
    <Table>
      <Table.Row>
        <Table.Cell>{catname}</Table.Cell>
      </Table.Row>
      {goals.map((goal, index) => (
        <Table.Row>
          <Table.Cell>
            <Goal key={index} description={goal.description} />
          </Table.Cell>
        </Table.Row>
      ))}
      ;
    </Table>
  );
};

const Goal = (props) => {
  const { description } = props;
  return { description };
};
