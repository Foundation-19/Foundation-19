/client
	var/obj/screen/tooltip/tooltip

/obj/screen/tooltip
	icon = 'icons/misc/tooltip.dmi'
	icon_state = "transparent"
	screen_loc = "TOP, CENTER - 3"
	plane = HUD_PLANE
	layer = UNDER_HUD_LAYER
	maptext_width = 256
	maptext_x = -16
	var/state = TRUE
	var/maptext_style = "font-family: 'Small Fonts';"

/obj/screen/tooltip/proc/SetMapText(newValue, forcedFontColor = "#ffffff")
	var/style = "color:[forcedFontColor];text-shadow: 0 2px 2px [invertHTML(forcedFontColor)];[maptext_style];"
	maptext = "<center><span style=\"[style]\">[newValue]</span></center>"

/obj/screen/tooltip/proc/set_state(new_state, type)
	switch(type)
		if(GLOB.PREF_SHOW)
			icon_state = "transparent"
	if(new_state == state)
		return
	state = new_state
	set_invisibility(state ? initial(invisibility) : INVISIBILITY_MAXIMUM)

/client/New(TopicData)
	. = ..()
	tooltip = new /obj/screen/tooltip()
	if(mob)
		var/value = mob.get_preference_value(/datum/client_preference/tooltip)
		if(value == GLOB.PREF_SHOW)
			tooltip.set_state(TRUE, value)
		else
			tooltip.set_state(FALSE, value)

/client/MouseEntered(atom/hoverOn, location, control, params)
	if (ticker.current_state == GAME_STATE_PLAYING)

//	if(tooltip?.state && GAME_STATE > RUNLEVEL_SETUP)
		var/text_in_tooltip = hoverOn.name

		screen |= tooltip
		tooltip.SetMapText(text_in_tooltip/*, istext(hoverOn.color) ? hoverOn.color : null*/)

/datum/client_preference/tooltip
	description = "Show Tooltip"
	key = "SHOW_TOOLTIP"
	options = list(GLOB.PREF_SHOW, GLOB.PREF_HIDE)

/datum/client_preference/tooltip/changed(mob/preference_mob, new_value)
	var/client/C = preference_mob.client
	if(new_value == GLOB.PREF_SHOW)
		C.tooltip.set_state(1, new_value)
	else
		C.tooltip.set_state(0)
