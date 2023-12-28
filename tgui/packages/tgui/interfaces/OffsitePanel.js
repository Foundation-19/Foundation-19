import { Window } from '../layouts';
import { useBackend } from '../backend';

export const OffsitePanel = (props, context) => {
  const { act, data } = useBackend(context);
  const [openOffsite, setOpenOffsite] = useLocalState(
    context,
    'openOffsite',
    0
  );
  const { offsites = [] } = data;

  return (
    <Window title={'Offsite Panel'} theme="admin">
      <Window.Content Scrollable>shit</Window.Content>
    </Window>
  );
};
