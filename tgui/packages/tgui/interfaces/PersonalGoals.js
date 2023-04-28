import { Window } from '../layouts';
import { Section } from '../components';

export const PersonalGoals = (props, context) => {
  const { act, data } = useBackend(context);
  const { goals = [] } = data;
  <Window title="Personal Goals" width={675} height={700}>
    <Window.Content scrollable>
      <Section>
        <Table>
          {goals.map(goal) => (
            <Goal key={goal.name} goal={goal} />
          )}
        </Table>
      </Section>
    </Window.Content>
  </Window>;
};

const Goal = (props, context) => {
  const { goal } = props;
  const { act, data } = useBackend(context);
  const {} = data;
}
