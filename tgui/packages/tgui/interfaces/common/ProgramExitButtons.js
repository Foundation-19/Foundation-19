import { Button } from '../../components';

// Exit/Minimize controls for UIs running as programs on a modular computer.
// Render inside the Window titlebar via the `buttons` prop:
//   <Window ... buttons={PC_showexitprogram ? <ProgramExitButtons act={act} /> : undefined}>
// PC_showexitprogram is only present in the payload when the nano module is
// hosted by a running computer program — standalone consoles never send it,
// so the buttons stay hidden there.
export const ProgramExitButtons = (props) => {
  const { act } = props;
  return (
    <>
      <Button
        icon="window-minimize-o"
        tooltip="Minimize"
        tooltipPosition="bottom"
        onClick={() => act('PC_minimize')}
      />
      <Button
        icon="window-close-o"
        tooltip="Exit Program"
        tooltipPosition="bottom-start"
        color="bad"
        onClick={() => act('PC_exit')}
      />
    </>
  );
};
