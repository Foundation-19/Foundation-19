/datum/nano_module/env_editor
	name = "Environment Editor"
	available_to_ai = 0
	var/datum/sound_player/player


/datum/nano_module/env_editor/New(datum/sound_player/player)
	src.host = player.actual_instrument
	src.player = player


/datum/nano_module/env_editor/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "EnvEditor", "Environment Editor", 300, 800)
		ui.open()

/datum/nano_module/env_editor/tgui_data(mob/user)
	var/list/data = list()
	data["env_params"] = list()
	for (var/i=1 to 23)
		var/list/env_data = list()
		env_data["index"] = i
		env_data["name"] = GLOB.musical_config.env_param_names[i]
		env_data["value"] = src.player.env[i]
		env_data["real"] = GLOB.musical_config.env_params_bounds[i][3]
		data["env_params"] += list(env_data)
	return data

/datum/nano_module/env_editor/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if (!GLOB.musical_config.env_settings_available)
		return FALSE

	if (..())
		return TRUE

	var/index = text2num(params["index"])
	if (params["index"] && !(index in 1 to 23))
		to_chat(usr, "Wrong index was provided: [index]")
		return FALSE

	var/name = GLOB.musical_config.env_param_names[index]
	var/default = GLOB.musical_config.env_default[index]
	var/list/bounds = GLOB.musical_config.env_params_bounds[index]
	var/bound_min = bounds[1]
	var/bound_max = bounds[2]

	switch (action)
		if ("set")
			var/new_value = min(max(input(usr, "[name]: [bound_min] - [bound_max]") as num, bound_min), bound_max)
			if (!isnum(new_value))
				return
			new_value = bounds[3] ? new_value : round(new_value)
			src.player.env[index] = new_value
		if ("reset")
			src.player.env[index] = default
		if ("reset_all")
			src.player.env = GLOB.musical_config.env_default.Copy()
		if ("desc")
			var/desc = GLOB.musical_config.env_param_desc[index]
			to_chat(usr, "[name]: from [bound_min] to [bound_max] (default: [default])<br>[desc]")

	return TRUE
