/datum/map/site13 // setting the map to use this list
	security_state = /decl/security_state/default/torchdept

//Torch map alert levels. Refer to security_state.dm.
/decl/security_state/default/torchdept
	all_security_levels = list(/decl/security_level/default/torchdept/code_green, /decl/security_level/default/torchdept/code_blue, /decl/security_level/default/torchdept/code_red, /decl/security_level/default/code_delta)
	standard_security_levels = list(/decl/security_level/default/torchdept/code_green, /decl/security_level/default/torchdept/code_blue)

/decl/security_level/default/torchdept
	icon = 'maps/site13/icons/security_state.dmi'

/decl/security_level/default/torchdept/code_green
	name = "code green"
	icon = 'icons/misc/security_state.dmi'

	light_range = 2
	light_power = 1
	light_color_alarm = COLOR_GREEN
	light_color_status_display = COLOR_GREEN

	overlay_alarm = "alarm_green"
	overlay_status_display = "status_display_green"

	var/static/datum/announcement/priority/security/security_announcement_green = new(do_log = 0, do_newscast = 1, new_sound = sound('sound/AI/ds90/codegreen.ogg', volume = 150))

/decl/security_level/default/torchdept/code_green/switching_down_to()
	security_announcement_green.Announce("The situation has been resolved, and all personnel are to return to their regular duties.", "Attention! Alert level lowered to code green.")
	notify_station()

/decl/security_level/default/torchdept/code_blue
	name = "code blue"
	icon = 'icons/misc/security_state.dmi'

	light_range = 3
	light_power = 2
	light_color_alarm = COLOR_BLUE
	light_color_status_display = COLOR_BLUE
	overlay_alarm = "alarm_blue"
	overlay_status_display = "status_display_blue"

	up_description = "A major security emergency has developed. Security personnel are to report to their supervisor for orders, are permitted to search staff and facilities, and may have weapons visible on their person."
	down_description = "Code blue procedures are now in effect. Security personnel are to report to their supervisor for orders, are permitted to search staff and facilities, and may have weapons visible on their person."

/decl/security_level/default/torchdept/code_red
	name = "code red"
	icon = 'icons/misc/security_state.dmi'

	light_range = 4
	light_power = 2
	light_color_alarm = COLOR_RED
	light_color_status_display = COLOR_RED
	overlay_alarm = "alarm_red"
	overlay_status_display = "status_display_red"

	var/static/datum/announcement/priority/security/security_announcement_red = new(do_log = 0, do_newscast = 1, new_sound = sound('sound/misc/redalert1.ogg'))

/decl/security_level/default/torchdept/code_red/switching_up_to()
	security_announcement_red.Announce("A severe emergency has occurred. All staff are to report to their supervisor for orders. All crew should obey orders from relevant emergency personnel. Security personnel are permitted to search staff and facilities, and may have weapons unholstered at any time.", "Attention! Code red alert procedures now in effect!")
	notify_station()

/decl/security_level/default/torchdept/code_red/switching_down_to()
	security_announcement_red.Announce("The self-destruct mechanism has been deactivated. All staff are to report to their supervisor for orders. All crew should obey orders from relevant emergency personnel. Security personnel are permitted to search staff and facilities, and may have weapons unholstered at any time.", "Attention! Code red alert procedures now in effect!")
	notify_station()
