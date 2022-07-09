/datum/spell/aimed/stopheart
	name = "Stop Heart"
	desc = "Stops the target's biological functions. Killing them quickly."
	spell_flags = null
	//var/deactive_msg = "You discharge your projectile..."
	//var/active_msg = "You charge your projectile!"
	//var/active_icon_state = "projectile"
	//var/list/projectile_var_overrides = list()
	projectile_amount = 0	//Projectiles per cast.
	current_amount = 0	//How many projectiles left.
	projectiles_per_fire = 0		//Projectiles per fire. Probably not a good thing to use unless you override ready_projectile().
	cast_prox_range = 1

/datum/spell/aimed/stopheart/cast(list/targets, mob/living/user)
	var/mob/living/carbon/human/target = locate(/mob/living/carbon/human) in get_turf(targets[1])
	var/obj/item/organ/internal/heart/heart = target.internal_organs_by_name[BP_HEART]
	heart.pulse = PULSE_NONE
	user.visible_message(SPAN_DANGER("[user.name] presses against [target.name]'s head."))