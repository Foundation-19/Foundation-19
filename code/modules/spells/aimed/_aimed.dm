/datum/spell/aimed
	name = "aimed projectile spell"
	hud_state = "projectile"

	var/projectile_type = /obj/item/projectile
	var/deactive_msg = "You discharge your projectile..."
	var/active_msg = "You charge your projectile!"
	var/active_icon_state = "projectile"
	var/list/projectile_var_overrides = list()
	var/projectile_amount = 1	//Projectiles per cast.
	var/current_amount = 0	//How many projectiles left.
	var/projectiles_per_fire = 1		//Projectiles per fire. Probably not a good thing to use unless you override ready_projectile().
	var/cast_prox_range = 1

/datum/spell/aimed/Click(click_usr, skipcharge = 0)
	var/mob/living/user = click_usr
	if(!istype(user))
		return
	var/msg
	if(!cast_check(skipcharge, user))
		remove_ranged_ability(msg)
		return
	if(active)
		msg = "<span class='notice'>[deactive_msg]</span>"
		if(charge_type == "recharge")
			var/refund_percent = current_amount/projectile_amount
			charge_counter = charge_max * refund_percent
		remove_ranged_ability(msg)
		on_deactivation(user)
	else
		msg = "<span class='notice'>[active_msg] <B>Left-click to shoot it at a target!</B></span>"
		current_amount = projectile_amount
		add_ranged_ability(user, msg, TRUE)
		on_activation(user)

/datum/spell/aimed/proc/on_activation(mob/user)
	active = TRUE
	return

/datum/spell/aimed/proc/on_deactivation(mob/user)
	active = FALSE
	return

/datum/spell/aimed/InterceptClickOn(mob/living/caller, params, atom/target)
	if(..())
		return FALSE
	var/ran_out = (current_amount <= 0)
	if(!cast_check(!ran_out, ranged_ability_user))
		remove_ranged_ability()
		return FALSE
	var/list/targets = list(target)
	perform(ranged_ability_user, targets)
	return TRUE

/datum/spell/aimed/cast(list/targets, mob/living/user)
	var/target = targets[1]
	var/turf/T = user.loc
	var/turf/U = get_step(user, user.dir) // Get the tile infront of the move, based on their direction
	if(!isturf(U) || !isturf(T))
		return FALSE
	fire_projectile(user, target)
	if(current_amount <= 0)
		remove_ranged_ability() //Auto-disable the ability once you run out of bullets.
		on_deactivation(user)
	return TRUE

/datum/spell/aimed/proc/fire_projectile(mob/living/user, atom/target)
	current_amount--
	for(var/i in 1 to projectiles_per_fire)
		var/obj/item/projectile/P = new projectile_type(user.loc)
		if(istype(P, /obj/item/projectile/spell_projectile))
			var/obj/item/projectile/spell_projectile/SP = P
			SP.carried = src //casting is magical
		P.original = target
		P.current = target
		P.starting = get_turf(user)
		P.shot_from = user
		P.launch(target, user.zone_sel.selecting, user)
	return TRUE

// For spell_projectile types
/datum/spell/aimed/proc/choose_prox_targets(mob/user = usr, atom/movable/spell_holder)
	var/list/targets = list()
	for(var/mob/living/M in range(spell_holder, cast_prox_range))
		if(M == user && !(spell_flags & INCLUDEUSER))
			continue
		targets += M
	return targets

/datum/spell/aimed/proc/prox_cast(list/targets, atom/movable/spell_holder)
	return
