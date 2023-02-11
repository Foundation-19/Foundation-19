//Powerful martial arts, usually shitspawned or somthing like this

//OP combat style for shitspawning. DO NOT FUCKING USE IT

/datum/martial_art/nanite/plasmafist
	name = "Plasma Fist"
	id = "plasma_fist"

	additional_hit_damage = 5
	additional_hit_type = BURN
	ignor_psishields = 1
	var/last_gib = 0

	desc = "Grab Harm Disarm Disarm Harm - Plasma Fist - gibs victim, 2 minutes of cooldown\n\
			Disarm Disarm Harm Disarm - Tornado Sweep - deals 10 damage and sends victim flying\n\
			Disarm Harm Disarm Harm - Phoron Repulse - sends victim and all nearby mobs flying"

/datum/martial_art/nanite/plasmafist/handle_streak(mob/living/carbon/human/owner, mob/living/carbon/human/D)
	if(findtext(streak, "GADDA"))
		if(last_gib > world.time)
			to_chat(owner, SPAN_WARNING("You can't use your plasma fist art so soon! Wait [round(last_gib - world.time) / 10] seconds."))
			return FALSE
		owner.say("PLASMA FIST!")
		D.gib()
		owner.visible_message(SPAN_DANGER("[owner] gibs [D] with his fists!"))
		playsound(owner.loc, 'sound/weapons/punch2.ogg', 25, 1, -1)
		last_gib = world.time + 120 SECONDS
		return TRUE

	if(findtext(streak, "DDAD"))
		owner.say("TORNADO SWEEP!")
		playsound(owner.loc, 'sound/weapons/punch1.ogg', 25, 1, -1)
		owner.visible_message(SPAN_DANGER("[owner] punches [D] with inhuman strengh, sending him flying!"))
		var/throwdir = get_dir(owner, D)
		D.throw_at(get_edge_target_turf(D, throwdir),200,3)
		D.apply_damage(10, BRUTE, BP_CHEST)
		D.Weaken(1)
		return TRUE

	if(findtext(streak, "DADA"))
		owner.say("PHORON REPULSE!")
		playsound(owner.loc, 'sound/weapons/punch3.ogg', 25, 1, -1)
		owner.visible_message(SPAN_DANGER("[owner] suddenly kicks [D] , sending him and all nearby flying!"))
		var/throwdir = get_dir(owner, D)
		for(var/mob/living/mob in range(get_turf(owner), 1))
			if(get_dist(mob, D) <= 1 && mob != owner)
				mob.throw_at(get_edge_target_turf(D, throwdir),200,1)
		return TRUE

	return FALSE


/obj/item/weapon/nanite_injector/plasmafist
	name = "combat nanite injector"
	desc = "A black autoinjector with red bar on top, which can transfer combat nanites to your body. This one has marking \"Plasma Fist\"."
	icon_state = "red_hypo"
	martial_art = new /datum/martial_art/nanite/plasmafist

//Not SO OP, but still, dont use it pls

/datum/martial_art/nanite/sleeping_carp
	name = "Sleeping Carp"
	id = "sleeping_carp"

	additional_hit_damage = 5
	additional_hit_type = BRUTE
	block_modifier = 2
	reflect_prob = 100
	noshooting = 1

	var/harmstreak = 0

	desc = "Harm Harm Harm etc. - Gnashing Teeth - each harm after first 3 deals 7 more damage up to +35\n\
			Harm Disarm Disarm Harm - Chest Kick - deals 10 damage and sends victim flying\n\
			Harm Grab Harm - Kneehaul - knocks victim down into 2-second stun"

/datum/martial_art/nanite/sleeping_carp/handle_streak(mob/living/carbon/human/owner, mob/living/carbon/human/D)

	if(findtext(streak, "AAA"))
		var/hit_zone = owner.zone_sel.selecting
		D.apply_damage(7 * harmstreak, BRUTE, hit_zone)
		harmstreak++
		if(harmstreak > 5)
			D.visible_message(SPAN_DANGER("[D] sputters blood as the blow of [owner] strikes them with inhuman force!"))
			playsound(owner.loc, 'sound/weapons/punch2.ogg', 25, 1, -1)
			return TRUE
		playsound(owner.loc, 'sound/weapons/punch1.ogg', 25, 1, -1)
		return FALSE
	else
		harmstreak = 0

	if(findtext(streak, "ADDA"))
		owner.visible_message(SPAN_DANGER("[owner] kicks [D] square in the chest, sending them flying!"))
		playsound(owner.loc, 'sound/weapons/punch1.ogg', 25, 1, -1)
		var/throwdir = get_dir(owner, D)
		D.throw_at(get_edge_target_turf(D, throwdir),200,3)
		D.apply_damage(10, BRUTE, BP_CHEST)
		D.Weaken(1)
		return TRUE

	if(findtext(streak, "AGA"))
		playsound(owner.loc, 'sound/weapons/punch1.ogg', 25, 1, -1)
		if(D.lying)
			D.apply_damage(5, BRUTE, BP_HEAD)
			owner.visible_message(SPAN_DANGER("[owner] kicks [D] in the head!"))
			return TRUE
		D.apply_damage(7, BRUTE, BP_HEAD)
		D.Weaken(2)
		D.Stun(1)
		owner.visible_message(SPAN_DANGER("[owner] kicks [D] in the head, sending them face first into the floor!"))
		return TRUE
	return FALSE

/datum/martial_art/nanite/sleeping_carp/handle_harm(mob/living/carbon/human/owner, mob/living/carbon/human/victim)
	if(handle_streak(owner, victim))
		streak = ""
		return TRUE
	return FALSE


/obj/item/weapon/nanite_injector/sleeping_carp
	name = "combat nanite injector"
	desc = "A black autoinjector with yellow bar on top, which can transfer combat nanites to your body. This one has marking \"Sleeping Carp\"."
	icon_state = "yellow_hypo"
	martial_art = new /datum/martial_art/nanite/sleeping_carp

/obj/item/weapon/nanite_injector
	name = "nanite injector"
	desc = "A black autoinjector, which can transfer nanite fluinds to your body."
	icon = 'icons/SCP/syringe.dmi'
	icon_state = "red_hypo"

	var/spend = 0
	var/datum/martial_art/martial_art = new /datum/martial_art/krav_maga

/obj/item/weapon/nanite_injector/attack(mob/living/carbon/human/M, mob/living/carbon/human/user)

	if(spend)
		to_chat(user, "[src] is already spend!")
		return

	if((!istype(user)) || (!istype(M)))
		to_chat(user, "You can't manage to inject [M] with [src]!")
		return

	if(user != M)
		user.visible_message(SPAN_WARNING("[user] tries to inject [M] with [src]!"))
		if(do_mob(user, M, 0.5 SECONDS))
			user.visible_message(SPAN_WARNING("[user] injects [M] with [src]!"))
			inject_nanites(M)
	else
		user.visible_message(SPAN_WARNING("[user] injects himself with [src]!"))
		inject_nanites(user)

/obj/item/weapon/nanite_injector/proc/inject_nanites(mob/living/carbon/human/H)
	spend = 1
	icon_state = "[initial(icon_state)]_spend"
	H.martial_art = martial_art
	to_chat(H, "You feel like you are good on [martial_art.name]!")
	to_chat(H, martial_art.desc)
	if(!/mob/living/carbon/human/proc/remember_art in H.verbs)
		H.verbs += /mob/living/carbon/human/proc/remember_art

/mob/living/carbon/human/proc/remember_art()
	set name = "Check Art Combos"
	set category = "Abilities"

	if(istype(martial_art))
		to_chat(src, martial_art.desc)
	else
		to_chat(src, "You don't know any martial art. Please contact developers if you see this.")
