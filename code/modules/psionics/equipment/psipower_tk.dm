/obj/item/psychic_power/telekinesis
	name = "telekinetic grip"
	maintain_cost = 1
	icon_state = "telekinesis"
	silent_drop = TRUE
	var/atom/movable/focus

/obj/item/psychic_power/telekinesis/Destroy()
	focus = null
	. = ..()

/obj/item/psychic_power/telekinesis/Process()
	if(!focus || !istype(focus.loc, /turf) || get_dist(get_turf(focus), get_turf(owner)) > owner.psi.get_rank(PSI_PSYCHOKINESIS))
		owner.drop_from_inventory(src)
		return
	. = ..()

/obj/item/psychic_power/telekinesis/proc/set_focus(atom/movable/_focus)

	if(!_focus.simulated || !istype(_focus.loc, /turf))
		return FALSE

	var/check_paramount
	if(ismob(_focus))
		var/mob/victim = _focus
		check_paramount = (victim.mob_size >= MOB_MEDIUM)
	else if(isobj(_focus))
		var/obj/thing = _focus
		check_paramount = (thing.w_class >= 5)
	else
		return FALSE

	if(_focus.anchored || (check_paramount && owner.psi.get_rank(PSI_PSYCHOKINESIS) < PSI_RANK_PARAMOUNT))
		focus = _focus
		. = attack_self(owner)
		if(!.)
			to_chat(owner, SPAN_WARNING("\The [_focus] is too hefty for you to get a mind-grip on."))
		else
			owner.visible_message(SPAN_NOTICE("\The [owner] makes a strange gesture."))
		owner.drop_from_inventory(src)
		return FALSE

	focus = _focus
	cut_overlays()
	var/image/I = image(icon = focus.icon, icon_state = focus.icon_state)
	I.color = focus.color
	I.overlays = focus.overlays
	add_overlay(I)
	return TRUE

/obj/item/psychic_power/telekinesis/attack_self(mob/user)
	user.visible_message(SPAN_NOTICE("\The [user] makes a strange gesture."))
	sparkle()
	return focus.do_simple_ranged_interaction(user)

/obj/item/psychic_power/telekinesis/afterattack(atom/target, mob/living/user, proximity)

	if(!target || !user || (isobj(target) && !isturf(target.loc)) || !user.psi || !user.psi.can_use() || !user.psi.spend_power(5))
		return

	var/user_rank = owner.psi.get_rank(PSI_PSYCHOKINESIS) // Can only be above/equal to 4

	user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN * (8 / user_rank))
	user.psi.set_cooldown((32 / user_rank))

	var/user_psi_leech = user.do_psionics_check(5, user)
	if(user_psi_leech)
		to_chat(user, SPAN_WARNING("You reach for \the [target] but your telekinetic power is leeched away by \the [user_psi_leech]..."))
		return

	if(target.do_psionics_check(5, user))
		to_chat(user, SPAN_WARNING("Your telekinetic power skates over \the [target] but cannot get a grip..."))
		return

	var/distance = get_dist(get_turf(user), get_turf(focus ? focus : target))
	if(distance > user.psi.get_rank(PSI_PSYCHOKINESIS))
		to_chat(user, SPAN_WARNING("Your telekinetic power won't reach that far."))
		return FALSE

	if(target == focus)
		attack_self(user)
	else
		user.visible_message(SPAN_DANGER("\The [user] gestures sharply!"))
		sparkle()
		if(!istype(target, /turf) && istype(focus,/obj/item) && target.Adjacent(focus))
			var/obj/item/I = focus
			var/resolved = target.attackby(I, user, user.get_organ_target())
			if(!resolved && target && I)
				I.afterattack(target,user,1) // for splashing with beakers
		else
			if(!focus.anchored)
				focus.throw_at(target, min(user_rank, 10), min(round(user_rank*0.8), 8), owner)
			sleep(1)
			sparkle()
		if(user_rank < PSI_RANK_PARAMOUNT) // Memes
			owner.drop_from_inventory(src)

	if(!user.psi.spend_power(2)) // So you can't spam-click kill everything that moves
		return FALSE

/obj/item/psychic_power/telekinesis/proc/sparkle()
	set waitfor = 0
	if(focus)
		var/obj/effect/overlay/O = new /obj/effect/overlay(get_turf(focus))
		O.name = "sparkles"
		O.anchored = TRUE
		O.density = FALSE
		O.layer = FLY_LAYER
		O.setDir(pick(GLOB.cardinal))
		O.icon = 'icons/effects/effects.dmi'
		O.icon_state = "nothing"
		flick("empdisable",O)
		sleep(5)
		qdel(O)
