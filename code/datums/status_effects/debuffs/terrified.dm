/// Amount of terror passively generated (or removed) on every tick based on lighting.
#define DARKNESS_TERROR_AMOUNT 10
/// How much terror a random panic attack will give the victim.
#define PANIC_ATTACK_TERROR_AMOUNT 35
/// Amount of terror actively removed (or generated) upon being hugged.
#define HUG_TERROR_AMOUNT 60
/// Amount of terror caused by subsequent casting of the Terrify spell.
#define STACK_TERROR_AMOUNT 135

/// The soft cap on how much passively generated terror you can have. Takes about 30 seconds to reach without the victim being actively terrorized.
#define DARKNESS_TERROR_CAP 400

/// The terror_buildup threshold for minor fear effects to occur.
#define TERROR_FEAR_THRESHOLD 140
/// The terror_buildup threshold for the more serious effects. Takes about 20 seconds of darkness buildup to reach.
#define TERROR_PANIC_THRESHOLD 300
/// Terror buildup will cause a heart attack and knock them out, removing the status effect.
#define TERROR_HEART_ATTACK_THRESHOLD 600

/datum/status_effect/terrified
	id = "terrified"
	status_type = STATUS_EFFECT_REFRESH
	remove_on_fullheal = TRUE
	alert_type = /atom/movable/screen/alert/status_effect/terrified
	///A value that represents how much "terror" the victim has built up. Higher amounts cause more averse effects.
	var/terror_buildup = 100

/datum/status_effect/terrified/refresh(effect, ...) //Don't call parent, just add to the current amount
	freak_out(STACK_TERROR_AMOUNT)

/datum/status_effect/terrified/on_apply()
	RegisterSignal(owner, COMSIG_RECEIVED_HUG, PROC_REF(comfort_owner))
	owner.emote("scream")
	to_chat(owner, SPAN_ALERT("The darkness closes in around you, shadows dance around the corners of your vision... It feels like something is watching you!"))
	return TRUE

/datum/status_effect/terrified/on_remove()
	UnregisterSignal(owner, COMSIG_RECEIVED_HUG)
	//owner.remove_fov_trait(id, FOV_270_DEGREES)

/datum/status_effect/terrified/tick(seconds_per_tick, times_fired)
	if(check_surrounding_darkness())
		if(terror_buildup < DARKNESS_TERROR_CAP)
			terror_buildup += DARKNESS_TERROR_AMOUNT
	else
		terror_buildup -= DARKNESS_TERROR_AMOUNT

	if(terror_buildup <= 0) //If we've completely calmed down, we remove the status effect.
		qdel(src)
		return

	if(terror_buildup >= TERROR_FEAR_THRESHOLD) //The onset, minor effects of terror buildup
		owner.adjust_dizzy_up_to(10 SECONDS * seconds_per_tick, 10 SECONDS)
		owner.adjust_stutter_up_to(10 SECONDS * seconds_per_tick, 10 SECONDS)
		owner.adjust_jitter_up_to(10 SECONDS * seconds_per_tick, 10 SECONDS)

	if(terror_buildup >= TERROR_PANIC_THRESHOLD) //If you reach this amount of buildup in an engagement, it's time to start looking for a way out.
		ADD_TRAIT(owner, TRAIT_HEAR_HEARTBEAT, src)
		//owner.add_fov_trait(id, FOV_270_DEGREES) //Terror induced tunnel vision
		owner.adjust_eye_blur_up_to(10 SECONDS * seconds_per_tick, 10 SECONDS)
		if(prob(5)) //We have a little panic attack. Consider it GENTLE ENCOURAGEMENT to start running away.
			freak_out(PANIC_ATTACK_TERROR_AMOUNT)
			owner.visible_message(
				SPAN_WARNING("[owner] drops to the floor for a moment, clutching their chest."),
				SPAN_ALERT("Your heart lurches in your chest. You can't take much more of this!"),
				"You hear a grunt.",
			)
	//else
		//owner.remove_fov_trait(id, FOV_270_DEGREES)

	if(terror_buildup >= TERROR_HEART_ATTACK_THRESHOLD) //You should only be able to reach this by actively terrorizing someone
		owner.visible_message(
			SPAN_WARNING("[owner] clutches [owner.p_their()] chest for a moment, then collapses to the floor."),
			SPAN_ALERT("The shadows begin to creep up from the corners of your vision, and then there is nothing..."),
			"You hear something heavy collide with the ground.",
		)

		if(iscarbon(owner))
			var/mob/living/carbon/C = owner
		// since we don't have heart attacks, we'll just directly damage the heart
			var/obj/item/organ/internal/heart/heart = C.internal_organs_by_name[BP_HEART]
			heart.take_internal_damage(10)

		owner.Sleeping(20 SECONDS)
		qdel(src) //Victim passes out from fear, calming them down and permanently damaging their heart.

/datum/status_effect/terrified/get_examine_text()
	if(terror_buildup > DARKNESS_TERROR_CAP) //If we're approaching a heart attack
		return SPAN_WARNING("[owner.p_they(capitalized = TRUE)] [owner.p_are()] seizing up, about to collapse in fear!")

	if(terror_buildup >= TERROR_PANIC_THRESHOLD)
		return SPAN_WARNING("[owner] is visibly trembling and twitching. It looks like [owner.p_theyre()] freaking out!")

	if(terror_buildup >= TERROR_FEAR_THRESHOLD)
		return SPAN_WARNING("[owner] looks very worried about something. [owner.p_are(TRUE)] [owner.p_they()] alright?")

	return SPAN_NOTICE("[owner] looks rather anxious. [owner.p_they(capitalized = TRUE)] could probably use a hug...")

/// If we get a hug from a friend, we calm down!
/// owner_dupe is equal to owner, we just need it to get to the second argument
/datum/status_effect/terrified/proc/comfort_owner(owner_dupe, mob/living/carbon/human/hugger)
	SIGNAL_HANDLER

	terror_buildup -= HUG_TERROR_AMOUNT
	owner.visible_message(
		SPAN_NOTICE("The hug [hugger] gave [owner] seems to help [owner.p_them()] relax."),
		SPAN_GOOD("You feel [hugger] calm you down with a reassuring hug."),
		"You hear shuffling and a sigh of relief.",
	)

/**
 * Checks the surroundings of our victim and returns TRUE if the user is surrounded by enough darkness
 *
 * Checks the surrounded tiles for light amount. If the user has more light nearby, return true.
 * Otherwise, return false
 */

/datum/status_effect/terrified/proc/check_surrounding_darkness()
	var/lit_tiles = 0
	var/unlit_tiles = 0

	for(var/turf/turf_to_check in range(1, owner.loc))
		var/light_amount = turf_to_check.get_lumcount()
		if(light_amount > 0.2)
			lit_tiles++
		else
			unlit_tiles++

	return lit_tiles < unlit_tiles

/**
 * Adds to the victim's terror buildup, makes them scream, and knocks them over for a moment.
 *
 * Makes the victim scream and adds the passed amount to their buildup.
 * Knocks over the victim for a brief moment.
 *
 * * amount - how much terror buildup this freakout will cause
 */

/datum/status_effect/terrified/proc/freak_out(amount)
	terror_buildup += amount
	owner.Weaken(0.5 SECONDS)
	if(prob(50))
		owner.emote("scream")

/// The status effect popup for the terror status effect
/atom/movable/screen/alert/status_effect/terrified
	name = "Terrified!"
	desc = "You feel a supernatural darkness settle in around you, overwhelming you with panic! Get into the light!"
	icon_state = "terrified"

#undef DARKNESS_TERROR_AMOUNT
#undef PANIC_ATTACK_TERROR_AMOUNT
#undef HUG_TERROR_AMOUNT
#undef STACK_TERROR_AMOUNT
#undef DARKNESS_TERROR_CAP
#undef TERROR_FEAR_THRESHOLD
#undef TERROR_PANIC_THRESHOLD
#undef TERROR_HEART_ATTACK_THRESHOLD
