/datum/spell/aimed/fireball
	name = "Fireball"
	desc = "This spell fires an explosive fireball at a target."
	charge_max = 15 SECONDS
	spell_flags = 0
	invocation = "ONI SOMA"
	invocation_type = INVOKE_SHOUT
	range = 20
	projectile_type = /obj/item/projectile/spell_projectile/fireball
	hud_state = "wiz_fireball"
	cast_sound = 'sounds/magic/fireball.ogg'
	active_msg = "You prepare to cast your fireball spell!"
	deactive_msg = "You extinguish your fireball... for now."

	level_max = list(UPGRADE_TOTAL = 5, UPGRADE_SPEED = 0, UPGRADE_POWER = 5)

	categories = list(SPELL_CATEGORY_FIRE, SPELL_CATEGORY_EXPLOSIVE)
	spell_cost = 5
	mana_cost = 20

	var/ex_severe = -1
	var/ex_heavy = 1
	var/ex_light = 2
	var/ex_flash = 2

/datum/spell/aimed/fireball/ImproveSpellPower()
	if(!..())
		return 0

	if(spell_levels[UPGRADE_POWER]%2 == 0)
		ex_severe++
	ex_heavy++
	ex_light++
	ex_flash++

	return "The spell [src] now has a larger explosion."

/datum/spell/aimed/fireball/prox_cast(list/targets, spell_holder)
	var/turf/T = get_turf(spell_holder)
	if(LAZYLEN(targets))
		T = get_turf(pick(targets))
	explosion(T, ex_severe, ex_heavy, ex_light, ex_flash)

// Projectile
/obj/item/projectile/spell_projectile/fireball
	name = "fireball"
	icon_state = "fireball"
