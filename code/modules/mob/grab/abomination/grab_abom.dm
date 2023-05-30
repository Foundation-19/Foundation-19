/obj/item/grab/abomination
	type_name = GRAB_ABOMINATION
	start_grab_name = GRAB_ABOMINATION_PASSIVE

/obj/item/grab/abomination/init()
	. = ..()
	if(!.)
		return
	visible_message("<span class='warning'>[assailant] has grabbed [affecting] passively!</span>")

/datum/grab/abomination
	type_name = GRAB_ABOMINATION
	icon = 'icons/mob/screen1.dmi'

	can_absorb = 1
	point_blank_mult = 1
	ladder_carry = 1
	force_danger = 1
	can_grab_self = 0

/datum/grab/abomination/on_hit_grab(obj/item/grab/G)
	var/mob/living/carbon/human/user = G.assailant
	var/mob/living/carbon/human/target = G.affecting

	target.visible_message(
		SPAN_DANGER("[user] begins crushing [target]!"),
		SPAN_USERDANGER("[user] is trying to crush your bones!"),
		)
	G.attacking = TRUE
	if(do_after(user, action_cooldown * 0.5, target))
		G.attacking = FALSE
		G.action_used()
		Crush(G)
		return TRUE
	else
		G.attacking = FALSE
		target.visible_message(SPAN_WARNING("[user] stops crushing [target]!"))
		return FALSE

/datum/grab/abomination/on_hit_harm(obj/item/grab/G)
	var/mob/living/carbon/human/user = G.assailant
	var/mob/living/carbon/human/target = G.affecting
	var/obj/item/organ/external/damaging = target.get_organ(user.zone_sel.selecting)

	if(!istype(damaging))
		to_chat(user, SPAN_WARNING("This limb is missing!"))
		return FALSE

	target.visible_message(
		SPAN_DANGER("[user] begins eating [target]'s [damaging.name]!"),
		SPAN_USERDANGER("[user] is eating your [damaging.name]!"),
		)
	G.attacking = TRUE

	if(do_after(user, action_cooldown, target))
		G.attacking = FALSE
		G.action_used()
		Devour(G)
		return TRUE
	else
		G.attacking = FALSE
		target.visible_message(SPAN_WARNING("[user] stops eating [target]'s limbs."))
		return FALSE

// This causes the user to temporarily stun and weaken the target, dealing pain and slight brute damage
/datum/grab/abomination/proc/Crush(obj/item/grab/G)
	var/mob/living/carbon/human/user = G.assailant
	var/mob/living/carbon/human/target = G.affecting
	var/hit_zone = user.zone_sel.selecting
	var/obj/item/organ/external/damaging = target.get_organ(hit_zone)

	target.visible_message(SPAN_DANGER("[user] crushes [target]'s [damaging.name]!"))
	target.custom_pain("You feel your bones painfuly compress in [damaging.name]!", 50, affecting = damaging)
	target.apply_damage(4, BRUTE, hit_zone, used_weapon = "crushing")
	target.Stun(10)
	target.Weaken(15)
	playsound(get_turf(target), 'sound/weapons/pierce.ogg', 25, TRUE, -3)

	admin_attack_log(user, target, "Crushed their victim.", "Was crushed.", "crushed")

// This causes the user to heavily damage targeted limb while also restoring its own nutrition
/datum/grab/abomination/proc/Devour(obj/item/grab/G)
	var/mob/living/carbon/human/user = G.assailant
	var/mob/living/carbon/human/target = G.affecting
	var/hit_zone = user.zone_sel.selecting
	var/obj/item/organ/external/damaging = target.get_organ(hit_zone)

	if(!istype(damaging))
		to_chat(user, SPAN_WARNING("This limb is missing!"))
		return

	if(!damaging.how_open())
		damaging.createwound(CUT, damaging.min_broken_damage*0.75, 1)
		playsound(get_turf(target), 'sound/weapons/alien_tail_attack.ogg', 50, TRUE, 5)
		target.visible_message(
			SPAN_DANGER("[user] cuts [target]'s [damaging.name] open!"),
			SPAN_USERDANGER("[user] cuts your [damaging.name] open!"),
			)
		admin_attack_log(user, target, "Cuts open their victim.", "Has been cut.", "cut")
		return

	if(user.get_fullness() > 380) // Just slash them
		target.apply_damage(rand(16, 24), BRUTE, hit_zone, DAM_SHARP|DAM_EDGE, used_weapon = "claws")
		target.visible_message(SPAN_DANGER("[user] slashes [target]'s [damaging.name]!"))
		playsound(get_turf(target), 'sound/weapons/alien_claw_flesh3.ogg', 25, TRUE)
	else // Food!
		var/datum/reagents/R = new /datum/reagents(3, GLOB.temp_reagents_holder)
		R.add_reagent(/datum/reagent/nutriment, 3)
		R.trans_to_mob(user, 3, CHEM_INGEST)
		qdel(R)
		target.apply_damage(rand(8, 14), BRUTE, hit_zone, DAM_SHARP|DAM_EDGE, used_weapon = "fangs")
		target.visible_message(SPAN_DANGER("[user] eats [target]'s [damaging.name]!"))
		playsound(get_turf(target), 'sound/weapons/alien_claw_flesh1.ogg', 25, TRUE)

	admin_attack_log(user, target, "Devours their victim.", "Was chewed.", "chewed")
