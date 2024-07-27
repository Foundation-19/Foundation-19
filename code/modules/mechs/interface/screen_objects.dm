// Screen objects hereon out.
#define MECH_UI_STYLE(X) ("<span style=\"font-family: 'Small Fonts'; -dm-text-outline: 1 black; font-size: 5px;\">" + X + "</span>")

/atom/movable/screen/exosuit
	name = "hardpoint"
	icon = 'icons/mecha/mech_hud.dmi'
	icon_state = "base"
	var/mob/living/exosuit/owner
	var/height = 14

/atom/movable/screen/exosuit/radio
	name = "radio"
	maptext = MECH_UI_STYLE("RADIO")
	maptext_x = 5
	maptext_y = 12

/atom/movable/screen/exosuit/radio/Click()
	if(..())
		if(owner.radio)
			owner.radio.attack_self(usr)
		else
			to_chat(usr, SPAN_WARNING("There is no radio installed."))

/atom/movable/screen/exosuit/Initialize()
	. = ..()
	var/mob/living/exosuit/newowner = loc
	if(!istype(newowner))
		return qdel(src)
	owner = newowner

/atom/movable/screen/exosuit/Click()
	return (!usr.incapacitated() && usr.canClick() && (usr == owner || usr.loc == owner))

#define HARDPOINT_SELECTABLE (1<<0)
#define HARDPOINT_EJECTABLE (1<<1)

/atom/movable/screen/exosuit/hardpoint
	name = "hardpoint"
	var/hardpoint_tag
	var/obj/item/holding
	var/interact_flags = HARDPOINT_SELECTABLE | HARDPOINT_EJECTABLE
	icon_state = "hardpoint"

	maptext_x = 34
	maptext_y = 3
	maptext_width = 72

/atom/movable/screen/exosuit/hardpoint/MouseDrop()
	..()
	if(holding) holding.screen_loc = screen_loc

/atom/movable/screen/exosuit/hardpoint/proc/update_system_info()

	// No point drawing it if we have no item to use or nobody to see it.
	if(!holding || !owner)
		return

	var/has_pilot_with_client = owner.client
	if(!has_pilot_with_client && LAZYLEN(owner.pilots))
		for(var/thing in owner.pilots)
			var/mob/pilot = thing
			if(pilot.client)
				has_pilot_with_client = TRUE
				break
	if(!has_pilot_with_client)
		return

	var/list/new_overlays = list()
	if(!owner.get_cell(FALSE, ME_ANY_POWER) || (owner.get_cell(FALSE, ME_ANY_POWER).charge <= 0))
		cut_overlays()
		maptext = ""
		return

	maptext =  SPAN_STYLE("font-family: 'Small Fonts'; -dm-text-outline: 1 black; font-size: 7px;", "[holding.get_hardpoint_maptext()]")

	var/ui_damage = (!owner.body.diagnostics || !owner.body.diagnostics.is_functional() || ((owner.emp_damage>EMP_GUI_DISRUPT) && prob(owner.emp_damage)))

	var/value = holding.get_hardpoint_status_value()
	if(isnull(value))
		cut_overlays()
		return

	if(ui_damage)
		value = -1
		maptext = SPAN_STYLE("font-family: 'Small Fonts'; -dm-text-outline: 1 black; font-size: 7px;", "ERROR")
	else
		if((owner.emp_damage>EMP_GUI_DISRUPT) && prob(owner.emp_damage*2))
			if(prob(10))
				value = -1
			else
				value = rand(1,BAR_CAP)
		else
			value = round(value * BAR_CAP)

	// Draw background.
	if(!GLOB.default_hardpoint_background)
		GLOB.default_hardpoint_background = image(icon = 'icons/mecha/mech_hud.dmi', icon_state = "bar_bkg")
		GLOB.default_hardpoint_background.pixel_x = 34
	new_overlays += GLOB.default_hardpoint_background

	if(value == 0)
		if(!GLOB.hardpoint_bar_empty)
			GLOB.hardpoint_bar_empty = image(icon='icons/mecha/mech_hud.dmi',icon_state="bar_flash")
			GLOB.hardpoint_bar_empty.pixel_x = 24
			GLOB.hardpoint_bar_empty.color = "#ff0000"
		new_overlays += GLOB.hardpoint_bar_empty
	else if(value < 0)
		if(!GLOB.hardpoint_error_icon)
			GLOB.hardpoint_error_icon = image(icon='icons/mecha/mech_hud.dmi',icon_state="bar_error")
			GLOB.hardpoint_error_icon.pixel_x = 34
		new_overlays += GLOB.hardpoint_error_icon
	else
		value = min(value, BAR_CAP)
		// Draw statbar.
		if(!LAZYLEN(GLOB.hardpoint_bar_cache))
			for(var/i=0;i<BAR_CAP;i++)
				var/image/bar = image(icon='icons/mecha/mech_hud.dmi',icon_state="bar")
				bar.pixel_x = 24+(i*2)
				if(i>5)
					bar.color = "#00ff00"
				else if(i>1)
					bar.color = "#ffff00"
				else
					bar.color = "#ff0000"
				GLOB.hardpoint_bar_cache += bar
		for(var/i=1;i<=value;i++)
			new_overlays += GLOB.hardpoint_bar_cache[i]
	set_overlays(new_overlays)

/atom/movable/screen/exosuit/hardpoint/Initialize(mapload, newtag)
	. = ..()
	hardpoint_tag = newtag
	name = "hardpoint ([hardpoint_tag])"

/atom/movable/screen/exosuit/hardpoint/Click(location, control, params)

	if(!(..()))
		return FALSE

	if(!owner?.hatch_closed)
		if(istype(holding, /obj/item/mech_equipment))
			var/obj/item/mech_equipment/cast = holding
			if(!(cast.equipment_flags & ME_BYPASS_INTERFACE))
				to_chat(usr, SPAN_WARNING("Error: Hardpoint interface disabled while [owner.body.hatch_descriptor] is open."))
				return FALSE
		else
			to_chat(usr, SPAN_WARNING("Error: Hardpoint interface disabled while [owner.body.hatch_descriptor] is open."))
			return FALSE

	var/modifiers = params2list(params)
	if(modifiers["ctrl"])
		if(owner.hardpoints_locked)
			to_chat(usr, SPAN_WARNING("Hardpoint ejection system is locked."))
			return FALSE
		if(!(interact_flags & HARDPOINT_EJECTABLE))
			to_chat(usr, SPAN_WARNING("This hardpoint can't eject modules! It must be done manually."))
			return FALSE
		if(owner.remove_system(hardpoint_tag))
			to_chat(usr, SPAN_NOTICE("You disengage and discard the system mounted to your [hardpoint_tag] hardpoint."))
		else
			to_chat(usr, SPAN_DANGER("You fail to remove the system mounted to your [hardpoint_tag] hardpoint."))
		return FALSE

	if(interact_flags & HARDPOINT_SELECTABLE)
		if(owner.selected_hardpoint == hardpoint_tag)
			icon_state = initial(icon_state)
			owner.clear_selected_hardpoint()
		else
			if(owner.set_hardpoint(hardpoint_tag))
				icon_state = "[initial(icon_state)]_selected"
	return TRUE

/atom/movable/screen/exosuit/hardpoint/power
	name = "power hardpoint"
	icon_state = "hardpoint_p"
	interact_flags = null

/atom/movable/screen/exosuit/hardpoint/power/Click(location, control, params)
	if(!..())
		return
	var/obj/item/mech_equipment/power_stuff = owner.hardpoints[hardpoint_tag]
	if(power_stuff)
		power_stuff.attack_self(usr)

/atom/movable/screen/exosuit/hardpoint/power/update_system_info()
	..()
	var/obj/item/mech_equipment/power_stuff = owner.hardpoints[hardpoint_tag]
	if(power_stuff?.active)
		icon_state = "[initial(icon_state)]_selected"
	else
		icon_state = "[initial(icon_state)]"

/atom/movable/screen/exosuit/eject
	name = "eject"
	maptext = MECH_UI_STYLE("EJECT")
	maptext_x = 5
	maptext_y = 12

/atom/movable/screen/exosuit/eject/Click()
	if(..())
		owner.eject(usr)

/atom/movable/screen/exosuit/rename
	name = "rename"
	maptext = MECH_UI_STYLE("RENAME")
	maptext_x = 1
	maptext_y = 12

/atom/movable/screen/exosuit/power
	name = "power"
	icon_state = null

	maptext_width = 64

/atom/movable/screen/exosuit/rename/Click()
	if(..())
		owner.rename(usr)

/atom/movable/screen/exosuit/toggle
	name = "toggle"
	var/toggled = FALSE

/atom/movable/screen/exosuit/toggle/Initialize()
	. = ..()
	queue_icon_update()

/atom/movable/screen/exosuit/toggle/on_update_icon()
	. = ..()
	icon_state = "[initial(icon_state)][toggled ? "_enabled" : ""]"
	maptext = FONT_COLORED(toggled ? COLOR_WHITE : COLOR_GRAY,initial(maptext))

/atom/movable/screen/exosuit/toggle/Click()
	if(..()) toggled()

/atom/movable/screen/exosuit/toggle/proc/toggled()
	toggled = !toggled
	queue_icon_update()
	return toggled

/atom/movable/screen/exosuit/toggle/air
	name = "air"
	icon_state = "small_important"
	maptext = MECH_UI_STYLE("AIR")
	maptext_x = 9
	maptext_y = 13
	height = 12

/atom/movable/screen/exosuit/toggle/air/toggled()
	owner.use_air = ..()
	to_chat(usr, SPAN_NOTICE("Auxiliary atmospheric system [owner.use_air ? "enabled" : "disabled"]."))
	playsound(src.loc, 'sounds/effects/turret/open.wav', 50, 1, -6)

/atom/movable/screen/exosuit/toggle/maint
	name = "toggle maintenance protocol"
	icon_state = "small"
	maptext = MECH_UI_STYLE("MAINT")
	maptext_x = 5
	maptext_y = 13
	height = 12

/atom/movable/screen/exosuit/toggle/maint/toggled()
	owner.maintenance_protocols = ..()
	to_chat(usr, SPAN_NOTICE("Maintenance protocols [owner.maintenance_protocols ? "enabled" : "disabled"]."))
	playsound(src.loc, 'sounds/mecha/mech_maints_toggle.ogg', 50, 1, -6)

/atom/movable/screen/exosuit/toggle/hardpoint
	name = "toggle hardpoint lock"
	maptext = MECH_UI_STYLE("GEAR")
	maptext_x = 5
	maptext_y = 12

/atom/movable/screen/exosuit/toggle/hardpoint/toggled()
	owner.hardpoints_locked = ..()
	to_chat(usr, SPAN_NOTICE("Hardpoint system access is now [owner.hardpoints_locked ? "disabled" : "enabled"]."))
	playsound(src.loc, 'sounds/machines/twobeep.ogg', 50, 1, -6)

/atom/movable/screen/exosuit/toggle/hatch
	name = "toggle hatch lock"
	maptext = MECH_UI_STYLE("LOCK")
	maptext_x = 5
	maptext_y = 12

/atom/movable/screen/exosuit/toggle/hatch/toggled()
	if(!owner.hatch_locked && !owner.hatch_closed)
		to_chat(usr, SPAN_WARNING("You cannot lock the hatch while it is open."))
		return
	owner.hatch_locked = ..()
	to_chat(usr, SPAN_NOTICE("The [owner.body.hatch_descriptor] is [owner.hatch_locked ? "now" : "no longer" ] locked."))
	playsound(src.loc, 'sounds/mecha/mech_lock_toggle.ogg', 50, 1, -6)

/atom/movable/screen/exosuit/toggle/hatch_open
	name = "open or close hatch"
	maptext = MECH_UI_STYLE("CLOSE")
	maptext_x = 4
	maptext_y = 12

/atom/movable/screen/exosuit/toggle/hatch_open/toggled()
	if (!owner)
		return
	if(owner.hatch_locked && owner.hatch_closed)
		to_chat(usr, SPAN_WARNING("You cannot open the hatch while it is locked."))
		return
	owner.hatch_closed = ..()
	to_chat(usr, SPAN_NOTICE("The [owner.body.hatch_descriptor] is now [owner.hatch_closed ? "closed" : "open" ]."))
	owner.update_icon()
	playsound(src.loc, 'sounds/mecha/mech_hatch_toggle.ogg', 50, 1, -6)

/atom/movable/screen/exosuit/toggle/hatch_open/on_update_icon()
	toggled = owner.hatch_closed
	. = ..()
	if(toggled)
		maptext = MECH_UI_STYLE("OPEN")
		maptext_x = 5
	else
		maptext = MECH_UI_STYLE("CLOSE")
		maptext_x = 4

// This is basically just a holder for the updates the exosuit does.
/atom/movable/screen/exosuit/health
	name = "exosuit integrity"
	icon_state = "health"

/atom/movable/screen/exosuit/health/Click()
	if(..())
		if(owner && owner.body && owner.get_cell(FALSE, ME_ANY_POWER) && owner.body.diagnostics?.is_functional())
			usr.setClickCooldown(0.2 SECONDS)
			to_chat(usr, SPAN_NOTICE("The diagnostics panel blinks several times as it updates:"))
			playsound(owner.loc,'sounds/effects/scanbeep.ogg',30,0)
			for(var/obj/item/mech_component/MC in list(owner.arms, owner.legs, owner.body, owner.head))
				if(MC)
					MC.return_diagnostics(usr)

//Controls if cameras set the vision flags
/atom/movable/screen/exosuit/toggle/camera
	name = "toggle camera matrix"
	icon_state = "small_important"
	maptext = MECH_UI_STYLE("SENSOR")
	maptext_x = 1
	maptext_y = 13
	height = 12

/atom/movable/screen/exosuit/toggle/camera/toggled()
	if(!owner.head)
		to_chat(usr, SPAN_WARNING("I/O Error: Camera systems not found."))
		return
	if(!owner.head.vision_flags)
		to_chat(usr,  SPAN_WARNING("Alternative sensor configurations not found. Contact manufacturer for more details."))
		return
	if(!owner.get_cell(FALSE, ME_ANY_POWER))
		to_chat(usr,  SPAN_WARNING("The augmented vision systems are offline."))
		return
	owner.head.active_sensors = ..()
	to_chat(usr, SPAN_NOTICE("[owner.head.name] advanced sensor mode is [owner.head.active_sensors ? "now" : "no longer" ] active."))

/atom/movable/screen/exosuit/toggle/camera/on_update_icon()
	toggled = owner.head.active_sensors
	. = ..()

// Controls strafing mode on the mech
/atom/movable/screen/exosuit/toggle/strafe
	name = "toggle strafe"
	maptext = MECH_UI_STYLE("STRAFE")
	maptext_x = 2
	maptext_y = 12

/atom/movable/screen/exosuit/toggle/strafe/toggled() // Prevents exosuits from strafing when EMP'd enough
	if(!(owner.legs.movement_flags & PF_OMNI_STRAFE))
		to_chat(usr, SPAN_WARNING("Error: This propulsion system doesn't support synchronization!"))
		return
	if(owner.emp_damage >= EMP_MOVE_DISRUPT)
		to_chat(usr, SPAN_WARNING("Error: Coordination systems are unable to synchronize. Contact an authorised exo-electrician immediately."))
		return
	if(..())
		owner.mech_flags |= MF_STRAFING
	else
		owner.mech_flags &= ~MF_STRAFING
	to_chat(usr, SPAN_NOTICE("Strafing [owner.mech_flags & MF_STRAFING ? "enabled" : "disabled"]."))
	playsound(src,'sounds/mecha/lever.ogg', 40, 1)

/atom/movable/screen/exosuit/toggle/strafe/on_update_icon()
	if(!(owner?.legs?.movement_flags & PF_OMNI_STRAFE))
		maptext = MECH_UI_STYLE("------")
	else
		maptext = initial(maptext)
	. = ..()



#undef BAR_CAP
#undef MECH_UI_STYLE
