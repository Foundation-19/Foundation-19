/mob/living/carbon/alien/diona/get_scooped(mob/living/carbon/grabber)
	if(grabber.species && grabber.species.name == SPECIES_DIONA && do_merge(grabber))
		return
	else return ..()

/mob/living/carbon/alien/diona/MouseDrop(atom/over_object)
	var/mob/living/carbon/H = over_object

	if(istype(H) && Adjacent(H) && (usr == H) && (H.a_intent == "grab") && hat && !(H.l_hand && H.r_hand))
		hat.forceMove(get_turf(src))
		H.put_in_hands(hat)
		H.visible_message(SPAN_DANGER("\The [H] removes \the [src]'s [hat]."))
		hat = null
		update_icons()
		return

	return ..()

/mob/living/carbon/alien/diona/attackby(obj/item/weapon/W, mob/user)
	if(user.a_intent == I_HELP && istype(W, /obj/item/clothing/head))
		if(hat)
			to_chat(user, SPAN_WARNING("\The [src] is already wearing \the [hat]."))
			return
		user.unEquip(W)
		wear_hat(W)
		user.visible_message(SPAN_NOTICE("\The [user] puts \the [W] on \the [src]."))
		return
	return ..()
