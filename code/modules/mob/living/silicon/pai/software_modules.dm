/datum/pai_software
	// Name for the software. This is used as the button text when buying or opening/toggling the software
	var/name = "pAI software module"
	// RAM cost; pAIs start with 100 RAM, spending it on programs
	var/ram_cost = 0
	// ID for the software. This must be unique
	var/id = ""
	// Whether this software is a toggle or not
	// Toggled software should override toggle() and is_active()
	// Non-toggled software should override on_ui_interact() and Topic()
	var/toggle = 1
	// Whether pAIs should automatically receive this module at no cost
	var/default = 0

/datum/pai_software/proc/toggle(mob/living/silicon/pai/user)
	return

/datum/pai_software/proc/is_active(mob/living/silicon/pai/user)
	return 0

/datum/pai_software/proc/on_purchase(mob/living/silicon/pai/user)
	return

/datum/pai_software/directives
	name = "Directives"
	ram_cost = 0
	id = "directives"
	toggle = 0
	default = 1

/datum/pai_software/directives/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, user, ui)
	if(!ui)
		ui = new(user, user, "PAISoftwareModules", "pAI Directives", 450, 600)
		ui.open()

/datum/pai_software/directives/tgui_data(mob/living/silicon/pai/user)
	var/data[0]

	data["module"] = "directives"
	data["master"] = user.master
	data["dna"] = user.master_dna
	data["prime"] = user.pai_law0
	data["supplemental"] = user.pai_laws

	return data

/datum/pai_software/directives/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	var/mob/living/silicon/pai/P = usr
	if(!istype(P)) return

	if(action == "getdna")
		var/mob/living/M = P.loc
		var/count = 0

		while(!istype(M, /mob/living))
			if(!M || !M.loc || count > 6)
				to_chat(src, "You are not being carried by anyone!")
				return FALSE
			M = M.loc
			count++

		var/answer = input(M, "[P] is requesting a DNA sample from you. Will you allow it to confirm your identity?", "[P] Check DNA", "No") in list("Yes", "No")
		if(answer == "Yes")
			var/turf/T = get_turf_or_move(P.loc)
			for (var/mob/v in viewers(T))
				v.show_message(SPAN_NOTICE("[M] presses \his thumb against [P]."), 3, SPAN_NOTICE("[P] makes a sharp clicking sound as it extracts DNA material from [M]."), 2)
			var/datum/dna/dna = M.dna
			to_chat(P, "<font color = red><h3>[M]'s UE string : [dna.unique_enzymes]</h3></font>")
			if(dna.unique_enzymes == P.master_dna)
				to_chat(P, "<b>DNA is a match to stored Master DNA.</b>")
			else
				to_chat(P, "<b>DNA does not match stored Master DNA.</b>")
		else
			to_chat(P, "[M] does not seem like \he is going to provide a DNA sample willingly.")
		return TRUE

/datum/pai_software/radio_config
	name = "Radio Configuration"
	ram_cost = 0
	id = "radio"
	toggle = 0
	default = 1

/datum/pai_software/radio_config/tgui_interact(mob/living/silicon/pai/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, user, ui)
	if(!ui)
		ui = new(user, user, "PAISoftwareModules", "Radio Configuration", 300, 150)
		ui.open()

/datum/pai_software/radio_config/tgui_data(mob/living/silicon/pai/user)
	var/data[0]

	data["module"] = "radio"
	data["listening"] = user.silicon_radio.broadcasting
	data["frequency"] = format_frequency(user.silicon_radio.frequency)

	var/channels[0]
	for(var/ch_name in user.silicon_radio.channels)
		var/ch_stat = user.silicon_radio.channels[ch_name]
		var/ch_dat[0]
		ch_dat["name"] = ch_name
		ch_dat["listening"] = !!(ch_stat & user.silicon_radio.FREQ_LISTENING)
		channels[++channels.len] = ch_dat

	data["channels"] = channels
	return data

/datum/pai_software/radio_config/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	var/mob/living/silicon/pai/P = usr
	if(!istype(P)) return

	P.silicon_radio.tgui_act(action, params, ui, state)
	return TRUE

/datum/pai_software/crew_manifest
	name = "Crew Manifest"
	ram_cost = 5
	id = "manifest"
	toggle = 0

/datum/pai_software/crew_manifest/tgui_interact(mob/living/silicon/pai/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, user, ui)
	if(!ui)
		ui = new(user, user, "PAISoftwareModules", "Crew Manifest", 450, 600)
		ui.open()

/datum/pai_software/crew_manifest/tgui_data(mob/user)
	var/data[0]
	data["module"] = "manifest"
	data["crew_manifest"] = html_crew_manifest()
	return data

/datum/pai_software/door_jack/
	name = "Door Jack"
	ram_cost = 30
	id = "door_jack"
	toggle = 0

/datum/pai_software/door_jack/tgui_interact(mob/living/silicon/pai/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, user, ui)
	if(!ui)
		ui = new(user, user, "PAISoftwareModules", "Door Jack", 300, 150)
		ui.open()

/datum/pai_software/door_jack/tgui_data(mob/living/silicon/pai/user)
	var/data[0]

	data["module"] = "door_jack"
	data["cable"] = user.cable != null
	data["machine"] = user.cable && (user.cable.machine != null)
	data["inprogress"] = user.hackdoor != null
	data["progress_a"] = round(user.hackprogress / 10)
	data["progress_b"] = user.hackprogress % 10
	data["aborted"] = user.hack_aborted

	return data

/datum/pai_software/door_jack/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	var/mob/living/silicon/pai/P = usr
	if(!istype(P)) return

	if(action == "jack")
		if(P.cable && P.cable.machine)
			P.hackdoor = P.cable.machine
			P.hackloop()
		return TRUE
	else if(action == "cancel")
		P.hackdoor = null
		return TRUE
	else if(action == "cable")
		var/turf/T = get_turf_or_move(P.loc)
		P.hack_aborted = 0
		P.cable = new /obj/item/pai_cable(T)
		for(var/mob/M in viewers(T))
			M.show_message(SPAN_WARNING("A port on [P] opens to reveal [P.cable], which promptly falls to the floor."), 3,
							SPAN_WARNING("You hear the soft click of something light and hard falling to the ground."), 2)
		return TRUE

/mob/living/silicon/pai/proc/hackloop()
	var/turf/T = get_turf_or_move(src.loc)
	for(var/mob/living/silicon/ai/AI in GLOB.player_list)
		if(T.loc)
			to_chat(AI, "<font color = red><b>Network Alert: Brute-force encryption crack in progress in [T.loc].</b></font>")
		else
			to_chat(AI, "<font color = red><b>Network Alert: Brute-force encryption crack in progress. Unable to pinpoint location.</b></font>")
	var/obj/machinery/door/D = cable.machine
	if(!istype(D))
		hack_aborted = 1
		hackprogress = 0
		cable.machine = null
		hackdoor = null
		return
	while(hackprogress < 1000)
		if(cable && cable.machine == D && cable.machine == hackdoor && get_dist(src, hackdoor) <= 1)
			hackprogress = min(hackprogress+rand(1, 20), 1000)
		else
			hack_aborted = 1
			hackprogress = 0
			hackdoor = null
			return
		if(hackprogress >= 1000)
			hackprogress = 0
			D.open()
			cable.machine = null
			return
		sleep(10)			// Update every second

/datum/pai_software/atmosphere_sensor
	name = "Atmosphere Sensor"
	ram_cost = 5
	id = "atmos_sense"
	toggle = 0

/datum/pai_software/atmosphere_sensor/tgui_interact(mob/living/silicon/pai/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, user, ui)
	if(!ui)
		ui = new(user, user, "PAISoftwareModules", "Atmosphere Sensor", 350, 300)
		ui.open()

/datum/pai_software/atmosphere_sensor/tgui_data(mob/living/silicon/pai/user)
	var/data[0]

	var/turf/T = get_turf_or_move(user.loc)
	if(!T)
		data["reading"] = 0
		data["pressure"] = 0
		data["temperature"] = 0
		data["temperatureC"] = 0
		data["gas"] = list()
	else
		var/datum/gas_mixture/env = T.return_air()
		data["reading"] = 1
		var/pres = env.return_pressure() * 10
		data["pressure"] = "[round(pres/10)].[pres%10]"
		data["temperature"] = round(env.temperature)
		data["temperatureC"] = round(env.temperature-T0C)

		var/t_moles = env.total_moles
		var/gases[0]
		for(var/g in env.gas)
			var/gas[0]
			gas["name"] = gas_data.name[g]
			gas["percent"] = round((env.gas[g] / t_moles) * 100)
			gases[++gases.len] = gas
		data["gas"] = gases

	data["module"] = "atmos_sense"
	return data

/datum/pai_software/sec_hud
	name = "Security HUD"
	ram_cost = 20
	id = "sec_hud"

/datum/pai_software/sec_hud/toggle(mob/living/silicon/pai/user)
	user.secHUD = !user.secHUD

/datum/pai_software/sec_hud/is_active(mob/living/silicon/pai/user)
	return user.secHUD

/datum/pai_software/med_hud
	name = "Medical HUD"
	ram_cost = 20
	id = "med_hud"

/datum/pai_software/med_hud/toggle(mob/living/silicon/pai/user)
	user.medHUD = !user.medHUD

/datum/pai_software/med_hud/is_active(mob/living/silicon/pai/user)
	return user.medHUD

/datum/pai_software/translator
	name = "Universal Translator"
	ram_cost = 35
	id = "translator"
	var/list/languages = list(LANGUAGE_ENGLISH, LANGUAGE_GUTTER, LANGUAGE_UNATHI_SINTA, LANGUAGE_SKRELLIAN, LANGUAGE_EAL, LANGUAGE_HUMAN_ARABIC, LANGUAGE_HUMAN_CHINESE, LANGUAGE_HUMAN_FRENCH, LANGUAGE_HUMAN_SPANISH, LANGUAGE_HUMAN_INDIAN, LANGUAGE_HUMAN_RUSSIAN)

/datum/pai_software/translator/toggle(mob/living/silicon/pai/user)
	// 	Sol Common, Tradeband and Gutter are added with New() and are therefore the current default, always active languages
	user.translator_on = !user.translator_on
	if(user.translator_on)
		for(var/language in languages)
			user.add_language(language)
	else
		for(var/language in languages)
			user.remove_language(language)

/datum/pai_software/translator/is_active(mob/living/silicon/pai/user)
	return user.translator_on
