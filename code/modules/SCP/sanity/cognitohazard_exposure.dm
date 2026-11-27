
#define COGNITOHAZARD_PROTECTION_NONE 0
#define COGNITOHAZARD_PROTECTION_PARTIAL 0.5
#define COGNITOHAZARD_PROTECTION_FULL 1

#define COGNITOHAZARD_TIER_UNEASE 1
#define COGNITOHAZARD_TIER_PARANOIA 2
#define COGNITOHAZARD_TIER_HALLUCINATION 3
#define COGNITOHAZARD_TIER_COMPULSION 4
#define COGNITOHAZARD_TIER_BREAKDOWN 5

#define COGNITOHAZARD_TIER_1_THRESHOLD 10
#define COGNITOHAZARD_TIER_2_THRESHOLD 25
#define COGNITOHAZARD_TIER_3_THRESHOLD 50
#define COGNITOHAZARD_TIER_4_THRESHOLD 75
#define COGNITOHAZARD_TIER_5_THRESHOLD 95

#define COGNITOHAZARD_DECAY_RATE 0.5
#define COGNITOHAZARD_ACCUMULATION_RATE 0.3
#define COGNITOHAZARD_DARKNESS_MULTIPLIER 1.5

// Exposure sources call apply_cognitohazard_exposure() to add
// accumulation; the status effect self-installs on first exposure.

/datum/movespeed_modifier/cognitohazard_paranoia
	variable = TRUE

/datum/status_effect/cognitohazard_exposure
	id = "cognitohazard_exposure"
	duration = -1
	tick_interval = 2 SECONDS
	// F19 has no STATUS_EFFECT_CHANGE: REFRESH re-runs refresh() with the
	// apply args when re-applied — we consume the extra arg as exposure.
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/cognitohazard_exposure

	var/accumulation = 0
	var/max_accumulation = 100
	var/current_tier = 0
	var/source_id = "generic"
	var/darkness_amplified = FALSE
	var/protection_level = COGNITOHAZARD_PROTECTION_NONE

	var/list/tier_messages = list(
		"",
		"You feel a growing sense of unease...",
		"Paranoid thoughts creep into your mind...",
		"You begin to see things that aren't there...",
		"A compulsion grips you, your body fights against itself...",
		"Your mind fractures under the strain. Reality breaks apart.",
	)

	var/list/tier_thresholds = list(
		COGNITOHAZARD_TIER_1_THRESHOLD,
		COGNITOHAZARD_TIER_2_THRESHOLD,
		COGNITOHAZARD_TIER_3_THRESHOLD,
		COGNITOHAZARD_TIER_4_THRESHOLD,
		COGNITOHAZARD_TIER_5_THRESHOLD,
	)

/datum/status_effect/cognitohazard_exposure/on_creation(mob/living/new_owner, source_id_new = "generic", initial_dose = 0)
	. = ..()
	if(. == null || QDELETED(src))
		return
	source_id = source_id_new
	if(initial_dose > 0)
		accumulation = min(accumulation + modify_change(initial_dose), max_accumulation)
		update_tier()

/datum/status_effect/cognitohazard_exposure/on_apply()
	RegisterSignal(owner, COMSIG_MOVED, PROC_REF(on_moved))
	update_protection()
	return TRUE

/datum/status_effect/cognitohazard_exposure/on_remove()
	UnregisterSignal(owner, COMSIG_MOVED)
	if(current_tier >= COGNITOHAZARD_TIER_HALLUCINATION)
		clear_hallucinations()

/datum/status_effect/cognitohazard_exposure/Destroy()
	if(owner)
		UnregisterSignal(owner, COMSIG_MOVED)
	return ..()

/datum/status_effect/cognitohazard_exposure/refresh(effect, ...)
	// Re-application passes (source_id, amount): treat as exposure dose.
	// args[1]=src is consumed by the framework; args[2]=source_id,
	// args[3]=amount.
	if(length(args) >= 3)
		source_id = args[2]
		var/amount = args[3]
		if(amount > 0)
			amount = modify_change(amount)
			if(amount > 0)
				accumulation = min(accumulation + amount, max_accumulation)
				update_tier()
	// duration is -1; base refresh no-ops on infinite durations.
	return ..()

/datum/status_effect/cognitohazard_exposure/proc/modify_change(change_amount)
	if(protection_level >= COGNITOHAZARD_PROTECTION_FULL)
		return 0
	return change_amount * (1 - protection_level)

/datum/status_effect/cognitohazard_exposure/tick(delta_time, times_fired)
	if(owner.stat == DEAD)
		qdel(src)
		return

	update_protection()
	update_darkness()

	accumulation = max(0, accumulation - COGNITOHAZARD_DECAY_RATE)

	if(protection_level < COGNITOHAZARD_PROTECTION_FULL && accumulation < max_accumulation)
		var/growth = COGNITOHAZARD_ACCUMULATION_RATE
		if(darkness_amplified)
			growth *= COGNITOHAZARD_DARKNESS_MULTIPLIER
		accumulation = min(accumulation + growth, max_accumulation)

	update_tier()
	apply_tier_effects()

/datum/status_effect/cognitohazard_exposure/proc/update_protection()
	protection_level = COGNITOHAZARD_PROTECTION_NONE

	var/mob/living/carbon/human/H = owner
	if(!istype(H))
		return

	if(istype(H.wear_suit, /obj/item/clothing/suit/bio_suit))
		protection_level += COGNITOHAZARD_PROTECTION_PARTIAL

	if(istype(H.head, /obj/item/clothing/head/bio_hood))
		protection_level += COGNITOHAZARD_PROTECTION_PARTIAL

	// F19 memetic insulation gear provides protection.
	if(istype(H.wear_mask, /obj/item/clothing/mask/gas))
		protection_level += COGNITOHAZARD_PROTECTION_PARTIAL

	protection_level = clamp(protection_level, 0, 1)

/datum/status_effect/cognitohazard_exposure/proc/update_darkness()
	var/turf/T = get_turf(owner)
	if(!T)
		darkness_amplified = FALSE
		return
	darkness_amplified = T.get_lumcount() < 0.3

/datum/status_effect/cognitohazard_exposure/proc/update_tier()
	var/new_tier = 0
	for(var/i in 1 to length(tier_thresholds))
		if(accumulation >= tier_thresholds[i])
			new_tier = i

	if(new_tier != current_tier)
		if(new_tier > current_tier)
			on_tier_escalation(current_tier, new_tier)
		else
			on_tier_deescalation(current_tier, new_tier)
		current_tier = new_tier

	if(linked_alert)
		linked_alert.desc = "Cognitohazard exposure: [round(accumulation, 0.1)]% | Tier [current_tier] | Source: [source_id]"

/datum/status_effect/cognitohazard_exposure/proc/on_tier_escalation(old_tier, new_tier)
	if(new_tier >= 1 && new_tier <= 5)
		to_chat(owner, SPAN_WARNING(tier_messages[new_tier]))

/datum/status_effect/cognitohazard_exposure/proc/on_tier_deescalation(old_tier, new_tier)
	if(old_tier >= COGNITOHAZARD_TIER_HALLUCINATION && new_tier < COGNITOHAZARD_TIER_HALLUCINATION)
		clear_hallucinations()

/datum/status_effect/cognitohazard_exposure/proc/apply_tier_effects()
	var/mob/living/carbon/human/H = owner
	if(!istype(H))
		return
	var/strength = current_tier * 0.2

	switch(current_tier)
		if(COGNITOHAZARD_TIER_UNEASE)
			if(prob(3 * strength))
				H.emote("shiver")

		if(COGNITOHAZARD_TIER_PARANOIA)
			if(prob(5 * strength))
				H.apply_status_effect(/datum/status_effect/drugginess, 4 SECONDS)
			if(prob(3 * strength))
				H.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/cognitohazard_paranoia, TRUE, 0.5)
				addtimer(CALLBACK(H, TYPE_PROC_REF(/mob, remove_movespeed_modifier), /datum/movespeed_modifier/cognitohazard_paranoia), 3 SECONDS)

		if(COGNITOHAZARD_TIER_HALLUCINATION)
			if(prob(5 * strength))
				spawn_hallucination()
			if(prob(5 * strength))
				H.sanity?.adjust_sanity(-2, "cognitohazard")

		if(COGNITOHAZARD_TIER_COMPULSION)
			if(prob(8 * strength))
				H.sanity?.adjust_sanity(-3, "cognitohazard")
			if(prob(5 * strength))
				spawn_hallucination()

		if(COGNITOHAZARD_TIER_BREAKDOWN)
			if(prob(10 * strength))
				H.sanity?.adjust_sanity(-6, "cognitohazard_breakdown")
			if(prob(8 * strength))
				spawn_hallucination()
			if(prob(2 * strength))
				H.sanity?.adjust_sanity(-15, "cognitohazard_breakdown")

/datum/status_effect/cognitohazard_exposure/proc/spawn_hallucination()
	if(!owner.client)
		return

	var/hallucination_type = rand(1, 3)
	switch(hallucination_type)
		if(1)
			var/list/sounds = list(
				'sounds/effects/ghost.ogg',
				'sounds/effects/ghost2.ogg',
				'sounds/hallucinations/growl1.ogg',
				'sounds/hallucinations/i_see_you1.ogg',
			)
			for(var/sound in sounds)
				if(fexists(sound))
					owner.playsound_local(get_turf(owner), sound, 50, TRUE)
					break
		if(2)
			var/list/alerts = list(
				"You hear whispers coming from the walls...",
				"Something is watching you from the shadows...",
				"The air itself seems to twist around you...",
				"A voice in your head screams warnings...",
			)
			to_chat(owner, SPAN_CLASS("boldannounce", pick(alerts)))
		if(3)
			var/turf/T = get_turf(owner)
			if(!T)
				return
			var/image/I = image(icon = 'icons/effects/effects.dmi', loc = T, icon_state = pick("nothing", "smoke"), layer = MOB_LAYER + 0.1)
			owner.client.images += I
			addtimer(CALLBACK(src, PROC_REF(remove_hallucination_image), I), 8 SECONDS)

/datum/status_effect/cognitohazard_exposure/proc/remove_hallucination_image(image/I)
	if(owner?.client)
		owner.client.images -= I
	qdel(I)

/datum/status_effect/cognitohazard_exposure/proc/clear_hallucinations()
	if(!owner?.client)
		return
	var/list/to_remove = list()
	for(var/image/I in owner.client.images)
		if(I.icon == 'icons/effects/effects.dmi')
			to_remove += I
	for(var/image/I in to_remove)
		owner.client.images -= I
		qdel(I)

/datum/status_effect/cognitohazard_exposure/proc/on_moved(datum/source, turf/origin, turf/destination)
	SIGNAL_HANDLER
	update_protection()
	update_darkness()

/datum/status_effect/cognitohazard_exposure/get_examine_text()
	return SPAN_WARNING("Subject shows signs of cognitohazard exposure (Tier [current_tier], [round(accumulation, 0.1)]% accumulation).")

/atom/movable/screen/alert/status_effect/cognitohazard_exposure
	name = "Cognitohazard Exposure"
	desc = "You are being exposed to a cognitohazardous effect."
	icon_state = "cult_sense"

// ---------------------------------------------------------------------------
// Global exposure API — cognitohazard sources call this.
// ---------------------------------------------------------------------------

/proc/apply_cognitohazard_exposure(mob/living/carbon/human/target, amount, source_id = "generic")
	if(!istype(target) || target.stat == DEAD || target.SCP)
		return
	target.apply_status_effect(/datum/status_effect/cognitohazard_exposure, source_id, amount)
