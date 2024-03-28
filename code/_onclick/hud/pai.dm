/datum/hud/pai/FinalizeInstantiation()
	adding = list()
	var/atom/movable/screen/using

	using = new /atom/movable/screen/pai/software()
	using.SetName("Software Interface")
	adding += using

	using = new /atom/movable/screen/pai/subsystems()
	using.SetName("Subsystems")
	adding += using

	using = new /atom/movable/screen/pai/shell()
	using.SetName("Toggle Chassis")
	adding += using

	using = new /atom/movable/screen/pai/rest()
	using.SetName("Rest")
	adding += using

	using = new /atom/movable/screen/pai/light()
	using.SetName("Toggle Light")
	adding += using

	mymob.client.screen = list()
	mymob.client.screen += adding
	inventory_shown = 0

/atom/movable/screen/pai
	icon = 'icons/mob/screen/pai.dmi'

/atom/movable/screen/pai/Click()
	if(!isobserver(usr) && (!usr.incapacitated() || usr.resting))
		OnClick()

/atom/movable/screen/pai/proc/OnClick()

/atom/movable/screen/pai/software
	name = "Software Interface"
	icon_state = "pai"
	screen_loc = ui_pai_software

/atom/movable/screen/pai/software/OnClick()
	var/mob/living/silicon/pai/pAI = usr
	pAI.paiInterface()

/atom/movable/screen/pai/shell
	name = "Toggle Chassis"
	icon_state = "pai_holoform"
	screen_loc = ui_pai_shell

/atom/movable/screen/pai/shell/OnClick()
	var/mob/living/silicon/pai/pAI = usr
	if(pAI.is_in_card)
		pAI.unfold()
	else
		pAI.fold()

/atom/movable/screen/pai/chassis
	name = "Holochassis Appearance Composite"
	icon_state = "pai_holoform"

/atom/movable/screen/pai/rest
	name = "Rest"
	icon_state = "pai_rest"
	screen_loc = ui_pai_rest

/atom/movable/screen/pai/rest/OnClick()
	var/mob/living/silicon/pai/pAI = usr
	pAI.lay_down()

/atom/movable/screen/pai/light
	name = "Toggle Integrated Lights"
	icon_state = "light"
	screen_loc = ui_pai_light

/atom/movable/screen/pai/light/OnClick()
	var/mob/living/silicon/pai/pAI = usr
	pAI.toggle_integrated_light()

/atom/movable/screen/pai/pull
	name = "pull"
	icon_state = "pull1"

/atom/movable/screen/pai/pull/OnClick()
	var/mob/living/silicon/pai/pAI = usr
	pAI.stop_pulling()
	pAI.pullin.screen_loc = null
	pAI.client.screen -= pAI.pullin

/atom/movable/screen/pai/subsystems
	name = "SubSystems"
	icon_state = "subsystems"
	screen_loc = ui_pai_subsystems

/atom/movable/screen/pai/subsystems/OnClick()
	var/mob/living/silicon/pai/pAI = usr
	var/ss_name = input(usr, "Activates the given subsystem", "Subsystems", "") in pAI.silicon_subsystems_by_name
	if (!ss_name)
		return

	var/stat_silicon_subsystem/SSS = pAI.silicon_subsystems_by_name[ss_name]
	if(istype(SSS))
		SSS.Click()
