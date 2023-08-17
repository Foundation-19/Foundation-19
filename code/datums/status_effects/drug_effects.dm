/datum/status_effect/woozy
	id = "woozy"
	tick_interval = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/woozy

/datum/status_effect/woozy/nextmove_modifier()
	return 1.5

/atom/movable/screen/alert/status_effect/woozy
	name = "Woozy"
	desc = "You feel a bit slower than usual, it seems doing things with your hands takes longer than it usually does."
	icon_state = "woozy"

/datum/status_effect/seizure
	id = "seizure"
	tick_interval = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/seizure

/datum/status_effect/seizure/on_apply()
	if(!iscarbon(owner))
		return FALSE
	var/amplitude = rand(1 SECONDS, 3 SECONDS)
	duration = amplitude
	owner.set_jitter_if_lower(100 SECONDS)
	owner.Paralyze(duration)
	owner.visible_message(SPAN_WARNING("[owner] drops to the ground as [owner.p_they()] start seizing up."), \
	SPAN_WARNING("[pick("You can't collect your thoughts...", "You suddenly feel extremely dizzy...", "You cant think straight...","You can't move your face properly anymore...")]"))
	return TRUE

/atom/movable/screen/alert/status_effect/seizure
	name = "Seizure"
	desc = "FJOIWEHUWQEFGYUWDGHUIWHUIDWEHUIFDUWGYSXQHUIODSDBNJKVBNKDML <--- this is you right now"
	icon_state = "paralysis"

/datum/status_effect/stoned
	id = "stoned"
	duration = 10 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/stoned
	status_type = STATUS_EFFECT_REFRESH

/datum/status_effect/stoned/on_apply()
	if(!ishuman(owner))
		CRASH("[type] status effect added to non-human owner: [owner ? owner.type : "null owner"]")
	var/mob/living/carbon/human/human_owner = owner
	//human_owner.add_movespeed_modifier(/datum/movespeed_modifier/reagent/cannabis) //slows you down
	human_owner.update_body() //updates eye color
	human_owner.add_traits(list(TRAIT_CLUMSY, TRAIT_BLOODSHOT_EYES), type) // impairs motor coordination and dilates blood vessels in eyes
	//human_owner.add_mood_event("stoned", /datum/mood_event/stoned) //improves mood
	//human_owner.sound_environment_override = SOUND_ENVIRONMENT_DRUGGED //not realistic but very immersive
	return TRUE

/datum/status_effect/stoned/on_remove()
	if(!ishuman(owner))
		CRASH("[type] status effect being removed from non-human owner: [owner ? owner.type : "null owner"]")
	var/mob/living/carbon/human/human_owner = owner
	//human_owner.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/cannabis)
	human_owner.update_body()
	human_owner.remove_traits(list(TRAIT_CLUMSY, TRAIT_BLOODSHOT_EYES), type)
	//human_owner.clear_mood_event("stoned")
	//human_owner.sound_environment_override = SOUND_ENVIRONMENT_NONE

/atom/movable/screen/alert/status_effect/stoned
	name = "Stoned"
	desc = "Cannabis is impairing your speed, motor skills, and mental cognition."
	icon_state = "stoned"
