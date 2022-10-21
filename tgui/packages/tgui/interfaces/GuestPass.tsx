import { useBackend, useLocalState } from '../backend';
import { Section, Box, Button, Stack, LabeledList, Tabs, NoticeBox, NumberInput, BlockQuote } from '../components';
import { Window } from '../layouts';
import { BooleanLike } from 'common/react';

type Access = {
  desc: string;
  access: number;
  selected: BooleanLike;
};

type Data = {
  mode: BooleanLike;
  internal_log: Array<String>;
  reason: String;
  duration: number;
  min_duration: number;
  max_duration: number;
  area_code: string | null;
  giver: BooleanLike;
  giver_name: string | null;
  guestpass_name: string | null;
  area_access: Array<Access>;
  special_access: Array<Access>;
};

export const GuestPass = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { mode, area_code } = data;

  const window_width = 600;
  const window_height = 800;
  return (
    <Window width={window_width} height={window_height}>
      <Window.Content>
        <Box width="90%" mx="5%">
          <Section
            title={
              (area_code ? area_code + ' ' : '') + 'Temporary Access Terminal'
            }>
            <Stack vertical>
              <Stack.Item>
                <Button
                  fluid
                  content={mode === 0 ? 'ACTIVITY LOG' : 'ACCESS PASS EDITOR'}
                  textAlign="center"
                  my="2px"
                  onClick={() => {
                    act('set_mode', {
                      mode: !mode,
                    });
                  }}
                />
              </Stack.Item>
              <Stack.Item>
                {(mode === 0 && <IdEditor />) || <LogAccess />}
              </Stack.Item>
            </Stack>
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};

const IdEditor = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const {
    reason,
    duration,
    min_duration,
    max_duration,
    giver_name,
    guestpass_name,
    area_access,
    special_access,
  } = data;
  const [tabIndex, setTabIndex] = useLocalState(context, 'tabIndex', 0);
  return (
    <Stack vertical>
      <Stack.Item>
        <LabeledList>
          <LabeledList.Item label="Issuing ID Name">
            <Button
              content={giver_name ? giver_name : 'No ID Inserted!'}
              onClick={() => act('id')}
            />
          </LabeledList.Item>
          <LabeledList.Item label="Issued To">
            <Button
              content={guestpass_name ? guestpass_name : 'NOT SPECIFIED'}
              onClick={() => act('give_name')}
            />
          </LabeledList.Item>
          <LabeledList.Item label="Reason">
            <Button
              content={reason ? reason : 'NOT SPECIFIED'}
              onClick={() => act('set_reason')}
            />
          </LabeledList.Item>
          <LabeledList.Item label="Duration (minutes)">
            <NumberInput
              value={duration}
              minValue={min_duration}
              maxValue={max_duration}
              onChange={(e, newval) => {
                act('set_duration', {
                  duration: newval,
                });
              }}
            />
          </LabeledList.Item>
        </LabeledList>
      </Stack.Item>
      <Stack.Divider />
      <Stack.Item>
        <Stack>
          <Stack.Item>
            <Tabs>
              <Tabs.Tab
                selected={tabIndex === 0}
                onClick={() => setTabIndex(0)}>
                Area
              </Tabs.Tab>
              <Tabs.Tab
                selected={tabIndex === 1}
                onClick={() => setTabIndex(1)}>
                Special
              </Tabs.Tab>
            </Tabs>
          </Stack.Item>
          <Stack.Divider />
          <Stack.Item>
            <Button
              content="ISSUE ACCESS PASS"
              onClick={() => act('issue_id')}
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        {tabIndex === 0 &&
          ((area_access &&
            area_access.length &&
            area_access.map((access) => (
              <Button
                key={access.desc}
                content={access.desc}
                selected={access.selected}
                onClick={() => {
                  act('set_access', {
                    access: access.access,
                  });
                }}
              />
            ))) || <NoticeBox>No area access available.</NoticeBox>)}
        {tabIndex === 1 &&
          ((special_access &&
            special_access.length &&
            special_access.map((access) => (
              <Button
                key={access.desc}
                content={access.desc}
                selected={access.selected}
                onClick={() => {
                  act('set_access', {
                    access: access.access,
                  });
                }}
              />
            ))) || <NoticeBox>No special access available.</NoticeBox>)}
      </Stack.Item>
    </Stack>
  );
};

const LogAccess = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { internal_log } = data;
  return (
    <Stack vertical>
      <Stack.Item>
        <Button
          fluid
          content="PRINT LOG"
          onClick={() => act('print')}
          textAlign="center"
        />
      </Stack.Item>
      <Stack.Item>
        {internal_log.map((logstr) => (
          <BlockQuote key={logstr}>{logstr}</BlockQuote>
        ))}
      </Stack.Item>
    </Stack>
  );
};
