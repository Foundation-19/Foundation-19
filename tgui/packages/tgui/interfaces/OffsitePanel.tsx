import { useBackend, useLocalState } from '../backend';
import { Section, Button, Tabs, Flex, Collapsible, Box, BlockQuote } from '../components';
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
    0
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
                  onClick={() => setOpenOffsite(i)}>
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
  const { type, os, target, taker, children } = props;
  return (
    <Button
      onClick={() =>
        act(`send_${type}`, {
          os: os,
          target: target,
          taker: taker,
        })
      }>
      {children}
    </Button>
  );
};

const ReadButton = (props, context) => {
  const { act } = useBackend(context);
  const { os, fax, to, children } = props;
  return (
    <Button
      onClick={() =>
        act(`read_fax`, {
          os: os,
          fax: fax,
          type: to,
        })
      }>
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
                {taker && (
                  <>
                    <br />
                    <b>Taken by {taker}</b>
                  </>
                )}
                <Box ml={2}>
                  {type.includes('fax') ? (
                    <ReadButton os={os_type} to={type} fax={id}>
                      Read
                    </ReadButton>
                  ) : (
                    <Collapsible title="Message Contents">
                      <BlockQuote>{ref}</BlockQuote>
                    </Collapsible>
                  )}
                  {type.includes('Received') && (
                    <>
                      <SendButton
                        type="msg"
                        os={os_type}
                        target={user_key}
                        taker={taker}>
                        Reply (Message)
                      </SendButton>
                      {dept && (
                        <SendButton
                          type="fax"
                          os={os_type}
                          target={dept}
                          taker={taker}>
                          Reply (Fax)
                        </SendButton>
                      )}
                      <Button
                        onClick={() =>
                          act(`take`, {
                            os: os_type,
                            fax: id,
                            type: type,
                          })
                        }>
                        {taker === config.client.ckey ? 'Untake' : 'Take'}
                      </Button>
                    </>
                  )}
                </Box>
              </Flex.Item>
            );
          })}
      </Flex>
      <Box mt={2}>
        <SendButton type="fax" os={os_type}>
          Send fax
        </SendButton>
        <SendButton type="msg" os={os_type}>
          Send message
        </SendButton>
      </Box>
    </Section>
  );
};
