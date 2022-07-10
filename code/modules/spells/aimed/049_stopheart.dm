/datum/spell/aimed/stopheart
	name = "Stop Heart"
	desc = "Stops the target's biological functions. Killing them quickly."
	spell_flags = null
	active_msg = "You hold your hand out."
	still_recharging_msg = "You aren't ready to use this again."
	projectile_amount = 0
	current_amount = 0
	projectiles_per_fire = 0
	cast_prox_range = 1

/datum/spell/aimed/stopheart/proc/failed_cast(var/mob/living/user)
	remove_ranged_ability()
	on_deactivation(user)
	charge_counter = charge_max

/datum/spell/aimed/stopheart/cast(list/targets, mob/living/user)
	var/mob/living/carbon/human/target = targets[1]
	if(isspecies(target, SPECIES_SCP049_1) || isscp343(target) || !istype(target))
		failed_cast(user)
		return FALSE

	var/obj/item/organ/internal/heart/heart = target.internal_organs_by_name[BP_HEART]
	if(heart.pulse != PULSE_NONE)
		var/targetted_bodypart = user.zone_sel.selecting
		if(targetted_bodypart == BP_EYES)
			to_chat(usr, SPAN_WARNING("I can't reach their eyes."))
			failed_cast(user)
			return FALSE
		user.visible_message(SPAN_DANGER("[user.name] presses against [target.name]'s [targetted_bodypart]."))
		if(target.get_covering_equipped_item_by_zone(targetted_bodypart))
			to_chat(usr, SPAN_WARNING("Their [targetted_bodypart] is covered."))
			remove_ranged_ability()
			on_deactivation(user)
			return FALSE
		heart.pulse = PULSE_NONE
		remove_ranged_ability()
		on_deactivation(user)
		return TRUE
	else
		to_chat(usr, SPAN_WARNING("They are already dead."))
		failed_cast(user)
		return FALSE
