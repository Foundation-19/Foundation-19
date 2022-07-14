/datum/preferences
	var/clientfps = 0
	var/ooccolor = "#010000" //Whatever this is set to acts as 'reset' color and is thus unusable as an actual custom color

	var/UI_style = "Midnight"
	var/UI_style_color = "#ffffff"
	var/UI_style_alpha = 255

	var/tgui_fancy = TRUE
	var/tgui_lock = FALSE
	var/fast_mc_refresh = FALSE
	var/tgui_input = TRUE
	var/tgui_input_large = FALSE
	var/tgui_input_swapped = TRUE

/datum/category_item/player_setup_item/player_global/ui
	name = "UI"
	sort_order = 1

/datum/category_item/player_setup_item/player_global/ui/load_preferences(datum/pref_record_reader/R)
	pref.UI_style = R.read("UI_style")
	pref.UI_style_color = R.read("UI_style_color")
	pref.UI_style_alpha = R.read("UI_style_alpha")
	pref.ooccolor = R.read("ooccolor")
	pref.clientfps = R.read("clientfps")
	pref.tgui_fancy = R.read("tgui_fancy")
	pref.tgui_lock = R.read("tgui_lock")
	pref.fast_mc_refresh = R.read("fast_mc_refresh")
	pref.tgui_input = R.read("tgui_input")
	pref.tgui_input_large = R.read("tgui_input_large")
	pref.tgui_input_swapped = R.read("tgui_input_swapped")

/datum/category_item/player_setup_item/player_global/ui/save_preferences(datum/pref_record_writer/W)
	W.write("UI_style", pref.UI_style)
	W.write("UI_style_color", pref.UI_style_color)
	W.write("UI_style_alpha", pref.UI_style_alpha)
	W.write("ooccolor", pref.ooccolor)
	W.write("clientfps", pref.clientfps)
	W.write("tgui_fancy", pref.tgui_fancy)
	W.write("tgui_lock", pref.tgui_lock)
	W.write("fast_mc_refresh", pref.fast_mc_refresh)
	W.write("tgui_input", pref.tgui_input)
	W.write("tgui_input_large", pref.tgui_input_large)
	W.write("tgui_input_swapped", pref.tgui_input_swapped)

/datum/category_item/player_setup_item/player_global/ui/sanitize_preferences()
	pref.UI_style			= sanitize_inlist(pref.UI_style, all_ui_styles, initial(pref.UI_style))
	pref.UI_style_color		= sanitize_hexcolor(pref.UI_style_color, initial(pref.UI_style_color))
	pref.UI_style_alpha		= sanitize_integer(pref.UI_style_alpha, 0, 255, initial(pref.UI_style_alpha))
	pref.ooccolor			= sanitize_hexcolor(pref.ooccolor, initial(pref.ooccolor))
	pref.clientfps	   		= sanitize_integer(pref.clientfps, CLIENT_MIN_FPS, CLIENT_MAX_FPS, initial(pref.clientfps))
	pref.tgui_fancy			= sanitize_bool(pref.tgui_fancy, TRUE)
	pref.tgui_lock			= sanitize_bool(pref.tgui_lock, FALSE)
	pref.fast_mc_refresh	= sanitize_bool(pref.fast_mc_refresh, FALSE)
	pref.tgui_input			= sanitize_bool(pref.tgui_input, TRUE)
	pref.tgui_input_large	= sanitize_bool(pref.tgui_input_large, FALSE)
	pref.tgui_input_swapped	= sanitize_bool(pref.tgui_input_swapped, TRUE)

/datum/category_item/player_setup_item/player_global/ui/content(var/mob/user)
	. += "<b>UI Settings</b><br>"
	. += "<b>UI Style:</b> <a href='?src=\ref[src];select_style=1'><b>[pref.UI_style]</b></a><br>"
	. += "<b>Custom UI</b> (recommended for White UI):<br>"
	. += "-Color: <a href='?src=\ref[src];select_color=1'><b>[pref.UI_style_color]</b></a> <table style='display:inline;' bgcolor='[pref.UI_style_color]'><tr><td>__</td></tr></table> <a href='?src=\ref[src];reset=ui'>reset</a><br>"
	. += "-Alpha(transparency): <a href='?src=\ref[src];select_alpha=1'><b>[pref.UI_style_alpha]</b></a> <a href='?src=\ref[src];reset=alpha'>reset</a><br>"
	if(can_select_ooc_color(user))
		. += "<b>OOC Color:</b> "
		if(pref.ooccolor == initial(pref.ooccolor))
			. += "<a href='?src=\ref[src];select_ooc_color=1'><b>Using Default</b></a><br>"
		else
			. += "<a href='?src=\ref[src];select_ooc_color=1'><b>[pref.ooccolor]</b></a> <table style='display:inline;' bgcolor='[pref.ooccolor]'><tr><td>__</td></tr></table> <a href='?src=\ref[src];reset=ooc'>reset</a><br>"
	. += "<b>Client FPS:</b> <a href='?src=\ref[src];select_fps=1'><b>[pref.clientfps]</b></a><br>"
	. += "<b>Fancy TGUI:</b> <a href='?src=\ref[src];select_fancy_tgui=1'><b>[pref.tgui_fancy]</b></a><br>"
	. += "<b>Lock TGUI:</b> <a href='?src=\ref[src];select_tgui_lock=1'><b>[pref.tgui_lock]</b></a><br>"
	. += "<b>Fast MC Refresh:</b> <a href='?src=\ref[src];select_fast_mc_refresh=1'><b>[pref.fast_mc_refresh]</b></a><br>"
	. += "<b>Use TGUI inputs:</b> <a href='?src=\ref[src];select_tgui_input=1'><b>[pref.tgui_input]</b></a><br>"
	. += "<b>Large TGUI inputs buttons:</b> <a href='?src=\ref[src];select_tgui_input_large=1'><b>[pref.tgui_input_large]</b></a><br>"
	. += "<b>Swap Sumbmit/Cancle buttons:</b> <a href='?src=\ref[src];select_tgui_input_swapped=1'><b>[pref.tgui_input_swapped]</b></a><br>"

/datum/category_item/player_setup_item/player_global/ui/OnTopic(var/href,var/list/href_list, var/mob/user)
	if(href_list["select_style"])
		var/UI_style_new = input(user, "Choose UI style.", CHARACTER_PREFERENCE_INPUT_TITLE, pref.UI_style) as null|anything in all_ui_styles
		if(!UI_style_new || !CanUseTopic(user)) return TOPIC_NOACTION
		pref.UI_style = UI_style_new
		return TOPIC_REFRESH

	else if(href_list["select_color"])
		var/UI_style_color_new = input(user, "Choose UI color, dark colors are not recommended!", "Global Preference", pref.UI_style_color) as color|null
		if(isnull(UI_style_color_new) || !CanUseTopic(user)) return TOPIC_NOACTION
		pref.UI_style_color = UI_style_color_new
		return TOPIC_REFRESH

	else if(href_list["select_alpha"])
		var/UI_style_alpha_new = input(user, "Select UI alpha (transparency) level, between 50 and 255.", "Global Preference", pref.UI_style_alpha) as num|null
		if(isnull(UI_style_alpha_new) || (UI_style_alpha_new < 50 || UI_style_alpha_new > 255) || !CanUseTopic(user)) return TOPIC_NOACTION
		pref.UI_style_alpha = UI_style_alpha_new
		return TOPIC_REFRESH

	else if(href_list["select_ooc_color"])
		var/new_ooccolor = input(user, "Choose OOC color:", "Global Preference") as color|null
		if(new_ooccolor && can_select_ooc_color(user) && CanUseTopic(user))
			pref.ooccolor = new_ooccolor
			return TOPIC_REFRESH

	else if(href_list["select_fps"])
		var/version_message
		if (user.client && user.client.byond_version < 511)
			version_message = "\nYou need to be using byond version 511 or later to take advantage of this feature, your version of [user.client.byond_version] is too low"
		if (world.byond_version < 511)
			version_message += "\nThis server does not currently support client side fps. You can set now for when it does."
		var/new_fps = input(user, "Choose your desired fps.[version_message]\n(0 = synced with server tick rate (currently:[world.fps]))", "Global Preference") as num|null
		if (isnum(new_fps) && CanUseTopic(user))
			pref.clientfps = Clamp(new_fps, CLIENT_MIN_FPS, CLIENT_MAX_FPS)

			var/mob/target_mob = preference_mob()
			if(target_mob && target_mob.client)
				target_mob.client.apply_fps(pref.clientfps)
			return TOPIC_REFRESH

	else if(href_list["select_fancy_tgui"])
		pref.tgui_fancy = !pref.tgui_fancy
		return TOPIC_REFRESH

	else if(href_list["select_tgui_lock"])
		pref.tgui_lock = !pref.tgui_lock
		return TOPIC_REFRESH

	else if(href_list["select_fast_mc_refresh"])
		pref.fast_mc_refresh = !pref.fast_mc_refresh
		return TOPIC_REFRESH

	else if(href_list["select_tgui_input"])
		pref.tgui_input = !pref.tgui_input
		return TOPIC_REFRESH

	else if(href_list["select_tgui_input_large"])
		pref.tgui_input_large = !pref.tgui_input_large
		return TOPIC_REFRESH

	else if(href_list["select_tgui_input_swapped"])
		pref.tgui_input_swapped = !pref.tgui_input_swapped
		return TOPIC_REFRESH

	else if(href_list["reset"])
		switch(href_list["reset"])
			if("ui")
				pref.UI_style_color = initial(pref.UI_style_color)
			if("alpha")
				pref.UI_style_alpha = initial(pref.UI_style_alpha)
			if("ooc")
				pref.ooccolor = initial(pref.ooccolor)
		return TOPIC_REFRESH

	return ..()

/proc/can_select_ooc_color(var/mob/user)
	return config.allow_admin_ooccolor && check_rights(R_ADMIN, 0, user)
