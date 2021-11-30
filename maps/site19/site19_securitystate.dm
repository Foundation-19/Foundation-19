/datum/map/site19 // setting the map to use this list
	security_state = /decl/security_state/default/site19

//Torch map alert levels. Refer to security_state.dm.
/decl/security_state/default/site19
	all_security_levels = list(/decl/security_level/default/site19/code_green, /decl/security_level/default/site19/code_yellow, /decl/security_level/default/site19/code_blue, /decl/security_level/default/site19/code_orange, /decl/security_level/default/site19/code_red, /decl/security_level/default/site19/code_black, /decl/security_level/default/site19/code_gray, /decl/security_level/default/code_delta)
	standard_security_levels = list(/decl/security_level/default/site19/code_green, /decl/security_level/default/site19/code_yellow, /decl/security_level/default/site19/code_blue, /decl/security_level/default/site19/code_orange, /decl/security_level/default/site19/code_red, /decl/security_level/default/site19/code_black, /decl/security_level/default/site19/code_gray)

/decl/security_level/default/site19
	icon = 'maps/site19/icons/security_state.dmi'

/decl/security_level/default/site19/code_green
	name = "code green"
	icon = 'icons/misc/security_state.dmi'

	light_range = 2
	light_power = 1
	light_color_alarm = COLOR_GREEN
	light_color_status_display = COLOR_GREEN

	overlay_alarm = "alarm_green"
	overlay_status_display = "status_display_green"

	var/static/datum/announcement/priority/security/security_announcement_green = new(do_log = 0, do_newscast = 1, new_sound = sound('sound/AI/announcer/codegreen.ogg', volume = 150))

/decl/security_level/default/site19/code_green/switching_down_to()
	security_announcement_green.Announce("The situation has been resolved, and all personnel are to return to their regular duties.", "Attention! Alert level lowered to code green.")
	notify_station()

/decl/security_level/default/site19/code_yellow
	name = "code yellow"
	icon = 'icons/misc/security_state.dmi'

	light_range = 3
	light_power = 2
	light_color_alarm = COLOR_BLUE
	light_color_status_display = COLOR_BLUE
	overlay_alarm = "alarm_yellow"
	overlay_status_display = "status_display_yellow"

	up_description = "Code Yellow procedures now in effect. A test on a Euclid SCP will commence shortly. Guards are to be posted at sensitive entry area's and maintain their post there until the all clear. Civilian and Scientists unrelated to the on-going test are to vacate the relevant zone before the test commences and kept there until the all clear. Violation of these procedures is grounds for immediate termination."
	down_description = "Code Yellow procedures now in effect. Code Blue has been resolved, but all area's should be swept for threats extensively, and the integrity of all chambers should be inspected. All SCP's must be accounted for."

/decl/security_level/default/site19/code_blue
	name = "code blue"
	icon = 'icons/misc/security_state.dmi'

	light_range = 3
	light_power = 2
	light_color_alarm = COLOR_BLUE
	light_color_status_display = COLOR_BLUE
	overlay_alarm = "alarm_blue"
	overlay_status_display = "status_display_blue"

	up_description = "Code Blue procedures now in effect. A test on a Keter SCP will commence shortly. All class D should return to their cells and await the all-clear at this time. Guards are to be posted at sensitive entry area's and maintain their post there until the all clear. Engineering and Medical staff are confined to their departments or relevant work area's for this test. Civilian and Scientists unrelated to the on-going test are to be escorted to a safe place before the test commences and kept there until the all clear. Violation of these procedures is grounds for immediate termination."
	down_description = "Code Blue procedures now in effect. Code Red has been resolved, but all area's should be swept for threats extensively, and the integrity of all chambers should be inspected. All SCP's must be accounted for."

/decl/security_level/default/site19/code_orange
	name = "code orange"
	icon = 'icons/misc/security_state.dmi'

	light_range = 4
	light_power = 2
	light_color_alarm = COLOR_ORANGE
	light_color_status_display = COLOR_ORANGE
	overlay_alarm = "alarm_orange"
	overlay_status_display = "status_display_orange"

	crb = TRUE

	var/static/datum/announcement/priority/security/security_announcement_orange = new(do_log = 0, do_newscast = 1, new_sound = sound('sound/AI/announcer/codered.ogg'))

/decl/security_level/default/site19/code_orange/switching_up_to()
	security_announcement_orange.Announce("Code Orange procedures are now in effect. A Euclid SCP has broken containment and its current whereabouts are unknown. Security should investigate and focus on recontainment as a first priority, or request an MTF unit to assist.", "Attention! Code Orange alert procedures now in effect!")
	notify_station()

/decl/security_level/default/site19/code_orange/switching_down_to()
	security_announcement_orange.Announce("Code Orange procedures now in effect. All Keter SCP's have been recontained, but one or more Euclid SCP remains unaccounted for. Security should intensify searches to all area's to locate, and recontain the affected SCP's.", "Attention! Code Orange alert procedures now in effect!")
	notify_station()

/decl/security_level/default/site19/code_red
	name = "code red"
	icon = 'icons/misc/security_state.dmi'

	light_range = 4
	light_power = 2
	light_color_alarm = COLOR_RED
	light_color_status_display = COLOR_RED
	overlay_alarm = "alarm_red"
	overlay_status_display = "status_display_red"

	crb = TRUE

	var/static/datum/announcement/priority/security/security_announcement_red = new(do_log = 0, do_newscast = 1, new_sound = sound('sound/AI/announcer/codered.ogg'))

/decl/security_level/default/site19/code_red/switching_up_to()
	security_announcement_red.Announce("Code Red procedures are now in effect. A Keter SCP has broken containment and its current whereabouts are unknown. Security should investigate and focus on recontainment as a first priority, or request an MTF unit to assist.", "Attention! Code red alert procedures now in effect!")
	notify_station()

/decl/security_level/default/site19/code_red/switching_down_to()
	security_announcement_red.Announce("Code Red procedures now in effect. Code Black has been canceled, making the facility largely accessible once more, but one or more Keter SCP's remain at large. Security should focus their efforts on recontaining the SCP. Code Red evacuation procedures are now in effect, consult the relevant SoP section for more information.", "Attention! Code red alert procedures now in effect!")
	notify_station()

/decl/security_level/default/site19/code_black
	name = "code black"

	light_range = 4
	light_power = 2
	light_color_alarm = COLOR_RED
	light_color_status_display = COLOR_NAVY_BLUE

	overlay_alarm = "black_alarm"
	overlay_status_display = "status_display_black"

	crb = TRUE

	var/static/datum/announcement/priority/security/security_announcement_black = new(do_log = 0, do_newscast = 1, new_sound = sound('sound/AI/announcer/codeblack.ogg'))

/decl/security_level/default/site19/code_black/switching_up_to()
	security_announcement_black.Announce("The site is experiencing multiple keter and euclid level containment breaches. Full site lockdown initiated.", "Attention! Code Black alert procedures now in effect!")
	notify_station()

/decl/security_level/default/site19/code_black/switching_down_to()
	security_announcement_black.Announce("The Site has been secured from subversive elements. Security is to do a mandatory sweep of the facility to make sure all SCP's remained inside containment.", "Attention! Code Black alert procedures now in effect!")
	notify_station()

/decl/security_level/default/site19/code_gray
	name = "code gray"

	light_range = 4
	light_power = 2
	light_color_alarm = COLOR_GRAY
	light_color_status_display = COLOR_GRAY

	overlay_alarm = "grey_alarm"
	overlay_status_display = "status_display_grey"

	var/static/datum/announcement/priority/security/security_announcement_gray = new(do_log = 0, do_newscast = 1, new_sound = sound())

/decl/security_level/default/site19/code_gray/switching_up_to()
	security_announcement_gray.Announce("There have been confirmed reports of a hostile Group of Interest having infiltrated the Site. Security is allowed to terminate the threats." ,"Attention! Code Gray alert procedures now in effect!")
	notify_station()

/decl/security_level/default/site19/code_gray/switching_down_to()
	security_announcement_gray.Announce("The Site's Nuclear Detonation has been canceled, however, the site should be swept for subversive elements before returning to normal operations.", "Attention! Code Gray alert procedures now in effect!")
	notify_station()
