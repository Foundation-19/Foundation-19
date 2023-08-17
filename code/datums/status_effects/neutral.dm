//entirely neutral or internal status effects go here

/datum/status_effect/throat_soothed
	id = "throat_soothed"
	duration = 60 SECONDS
	status_type = STATUS_EFFECT_REFRESH
	alert_type = null

/datum/status_effect/throat_soothed/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_SOOTHED_THROAT, "[STATUS_EFFECT_TRAIT]_[id]")

/datum/status_effect/throat_soothed/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_SOOTHED_THROAT, "[STATUS_EFFECT_TRAIT]_[id]")

// this status effect is used to negotiate the high-fiving capabilities of all concerned parties
/datum/status_effect/offering
	id = "offering"
	duration = -1
	tick_interval = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = null
	/// The people who were offered this item at the start
	var/list/possible_takers
	/// The actual item being offered
	var/obj/item/offered_item
	/// The type of alert given to people when offered, in case you need to override some behavior (like for high-fives)
	var/give_alert_type = /atom/movable/screen/alert/give

/datum/status_effect/offering/on_creation(mob/living/new_owner, obj/item/offer, give_alert_override, mob/living/carbon/offered)
	. = ..()
	if(!.)
		return
	offered_item = offer
	if(give_alert_override)
		give_alert_type = give_alert_override

	if(offered && is_taker_elligible(offered))
		register_candidate(offered)
	else
		for(var/mob/living/carbon/possible_taker in orange(1, owner))
			if(!is_taker_elligible(possible_taker))
				continue

			register_candidate(possible_taker)

	if(!possible_takers) // no one around
		qdel(src)
		return

	RegisterSignal(owner, COMSIG_MOVED, .proc/check_owner_in_range)
	RegisterSignals(offered_item, list(COMSIG_PARENT_QDELETING, COMSIG_ITEM_DROPPED), .proc/dropped_item)

/datum/status_effect/offering/Destroy()
	for(var/mob/living/carbon/removed_taker as anything in possible_takers)
		remove_candidate(removed_taker)
	LAZYCLEARLIST(possible_takers)
	offered_item = null
	return ..()

/// Hook up the specified carbon mob to be offered the item in question, give them the alert and signals and all
/datum/status_effect/offering/proc/register_candidate(mob/living/carbon/possible_candidate)
	var/atom/movable/screen/alert/give/G = possible_candidate.throw_alert("[owner]", give_alert_type)
	if(!G)
		return
	LAZYADD(possible_takers, possible_candidate)
	RegisterSignal(possible_candidate, COMSIG_MOVED, .proc/check_taker_in_range)
	G.setup(possible_candidate, src)

/// Remove the alert and signals for the specified carbon mob. Automatically removes the status effect when we lost the last taker
/datum/status_effect/offering/proc/remove_candidate(mob/living/carbon/removed_candidate)
	removed_candidate.clear_alert("[owner]")
	LAZYREMOVE(possible_takers, removed_candidate)
	UnregisterSignal(removed_candidate, COMSIG_MOVED)
	if(!possible_takers && !QDELING(src))
		qdel(src)

/// One of our possible takers moved, see if they left us hanging
/datum/status_effect/offering/proc/check_taker_in_range(mob/living/carbon/taker)
	SIGNAL_HANDLER
	if(owner.CanReach(taker) && !IS_DEAD_OR_INCAP(taker))
		return

	to_chat(taker, SPAN_WARNING("You moved out of range of [owner]!"))
	remove_candidate(taker)

/// The offerer moved, see if anyone is out of range now
/datum/status_effect/offering/proc/check_owner_in_range(mob/living/carbon/source)
	SIGNAL_HANDLER

	for(var/mob/living/carbon/checking_taker as anything in possible_takers)
		if(!istype(checking_taker) || !owner.CanReach(checking_taker) || IS_DEAD_OR_INCAP(checking_taker))
			remove_candidate(checking_taker)

/// We lost the item, give it up
/datum/status_effect/offering/proc/dropped_item(obj/item/source)
	SIGNAL_HANDLER
	qdel(src)

/**
 * Is our taker valid as a target for the offering? Meant to be used when registering
 * takers in `on_creation()`. You should override `additional_taker_check()` instead of this.
 *
 * Returns `TRUE` if the taker is valid as a target for the offering.
 */
/datum/status_effect/offering/proc/is_taker_elligible(mob/living/carbon/taker)
	return owner.CanReach(taker) && !IS_DEAD_OR_INCAP(taker) && additional_taker_check(taker)

/**
 * Additional checks added to `CanReach()` and `IS_DEAD_OR_INCAP()` in `is_taker_elligible()`.
 * Should be what you override instead of `is_taker_elligible()`. By default, checks if the
 * taker can hold items.
 *
 * Returns `TRUE` if the taker is valid as a target for the offering based on these
 * additional checks.
 */
/datum/status_effect/offering/proc/additional_taker_check(mob/living/carbon/taker)
	return taker.can_hold_items()

/**
 * This status effect is meant only for items that you don't actually receive
 * when offered, mostly useful for `/obj/item/hand_item` subtypes.
 */
/datum/status_effect/offering/no_item_received

/datum/status_effect/offering/no_item_received/additional_taker_check(mob/living/carbon/taker)
	return taker.usable_hands > 0

/**
 * This status effect is meant only to be used for offerings that require the target to
 * be resting (like when you're trying to give them a hand to help them up).
 * Also doesn't require them to have their hands free (since you're not giving them
 * anything).
 */
/datum/status_effect/offering/no_item_received/needs_resting

/datum/status_effect/offering/no_item_received/needs_resting/additional_taker_check(mob/living/carbon/taker)
	return taker.body_position == LYING_DOWN

/datum/status_effect/offering/no_item_received/needs_resting/on_creation(mob/living/new_owner, obj/item/offer, give_alert_override, mob/living/carbon/offered)
	. = ..()
	RegisterSignal(owner, COMSIG_LIVING_SET_BODY_POSITION, .proc/check_owner_standing)

/datum/status_effect/offering/no_item_received/needs_resting/register_candidate(mob/living/carbon/possible_candidate)
	. = ..()
	RegisterSignal(possible_candidate, COMSIG_LIVING_SET_BODY_POSITION, .proc/check_candidate_resting)

/datum/status_effect/offering/no_item_received/needs_resting/remove_candidate(mob/living/carbon/removed_candidate)
	UnregisterSignal(removed_candidate, COMSIG_LIVING_SET_BODY_POSITION)
	return ..()

/// Simple signal handler that ensures that, if the owner stops standing, the offer no longer stands either!
/datum/status_effect/offering/no_item_received/needs_resting/proc/check_owner_standing(mob/living/carbon/owner)
	if(src.owner.body_position == STANDING_UP)
		return

	// This doesn't work anymore if the owner is no longer standing up, sorry!
	qdel(src)

/// Simple signal handler that ensures that, should a candidate now be standing up, the offer won't be standing for them anymore!
/datum/status_effect/offering/no_item_received/needs_resting/proc/check_candidate_resting(mob/living/carbon/candidate)
	SIGNAL_HANDLER

	if(candidate.body_position == LYING_DOWN)
		return

	// No longer lying down? You're no longer eligible to take the offer, sorry!
	remove_candidate(candidate)

/// Subtype for high fives, so we can fake out people
/datum/status_effect/offering/no_item_received/high_five
	id = "offer_high_five"

/datum/status_effect/offering/no_item_received/high_five/dropped_item(obj/item/source)
	// Lets us "too slow" people, instead of qdeling we just handle the ref
	offered_item = null

/*
 * A status effect used for preventing caltrop message spam
 *
 * While a mob has this status effect, they won't recieve any messages about
 * stepping on caltrops. But they will be stunned and damaged regardless.
 *
 * The status effect itself has no effect, other than to disappear after
 * a second.
 */
/datum/status_effect/caltropped
	id = "caltropped"
	duration = 1 SECONDS
	tick_interval = INFINITY
	status_type = STATUS_EFFECT_REFRESH
	alert_type = null

#define EIGENSTASIUM_MAX_BUFFER -251
#define EIGENSTASIUM_STABILISATION_RATE 5
#define EIGENSTASIUM_PHASE_1_END 50
#define EIGENSTASIUM_PHASE_2_END 80
#define EIGENSTASIUM_PHASE_3_START 100
#define EIGENSTASIUM_PHASE_3_END 150

/datum/status_effect/eigenstasium
	id = "eigenstasium"
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = null
	processing_speed = STATUS_EFFECT_NORMAL_PROCESS
	///So we know what cycle we're in during the status
	var/current_cycle = EIGENSTASIUM_MAX_BUFFER //Consider it your stability
	///The addiction looper for addiction stage 3
	var/phase_3_cycle = -0 //start off delayed
	///Your clone from another reality
	var/mob/living/carbon/alt_clone = null
	///If we display the stabilised message or not
	var/stable_message = FALSE

/datum/status_effect/eigenstasium/Destroy()
	if(alt_clone)
		UnregisterSignal(alt_clone, COMSIG_PARENT_QDELETING)
		QDEL_NULL(alt_clone)
	return ..()

/datum/status_effect/eigenstasium/tick()
	. = ..()
	//This stuff runs every cycle
	if(prob(5))
		sparks(5, FALSE, owner)

	//If we have a reagent that blocks the effects
	var/block_effects = FALSE
	if(owner.reagents?.has_reagent(/datum/reagent/bluespace))
		current_cycle = max(EIGENSTASIUM_MAX_BUFFER, (current_cycle - (EIGENSTASIUM_STABILISATION_RATE * 1.5))) //cap to -250
		block_effects = TRUE
	if(owner.reagents?.has_reagent(/datum/reagent/stabilizing_agent))
		current_cycle = max(EIGENSTASIUM_MAX_BUFFER, (current_cycle - EIGENSTASIUM_STABILISATION_RATE))
		block_effects = TRUE
	var/datum/reagent/eigen = owner.reagents?.has_reagent(/datum/reagent/eigenstate)
	if(eigen)
		if(eigen.overdosed)
			block_effects = FALSE
		else
			current_cycle = max(EIGENSTASIUM_MAX_BUFFER, (current_cycle - (EIGENSTASIUM_STABILISATION_RATE * 2)))
			block_effects = TRUE

	if(!QDELETED(alt_clone)) //catch any stragglers
		sparks(5, FALSE, alt_clone)
		owner.visible_message("[owner] is snapped across to a different alternative reality!")
		QDEL_NULL(alt_clone)

	if(block_effects)
		if(!stable_message)
			owner.visible_message("You feel stable...for now.")
			stable_message = TRUE
		return
	stable_message = FALSE


	//Increment cycle
	current_cycle++ //needs to be done here because phase 2 can early return

	//These run on specific cycles
	switch(current_cycle)
		if(0)
			to_chat(owner, SPAN_USERDANGER("You feel like you're being pulled across to somewhere else. You feel empty inside."))

		//phase 1
		if(1 to EIGENSTASIUM_PHASE_1_END)
			owner.set_jitter_if_lower(4 SECONDS)
			owner.adjust_nutrition(-4)

		//phase 2
		if(EIGENSTASIUM_PHASE_1_END to EIGENSTASIUM_PHASE_2_END)
			if(current_cycle == 51)
				to_chat(owner, SPAN_USERDANGER("You start to convlse violently as you feel your consciousness merges across realities, your possessions flying wildy off your body!"))
				owner.set_jitter_if_lower(400 SECONDS)
				owner.Knockdown(10)

			var/list/items = list()
			var/max_loop
			if (length(owner.get_contents()) >= 10)
				max_loop = 10
			else
				max_loop = length(owner.get_contents())
			for (var/i in 1 to max_loop)
				var/obj/item/item = owner.get_contents()[i]
				if ((item.item_flags & DROPDEL) || HAS_TRAIT(item, TRAIT_NODROP)) // can't teleport these kinds of items
					continue
				items.Add(item)

			if(!LAZYLEN(items))
				return ..()
			var/obj/item/item = pick(items)
			owner.dropItemToGround(item, TRUE)
			sparks(5, FALSE, item)
			do_teleport(item, get_turf(item), 3, /decl/teleport);
			sparks(5, FALSE, item)

		//phase 3 - little break to get your items
		if(EIGENSTASIUM_PHASE_3_START to EIGENSTASIUM_PHASE_3_END)
			//Clone function - spawns a clone then deletes it - simulates multiple copies of the player teleporting in
			switch(phase_3_cycle) //Loops 0 -> 1 -> 2 -> 1 -> 2 -> 1 ...ect.
				if(0)
					owner.set_jitter_if_lower(200 SECONDS)
					to_chat(owner, SPAN_USERDANGER("Your eigenstate starts to rip apart, drawing in alternative reality versions of yourself!"))
				if(1)
					var/typepath = owner.type
					alt_clone = new typepath(owner.loc)
					alt_clone.appearance = owner.appearance
					alt_clone.real_name = owner.real_name
					RegisterSignal(alt_clone, COMSIG_PARENT_QDELETING, .proc/remove_clone_from_var)
					owner.visible_message("[owner] splits into seemingly two versions of themselves!")
					do_teleport(alt_clone, get_turf(alt_clone), 2, /decl/teleport) //teleports clone so it's hard to find the real one!
					sparks(5, FALSE, alt_clone)
					alt_clone.emote("spin")
					owner.emote("spin")
					var/list/say_phrases = strings(EIGENSTASIUM_FILE, "lines")
					alt_clone.say(pick(say_phrases))
				if(2)
					phase_3_cycle = 0 //counter
			phase_3_cycle++
			do_teleport(owner, get_turf(owner), 2, /decl/teleport) //Teleports player randomly
			sparks(5, FALSE, owner)

		//phase 4
		if(EIGENSTASIUM_PHASE_3_END to INFINITY)
			//clean up and remove status
			//SSblackbox.record_feedback("tally", "chemical_reaction", 1, "Eigenstasium wild rides ridden")
			sparks(5, FALSE, owner)
			do_teleport(owner, get_turf(owner), 2, /decl/teleport) //teleports clone so it's hard to find the real one!
			sparks(5, FALSE, owner)
			owner.Sleeping(100)
			owner.set_jitter_if_lower(100 SECONDS)
			to_chat(owner, SPAN_USERDANGER("You feel your eigenstate settle, as \"you\" become an alternative version of yourself!"))
			owner.emote("me",1,"flashes into reality suddenly, gasping as they gaze around in a bewildered and highly confused fashion!",TRUE)
			owner.log_message("has become an alternative universe version of themselves via EIGENSTASIUM.", LOG_GAME)
			//new you new stuff
			//SSquirks.randomise_quirks(owner)
			owner.reagents.remove_all(1000)
			//owner.mob_mood.remove_temp_moods()
			var/mob/living/carbon/human/human_mob = owner
			//owner.add_mood_event("Eigentrip", /datum/mood_event/eigentrip)
			if(QDELETED(human_mob))
				return
			var/datum/species/human_species = human_mob.dna?.species
			if(human_species)
				human_species.randomize_features(human_mob)

			owner.remove_status_effect(/datum/status_effect/eigenstasium)

/datum/status_effect/eigenstasium/proc/remove_clone_from_var()
	SIGNAL_HANDLER
	UnregisterSignal(alt_clone, COMSIG_PARENT_QDELETING)

/datum/status_effect/eigenstasium/on_remove()
	if(!QDELETED(alt_clone))//catch any stragilers
		sparks(5, FALSE, alt_clone)
		owner.visible_message("One of the [owner]s suddenly phases out of reality in front of you!")
		QDEL_NULL(alt_clone)
	return ..()

#undef EIGENSTASIUM_MAX_BUFFER
#undef EIGENSTASIUM_STABILISATION_RATE
#undef EIGENSTASIUM_PHASE_1_END
#undef EIGENSTASIUM_PHASE_2_END
#undef EIGENSTASIUM_PHASE_3_START
#undef EIGENSTASIUM_PHASE_3_END

///Makes the mob luminescent for the duration of the effect.
/datum/status_effect/tinlux_light
	id = "tinea_luxor_light"
	processing_speed = STATUS_EFFECT_NORMAL_PROCESS
	remove_on_fullheal = TRUE
	var/obj/effect/dummy/lighting_obj/moblight/mob_light_obj

/datum/status_effect/tinlux_light/on_creation(mob/living/new_owner, duration)
	if(duration)
		src.duration = duration
	return ..()

/datum/status_effect/tinlux_light/on_apply()
	mob_light_obj = owner.mob_light(2)
	return TRUE

/datum/status_effect/tinlux_light/on_remove()
	QDEL_NULL(mob_light_obj)
