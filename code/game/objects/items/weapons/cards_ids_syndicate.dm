/obj/item/card/id/syndicate
	assignment = "Agent"
	origin_tech = list(TECH_ESOTERIC = 3)
	var/electronic_warfare = 1
	var/mob/registered_user = null
	color = COLOR_GRAY40
	detail_color = COLOR_NT_RED

/obj/item/card/id/syndicate/New(mob/user as mob)
	..()
	access = syndicate_access.Copy()

/obj/item/card/id/syndicate/station_access/New()
	..() // Same as the normal Syndicate id, only already has all station access
	access |= get_all_site_access()

/obj/item/card/id/syndicate/Destroy()
	unset_registered_user(registered_user)
	return ..()

/obj/item/card/id/syndicate/prevent_tracking()
	return electronic_warfare

/obj/item/card/id/syndicate/afterattack(obj/item/O as obj, mob/user as mob, proximity)
	if(!proximity) return
	if(istype(O, /obj/item/card/id))
		var/obj/item/card/id/I = O
		src.access |= I.access
		if(player_is_antag(user.mind))
			to_chat(user, SPAN_NOTICE("The microscanner activates as you pass it over the ID, copying its access."))

/obj/item/card/id/syndicate/attack_self(mob/user as mob)
	if(!registered_user && register_user(user))
		to_chat(user, SPAN_NOTICE("The microscanner marks you as its owner, preventing others from accessing its internals."))
	if(registered_user == user)
		switch(alert("Would you like edit the ID, or show it?","Show or Edit?", "Edit","Show"))
			if("Edit")
				tgui_interact(user)
			if("Show")
				..()
	else
		..()

/obj/item/card/id/syndicate/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "SyndicateCard", "Agent id", 600, 400)
		ui.open()

/obj/item/card/id/syndicate/tgui_data(mob/user)
	var/data[0]
	var/entries[0]
	entries[++entries.len] = list("name" = "Age", 				"value" = age)
	entries[++entries.len] = list("name" = "Prefix", 			"value" = formal_name_prefix)
	entries[++entries.len] = list("name" = "Suffix", 			"value" = formal_name_suffix)
	entries[++entries.len] = list("name" = "Appearance",		"value" = "Set")
	entries[++entries.len] = list("name" = "Assignment",		"value" = assignment)
	entries[++entries.len] = list("name" = "Class",				"value" = class)
	entries[++entries.len] = list("name" = "Blood Type",		"value" = blood_type)
	entries[++entries.len] = list("name" = "DNA Hash", 			"value" = dna_hash)
	entries[++entries.len] = list("name" = "Fingerprint Hash",	"value" = fingerprint_hash)
	entries[++entries.len] = list("name" = "Name", 				"value" = registered_name)
	entries[++entries.len] = list("name" = "Photo", 			"value" = "Update")
	entries[++entries.len] = list("name" = "Sex", 				"value" = sex)
	entries[++entries.len] = list("name" = "Factory Reset",		"value" = "Use With Care")
	data["electronic_warfare"] = electronic_warfare
	data["entries"] = entries

	return data

/obj/item/card/id/syndicate/proc/register_user(mob/user)
	if(!istype(user) || user == registered_user)
		return FALSE
	unset_registered_user()
	registered_user = user
	user.set_id_info(src)
	RegisterSignal(user, COMSIG_PARENT_QDELETING, TYPE_PROC_REF(/obj/item/card/id/syndicate, unset_registered_user))
	return TRUE

/obj/item/card/id/syndicate/proc/unset_registered_user(mob/user)
	if(!registered_user || (user && user != registered_user))
		return
	UnregisterSignal(registered_user, COMSIG_PARENT_QDELETING)
	registered_user = null

/obj/item/card/id/syndicate/tgui_status(mob/user, datum/tgui_state/state, list/params)
	if(!(params && params["look_at_id"]) && (user != registered_user))
		return STATUS_CLOSE
	return ..()

/obj/item/card/id/syndicate/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE

	var/user = usr
	if(action == "electronic_warfare")
		electronic_warfare = text2num(params["electronic_warfare"])
		to_chat(user, SPAN_NOTICE("Electronic warfare [electronic_warfare ? "enabled" : "disabled"]."))
	else if(action == "set")
		switch(params["set"])
			if("Age")
				var/new_age = input(user,"What age would you like to put on this card?","Agent Card Age", age) as null|num
				if(!isnull(new_age) && tgui_status(user, state) == STATUS_INTERACTIVE)
					if(new_age < 0)
						age = initial(age)
					else
						age = new_age
					to_chat(user, SPAN_NOTICE("Age has been set to '[age]'."))
					. = TRUE
			if("Prefix")
				var/new_prefix = sanitizeSafe(input(user,"What title prefix would you like to put on this card?","Agent Card Prefix", age) as text, MAX_NAME_LEN)
				if(!isnull(new_prefix) && tgui_status(user, state) == STATUS_INTERACTIVE)
					formal_name_prefix = new_prefix
					to_chat(user, SPAN_NOTICE("Title prefix has been set to '[formal_name_prefix]'."))
					. = TRUE
			if("Suffix")
				var/new_suffix = sanitizeSafe(input(user,"What title suffix would you like to put on this card?","Agent Card Suffix", age) as text, MAX_NAME_LEN)
				if(!isnull(new_suffix) && tgui_status(user, state) == STATUS_INTERACTIVE)
					formal_name_suffix = new_suffix
					to_chat(user, SPAN_NOTICE("Title suffix has been set to '[formal_name_suffix]'."))
					. = TRUE
			if("Appearance")
				var/datum/card_state/choice = input(user, "Select the appearance for this card.", "Agent Card Appearance") as null|anything in id_card_states()
				if(choice && tgui_status(user, state) == STATUS_INTERACTIVE)
					src.icon_state = choice.icon_state
					src.name = choice.examine_name
					src.item_state = choice.item_state
					src.color = choice.color
					src.detail_color = choice.detail_color
					src.extra_details = choice.extra_details
					update_icon()
					to_chat(usr, SPAN_NOTICE("Appearance changed to [choice]."))
					. = TRUE
			if("Assignment")
				var/new_job = sanitize(input(user,"What assignment would you like to put on this card?\nChanging assignment will not grant or remove any access levels.","Agent Card Assignment", assignment) as null|text)
				if(!isnull(new_job) && tgui_status(user, state) == STATUS_INTERACTIVE)
					src.assignment = new_job
					to_chat(user, SPAN_NOTICE("Occupation changed to '[new_job]'."))
					. = TRUE
			if("Blood Type")
				var/default = blood_type
				if(default == initial(blood_type) && ishuman(user))
					var/mob/living/carbon/human/H = user
					if(H.dna)
						default = H.dna.b_type
				var/new_blood_type = sanitize(input(user,"What blood type would you like to be written on this card?","Agent Card Blood Type",default) as null|text)
				if(!isnull(new_blood_type) && tgui_status(user, state) == STATUS_INTERACTIVE)
					src.blood_type = new_blood_type
					to_chat(user, SPAN_NOTICE("Blood type changed to '[new_blood_type]'."))
					. = TRUE
			if("DNA Hash")
				var/default = dna_hash
				if(default == initial(dna_hash) && ishuman(user))
					var/mob/living/carbon/human/H = user
					if(H.dna)
						default = H.dna.unique_enzymes
				var/new_dna_hash = sanitize(input(user,"What DNA hash would you like to be written on this card?","Agent Card DNA Hash",default) as null|text)
				if(!isnull(new_dna_hash) && tgui_status(user, state) == STATUS_INTERACTIVE)
					src.dna_hash = new_dna_hash
					to_chat(user, SPAN_NOTICE("DNA hash changed to '[new_dna_hash]'."))
					. = TRUE
			if("Fingerprint Hash")
				var/default = fingerprint_hash
				if(default == initial(fingerprint_hash) && ishuman(user))
					var/mob/living/carbon/human/H = user
					if(H.dna)
						default = md5(H.dna.uni_identity)
				var/new_fingerprint_hash = sanitize(input(user,"What fingerprint hash would you like to be written on this card?","Agent Card Fingerprint Hash",default) as null|text)
				if(!isnull(new_fingerprint_hash) && tgui_status(user, state) == STATUS_INTERACTIVE)
					src.fingerprint_hash = new_fingerprint_hash
					to_chat(user, SPAN_NOTICE("Fingerprint hash changed to '[new_fingerprint_hash]'."))
					. = TRUE
			if("Name")
				var/new_name = sanitizeName(input(user,"What name would you like to put on this card?","Agent Card Name", registered_name) as null|text, allow_numbers=TRUE)
				if(!isnull(new_name) && tgui_status(user, state) == STATUS_INTERACTIVE)
					src.registered_name = new_name
					to_chat(user, SPAN_NOTICE("Name changed to '[new_name]'."))
					. = TRUE
			if("Photo")
				set_id_photo(user)
				to_chat(user, SPAN_NOTICE("Photo changed."))
				. = TRUE
			if("Sex")
				var/new_sex = sanitize(input(user,"What sex would you like to put on this card?","Agent Card Sex", sex) as null|text)
				if(!isnull(new_sex) && tgui_status(user, state) == STATUS_INTERACTIVE)
					src.sex = new_sex
					to_chat(user, SPAN_NOTICE("Sex changed to '[new_sex]'."))
					. = TRUE
			if("Factory Reset")
				if(alert("This will factory reset the card, including access and owner. Continue?", "Factory Reset", "No", "Yes") == "Yes" && tgui_status(user, state) == STATUS_INTERACTIVE)
					age = initial(age)
					formal_name_prefix = initial(formal_name_prefix)
					formal_name_suffix = initial(formal_name_suffix)
					access = syndicate_access.Copy()
					assignment = initial(assignment)
					blood_type = initial(blood_type)
					dna_hash = initial(dna_hash)
					electronic_warfare = initial(electronic_warfare)
					fingerprint_hash = initial(fingerprint_hash)
					icon_state = initial(icon_state)
					color = initial(color)
					detail_color = initial(detail_color)
					extra_details = initial(extra_details)
					SetName(initial(name))
					registered_name = initial(registered_name)
					unset_registered_user()
					sex = initial(sex)
					class = initial(class)
					to_chat(user, SPAN_NOTICE("All information has been deleted from \the [src]."))
					. = TRUE
			if("Class")
				var/list/classes = list(CLASS_A, CLASS_B, CLASS_C, CLASS_D, CLASS_E)
				var/new_class = sanitize(input(user,"What class would you like to put on this card?","Agent Card Branch") as null|anything in classes)
				if(!isnull(new_class) && tgui_status(user, state) == STATUS_INTERACTIVE)
					class = new_class
					to_chat(user, SPAN_NOTICE("Class changed to '[class]'."))
					. = TRUE

	SStgui.update_uis(src)

// Fine - Turns into emag.
/obj/item/card/id/syndicate/Conversion914(mode = MODE_ONE_TO_ONE, mob/user = usr)
	switch(mode)
		if(MODE_FINE)
			return /obj/item/card/emag
	return ..()

/var/global/list/id_card_states
/proc/id_card_states()
	if(!id_card_states)
		id_card_states = list()
		for(var/path in typesof(/obj/item/card/id))
			var/obj/item/card/id/ID = path
			var/datum/card_state/CS = new()
			CS.icon_state = initial(ID.icon_state)
			CS.item_state = initial(ID.item_state)
			CS.color = initial(ID.color)
			CS.detail_color = initial(ID.detail_color)
			CS.extra_details = initial(ID.extra_details)
			CS.examine_name = initial(ID.name)
			CS.name = initial(ID.name)
			if (initial(ID.job_access_type))
				var/datum/job/J = initial(ID.job_access_type)
				CS.name += " ([initial(J.title)]) "
			CS.name += " - [initial(ID.icon_state)]"
			var/color_pair = ""
			if(CS.color)
				color_pair += CS.color
			if(CS.detail_color)
				color_pair += "/[CS.detail_color]"
			if(color_pair)
				CS.name += " - [color_pair]"
			id_card_states += CS
		id_card_states = dd_sortedObjectList(id_card_states)

	return id_card_states

/datum/card_state
	var/name
	var/icon_state
	var/item_state
	var/color
	var/detail_color
	var/details
	var/extra_details
	var/examine_name

/datum/card_state/dd_SortValue()
	return name
