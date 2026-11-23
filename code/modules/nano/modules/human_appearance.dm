/datum/nano_module/appearance_changer
	name = "Appearance Editor"
	available_to_ai = FALSE
	var/flags
	var/mob/living/carbon/human/owner
	var/list/races
	var/list/heads
	var/list/faces
	var/list/langs


/datum/nano_module/appearance_changer/Destroy()
	owner = null
	races = null
	heads = null
	faces = null
	langs = null
	. = ..()

/datum/nano_module/appearance_changer/New(mob/living/carbon/human/_owner, _flags, _races)
	..(_owner, null)
	owner = _owner
	flags = _flags
	if (flags & APPEARANCE_RACE)
		if (islist(_races))
			races = _races
		else
			races = owner.generate_valid_species(_races)
	generate_data()

/datum/nano_module/appearance_changer/proc/generate_data()
	heads = owner.generate_valid_hairstyles()
	faces = owner.generate_valid_facial_hairstyles()
	if (~flags & APPEARANCE_LANG_ANY_ORIGIN)
		langs = owner.generate_valid_languages()


/datum/nano_module/appearance_changer/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	. = ..()
	if (.)
		return
	if (QDELETED(owner))
		return

	if (action == "race" && (flags & APPEARANCE_RACE) && (!races || (params["race"] in races)))
		owner.change_species(params["race"])
		generate_data()
		return TRUE

	if (action == "gender" && (flags & APPEARANCE_GENDER) && (params["gender"] in owner.species.genders))
		owner.change_gender(params["gender"])
		generate_data()
		return TRUE

	if (action == "skin_tone" && (flags & APPEARANCE_SKIN) && (owner.species.appearance_flags & HAS_A_SKIN_TONE))
		var/high = owner.species.max_skin_tone()
		var/dat = input(usr, "Skin Tone:\n1 (pale) ~ [high] (dark)", "Skin Tone", 35 - owner.s_tone) as null | num
		if (isnull(dat) || !can_still_topic(state))
			return
		dat = 35 - max(min(round(dat), high), 1)
		return owner.change_skin_tone(dat)

	if (action == "skin_color" && (flags & APPEARANCE_SKIN) && (owner.species.appearance_flags & HAS_SKIN_COLOR))
		var/color = rgb(owner.r_skin, owner.g_skin, owner.b_skin)
		var/dat = input(usr, "Skin Color:", "Skin Color", color) as null | color
		if (isnull(dat) || !can_still_topic(state))
			return
		color = rgb2num(dat)
		if (owner.change_skin_color(arglist(color)))
			if (flags & APPEARANCE_DNA2)
				owner.update_dna()
			return TRUE
		return

	if (action == "hair" && (flags & APPEARANCE_HEAD) && (params["hair"] in heads))
		if (owner.change_hair(params["hair"]))
			if (flags & APPEARANCE_DNA2)
				owner.update_dna()
			return TRUE
		return

	if (action == "hair_color" && (flags & APPEARANCE_HEAD_COLOR))
		var/color = rgb(owner.r_hair, owner.g_hair, owner.b_hair)
		var/dat = input(usr, "Hair Color:", "Hair Color", color) as null | color
		if (isnull(dat) || !can_still_topic(state))
			return
		color = rgb2num(dat)
		if (owner.change_hair_color(arglist(color)))
			if (flags & APPEARANCE_DNA2)
				owner.update_dna()
			return TRUE
		return

	if (action == "facial_hair" && (flags & APPEARANCE_FACE) && (params["facial_hair"] in faces))
		if (owner.change_facial_hair(params["facial_hair"]))
			if (flags & APPEARANCE_DNA2)
				owner.update_dna()
			return TRUE
		return

	if (action == "facial_hair_color" && (flags & APPEARANCE_FACE_COLOR))
		var/color = rgb(owner.r_facial, owner.g_facial, owner.b_facial)
		var/dat = input(usr, "Facial Hair Color:", "Facial Hair Color", color) as null | color
		if (isnull(dat) || !can_still_topic(state))
			return
		color = rgb2num(dat)
		if (owner.change_facial_hair_color(arglist(color)))
			if (flags & APPEARANCE_DNA2)
				owner.update_dna()
			return TRUE
		return

	if (action == "eye_color" && (flags & APPEARANCE_EYES))
		var/color = rgb(owner.r_eyes, owner.g_eyes, owner.b_eyes)
		var/dat = input(usr, "Eye Color:", "Eye Color", color) as null | color
		if (isnull(dat) || !can_still_topic(state))
			return
		color = rgb2num(dat)
		if (owner.change_eye_color(arglist(color)))
			if (flags & APPEARANCE_DNA2)
				owner.update_dna()
			return TRUE
		return

	if (action == "language" && (flags & APPEARANCE_LANG))
		if (params["language_mode"] == "add")
			if ((~flags & APPEARANCE_LANG_ANY_NUMBER) && length(owner.languages) >= MAX_LANGUAGES)
				return
			if ((~flags & APPEARANCE_LANG_ANY_ORIGIN) && !(params["language"] in langs))
				return
			if (owner.add_language(params["language"]))
				return TRUE
			return
		else
			owner.remove_language(params["language"])
			return TRUE


/datum/nano_module/appearance_changer/tgui_interact(mob/user, datum/tgui/ui, datum/tgui_state/state = GLOB.default_state)
	if (QDELETED(owner) || !owner.species)
		return

	ui = SStgui.try_update_ui(user, src, ui)
	if (ui)
		return
	ui = new(user, src, "HumanAppearance", "[src]", 800, 450, state = state)
	ui.open()

/datum/nano_module/appearance_changer/tgui_data(mob/user)
	var/list/data = host.initial_data()

	data["specimen"] = owner.species.name
	data["gender"] = owner.gender

	data["change_skin_tone"] = (flags & APPEARANCE_SKIN) && (owner.species.appearance_flags & HAS_A_SKIN_TONE)
	data["change_skin_color"] = (flags & APPEARANCE_SKIN) && (owner.species.appearance_flags & HAS_SKIN_COLOR)
	data["change_eye_color"] = !!(flags & APPEARANCE_EYES)
	data["change_hair_color"] = !!(flags & APPEARANCE_HEAD_COLOR)
	data["change_facial_hair_color"] = !!(flags & APPEARANCE_FACE_COLOR)

	data["change_race"] = !!(flags & APPEARANCE_RACE)
	if (data["change_race"])
		var/list/entries = (data["species"] = list())
		for (var/race_key in races)
			entries += list(list("specimen" = race_key))

	data["change_gender"] = !!(flags & APPEARANCE_GENDER)
	if (data["change_gender"])
		var/list/entries = (data["genders"] = list())
		for (var/gender_key in owner.species.genders)
			entries += list(list("gender_name" = gender2text(gender_key), "gender_key" = gender_key))

	data["change_hair"] = !!(flags & APPEARANCE_HEAD)
	if (data["change_hair"])
		var/list/entries = (data["hair_styles"] = list())
		for (var/head_key in heads)
			entries += list(list("hairstyle" = head_key))
		data["hair_style"] = owner.h_style

	data["change_facial_hair"] = !!(flags & APPEARANCE_FACE)
	if (data["change_facial_hair"])
		var/list/entries = (data["facial_hair_styles"] = list())
		for (var/face_key in faces)
			entries += list(list("facialhairstyle" = face_key))
		data["facial_hair_style"] = owner.f_style

	data["change_languages"] = !!(flags & APPEARANCE_LANG)
	if (data["change_languages"])
		var/list/entries = (data["languages"] = list())
		var/lang_list = (flags & APPEARANCE_LANG_ANY_ORIGIN) ? all_languages : langs
		for (var/lang_key in lang_list)
			entries += list(list("language" = lang_key, "selected" = (lang_list[lang_key] in owner.languages)))

	return data
