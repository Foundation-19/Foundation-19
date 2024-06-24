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
	var/datum/reagent/eigen = owner.reagents?.has_reagent(/datum/reagent/eigenstate)
	if(eigen)
		if(eigen.overdose_percentage() > 1)
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

			if(iscarbon(owner))
				var/mob/living/carbon/C = owner
				C.adjust_nutrition(-4)

		//phase 2
		if(EIGENSTASIUM_PHASE_1_END to EIGENSTASIUM_PHASE_2_END)
			if(current_cycle == 51)
				to_chat(owner, SPAN_USERDANGER("You start to convlse violently as you feel your consciousness merges across realities, your possessions flying wildy off your body!"))
				owner.set_jitter_if_lower(400 SECONDS)
				owner.Weaken(1 SECOND)

			var/obj/item/item = pick(owner.get_contents())

			if(isnull(item))
				return ..()

			owner.drop_from_inventory(item)
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
					RegisterSignal(alt_clone, COMSIG_PARENT_QDELETING, PROC_REF(remove_clone_from_var))
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
			log_game("[owner] has become an alternative universe version of themselves via EIGENSTASIUM.")
			//new you new stuff
			//SSquirks.randomise_quirks(owner)
			owner.reagents?.reagent_list.Cut()
			//owner.mob_mood.remove_temp_moods()
			var/mob/living/carbon/human/human_mob = owner
			//owner.add_mood_event("Eigentrip", /datum/mood_event/eigentrip)
			if(QDELETED(human_mob))
				return

			human_mob.randomize_hair_style()
			human_mob.randomize_skin_tone()
			human_mob.randomize_facial_hair_style()

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
