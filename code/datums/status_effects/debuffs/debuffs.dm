/// The damage healed per tick while sleeping without any modifiers
#define HEALING_SLEEP_DEFAULT 0.2
/// The sleep healing multipler for organ passive healing (since organs heal slowly)
#define HEALING_SLEEP_ORGAN_MULTIPLIER 5

//Largely negative status effects go here, even if they have small benificial effects
//STUN EFFECTS
/datum/status_effect/incapacitating
	tick_interval = 0
	status_type = STATUS_EFFECT_REPLACE
	alert_type = null
	remove_on_fullheal = TRUE
	//heal_flag_necessary = HEAL_CC_STATUS
	var/needs_update_stat = FALSE

/datum/status_effect/incapacitating/on_creation(mob/living/new_owner, set_duration)
	if(isnum(set_duration))
		duration = set_duration
	. = ..()
	if(. && (needs_update_stat || issilicon(owner)))
		owner.update_stat()


/datum/status_effect/incapacitating/on_remove()
	if(needs_update_stat || issilicon(owner)) //silicons need stat updates in addition to normal canmove updates
		owner.update_stat()
	return ..()


//STUN
/datum/status_effect/incapacitating/stun
	id = "stun"

/datum/status_effect/incapacitating/stun/on_apply()
	. = ..()
	if(!.)
		return
	owner.add_traits(list(TRAIT_INCAPACITATED, TRAIT_IMMOBILIZED, TRAIT_HANDS_BLOCKED), TRAIT_STATUS_EFFECT(id))

/datum/status_effect/incapacitating/stun/on_remove()
	owner.remove_traits(list(TRAIT_INCAPACITATED, TRAIT_IMMOBILIZED, TRAIT_HANDS_BLOCKED), TRAIT_STATUS_EFFECT(id))
	return ..()

//KNOCKDOWN
/datum/status_effect/incapacitating/knockdown
	id = "knockdown"

/datum/status_effect/incapacitating/knockdown/on_apply()
	. = ..()
	if(!.)
		return
	ADD_TRAIT(owner, TRAIT_FLOORED, TRAIT_STATUS_EFFECT(id))

/datum/status_effect/incapacitating/knockdown/on_remove()
	REMOVE_TRAIT(owner, TRAIT_FLOORED, TRAIT_STATUS_EFFECT(id))
	return ..()


//IMMOBILIZED
/datum/status_effect/incapacitating/immobilized
	id = "immobilized"

/datum/status_effect/incapacitating/immobilized/on_apply()
	. = ..()
	if(!.)
		return
	ADD_TRAIT(owner, TRAIT_IMMOBILIZED, TRAIT_STATUS_EFFECT(id))

/datum/status_effect/incapacitating/immobilized/on_remove()
	REMOVE_TRAIT(owner, TRAIT_IMMOBILIZED, TRAIT_STATUS_EFFECT(id))
	return ..()


//PARALYZED
/datum/status_effect/incapacitating/paralyzed
	id = "paralyzed"

/datum/status_effect/incapacitating/paralyzed/on_apply()
	. = ..()
	if(!.)
		return
	owner.add_traits(list(TRAIT_INCAPACITATED, TRAIT_IMMOBILIZED, TRAIT_FLOORED, TRAIT_HANDS_BLOCKED), TRAIT_STATUS_EFFECT(id))

/datum/status_effect/incapacitating/paralyzed/on_remove()
	owner.remove_traits(list(TRAIT_INCAPACITATED, TRAIT_IMMOBILIZED, TRAIT_FLOORED, TRAIT_HANDS_BLOCKED), TRAIT_STATUS_EFFECT(id))
	return ..()

//INCAPACITATED
/// This status effect represents anything that leaves a character unable to perform basic tasks (interrupting do-afters, for example), but doesn't incapacitate them further than that (no stuns etc..)
/datum/status_effect/incapacitating/incapacitated
	id = "incapacitated"

// What happens when you get the incapacitated status. You get TRAIT_INCAPACITATED added to you for the duration of the status effect.
/datum/status_effect/incapacitating/incapacitated/on_apply()
	. = ..()
	if(!.)
		return
	ADD_TRAIT(owner, TRAIT_INCAPACITATED, TRAIT_STATUS_EFFECT(id))

// When the status effect runs out, your TRAIT_INCAPACITATED is removed.
/datum/status_effect/incapacitating/incapacitated/on_remove()
	REMOVE_TRAIT(owner, TRAIT_INCAPACITATED, TRAIT_STATUS_EFFECT(id))
	return ..()


//UNCONSCIOUS
/datum/status_effect/incapacitating/unconscious
	id = "unconscious"
	needs_update_stat = TRUE

/datum/status_effect/incapacitating/unconscious/on_apply()
	. = ..()
	if(!.)
		return
	ADD_TRAIT(owner, TRAIT_KNOCKEDOUT, TRAIT_STATUS_EFFECT(id))

/datum/status_effect/incapacitating/unconscious/on_remove()
	REMOVE_TRAIT(owner, TRAIT_KNOCKEDOUT, TRAIT_STATUS_EFFECT(id))
	return ..()

/datum/status_effect/incapacitating/unconscious/tick()
	if(owner.getStaminaLoss())
		owner.adjustStaminaLoss(-0.3) //reduce stamina loss by 0.3 per tick, 6 per 2 seconds


//SLEEPING
/datum/status_effect/incapacitating/sleeping
	id = "sleeping"
	alert_type = /atom/movable/screen/alert/status_effect/asleep
	needs_update_stat = TRUE
	tick_interval = 2 SECONDS

/datum/status_effect/incapacitating/sleeping/on_apply()
	. = ..()
	if(!.)
		return
	if(!HAS_TRAIT(owner, TRAIT_SLEEPIMMUNE))
		ADD_TRAIT(owner, TRAIT_KNOCKEDOUT, TRAIT_STATUS_EFFECT(id))
		tick_interval = -1
	RegisterSignal(owner, SIGNAL_ADDTRAIT(TRAIT_SLEEPIMMUNE), .proc/on_owner_insomniac)
	RegisterSignal(owner, SIGNAL_REMOVETRAIT(TRAIT_SLEEPIMMUNE), .proc/on_owner_sleepy)

/datum/status_effect/incapacitating/sleeping/on_remove()
	UnregisterSignal(owner, list(SIGNAL_ADDTRAIT(TRAIT_SLEEPIMMUNE), SIGNAL_REMOVETRAIT(TRAIT_SLEEPIMMUNE)))
	if(!HAS_TRAIT(owner, TRAIT_SLEEPIMMUNE))
		REMOVE_TRAIT(owner, TRAIT_KNOCKEDOUT, TRAIT_STATUS_EFFECT(id))
		tick_interval = initial(tick_interval)
	return ..()

///If the mob is sleeping and gain the TRAIT_SLEEPIMMUNE we remove the TRAIT_KNOCKEDOUT and stop the tick() from happening
/datum/status_effect/incapacitating/sleeping/proc/on_owner_insomniac(mob/living/source)
	SIGNAL_HANDLER
	REMOVE_TRAIT(owner, TRAIT_KNOCKEDOUT, TRAIT_STATUS_EFFECT(id))
	tick_interval = -1

///If the mob has the TRAIT_SLEEPIMMUNE but somehow looses it we make him sleep and restart the tick()
/datum/status_effect/incapacitating/sleeping/proc/on_owner_sleepy(mob/living/source)
	SIGNAL_HANDLER
	ADD_TRAIT(owner, TRAIT_KNOCKEDOUT, TRAIT_STATUS_EFFECT(id))
	tick_interval = initial(tick_interval)

/datum/status_effect/incapacitating/sleeping/tick()
	if(owner.maxHealth)
		var/health_ratio = owner.health / owner.maxHealth
		var/healing = HEALING_SLEEP_DEFAULT

		// having high spirits helps us recover
		/*if(owner.mob_mood)
			switch(owner.mob_mood.sanity_level)
				if(SANITY_LEVEL_GREAT)
					healing = 0.2
				if(SANITY_LEVEL_NEUTRAL)
					healing = 0.1
				if(SANITY_LEVEL_DISTURBED)
					healing = 0
				if(SANITY_LEVEL_UNSTABLE)
					healing = 0
				if(SANITY_LEVEL_CRAZY)
					healing = -0.1
				if(SANITY_LEVEL_INSANE)
					healing = -0.2*/

		var/turf/rest_turf = get_turf(owner)
		var/is_sleeping_in_darkness = rest_turf.get_lumcount() <= LIGHTING_TILE_IS_DARK

		// sleeping with a blindfold or in the dark helps us rest
		if(owner.is_blind_from(EYES_COVERED) || is_sleeping_in_darkness)
			healing += 0.1

		// sleeping in silence is always better
		if(HAS_TRAIT(owner, TRAIT_DEAF))
			healing += 0.1

		// check for beds
		if((locate(/obj/structure/bed) in owner.loc))
			healing += 0.2
		else if((locate(/obj/structure/table) in owner.loc))
			healing += 0.1

		// don't forget the bedsheet
		if(locate(/obj/item/bedsheet) in owner.loc)
			healing += 0.1

		// you forgot the pillow
		if(locate(/obj/item/pillow) in owner.loc)
			healing += 0.1

		if(healing > 0)
			if(iscarbon(owner))
				var/mob/living/carbon/carbon_owner = owner
				for(var/obj/item/organ/target_organ as anything in carbon_owner.organs)
					// no healing boost for robotic or dying organs
					if(IS_ROBOTIC_ORGAN(target_organ) || !target_organ.damage || target_organ.organ_flags & ORGAN_FAILING)
						continue

					// organ regeneration is very low so we crank up the healing rate to give a good bonus
					var/healing_bonus = target_organ.healing_factor * healing * HEALING_SLEEP_ORGAN_MULTIPLIER
					target_organ.apply_organ_damage(-healing_bonus * target_organ.maxHealth)

			if(health_ratio > 0.8) // only heals minor physical damage
				owner.adjustBruteLoss(-1 * healing, required_bodytype = BODYTYPE_ORGANIC)
				owner.adjustFireLoss(-1 * healing, required_bodytype = BODYTYPE_ORGANIC)
				owner.adjustToxLoss(-1 * healing * 0.5, TRUE, TRUE, required_biotype = MOB_ORGANIC)
		owner.adjustStaminaLoss(min(-1 * healing, -1 * HEALING_SLEEP_DEFAULT))
	// Drunkenness gets reduced by 0.3% per tick (6% per 2 seconds)
	owner.set_drunk_effect(owner.get_drunk_amount() * 0.997)

	if(iscarbon(owner))
		var/mob/living/carbon/carbon_owner = owner
		carbon_owner.handle_dreams()

	if(prob(2) && owner.health > owner.crit_threshold)
		owner.emote("snore")

/atom/movable/screen/alert/status_effect/asleep
	name = "Asleep"
	desc = "You've fallen asleep. Wait a bit and you should wake up. Unless you don't, considering how helpless you are."
	icon_state = "asleep"

/datum/status_effect/cultghost //is a cult ghost and can't use manifest runes
	id = "cult_ghost"
	duration = -1
	alert_type = null

/datum/status_effect/cultghost/on_apply()
	owner.set_invis_see(SEE_INVISIBLE_OBSERVER)
	return TRUE

/datum/status_effect/cultghost/tick()
	if(owner.reagents)
		owner.reagents.del_reagent(/datum/reagent/water/holywater) //can't be deconverted

/datum/status_effect/crusher_mark
	id = "crusher_mark"
	duration = 300 //if you leave for 30 seconds you lose the mark, deal with it
	status_type = STATUS_EFFECT_REPLACE
	alert_type = null
	var/mutable_appearance/marked_underlay
	var/obj/item/kinetic_crusher/hammer_synced


/datum/status_effect/crusher_mark/on_creation(mob/living/new_owner, obj/item/kinetic_crusher/new_hammer_synced)
	. = ..()
	if(.)
		hammer_synced = new_hammer_synced

/datum/status_effect/crusher_mark/on_apply()
	if(owner.mob_size >= MOB_SIZE_LARGE)
		marked_underlay = mutable_appearance('icons/effects/effects.dmi', "shield2")
		marked_underlay.pixel_x = -owner.pixel_x
		marked_underlay.pixel_y = -owner.pixel_y
		owner.underlays += marked_underlay
		return TRUE
	return FALSE

/datum/status_effect/crusher_mark/Destroy()
	hammer_synced = null
	if(owner)
		owner.underlays -= marked_underlay
	QDEL_NULL(marked_underlay)
	return ..()

/datum/status_effect/crusher_mark/be_replaced()
	owner.underlays -= marked_underlay //if this is being called, we should have an owner at this point.
	..()

/datum/status_effect/stacking/saw_bleed
	id = "saw_bleed"
	tick_interval = 6
	delay_before_decay = 5
	stack_threshold = 10
	max_stacks = 10
	overlay_file = 'icons/effects/bleed.dmi'
	underlay_file = 'icons/effects/bleed.dmi'
	overlay_state = "bleed"
	underlay_state = "bleed"
	var/bleed_damage = 200

/datum/status_effect/stacking/saw_bleed/fadeout_effect()
	new /obj/effect/temp_visual/bleed(get_turf(owner))

/datum/status_effect/stacking/saw_bleed/threshold_cross_effect()
	owner.adjustBruteLoss(bleed_damage)
	var/turf/T = get_turf(owner)
	new /obj/effect/temp_visual/bleed/explode(T)
	for(var/d in GLOB.alldirs)
		new /obj/effect/temp_visual/dir_setting/bloodsplatter(T, d)
	playsound(T, SFX_DESECRATION, 100, TRUE, -1)

/datum/status_effect/stacking/saw_bleed/bloodletting
	id = "bloodletting"
	stack_threshold = 7
	max_stacks = 7
	bleed_damage = 20

/datum/status_effect/neck_slice
	id = "neck_slice"
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = null
	duration = -1

/datum/status_effect/neck_slice/on_apply()
	if(!ishuman(owner))
		return FALSE
	if(!owner.get_bodypart(BODY_ZONE_HEAD))
		return FALSE
	return TRUE

/datum/status_effect/neck_slice/tick()
	var/obj/item/bodypart/throat = owner.get_bodypart(BODY_ZONE_HEAD)
	if(owner.stat == DEAD || !throat) // they can lose their head while it's going.
		qdel(src)
		return

	var/still_bleeding = FALSE
	for(var/datum/wound/bleeding_thing as anything in throat.wounds)
		if(bleeding_thing.wound_type == WOUND_SLASH && bleeding_thing.severity > WOUND_SEVERITY_MODERATE)
			still_bleeding = TRUE
			break
	if(!still_bleeding)
		qdel(src)
		return

	if(prob(10))
		owner.emote(pick("gasp", "gag", "choke"))

/datum/status_effect/neck_slice/get_examine_text()
	return SPAN_WARNING("[owner.p_Their()] neck is cut and is bleeding profusely!")

/datum/status_effect/gonbola_pacify
	id = "gonbolaPacify"
	status_type = STATUS_EFFECT_MULTIPLE
	tick_interval = -1
	alert_type = null

/datum/status_effect/gonbola_pacify/on_apply()
	. = ..()
	owner.add_traits(list(TRAIT_PACIFISM, TRAIT_MUTE), CLOTHING_TRAIT)
	//owner.add_mood_event(type, /datum/mood_event/gondola)
	to_chat(owner, SPAN_NOTICE("You suddenly feel at peace and feel no need to make any sudden or rash actions..."))

/datum/status_effect/gonbola_pacify/on_remove()
	owner.remove_traits(list(TRAIT_PACIFISM, TRAIT_MUTE), CLOTHING_TRAIT)
	//owner.clear_mood_event(type)
	return ..()

/datum/status_effect/trance
	id = "trance"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 300
	tick_interval = 10
	var/stun = TRUE
	alert_type = /atom/movable/screen/alert/status_effect/trance

/atom/movable/screen/alert/status_effect/trance
	name = "Trance"
	desc = "Everything feels so distant, and you can feel your thoughts forming loops inside your head..."
	icon_state = "high"

/datum/status_effect/trance/tick()
	if(stun)
		owner.Stun(6 SECONDS, TRUE)
	owner.set_dizzy(40 SECONDS)

/datum/status_effect/trance/on_apply()
	if(!iscarbon(owner))
		return FALSE
	RegisterSignal(owner, COMSIG_MOVABLE_HEAR, .proc/hypnotize)
	ADD_TRAIT(owner, TRAIT_MUTE, STATUS_EFFECT_TRAIT)
	owner.add_client_colour(/datum/client_colour/monochrome/trance)
	owner.visible_message("[stun ? SPAN_WARNING("[owner] stands still as [owner.p_their()] eyes seem to focus on a distant point.") : ""]", \
	SPAN_WARNING(pick("You feel your thoughts slow down...", "You suddenly feel extremely dizzy...", "You feel like you're in the middle of a dream...","You feel incredibly relaxed...")))
	return TRUE

/datum/status_effect/trance/on_creation(mob/living/new_owner, _duration, _stun = TRUE)
	duration = _duration
	stun = _stun
	return ..()

/datum/status_effect/trance/on_remove()
	UnregisterSignal(owner, COMSIG_MOVABLE_HEAR)
	REMOVE_TRAIT(owner, TRAIT_MUTE, STATUS_EFFECT_TRAIT)
	owner.remove_status_effect(/datum/status_effect/dizziness)
	owner.remove_client_colour(/datum/client_colour/monochrome/trance)
	to_chat(owner, SPAN_WARNING("You snap out of your trance!"))

/datum/status_effect/trance/get_examine_text()
	return SPAN_WARNING("[owner.p_they()] seem[owner.p_s()] slow and unfocused.")

/datum/status_effect/trance/proc/hypnotize(datum/source, list/hearing_args)
	SIGNAL_HANDLER

	if(!owner.can_hear() || owner == hearing_args[HEARING_SPEAKER])
		return

	var/mob/hearing_speaker = hearing_args[HEARING_SPEAKER]
	var/mob/living/carbon/C = owner
	C.cure_trauma_type(/datum/brain_trauma/hypnosis, TRAUMA_RESILIENCE_SURGERY) //clear previous hypnosis
	// The brain trauma itself does its own set of logging, but this is the only place the source of the hypnosis phrase can be found.
	hearing_speaker.log_message("hypnotised [key_name(C)] with the phrase '[hearing_args[HEARING_RAW_MESSAGE]]'", LOG_ATTACK, color="red")
	C.log_message("has been hypnotised by the phrase '[hearing_args[HEARING_RAW_MESSAGE]]' spoken by [key_name(hearing_speaker)]", LOG_VICTIM, color="orange", log_globally = FALSE)
	addtimer(CALLBACK(C, /mob/living/carbon.proc/gain_trauma, /datum/brain_trauma/hypnosis, TRAUMA_RESILIENCE_SURGERY, hearing_args[HEARING_RAW_MESSAGE]), 10)
	addtimer(CALLBACK(C, /mob/living.proc/Stun, 60, TRUE, TRUE), 15) //Take some time to think about it
	qdel(src)

/datum/status_effect/spasms
	id = "spasms"
	status_type = STATUS_EFFECT_MULTIPLE
	alert_type = null

/datum/status_effect/spasms/tick()
	if(owner.stat >= UNCONSCIOUS)
		return
	if(!prob(15))
		return
	switch(rand(1, 5))
		if(1)
			if((owner.mobility_flags & MOBILITY_MOVE) && isturf(owner.loc))
				to_chat(owner, SPAN_WARNING("Your leg spasms!"))
				step(owner, pick(GLOB.cardinals))
		if(2)
			if(owner.incapacitated())
				return
			var/obj/item/held_item = owner.get_active_held_item()
			if(!held_item)
				return
			to_chat(owner, SPAN_WARNING("Your fingers spasm!"))
			owner.log_message("used [held_item] due to a Muscle Spasm", LOG_ATTACK)
			held_item.attack_self(owner)
		if(3)
			owner.set_combat_mode(TRUE)

			var/range = 1
			if(istype(owner.get_active_held_item(), /obj/item/gun)) //get targets to shoot at
				range = 7

			var/list/mob/living/targets = list()
			for(var/mob/living/nearby_mobs in oview(owner, range))
				targets += nearby_mobs
			if(LAZYLEN(targets))
				to_chat(owner, SPAN_WARNING("Your arm spasms!"))
				owner.log_message(" attacked someone due to a Muscle Spasm", LOG_ATTACK) //the following attack will log itself
				owner.ClickOn(pick(targets))
			owner.set_combat_mode(FALSE)
		if(4)
			owner.set_combat_mode(TRUE)
			to_chat(owner, SPAN_WARNING("Your arm spasms!"))
			owner.log_message("attacked [owner.p_them()]self to a Muscle Spasm", LOG_ATTACK)
			owner.ClickOn(owner)
			owner.set_combat_mode(FALSE)
		if(5)
			if(owner.incapacitated())
				return
			var/obj/item/held_item = owner.get_active_held_item()
			var/list/turf/targets = list()
			for(var/turf/nearby_turfs in oview(owner, 3))
				targets += nearby_turfs
			if(LAZYLEN(targets) && held_item)
				to_chat(owner, SPAN_WARNING("Your arm spasms!"))
				owner.log_message("threw [held_item] due to a Muscle Spasm", LOG_ATTACK)
				owner.throw_item(pick(targets))

/datum/status_effect/convulsing
	id = "convulsing"
	duration = 150
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/convulsing

/datum/status_effect/convulsing/on_creation(mob/living/zappy_boy)
	. = ..()
	to_chat(zappy_boy, SPAN_WARNING("You feel a shock moving through your body! Your hands start shaking!"))

/datum/status_effect/convulsing/tick()
	var/mob/living/carbon/H = owner
	if(prob(40))
		var/obj/item/I = H.get_active_held_item()
		if(I && H.dropItemToGround(I))
			H.visible_message(
				SPAN_NOTICE("[H]'s hand convulses, and they drop their [I.name]!"),
				SPAN_USERDANGER("Your hand convulses violently, and you drop what you were holding!"),
			)
			H.adjust_jitter(10 SECONDS)

/atom/movable/screen/alert/status_effect/convulsing
	name = "Shaky Hands"
	desc = "You've been zapped with something and your hands can't stop shaking! You can't seem to hold on to anything."
	icon_state = "convulsing"

/datum/status_effect/fake_virus
	id = "fake_virus"
	duration = 1800//3 minutes
	status_type = STATUS_EFFECT_REPLACE
	tick_interval = 1
	alert_type = null
	var/msg_stage = 0//so you dont get the most intense messages immediately

/datum/status_effect/fake_virus/tick()
	var/fake_msg = ""
	var/fake_emote = ""
	switch(msg_stage)
		if(0 to 300)
			if(prob(1))
				fake_msg = pick(
				SPAN_WARNING(pick("Your head hurts.", "Your head pounds.")),
				SPAN_WARNING(pick("You're having difficulty breathing.", "Your breathing becomes heavy.")),
				SPAN_WARNING(pick("You feel dizzy.", "Your head spins.")),
				SPAN_WARNING(pick("You swallow excess mucus.", "You lightly cough.")),
				SPAN_WARNING(pick("Your head hurts.", "Your mind blanks for a moment.")),
				SPAN_WARNING(pick("Your throat hurts.", "You clear your throat.")))
		if(301 to 600)
			if(prob(2))
				fake_msg = pick(
				SPAN_WARNING(pick("Your head hurts a lot.", "Your head pounds incessantly.")),
				SPAN_WARNING(pick("Your windpipe feels like a straw.", "Your breathing becomes tremendously difficult.")),
				SPAN_WARNING("You feel very [pick("dizzy","woozy","faint")]."),
				SPAN_WARNING(pick("You hear a ringing in your ear.", "Your ears pop.")),
				SPAN_WARNING("You nod off for a moment."))
		else
			if(prob(3))
				if(prob(50))// coin flip to throw a message or an emote
					fake_msg = pick(
					SPAN_USERDANGER(pick("Your head hurts!", "You feel a burning knife inside your brain!", "A wave of pain fills your head!")),
					SPAN_USERDANGER(pick("Your lungs hurt!", "It hurts to breathe!")),
					SPAN_WARNING(pick("You feel nauseated.", "You feel like you're going to throw up!")))
				else
					fake_emote = pick("cough", "sniff", "sneeze")

	if(fake_emote)
		owner.emote(fake_emote)
	else if(fake_msg)
		to_chat(owner, fake_msg)

	msg_stage++

/datum/status_effect/stagger
	id = "stagger"
	status_type = STATUS_EFFECT_REFRESH
	duration = 30 SECONDS
	tick_interval = 1 SECONDS
	alert_type = null

/datum/status_effect/stagger/on_apply()
	owner.next_move_modifier *= 1.5
	if(ishostile(owner))
		var/mob/living/simple_animal/hostile/simple_owner = owner
		simple_owner.ranged_cooldown_time *= 2.5
	return TRUE

/datum/status_effect/stagger/on_remove()
	. = ..()
	if(QDELETED(owner))
		return
	owner.next_move_modifier /= 1.5
	if(ishostile(owner))
		var/mob/living/simple_animal/hostile/simple_owner = owner
		simple_owner.ranged_cooldown_time /= 2.5

/datum/status_effect/discoordinated
	id = "discoordinated"
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/discoordinated

/atom/movable/screen/alert/status_effect/discoordinated
	name = "Discoordinated"
	desc = "You can't seem to properly use anything..."
	icon_state = "convulsing"

/datum/status_effect/discoordinated/on_apply()
	ADD_TRAIT(owner, TRAIT_DISCOORDINATED_TOOL_USER, "[type]")
	return ..()

/datum/status_effect/discoordinated/on_remove()
	REMOVE_TRAIT(owner, TRAIT_DISCOORDINATED_TOOL_USER, "[type]")
	return ..()

#undef HEALING_SLEEP_DEFAULT
#undef HEALING_SLEEP_ORGAN_MULTIPLIER
