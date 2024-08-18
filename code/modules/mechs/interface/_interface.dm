#define BAR_CAP 12

/mob/living/exosuit/proc/refresh_hud()
	if(LAZYLEN(pilots))
		for(var/thing in pilots)
			var/mob/pilot = thing
			if(pilot.client)
				pilot.client.screen |= hud_elements
	if(client)
		client.screen |= hud_elements

/mob/living/exosuit/InitializeHud()
	zone_sel = new
	if(!LAZYLEN(hud_elements))
		var/i = 1
		for(var/hardpoint in hardpoints)
			var/atom/movable/screen/exosuit/hardpoint/H
			// those 2 are always forced to the bottom for UI
			switch(hardpoint)
				if(HARDPOINT_POWER)
					H = new /atom/movable/screen/exosuit/hardpoint/power(src, hardpoint)
					H.screen_loc = "1:6,8"
				if(HARDPOINT_BACKUP_POWER)
					H = new /atom/movable/screen/exosuit/hardpoint/power(src, hardpoint)
					H.screen_loc = "1:6,7"
				else
					H = new(src, hardpoint)
					H.screen_loc = "1:6,[15-i]" //temp
			hud_elements |= H
			hardpoint_hud_elements[hardpoint] = H
			i++

		var/list/additional_hud_elements = list(
			/atom/movable/screen/exosuit/toggle/maint,
			/atom/movable/screen/exosuit/eject,
			/atom/movable/screen/exosuit/toggle/hardpoint,
			/atom/movable/screen/exosuit/toggle/hatch,
			/atom/movable/screen/exosuit/toggle/hatch_open,
			/atom/movable/screen/exosuit/radio,
			/atom/movable/screen/exosuit/rename,
			/atom/movable/screen/exosuit/toggle/camera,
			/atom/movable/screen/exosuit/toggle/strafe
			)
		if(body && body.pilot_coverage >= 100)
			additional_hud_elements += /atom/movable/screen/exosuit/toggle/air
		i = 0
		var/pos = 6
		for(var/additional_hud in additional_hud_elements)
			var/atom/movable/screen/exosuit/M = new additional_hud(src)
			M.screen_loc = "1:6,[pos]:[i]"
			hud_elements |= M
			i -= M.height

		hud_health = new /atom/movable/screen/exosuit/health(src)
		hud_health.screen_loc = "EAST-1:28,CENTER-3:11"
		hud_elements |= hud_health
		hud_open = locate(/atom/movable/screen/exosuit/toggle/hatch_open) in hud_elements
		hud_power = new /atom/movable/screen/exosuit/power(src)
		hud_power.screen_loc = "EAST-1:12,CENTER-4:25"
		hud_elements |= hud_power
		hud_camera = locate(/atom/movable/screen/exosuit/toggle/camera) in hud_elements
		strafing = locate(/atom/movable/screen/exosuit/toggle/strafe) in hud_elements

	refresh_hud()

/mob/living/exosuit/handle_hud_icons()
	for(var/hardpoint in hardpoint_hud_elements)
		var/atom/movable/screen/exosuit/hardpoint/H = hardpoint_hud_elements[hardpoint]
		if(H) H.update_system_info()
	handle_hud_icons_health()
	var/obj/item/cell/C = get_cell(FALSE, ME_ANY_POWER)
	if(istype(hardpoints[HARDPOINT_POWER], /obj/item/mech_equipment/engine) && C?.loc == hardpoints[HARDPOINT_POWER])
		hud_power.maptext_x = 25
		hud_power.maptext_y = initial(hud_power.maptext_y)
		hud_power.maptext = SPAN_STYLE("font-family: 'Small Fonts'; -dm-text-outline: 1 black; font-size: 7px;", "--/--")
	else if(istype(C))
		hud_power.maptext_x = initial(hud_power.maptext_x)
		hud_power.maptext_y = initial(hud_power.maptext_y)
		hud_power.maptext = SPAN_STYLE("font-family: 'Small Fonts'; -dm-text-outline: 1 black; font-size: 7px;",  "[round(C.charge)]/[round(C.maxcharge)]")
	else
		hud_power.maptext_x = 16
		hud_power.maptext_y = -8
		hud_power.maptext = SPAN_STYLE("font-family: 'Small Fonts'; -dm-text-outline: 1 black; font-size: 7px;", "CHECK POWER")

	refresh_hud()

/mob/living/exosuit/handle_hud_icons_health()

	hud_health.cut_overlays()

	if(!body || !get_cell(FALSE, ME_ANY_POWER) || (get_cell(FALSE, ME_ANY_POWER).charge <= 0))
		return

	if(!body.diagnostics || !body.diagnostics.is_functional() || ((emp_damage>EMP_GUI_DISRUPT) && prob(emp_damage*2)))
		if(!GLOB.mech_damage_overlay_cache["critfail"])
			GLOB.mech_damage_overlay_cache["critfail"] = image(icon='icons/mecha/mech_hud.dmi',icon_state="dam_error")
		hud_health.add_overlay(GLOB.mech_damage_overlay_cache["critfail"])
		return

	var/list/part_to_state = list("legs" = legs,"body" = body,"head" = head,"arms" = arms)
	for(var/part in part_to_state)
		var/state = 0
		var/obj/item/mech_component/MC = part_to_state[part]
		if(MC)
			if((emp_damage>EMP_GUI_DISRUPT) && prob(emp_damage*3))
				state = rand(0,4)
			else
				state = MC.damage_state
		if(!GLOB.mech_damage_overlay_cache["[part]-[state]"])
			var/image/I = image(icon='icons/mecha/mech_hud.dmi',icon_state="dam_[part]")
			switch(state)
				if(1)
					I.color = "#00ff00"
				if(2)
					I.color = "#f2c50d"
				if(3)
					I.color = "#ea8515"
				if(4)
					I.color = "#ff0000"
				else
					I.color = "#f5f5f0"
			GLOB.mech_damage_overlay_cache["[part]-[state]"] = I
		hud_health.add_overlay(GLOB.mech_damage_overlay_cache["[part]-[state]"])

/mob/living/exosuit/proc/reset_hardpoint_color()
	for(var/hardpoint in hardpoint_hud_elements)
		var/atom/movable/screen/exosuit/hardpoint/H = hardpoint_hud_elements[hardpoint]
		if(H)
			H.color = COLOR_WHITE

/mob/living/exosuit/setClickCooldown(timeout)
	. = ..()
	for(var/hardpoint in hardpoint_hud_elements)
		var/atom/movable/screen/exosuit/hardpoint/H = hardpoint_hud_elements[hardpoint]
		if(H)
			H.color = "#a03b3b"
			animate(H, color = COLOR_WHITE, time = timeout, easing = CUBIC_EASING | EASE_IN)
	addtimer(CALLBACK(src, PROC_REF(reset_hardpoint_color)), timeout)
