// Stores mana-related things and spell points
/datum/mana
	var/mana_level = 10
	var/mana_level_max = 10
	/// Amount of mana restored per second
	var/mana_recharge_speed = 0.25
	var/recharging = FALSE
	/// Personal spell points used for purchasing spells
	var/spell_points = 2

/datum/mana/proc/UseMana(mob/user, amount = 0, silent = TRUE)
	if(mana_level < amount)
		if(!silent && user)
			to_chat(user, SPAN_WARNING("You do not have enough mana!"))
		return FALSE
	mana_level = clamp(mana_level - amount, 0, mana_level_max)
	// We attempt to start recharge any time mana is used
	StartRecharge()
	return TRUE

/datum/mana/proc/AddMana(amount = 0)
	mana_level = clamp(mana_level + amount, 0, mana_level_max)
	return TRUE

// Starts a "process" of recharging if we should and can
/datum/mana/proc/StartRecharge()
	if(recharging)
		return FALSE
	if(mana_level >= mana_level_max)
		return FALSE
	recharging = TRUE
	RechargeMana()
	return TRUE

/datum/mana/proc/RechargeMana()
	if(!recharging)
		return FALSE
	if(mana_level >= mana_level_max)
		recharging = FALSE
		return FALSE
	AddMana(mana_recharge_speed * 0.5)
	addtimer(CALLBACK(src, PROC_REF(RechargeMana)), (0.5 SECONDS))
	return TRUE

/* Helpers procs */
/proc/GetManaDatum(atom/target)
	if(istype(target, /mob))
		var/mob/M = target
		if(istype(M.mind))
			return M.mind.mana
	// Certain items may store mana
	if(istype(target, /obj/item))
		var/obj/item/I = target
		if(istype(I.mana))
			return I.mana
	return null
