import { Window } from '../layouts';
import { useBackend } from '../backend';

export const OffsitePanel = (props, context) => {
  const { act, data } = useBackend(context);
  const {} = data;

  return <Window>shit</Window>;
};
