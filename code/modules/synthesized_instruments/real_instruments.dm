/datum/real_instrument
	var/datum/instrument/instruments
	var/datum/sound_player/player
	var/datum/nano_module/song_editor/song_editor
	var/datum/nano_module/usage_info/usage_info
	var/maximum_lines
	var/maximum_line_length
	var/obj/owner
	var/datum/nano_module/env_editor/env_editor
	var/datum/nano_module/echo_editor/echo_editor

/datum/real_instrument/New(obj/who, datum/sound_player/how, datum/instrument/what)
	player = how
	owner = who
	maximum_lines = GLOB.musical_config.max_lines
	maximum_line_length = GLOB.musical_config.max_line_length
	instruments = what

/datum/real_instrument/proc/act(action, list/params, mob/user)
	var/value = text2num(params["value"])
	if (params["value"] && !isnum(value))
		to_chat(user, "Non-numeric value was given")
		return FALSE

	switch (action)
		if ("tempo") src.player.song.tempo = src.player.song.sanitize_tempo(src.player.song.tempo + value*world.tick_lag)
		if ("play")
			src.player.song.playing = value
			if (src.player.song.playing)
				src.player.song.play_song(user)
		if ("newsong")
			src.player.song.lines.Cut()
			src.player.song.tempo = src.player.song.sanitize_tempo(5)
		if ("import")
			var/t = ""
			do
				t = html_encode(input(user, "Please paste the entire song, formatted:", text("[]", owner.name), t)  as message)
				if(!CanInteractWith(user, owner, GLOB.physical_state))
					return

				if(length(t) >= 2*src.maximum_lines*src.maximum_line_length)
					var/cont = input(user, "Your message is too long! Would you like to continue editing it?", "", "yes") in list("yes", "no")
					if(!CanInteractWith(user, owner, GLOB.physical_state))
						return
					if(cont == "no")
						break
			while(length(t) > 2*src.maximum_lines*src.maximum_line_length)
			if (length(t))
				src.player.song.lines = splittext(t, "\n")
				if(copytext(src.player.song.lines[1],1,6) == "BPM: ")
					if(text2num(copytext(src.player.song.lines[1],6)) != 0)
						src.player.song.tempo = src.player.song.sanitize_tempo(600 / text2num(copytext(src.player.song.lines[1],6)))
						src.player.song.lines.Cut(1,2)
					else
						src.player.song.tempo = src.player.song.sanitize_tempo(5)
				else
					src.player.song.tempo = src.player.song.sanitize_tempo(5)
				if(src.player.song.lines.len > maximum_lines)
					to_chat(user,"Too many lines!")
					src.player.song.lines.Cut(maximum_lines+1)
				var/linenum = 1
				for(var/l in src.player.song.lines)
					if(length(l) > maximum_line_length)
						to_chat(user, "Line [linenum] too long!")
						src.player.song.lines.Remove(l)
					else
						linenum++
		if ("show_song_editor")
			if (!src.song_editor)
				src.song_editor = new (host = src.owner, song = src.player.song)
			src.song_editor.tgui_interact(user)

		if ("show_usage")
			if (!src.usage_info)
				src.usage_info = new (owner, src.player)
			src.usage_info.tgui_interact(user)
		if ("volume")
			src.player.volume = min(max(min(player.volume+text2num(value), 100), 0), player.max_volume)
		if ("transposition")
			src.player.song.transposition = max(min(player.song.transposition+value, GLOB.musical_config.highest_transposition), GLOB.musical_config.lowest_transposition)
		if ("min_octave")
			src.player.song.octave_range_min = max(min(player.song.octave_range_min+value, GLOB.musical_config.highest_octave), GLOB.musical_config.lowest_octave)
			src.player.song.octave_range_max = max(player.song.octave_range_max, player.song.octave_range_min)
		if ("max_octave")
			src.player.song.octave_range_max = max(min(player.song.octave_range_max+value, GLOB.musical_config.highest_octave), GLOB.musical_config.lowest_octave)
			src.player.song.octave_range_min = min(player.song.octave_range_max, player.song.octave_range_min)
		if ("sustain_timer")
			src.player.song.sustain_timer = max(min(player.song.sustain_timer+value, GLOB.musical_config.longest_sustain_timer), 1)
		if ("soft_coeff")
			var/new_coeff = input(user, "from [GLOB.musical_config.gentlest_drop] to [GLOB.musical_config.steepest_drop]") as num
			if(!CanInteractWith(user, owner, GLOB.physical_state))
				return
			new_coeff = round(min(max(new_coeff, GLOB.musical_config.gentlest_drop), GLOB.musical_config.steepest_drop), 0.001)
			src.player.song.soft_coeff = new_coeff
		if ("instrument")
			if (!islist(instruments))
				return
			var/list/as_list = instruments
			var/list/categories = list()
			for (var/key in as_list)
				var/datum/instrument/instrument = instruments[key]
				categories |= instrument.category

			var/category = input(user, "Choose a category") as null|anything in categories
			if(!CanInteractWith(user, owner, GLOB.physical_state))
				return
			var/list/instruments_available = list()
			for (var/key in as_list)
				var/datum/instrument/instrument = instruments[key]
				if (instrument.category == category)
					instruments_available += key

			var/new_instrument = input(user, "Choose an instrument") as null|anything in instruments_available
			if(!CanInteractWith(user, owner, GLOB.physical_state))
				return
			if (new_instrument)
				src.player.song.instrument_data = instruments[new_instrument]
		if ("autorepeat") src.player.song.autorepeat = value
		if ("decay") src.player.song.linear_decay = value
		if ("echo") src.player.apply_echo = value
		if ("show_env_editor")
			if (GLOB.musical_config.env_settings_available)
				if (!src.env_editor)
					src.env_editor = new (src.player)
				src.env_editor.tgui_interact(user)
			else
				to_chat(user, "Virtual environment is disabled")

		if ("show_echo_editor")
			if (!src.echo_editor)
				src.echo_editor = new (src.player)
			src.echo_editor.tgui_interact(user)

		if ("select_env")
			if (value in -1 to 26)
				src.player.virtual_environment_selected = round(value)
		else
			return FALSE

	return TRUE



/datum/real_instrument/proc/get_ui_data(mob/user)
	var/list/data = list()
	data["playback"] = list(
		"playing" = src.player.song.playing,
		"autorepeat" = src.player.song.autorepeat,
	)
	data["basic_options"] = list(
		"cur_instrument" = src.player.song.instrument_data.name,
		"volume" = src.player.volume,
		"BPM" = round(600 / src.player.song.tempo),
		"transposition" = src.player.song.transposition,
		"octave_range" = list(
			"min" = src.player.song.octave_range_min,
			"max" = src.player.song.octave_range_max
		)
	)
	data["advanced_options"] = list(
		"all_environments" = GLOB.musical_config.all_environments,
		"selected_environment" = GLOB.musical_config.id_to_environment(src.player.virtual_environment_selected),
		"apply_echo" = src.player.apply_echo
	)
	data["sustain"] = list(
		"linear_decay_active" = src.player.song.linear_decay,
		"sustain_timer" = src.player.song.sustain_timer,
		"soft_coeff" = src.player.song.soft_coeff
	)
	data["show"] = list(
		"playback" = src.player.song.lines.len > 0,
		"custom_env_options" = GLOB.musical_config.is_custom_env(src.player.virtual_environment_selected),
		"env_settings" = GLOB.musical_config.env_settings_available
	)
	data["status"] = list(
		"channels" = src.player.song.available_channels,
		"events" = src.player.event_manager.events.len,
		"max_channels" = GLOB.musical_config.channels_per_instrument,
		"max_events" = GLOB.musical_config.max_events,
	)
	return data


/datum/real_instrument/proc/open_tgui(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "SynthesizedInstrument", owner.name, 600, 800)
		ui.open()



/datum/real_instrument/Destroy()
	QDEL_NULL(player)
	owner = null
	return ..()

/obj/structure/synthesized_instrument
	var/datum/real_instrument/real_instrument
	icon = 'icons/obj/musician.dmi'
	var/datum/instrument/instruments = list()
	var/path = /datum/instrument
	var/sound_player = /datum/sound_player

/obj/structure/synthesized_instrument/Initialize()
	. = ..()
	for (var/type in typesof(path))
		var/datum/instrument/new_instrument = new type
		if (!new_instrument.id) continue
		new_instrument.create_full_sample_deviation_map()
		src.instruments[new_instrument.name] = new_instrument
	src.real_instrument = new /datum/real_instrument(src, new sound_player(src, instruments[pick(instruments)]), instruments)

/obj/structure/synthesized_instrument/Destroy()
	QDEL_NULL(src.real_instrument)
	if (islist(instruments))
		var/list/as_list = instruments
		for (var/key in as_list)
			qdel(as_list[key])
	instruments = null
	. = ..()


/obj/structure/synthesized_instrument/attack_hand(mob/user)
	src.interact(user)


/obj/structure/synthesized_instrument/interact(mob/user)
	src.tgui_interact(user)


/obj/structure/synthesized_instrument/tgui_data(mob/user)
	return real_instrument.get_ui_data(user)


/obj/structure/synthesized_instrument/tgui_interact(mob/user, datum/tgui/ui)
	real_instrument.open_tgui(user, ui)


/obj/structure/synthesized_instrument/proc/shouldStopPlaying(mob/user)
	return 0


/obj/structure/synthesized_instrument/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if (..())
		return TRUE

	return real_instrument.act(action, params, usr)


////////////////////////
//DEVICE VERSION
////////////////////////


/obj/item/device/synthesized_instrument
	var/datum/real_instrument/real_instrument
	icon = 'icons/obj/musician.dmi'
	var/datum/instrument/instruments = list()
	var/path = /datum/instrument
	var/sound_player = /datum/sound_player

/obj/item/device/synthesized_instrument/Initialize()
	. = ..()
	for (var/type in typesof(path))
		var/datum/instrument/new_instrument = new type
		if (!new_instrument.id) continue
		new_instrument.create_full_sample_deviation_map()
		src.instruments[new_instrument.name] = new_instrument
	src.real_instrument = new /datum/real_instrument(src, new sound_player(src, instruments[pick(instruments)]), instruments)

/obj/item/device/synthesized_instrument/Destroy()
	QDEL_NULL(src.real_instrument)
	if (islist(instruments))
		var/list/as_list = instruments
		for (var/key in as_list)
			qdel(as_list[key])
	instruments = null
	. = ..()


/obj/item/device/synthesized_instrument/attack_self(mob/user as mob)
	src.interact(user)


/obj/item/device/synthesized_instrument/interact(mob/user)
	src.tgui_interact(user)


/obj/item/device/synthesized_instrument/tgui_data(mob/user)
	if (real_instrument)
		return real_instrument.get_ui_data(user)


/obj/item/device/synthesized_instrument/tgui_interact(mob/user, datum/tgui/ui)
	if (real_instrument)
		real_instrument.open_tgui(user, ui)


/obj/item/device/synthesized_instrument/proc/shouldStopPlaying(mob/user)
	return !(src && in_range(src, user))

/obj/item/device/synthesized_instrument/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if (..())
		return TRUE

	return real_instrument.act(action, params, usr)