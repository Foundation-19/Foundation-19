/*much like grab this item is used primarily for the utility it provides.
Basically: I can use it to target things where I click. I can then pass these targets to a spell and target things not using a list.
*/

/obj/item/magic_hand
	name = "Magic Hand"
	icon = 'icons/mob/screen1.dmi'
	atom_flags = 0
	item_flags = 0
	obj_flags = 0
	simulated = FALSE
	icon_state = "spell"
	var/next_spell_time = 0
	var/datum/spell/hand/hand_spell

/obj/item/magic_hand/New(datum/spell/hand/S)
	hand_spell = S
	name = "[name] ([S.name])"
	icon_state = S.hand_state

/obj/item/magic_hand/get_storage_cost()
	return ITEM_SIZE_NO_CONTAINER

/obj/item/magic_hand/afterattack(atom/A, mob/living/user, proximity)
	if(hand_spell && hand_spell.valid_target(A, user))
		fire_spell(A, user)
		return TRUE
	return FALSE

/obj/item/magic_hand/attack(atom/A, mob/living/user, target_zone, animate = TRUE)
	return afterattack(A, user, TRUE)

/obj/item/magic_hand/proc/fire_spell(atom/A, mob/living/user)
	if(!hand_spell) //no spell? Die.
		user.drop_from_inventory(src)

	if(!hand_spell.valid_target(A,user))
		return
	if(world.time < next_spell_time)
		to_chat(user, SPAN_WARNING("The spell isn't ready yet!"))
		return
	if(user.a_intent == I_HELP && hand_spell.harmful)
		to_chat(user, SPAN_NOTICE("You decide against casting this spell as your intent is set to help."))
		return

	if(hand_spell.show_message)
		user.visible_message("\The [user][hand_spell.show_message]")
	if(hand_spell.cast_hand(A,user))
		next_spell_time = world.time + hand_spell.spell_delay
		SEND_SIGNAL(user, COMSIG_SPELL_CAST_HAND, hand_spell, A)
		SEND_GLOBAL_SIGNAL(COMSIG_GLOB_SPELL_CAST_HAND, user, hand_spell, A)
		if(hand_spell.move_delay)
			user.ExtraMoveCooldown(hand_spell.move_delay)
		if(hand_spell.click_delay)
			user.setClickCooldown(hand_spell.click_delay)

/obj/item/magic_hand/throw_at(atom/target, range, speed, mob/thrower, spin = TRUE, datum/callback/callback) //no throwing pls
	usr.drop_from_inventory(src)

/obj/item/magic_hand/dropped() //gets deleted on drop
	..()
	qdel(src)

/obj/item/magic_hand/Destroy() //better save than sorry.
	hand_spell.current_hand = null
	hand_spell = null
	return ..()
