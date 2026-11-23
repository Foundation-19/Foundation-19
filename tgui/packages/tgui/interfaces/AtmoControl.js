import { useBackend, useLocalState } from '../backend';
import { Box, Button, Flex, LabeledList, Section, Tabs } from '../components';
import { Window } from '../layouts';

export const AtmoControl = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    systemname,
    sensors,
    control,
    frequency,
    input_tag,
    output_tag,
    sensor_tag,
    input_present,
    in_power,
    input_flow_setting,
    atmos_volume,
    output_present,
    out_power,
    out_pressure_setting,
    max_pump_pressure,
    external_pressure,
    out_pressure_mode,
    gasses,
    automation,
    screen,
  } = data;

  const [currentScreen, setCurrentScreen] = useLocalState(context, 'currentScreen', screen || 1);

  return (
    <Window width={800} height={800} resizable>
      <Window.Content scrollable>
        <Section title={systemname || "Atmospherics Control"}>
          <Tabs>
            <Tabs.Tab
              selected={currentScreen === 1}
              onClick={() => {
                setCurrentScreen(1);
                act('set_screen', { screen: 1 });
              }}>
              Sensors
            </Tabs.Tab>
            {(input_present || output_present) && (
              <Tabs.Tab
                selected={currentScreen === 2}
                onClick={() => {
                  setCurrentScreen(2);
                  act('set_screen', { screen: 2 });
                }}>
                Control
              </Tabs.Tab>
            )}
          </Tabs>

          {currentScreen === 1 && (
            <Box>
              <Section title="Sensor Data">
                {sensors && sensors.length > 0 && sensors.map((sensor, i) => (
                  <LabeledList key={i}>
                    <LabeledList.Item label="Sensor">
                      {sensor.long_name}
                    </LabeledList.Item>
                    {sensor.pressure && (
                      <LabeledList.Item label="Pressure">
                        {sensor.pressure} kPa
                      </LabeledList.Item>
                    )}
                    {sensor.temperature && (
                      <LabeledList.Item label="Temperature">
                        {sensor.temperature} K
                      </LabeledList.Item>
                    )}
                  </LabeledList>
                ))}
                {(!sensors || sensors.length === 0) && (
                  <Box color="label">No sensor data available.</Box>
                )}
              </Section>
              {gasses && Object.keys(gasses).length > 0 && (
                <Section title="Gas Composition">
                  <LabeledList>
                    {Object.entries(gasses).map(([gas, amount]) => (
                      <LabeledList.Item key={gas} label={gas}>
                        {amount}%
                      </LabeledList.Item>
                    ))}
                  </LabeledList>
                </Section>
              )}
            </Box>
          )}

          {currentScreen === 2 && (
            <Box>
              {input_present && (
                <Section title="Input Control">
                  <LabeledList>
                    <LabeledList.Item label="Power">
                      {in_power ? "On" : "Off"}
                    </LabeledList.Item>
                    <LabeledList.Item label="Flow Rate">
                      {input_flow_setting} L/s
                    </LabeledList.Item>
                  </LabeledList>
                  <Box mt={1}>
                    <Button
                      icon="power-off"
                      content="Toggle Injector"
                      onClick={() => act('in_toggle_injector')} />
                    <Button
                      icon="refresh"
                      content="Refresh"
                      onClick={() => act('in_refresh_status')} />
                    <Button
                      icon="cog"
                      content="Set Flow Rate"
                      onClick={() => act('in_set_flowrate')} />
                    <Button
                      icon="arrow-up"
                      content="Set Max"
                      onClick={() => act('in_set_max')} />
                  </Box>
                </Section>
              )}
              {output_present && (
                <Section title="Output Control">
                  <LabeledList>
                    <LabeledList.Item label="Power">
                      {out_power ? "On" : "Off"}
                    </LabeledList.Item>
                    <LabeledList.Item label="Pressure Setting">
                      {out_pressure_setting} kPa
                    </LabeledList.Item>
                    <LabeledList.Item label="Pressure Mode">
                      {out_pressure_mode ? "External" : "Internal"}
                    </LabeledList.Item>
                  </LabeledList>
                  <Box mt={1}>
                    <Button
                      icon="power-off"
                      content="Toggle Power"
                      onClick={() => act('out_toggle_power')} />
                    <Button
                      icon="refresh"
                      content="Refresh"
                      onClick={() => act('out_refresh_status')} />
                    <Button
                      icon="cog"
                      content="Set Pressure"
                      onClick={() => act('out_set_pressure')} />
                    <Button
                      icon="arrow-up"
                      content="Set Max"
                      onClick={() => act('out_set_max')} />
                    <Button
                      icon="exchange-alt"
                      content="Toggle Pressure Mode"
                      onClick={() => act('toggle_pressure_mode')} />
                    {out_pressure_mode && (
                      <Box inline>
                        <Button
                          icon="cog"
                          content="Set Core Pressure"
                          onClick={() => act('s_out_set_pressure')} />
                        <Button
                          icon="undo"
                          content="Set Default"
                          onClick={() => act('s_set_default')} />
                      </Box>
                    )}
                  </Box>
                </Section>
              )}
            </Box>
          )}

          <Section title="Configuration">
            <LabeledList>
              <LabeledList.Item label="Frequency">
                {frequency}
                <Button
                  icon="cog"
                  ml={1}
                  content="Set"
                  onClick={() => act('set_frequency')} />
              </LabeledList.Item>
              <LabeledList.Item label="Input Tag">
                {input_tag || "Not set"}
                <Button
                  icon="pen"
                  ml={1}
                  content="Set"
                  onClick={() => act('set_input_tag')} />
              </LabeledList.Item>
              <LabeledList.Item label="Output Tag">
                {output_tag || "Not set"}
                <Button
                  icon="pen"
                  ml={1}
                  content="Set"
                  onClick={() => act('set_output_tag')} />
              </LabeledList.Item>
              <LabeledList.Item label="Sensor Tag">
                {sensor_tag || "Not set"}
                <Button
                  icon="pen"
                  ml={1}
                  content="Set"
                  onClick={() => act('set_sensor_tag')} />
              </LabeledList.Item>
            </LabeledList>
          </Section>

          {automation >= 0 && (
            <Section title="Fuel Injection Automation">
              <Button
                icon={automation ? "toggle-on" : "toggle-off"}
                content={automation ? "Automation ON" : "Automation OFF"}
                selected={automation}
                onClick={() => act('toggle_automation')} />
            </Section>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
