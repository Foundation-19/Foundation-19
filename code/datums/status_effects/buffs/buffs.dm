/datum/status_effect/exercised
	id = "Exercised"
	duration = 1200
	alert_type = null
	processing_speed = STATUS_EFFECT_NORMAL_PROCESS

/datum/status_effect/good_music
	id = "Good Music"
	alert_type = null
	duration = 6 SECONDS
	tick_interval = 1 SECONDS
	status_type = STATUS_EFFECT_REFRESH

/datum/status_effect/good_music/tick()
	if(owner.can_hear())
		owner.adjust_dizzy(-4 SECONDS)
		owner.adjust_jitter(-4 SECONDS)
		owner.adjust_confusion(-1 SECONDS)
		//owner.add_mood_event("goodmusic", /datum/mood_event/goodmusic)

/datum/status_effect/mayhem
	id = "Mayhem"
	duration = 2 MINUTES
	/// The chainsaw spawned by the status effect
	var/obj/item/chainsaw/doomslayer/chainsaw

/datum/status_effect/mayhem/on_apply()
	. = ..()
	to_chat(owner, "<span class='reallybig redtext'>RIP AND TEAR</span>")
	sound_to(owner, sound('sound/hallucinations/veryfar_noise.ogg'))
	owner.cause_hallucination( \
		/datum/hallucination/delusion/preset/demon, \
		"[id] status effect", \
		duration = duration, \
		affects_us = FALSE, \
		affects_others = TRUE, \
		skip_nearby = FALSE, \
		play_wabbajack = FALSE, \
	)

	owner.drop_all_held_items()

	if(iscarbon(owner))
		chainsaw = new(get_turf(owner))
		ADD_TRAIT(chainsaw, TRAIT_NODROP, CHAINSAW_FRENZY_TRAIT)
		owner.put_in_hands(chainsaw, forced = TRUE)
		chainsaw.attack_self(owner)
		owner.reagents.add_reagent(/datum/reagent/medicine/adminordrazine, 25)

	owner.log_message("entered a blood frenzy", LOG_ATTACK)
	to_chat(owner, SPAN_WARNING("KILL, KILL, KILL! YOU HAVE NO ALLIES ANYMORE, KILL THEM ALL!"))

	var/datum/client_colour/colour = owner.add_client_colour(/datum/client_colour/bloodlust)
	QDEL_IN(colour, 1.1 SECONDS)
	return TRUE

/datum/status_effect/mayhem/on_remove()
	. = ..()
	to_chat(owner, SPAN_NOTICE("Your bloodlust seeps back into the bog of your subconscious and you regain self control."))
	owner.log_message("exited a blood frenzy", LOG_ATTACK)
	QDEL_NULL(chainsaw)

/datum/status_effect/speed_boost
	id = "speed_boost"
	duration = 2 SECONDS
	status_type = STATUS_EFFECT_REPLACE

/datum/status_effect/speed_boost/on_creation(mob/living/new_owner, set_duration)
	if(isnum(set_duration))
		duration = set_duration
	. = ..()

/datum/status_effect/speed_boost/on_apply()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/status_speed_boost, update = TRUE)
	return ..()

/datum/status_effect/speed_boost/on_remove()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/status_speed_boost, update = TRUE)

/datum/movespeed_modifier/status_speed_boost
	multiplicative_slowdown = -1

///this buff provides a max health buff and a heal.
/datum/status_effect/limited_buff/health_buff
	id = "health_buff"
	alert_type = null
	///This var stores the mobs max health when the buff was first applied, and determines the size of future buffs.database.database.
	var/historic_max_health
	///This var determines how large the health buff will be. health_buff_modifier * historic_max_health * stacks
	var/health_buff_modifier = 0.1 //translate to a 10% buff over historic health per stack
	///This modifier multiplies the healing by the effect.
	var/healing_modifier = 2
	///If the mob has a low max health, we instead use this flat value to increase max health and calculate any heal.
	var/fragile_mob_health_buff = 10

/datum/status_effect/limited_buff/health_buff/on_creation(mob/living/new_owner)
	historic_max_health = new_owner.maxHealth
	. = ..()

/datum/status_effect/limited_buff/health_buff/on_apply()
	. = ..()
	var/health_increase = round(max(fragile_mob_health_buff, historic_max_health * health_buff_modifier))
	owner.maxHealth += health_increase
	owner.balloon_alert_to_viewers("health buffed")
	to_chat(owner, SPAN_GOOD("You feel healthy, like if your body is little stronger than it was a moment ago."))

	if(isanimal(owner))	//dumb animals have their own proc for healing.
		var/mob/living/simple_animal/healthy_animal = owner
		healthy_animal.adjustHealth(-(health_increase * healing_modifier))
	else
		owner.adjustBruteLoss(-(health_increase * healing_modifier))

/datum/status_effect/limited_buff/health_buff/maxed_out()
	. = ..()
	to_chat(owner, SPAN_WARNING("You don't feel any healthier."))
