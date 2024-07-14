/datum/status_effect/stagger
	id = "stagger"
	status_type = STATUS_EFFECT_REFRESH
	duration = 30 SECONDS
	tick_interval = 1 SECONDS
	alert_type = null

/datum/status_effect/stagger/on_apply()
	owner.next_move_modifier *= 1.5
	if(istype(owner, /mob/living/simple_animal/hostile))
		var/mob/living/simple_animal/hostile/simple_owner = owner
		simple_owner.attack_delay *= 2.5
	return TRUE

/datum/status_effect/stagger/on_remove()
	. = ..()
	if(QDELETED(owner))
		return
	owner.next_move_modifier /= 1.5
	if(istype(owner, /mob/living/simple_animal/hostile))
		var/mob/living/simple_animal/hostile/simple_owner = owner
		simple_owner.attack_delay /= 2.5
