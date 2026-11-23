import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const Janicart = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    name,
    bag,
    mop,
    spray,
    replacer,
    signs,
  } = data;

  return (
    <Window width={240} height={200} resizable>
      <Window.Content>
        <Section title={name}>
          <LabeledList>
            {bag && (
              <LabeledList.Item label="Bag">
                {bag}
                <Button
                  ml={1}
                  icon="eject"
                  content="Take"
                  onClick={() => act('take', { take: 'garbage' })} />
              </LabeledList.Item>
            )}
            {mop && (
              <LabeledList.Item label="Mop">
                {mop}
                <Button
                  ml={1}
                  icon="eject"
                  content="Take"
                  onClick={() => act('take', { take: 'mop' })} />
              </LabeledList.Item>
            )}
            {spray && (
              <LabeledList.Item label="Spray">
                {spray}
                <Button
                  ml={1}
                  icon="eject"
                  content="Take"
                  onClick={() => act('take', { take: 'spray' })} />
              </LabeledList.Item>
            )}
            {replacer && (
              <LabeledList.Item label="Replacer">
                {replacer}
                <Button
                  ml={1}
                  icon="eject"
                  content="Take"
                  onClick={() => act('take', { take: 'replacer' })} />
              </LabeledList.Item>
            )}
            {signs && (
              <LabeledList.Item label="Signs">
                {signs}
                <Button
                  ml={1}
                  icon="eject"
                  content="Take"
                  onClick={() => act('take', { take: 'sign' })} />
              </LabeledList.Item>
            )}
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
