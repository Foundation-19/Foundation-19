/datum/keybinding/living
	category = CATEGORY_HUMAN

/datum/keybinding/living/can_use(client/user)
	return isliving(user.mob)

/datum/keybinding/living/rest
	hotkey_keys = list("ShiftB")
	name = "rest"
	full_name = "Rest"
	description = "You lay down/get up"

/datum/keybinding/living/rest/down(client/user)
	var/mob/living/L = user.mob
	L.lay_down()
	return TRUE

/datum/keybinding/living/resist
	hotkey_keys = list("B")
	name = "resist"
	full_name = "Resist"
	description = "Break free of your current state. Handcuffed? On fire? Resist!"

/datum/keybinding/living/resist/down(client/user)
	var/mob/living/L = user.mob
	L.resist()
	return TRUE

/datum/keybinding/living/drop_item
	hotkey_keys = list("Q", "Northwest") // HOME
	name = "drop_item"
	full_name = "Drop Item"
	description = ""

/datum/keybinding/living/drop_item/down(client/user)
	var/mob/living/L = user.mob
	var/obj/item/hand = L.get_active_hand()
	if(!hand)
		to_chat(L, "<span class='warning'>You have nothing to drop in your hand.</span>")
	else if(hand.can_be_dropped_by_client(L))
		L.drop_item()

	return TRUE

/datum/keybinding/living/aim_mode
	hotkey_keys = list("N")
	name = "toggle_aim_mode"
	full_name = "Toggle Aim Mode"
	description = "Toggle between hip fire and aiming."

/datum/keybinding/living/aim_mode/down(client/user)
	var/mob/living/L = user.mob
	if(!L.aiming)
		return
	L.aiming.toggle_active()
	return TRUE
