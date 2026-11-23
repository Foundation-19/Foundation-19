/datum/nano_module/echo_editor
	name = "Echo Editor"
	available_to_ai = 0
	var/datum/sound_player/player
	var/atom/source


/datum/nano_module/echo_editor/New(datum/sound_player/player)
	src.host = player.actual_instrument
	src.player = player


/datum/nano_module/echo_editor/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "EchoEditor", "Echo Editor", 300, 600)
		ui.open()

/datum/nano_module/echo_editor/tgui_data(mob/user)
	var/list/data = list()
	data["echo_params"] = list()
	for (var/i=1 to 18)
		var/list/echo_data = list()
		echo_data["index"] = i
		echo_data["name"] = GLOB.musical_config.echo_param_names[i]
		echo_data["value"] = src.player.echo[i]
		echo_data["real"] = GLOB.musical_config.echo_params_bounds[i][3]
		data["echo_params"] += list(echo_data)
	return data

/datum/nano_module/echo_editor/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if (..())
		return TRUE

	var/index = text2num(params["index"])
	if (params["index"] && !(index in 1 to 18))
		to_chat(usr, "Wrong index was provided: [index]")
		return FALSE

	var/name = GLOB.musical_config.echo_param_names[index]
	var/default = GLOB.musical_config.echo_default[index]
	var/list/bounds = GLOB.musical_config.echo_params_bounds[index]
	var/bound_min = bounds[1]
	var/bound_max = bounds[2]

	switch (action)
		if ("set")
			var/new_value = min(max(input(usr, "[name]: [bound_min] - [bound_max]") as num, bound_min), bound_max)
			if (!isnum(new_value))
				return
			new_value = bounds[3] ? new_value : round(new_value)
			src.player.echo[index] = new_value
		if ("reset")
			src.player.echo[index] = default
		if ("reset_all")
			src.player.echo = GLOB.musical_config.echo_default.Copy()
		if ("desc")
			var/desc = GLOB.musical_config.echo_param_desc[index]
			to_chat(usr, "[name]: from [bound_min] to [bound_max] (default: [default])<br>[desc]")

	return TRUE
