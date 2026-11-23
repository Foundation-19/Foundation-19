/datum/nano_module/usage_info
	name = "Usage Info"
	available_to_ai = 0
	var/datum/sound_player/player

/datum/nano_module/usage_info/New(atom/source, datum/sound_player/player)
	src.host = source
	src.player = player

//This will let you easily monitor when you're going overboard with tempo and sound duration, generally if the bars fill up it is BAD
/datum/nano_module/usage_info/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "InstrumentUsageInfo", "Usage info", 500, 150)
		ui.open()

/datum/nano_module/usage_info/tgui_data(mob/user)
	var/list/data = list()
	data["channels_left"] = GLOB.sound_channels.available_channels.stack.len
	data["events_active"] = src.player.event_manager.events.len
	data["max_channels"] = GLOB.sound_channels.channel_ceiling
	data["max_events"] = GLOB.musical_config.max_events
	return data


/datum/nano_module/usage_info/Destroy()
	player = null
	..()
