/datum/spell/aimed/dispell_projectile
	name = "Dispelling projectile"
	desc = "Launches a magic bolt capable of dispelling magic."

	spell_flags = 0
	invocation = "Ma'Gi-Di!"
	invocation_type = INVOKE_SHOUT
	range = 15
	level_max = list(UPGRADE_TOTAL = 3, UPGRADE_SPEED = 2, UPGRADE_POWER = 2)
	duration = 15
	projectile_type = /obj/item/projectile/spell_projectile/dispell

	charge_max = 15 SECONDS
	cooldown_reduc = 5 SECONDS

	active_msg = "You prepare to cast the bolt of dispell!"
	deactive_msg = "You decide against using the bolt of dispell."

	hud_state = "wiz_dispell_proj"
	cast_sound = 'sounds/magic/staff_healing.ogg'

	categories = list(SPELL_CATEGORY_ANTIMAGIC)
	spell_cost = 2
	mana_cost = 15

	var/amt_range = 0
	var/strength = DISPELL_WEAK

/datum/spell/aimed/dispell_projectile/prox_cast(list/targets, atom/spell_holder)
	var/atom/movable/A = targets[1]
	if(amt_range > 0)
		for(var/atom/movable/AA in range(amt_range, A))
			if(AA == holder)
				continue
			AA.Dispell()
	else if(istype(A))
		A.Dispell()

	playsound(A, 'sounds/magic/smoke.ogg', min(100, 25 * amt_range))

/datum/spell/aimed/dispell_projectile/ImproveSpellPower()
	if(!..())
		return FALSE

	amt_range += 1

	return "[src] now affects multiple targets within a [amt_range <= 1 ? "small" : "big"] area."

/obj/item/projectile/spell_projectile/dispell
	name = "bolt of dispell"
	icon_state = "spark_green"
	speed = 0.8

/obj/item/projectile/spell_projectile/dispell/Bump(atom/A, forced = FALSE)
	if(A && carried)
		prox_cast(list(A), src)
	return TRUE

/obj/item/projectile/spell_projectile/dispell/on_impact(atom/A)
	if(A && carried)
		prox_cast(list(A), src)
	return TRUE
