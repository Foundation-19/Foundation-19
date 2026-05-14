import { useBackend, useLocalState } from '../backend';
import {
  BlockQuote,
  Button,
  Collapsible,
  Flex,
  Section,
  Stack,
  Tabs,
} from '../components';
import { Window } from '../layouts';

type OffsiteHistoryItem = {
  id: number;
  type: string;
  time: number;
  time_pretty: string;
  ref: string;
  dept?: string;
  user: string;
  user_key?: string;
  admin?: string;
  taker?: string;
};

type OffsiteInfo = {
  name: string;
  type: string;
  data: OffsiteHistoryItem[];
};

type Data = {
  offsites: OffsiteInfo[];
};

export const OffsitePanel = (_, context) => {
  const { data } = useBackend<Data>(context);
  const [openOffsite, setOpenOffsite] = useLocalState(
    context,
    'openOffsite',
    0,
  );
  const { offsites = [] } = data;

  return (
    <Window width={900} height={800} title={'Offsite Panel'} theme="admin">
      <Window.Content Scrollable>
        <Section fitted>
          <Tabs horizontal>
            {offsites.map((offsite_data, i) => {
              return (
                <Tabs.Tab
                  key={i}
                  selected={i === openOffsite}
                  onClick={() => setOpenOffsite(i)}
                >
                  {offsite_data.name}
                </Tabs.Tab>
              );
            })}
          </Tabs>
        </Section>
        <OffsitePage current_offsite_data={offsites[openOffsite]} />
      </Window.Content>
    </Window>
  );
};

const SendButton = (props, context) => {
  const { act } = useBackend(context);
  const { type, os, target, id, children } = props;
  return (
    <Button
      onClick={() =>
        act(`send_${type}`, {
          os: os,
          target: target,
          id: id,
        })
      }
    >
      {children}
    </Button>
  );
};

const ReadButton = (props, context) => {
  const { act } = useBackend(context);
  const { os, fax, children } = props;
  return (
    <Button
      onClick={() =>
        act(`read_fax`, {
          os: os,
          fax: fax,
        })
      }
    >
      {children}
    </Button>
  );
};

const OffsitePage = (props, context) => {
  const { act, config } = useBackend(context);
  const current_offsite_data: OffsiteInfo = props.current_offsite_data;
  const name = current_offsite_data.name;
  const os_type = current_offsite_data.type;
  const comms_data = current_offsite_data.data.sort((a, b) => a.time - b.time);

  return (
    <Section>
      <h1>{name}</h1>
      <Flex direction="column-reverse">
        {comms_data &&
          comms_data.map((c_data) => {
            const {
              id,
              ref,
              dept,
              user,
              user_key,
              type,
              time_pretty,
              admin,
              taker,
            } = c_data;
            return (
              <Flex.Item key={id}>
                {type} {user}
                {admin ? ` by ${admin}` : ''}
                {dept ? ` to department: ${dept}` : ''} at round time{' '}
                {time_pretty}
                <Stack ml={2} textAlign="center">
                  {taker && (
                    <Stack.Item lineHeight="1.667em">
                      <strong>Taken by {taker}</strong>
                    </Stack.Item>
                  )}
                  <Stack.Item>
                    {type.includes('fax') ? (
                      <ReadButton os={os_type} to={type} fax={id}>
                        Read
                      </ReadButton>
                    ) : (
                      <Collapsible title="Message Contents">
                        <BlockQuote>{ref}</BlockQuote>
                      </Collapsible>
                    )}
                  </Stack.Item>
                  {type.includes('Received') && (
                    <>
                      <Stack.Item>
                        <SendButton
                          type="msg"
                          os={os_type}
                          target={user_key}
                          id={id}
                        >
                          Reply (Message)
                        </SendButton>
                      </Stack.Item>
                      {dept && (
                        <Stack.Item>
                          <SendButton
                            type="fax"
                            os={os_type}
                            target={dept}
                            id={id}
                          >
                            Reply (Fax)
                          </SendButton>
                        </Stack.Item>
                      )}
                      <Stack.Item>
                        <Button
                          onClick={() =>
                            act(`take`, {
                              os: os_type,
                              fax: id,
                            })
                          }
                        >
                          {taker === config.client.ckey ? 'Untake' : 'Take'}
                        </Button>
                      </Stack.Item>
                    </>
                  )}
                </Stack>
              </Flex.Item>
            );
          })}
      </Flex>
      <Stack mt={2}>
        <Stack.Item>
          <SendButton type="fax" os={os_type}>
            Send fax
          </SendButton>
        </Stack.Item>
        <Stack.Item>
          <SendButton type="msg" os={os_type}>
            Send message
          </SendButton>
        </Stack.Item>
      </Stack>
    </Section>
  );
};
