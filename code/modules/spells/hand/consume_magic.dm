/datum/spell/hand/consume_energy
	name = "Consume Magic Energy"
	desc = "Absorbs spell points and mana from the living target. Considered to be outlawed by all governing bodies of \
			the wizard society."

	spell_flags = NEEDSCLOTHES | SELECTABLE | IGNOREPREV
	invocation = "Vis Absumo!"
	invocation_type = INVOKE_SHOUT

	categories = list(SPELL_CATEGORY_FORBIDDEN)
	level_max = list(UPGRADE_TOTAL = 2, UPGRADE_SPEED = 2, UPGRADE_POWER = 0)

	charge_max = 60 SECONDS
	cooldown_reduc = 15 SECONDS
	spell_delay = 15 SECONDS
	click_delay = 5 SECONDS

	hud_state = "wiz_consume_energy"
	cast_sound = 'sounds/magic/words.ogg'

	range = 1
	compatible_targets = list(/mob/living/carbon/human)

	spell_cost = 10
	mana_cost = 30
	mana_cost_per_cast = 10

	var/do_effects = FALSE

/datum/spell/hand/consume_energy/valid_target(mob/living/L, mob/user)
	if(!..())
		return FALSE
	if(L.stat == DEAD)
		to_chat(user, SPAN_WARNING("You are unable to consume magic power from a dead creature!"))
		return FALSE
	var/datum/mana/M = GetManaDatum(L)
	if(!M || (M.mana_level_max <= 5 && M.spell_points <= 1 && !LAZYLEN(L.mind.learned_spells)))
		to_chat(user, SPAN_WARNING("There's nothing to consume here..."))
		return FALSE
	return TRUE

/datum/spell/hand/consume_energy/cast_hand(mob/living/carbon/human/H, mob/living/user)
	. = ..()
	if(!.)
		return

	user.visible_message(
		SPAN_DANGER("[user] places their hand on [H], as magic particles begin to float all around them."),
		SPAN_NOTICE("<b>You begin draining magic power out of [H]...</b>"),
		)
	do_effects = TRUE
	DoEffects(user, H)
	current_hand.next_spell_time = world.time + spell_delay
	var/datum/mana/M = GetManaDatum(H)
	var/datum/mana/MU = GetManaDatum(user)
	for(var/i = 1 to 3)
		if(!do_after(user, 10 SECONDS, H))
			user.visible_message(
				SPAN_WARNING("[user] retracts their hand from \the [H]."),
				SPAN_WARNING("You stop draining the power out of [H]..."),
				)
			do_effects = FALSE
			return
		if(QDELETED(H) || QDELETED(M))
			user.visible_message(
				SPAN_WARNING("[user] retracts their hand."),
				SPAN_WARNING("You stop draining the power..."),
				)
			do_effects = FALSE
			return
		playsound(H, 'sounds/magic/drain.ogg', 50, TRUE)
		current_hand.next_spell_time = world.time + spell_delay
		// First, we steal all free spell points
		if(M.spell_points > 1)
			to_chat(user, SPAN_NOTICE("You've consumed [M.spell_points - 1] spell power."))
			to_chat(H, SPAN_USERDANGER("You lost your spell power!"))
			MU.spell_points += M.spell_points - 1
			M.spell_points = min(M.spell_points, 1)
			continue
		// Proceed to eat all(most of) the mana
		if(M.mana_level_max > 5)
			to_chat(user, SPAN_NOTICE("You've consumed [M.mana_level_max - 5] units of mana."))
			to_chat(H, SPAN_USERDANGER("You lost your mana!"))
			MU.mana_level_max += M.mana_level_max - 5
			MU.StartRecharge()
			M.mana_level_max = min(M.mana_level_max, 5)
			M.mana_level = M.mana_level_max
			continue
		// Then we convert learnt spells to spell points
		if(LAZYLEN(H.mind.learned_spells))
			for(var/ii = 1 to length(H.mind.learned_spells))
				if(!LAZYLEN(H.mind.learned_spells))
					break
				var/datum/spell/S = H.mind.learned_spells[length(H.mind.learned_spells)]
				if(!istype(S))
					continue
				to_chat(user, SPAN_NOTICE("You've consumed [user]'s [S.name] spell and gained [S.total_points_used] spell power."))
				to_chat(H, SPAN_USERDANGER("You lost knowledge on how to use [S.name] spell!"))
				MU.spell_points += S.total_points_used
				H.remove_spell(S)
		// And now, nothing left to do!
		break

	user.visible_message(
		SPAN_NOTICE("[user] retracts their hand from [H]."),
		SPAN_NOTICE("<b>You finish draining magic power out of [H]!</b>"),
		)
	to_chat(H, SPAN_USERDANGER("You lost your spell power!"))
	do_effects = FALSE
	qdel(current_hand)

/datum/spell/hand/consume_energy/proc/DoEffects(mob/living/user, mob/living/target)
	if(!do_effects)
		return

	var/obj/effect/temp_visual/decoy/D = new /obj/effect/temp_visual/decoy(get_turf(target), target.dir, target)
	D.pixel_x = target.pixel_x + rand(-4, 4)
	D.pixel_y = target.pixel_y + rand(-4, 4)
	D.color = COLOR_MANA
	D.alpha = 0
	animate(D, pixel_x = (user.x - target.x) * world.icon_size, pixel_y = (user.y - target.y) * world.icon_size, alpha = rand(100, 175), time = rand(3, 6))
	animate(alpha = 0, time = 2)

	addtimer(CALLBACK(src, PROC_REF(DoEffects), user, target), rand(1, 3))
