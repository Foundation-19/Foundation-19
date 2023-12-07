/datum/status_effect/stoned
	id = "stoned"
	duration = 10 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/stoned
	status_type = STATUS_EFFECT_REFRESH

/datum/status_effect/stoned/on_apply()
	if(!ishuman(owner))
		CRASH("[type] status effect added to non-human owner: [owner ? owner.type : "null owner"]")
	var/mob/living/carbon/human/human_owner = owner
	human_owner.add_movespeed_modifier(/datum/movespeed_modifier/status_effect/stoned) //slows you down
	human_owner.update_body() //updates eye color
	ADD_TRAIT(human_owner, TRAIT_CLUMSY, type) // impairs motor coordination and dilates blood vessels in eyes
	//human_owner.add_mood_event("stoned", /datum/mood_event/stoned) //improves mood
	//human_owner.sound_environment_override = SOUND_ENVIRONMENT_DRUGGED //not realistic but very immersive
	return TRUE

/datum/status_effect/stoned/on_remove()
	if(!ishuman(owner))
		CRASH("[type] status effect being removed from non-human owner: [owner ? owner.type : "null owner"]")
	var/mob/living/carbon/human/human_owner = owner
	human_owner.remove_movespeed_modifier(/datum/movespeed_modifier/status_effect/stoned)
	human_owner.update_body()
	REMOVE_TRAIT(human_owner, TRAIT_CLUMSY, type)
	//human_owner.clear_mood_event("stoned")
	//human_owner.sound_environment_override = SOUND_ENVIRONMENT_NONE

/atom/movable/screen/alert/status_effect/stoned
	name = "Stoned"
	desc = "Cannabis is impairing your speed, motor skills, and mental cognition."
	icon_state = "stoned"
