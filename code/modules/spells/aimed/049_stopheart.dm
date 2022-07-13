/datum/spell/aimed/stopheart
	name = "Stop Heart"
	desc = "Stops the target's biological functions. Killing them quickly."
	spell_flags = null
	active_msg = "You hold your hand out."
	still_recharging_msg = "You aren't ready to use this again."
	projectile_amount = 0
	current_amount = 0
	projectiles_per_fire = 0
	cast_prox_range = 1

/datum/spell/aimed/stopheart/proc/failed_cast(var/mob/living/user)
	remove_ranged_ability()
	on_deactivation(user)
	charge_counter = charge_max

/datum/spell/aimed/stopheart/cast(list/targets, mob/living/user)
	var/mob/living/carbon/human/target = targets[1]
	var/mob/living/carbon/human/scp049/player = user
	if(!player.stop_heart(target))
		failed_cast(player)