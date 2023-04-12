/datum/random_ability
	var/name = "random ability"
	/// If it isn't empty - the random monster will have a chance to pick this name
	var/added_name = null
	/// Cooldown time for that ability
	var/cooldown_time = 0
	/// Current cooldown...
	var/current_cooldown = 0

	/// Added/Removed health from this ability
	var/health_mod = 0
	/// Added/Removed speed
	var/speed_mod = 0
	/// Overlay related to this ability
	var/overlay_type = null

/datum/random_ability/proc/perform(mob/living/user, atom/target)
	current_cooldown = world.time + cooldown_time

/datum/random_ability/proc/CanUse(mob/living/user)
	if(current_cooldown > world.time)
		return FALSE
	return TRUE
