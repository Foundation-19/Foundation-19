/datum/keybinding/human
	category = CATEGORY_HUMAN

/datum/keybinding/human/can_use(client/user)
	return ishuman(user.mob)

/datum/keybinding/human/quick_equip
	hotkey_keys = list("E")
	name = "quick_equip"
	full_name = "Quick Equip"
	description = "Quickly puts an item in the best slot available"

/datum/keybinding/human/quick_equip/down(client/user)
	var/mob/living/carbon/human/H = user.mob
	H.quick_equip()
	return TRUE

/datum/keybinding/human/holster
	hotkey_keys = list("J")
	name = "holster"
	full_name = "Holster"
	description = "Draw or holster weapon"

/datum/keybinding/human/holster/down(client/user)
	var/mob/living/carbon/human/H = user.mob
	if(H.incapacitated())
		return

	var/obj/item/holster_item = H.get_active_hand()
	var/obj/item/clothing/under/U = H.w_uniform
	for(var/obj/S in U.accessories)
		if(istype(S, /obj/item/clothing/accessory/storage/holster))
			var/datum/extension/holster/E = get_extension(S, /datum/extension/holster)
			if(!E.holstered)
				if(!holster_item)
					to_chat(H, SPAN_WARNING("You're not holding anything to holster."))
					return
				if(!E.can_holster(holster_item))
					to_chat(H, SPAN_WARNING("You can't holster [holster_item]."))
					return
				E.holster(holster_item, H)
				return
			else
				E.unholster(H, TRUE)
				return

	if(istype(H.belt, /obj/item/storage/belt/holster))
		var/obj/item/storage/belt/holster/B = H.belt
		var/datum/extension/holster/E = get_extension(B, /datum/extension/holster)
		if(!E.holstered)
			if(!holster_item)
				to_chat(H, SPAN_WARNING("You're not holding anything to holster."))
				return
			if(!E.can_holster(holster_item))
				to_chat(H, SPAN_WARNING("You can't holster [holster_item]."))
				return
			E.holster(holster_item, H)
			return
		else
			E.unholster(H, TRUE)
			return

	return TRUE

/datum/keybinding/human/give
	hotkey_keys = list("G")
	name = "give_item"
	full_name = "Give Item"
	description = "Give the item you're currently holding"

/datum/keybinding/human/give/down(client/user)
	var/mob/living/carbon/human/H = user.mob
	var/list/valid_mobs = list()
	for(var/mob/living/carbon/human/target in orange(1, H))
		if(!istype(target) || target.incapacitated() || target.client == null)
			continue
		valid_mobs += target
	if(!LAZYLEN(valid_mobs))
		to_chat(H, SPAN_WARNING("There's nobody nearby to give items to."))
		return
	H.give(pick(valid_mobs))
	return TRUE

/datum/keybinding/human/delay_blink
	hotkey_keys = list("SPACEBAR")
	name = "d_blink"
	full_name = "Delay Blink"
	description = "Spam in order to delay blinking."

/datum/keybinding/human/delay_blink/down(client/user)
	var/mob/living/carbon/human/H = user.mob
	var/obj/item/organ/internal/eyes/h_eyes = H.internal_organs_by_name[BP_EYES]
	h_eyes.delay_blink()
	return TRUE

