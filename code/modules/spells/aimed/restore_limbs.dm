/datum/spell/aimed/restore_limbs
	name = "Restore Limbs"
	desc = "Restores internal damage within the limbs, including broken bones, internal bleeding and missing limbs."
	deactive_msg = "You discharge the limb restoration spell..."
	active_msg = "You charge the limb restoration spell!"

	charge_max = 60 SECONDS
	cooldown_reduc = 20 SECONDS

	invocation = "Membrum Di'Nath!"
	invocation_type = INVOKE_SHOUT
	level_max = list(UPGRADE_TOTAL = 2, UPGRADE_SPEED = 1, UPGRADE_POWER = 2)

	hud_state = "wiz_restore_limbs"
	cast_sound = 'sounds/magic/staff_healing.ogg'

	range = 1

	categories = list(SPELL_CATEGORY_HEALING)
	spell_cost = 5
	mana_cost = 25

	var/restore_missing_limbs = FALSE
	/// How many missing limbs can be restored per single cast
	var/restore_missing_limbs_count = 1

/datum/spell/aimed/restore_limbs/TargetCastCheck(mob/living/user, mob/living/target)
	if(!ishuman(target))
		to_chat(user, SPAN_WARNING("The target must be a humanoid creature!"))
		return FALSE
	if(get_dist(user, target) > range)
		to_chat(user, SPAN_WARNING("The target is too far away!"))
		return FALSE
	return ..()

/datum/spell/aimed/restore_limbs/fire_projectile(mob/living/user, mob/living/carbon/human/H)
	. = ..()
	for(var/obj/item/organ/external/E in H.bad_external_organs)
		if(E.status & ORGAN_ARTERY_CUT)
			E.status &= ~ORGAN_ARTERY_CUT
		if(E.status & ORGAN_TENDON_CUT)
			E.status &= ~ORGAN_TENDON_CUT
		if(E.status & ORGAN_BLEEDING)
			E.status &= ~ORGAN_BLEEDING
		if(E.status & ORGAN_BROKEN)
			E.status &= ~ORGAN_BROKEN

	if(restore_missing_limbs)
		// Remove all stumps first
		for(var/O in H.organs_by_name)
			var/obj/item/organ/external/E = H.organs_by_name[O]
			if(E.is_stump())
				H.visible_message(SPAN_WARNING("\The [E.name] falls apart!"))
				qdel(E)
		var/list/missing_limbs = H.species.has_limbs - H.organs_by_name
		for(var/i = 1 to restore_missing_limbs_count)
			if(!LAZYLEN(missing_limbs))
				break
			var/o_type = pick(missing_limbs)
			missing_limbs -= o_type
			var/limb_type = H.species.has_limbs[o_type]["path"]
			var/obj/new_limb = new limb_type(H)
			H.visible_message(SPAN_NOTICE(SPAN_BOLD("A new [new_limb.name] grows on \the [H]!")))

	H.regenerate_icons()

	var/obj/o = new /obj/effect/temp_visual/temporary(get_turf(H), 15, 'icons/effects/effects.dmi', "green_sparkles")
	o.color = COLOR_GREEN

	to_chat(H, SPAN_NOTICE(SPAN_BOLD("Your bones and wounds seem to mend themselves!")))

	return TRUE

/datum/spell/aimed/restore_limbs/ImproveSpellPower()
	if(!..())
		return FALSE

	if(spell_levels[UPGRADE_POWER] == 1)
		restore_missing_limbs = TRUE
		return "The [src] spell is now capable of restoring missing limbs."

	restore_missing_limbs_count += 1

	return "The [src] spell is now capable of restoring [restore_missing_limbs_count] missing limbs."
