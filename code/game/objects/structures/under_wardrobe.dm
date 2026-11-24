#define WARDROBE_BLIND_MESSAGE(fool) "\The [src] flashes a light at \the [fool] as it states a message."

/obj/structure/undies_wardrobe
	name = "underwear wardrobe"
	desc = "Holds item of clothing you shouldn't be showing off in the hallways."
	icon = 'icons/obj/undies_wardrobe.dmi'
	icon_state = "closed"
	density = TRUE
	var/static/list/amount_of_underwear_by_id_card

/obj/structure/undies_wardrobe/attackby(obj/item/underwear/underwear, mob/user)
	if(istype(underwear))
		if(!user.unEquip(underwear))
			return
		qdel(underwear)
		user.visible_message(SPAN_NOTICE("\The [user] inserts \their [underwear.name] into \the [src]."), SPAN_NOTICE("You insert your [underwear.name] into \the [src]."))

		var/id = user.GetIdCard()
		var/message
		if(id)
			message = "ID card detected. Your underwear quota for this shift has been increased, if applicable."
		else
			message = "No ID card detected. Thank you for your contribution."

		audible_message(message, WARDROBE_BLIND_MESSAGE(user))

		var/number_of_underwear = LAZYACCESS(amount_of_underwear_by_id_card, id) - 1
		if(number_of_underwear)
			LAZYSET(amount_of_underwear_by_id_card, id, number_of_underwear)
			RegisterSignal(id, COMSIG_PARENT_QDELETING, TYPE_PROC_REF(/obj/structure/undies_wardrobe, remove_id_card))
		else
			remove_id_card(id)

	else
		..()

/obj/structure/undies_wardrobe/proc/remove_id_card(id_card)
	LAZYREMOVE(amount_of_underwear_by_id_card, id_card)
	UnregisterSignal(id_card, COMSIG_PARENT_QDELETING)

/obj/structure/undies_wardrobe/attack_hand(mob/user)
	if(!human_who_can_use_underwear(user))
		to_chat(user, SPAN_WARNING("Sadly there's nothing in here for you to wear."))
		return
	tgui_interact(user)

/obj/structure/undies_wardrobe/tgui_interact(mob/user, datum/tgui/ui)
	if(!human_who_can_use_underwear(user))
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "UnderWardrobe", "Underwear Wardrobe")
		ui.open()

/obj/structure/undies_wardrobe/tgui_data(mob/user)
	if(!human_who_can_use_underwear(user))
		return list()

	var/mob/living/carbon/human/H = user
	var/id = H.GetIdCard()

	var/list/data = list()
	data["quota"] = id ? length(GLOB.underwear.categories) - LAZYACCESS(amount_of_underwear_by_id_card, id) : 0
	var/list/category_list = list()
	for(var/datum/category_group/underwear/UWC in GLOB.underwear.categories)
		category_list += list(list("name" = UWC.name))
	data["categories"] = category_list
	return data

/obj/structure/undies_wardrobe/proc/human_who_can_use_underwear(mob/living/carbon/human/H)
	if(!istype(H) || !H.species || !(H.species.appearance_flags & HAS_UNDERWEAR))
		return FALSE
	return TRUE

/obj/structure/undies_wardrobe/CanUseTopic(user)
	if(!human_who_can_use_underwear(user))
		return STATUS_CLOSE

	return ..()

/obj/structure/undies_wardrobe/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	if(!human_who_can_use_underwear(usr))
		return TRUE

	var/mob/living/carbon/human/H = usr
	if(action == "select_underwear")
		var/datum/category_group/underwear/UWC = GLOB.underwear.categories_by_name[params["category"]]
		if(!UWC)
			return TRUE
		var/datum/category_item/underwear/UWI = input("Select your desired underwear:", "Choose underwear") as null|anything in exlude_none(UWC.items)
		if(!UWI)
			return TRUE

		var/list/metadata_list = list()
		for(var/tweak in UWI.tweaks)
			var/datum/gear_tweak/gt = tweak
			var/metadata = gt.get_metadata(H, title = "Adjust underwear")
			if(!metadata)
				return TRUE
			metadata_list["[gt]"] = metadata

		if(tgui_status(H, state) != STATUS_INTERACTIVE)
			return TRUE

		var/id = H.GetIdCard()
		if(!id)
			audible_message("No ID card detected. Unable to acquire your underwear quota for this shift.", WARDROBE_BLIND_MESSAGE(H))
			return TRUE

		var/current_quota = LAZYACCESS(amount_of_underwear_by_id_card, id)
		if(current_quota >= length(GLOB.underwear.categories))
			audible_message("You have already used up your underwear quota for this shift. Please return previously acquired items to increase it.", WARDROBE_BLIND_MESSAGE(H))
			return TRUE
		LAZYSET(amount_of_underwear_by_id_card, id, ++current_quota)

		var/obj/UW = UWI.create_underwear(H, metadata_list)
		UW.forceMove(loc)
		H.put_in_hands(UW)

		return TRUE
	return FALSE

/obj/structure/undies_wardrobe/proc/exlude_none(list/L)
	. = L.Copy()
	for(var/e in .)
		var/datum/category_item/underwear/UWI = e
		if(!UWI.underwear_type)
			. -= UWI

#undef WARDROBE_BLIND_MESSAGE
