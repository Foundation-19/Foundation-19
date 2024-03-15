/datum/spell/targeted/projectile/magic_missile
	name = "Magic Missile"
	desc = "This spell fires several, slow moving, magic projectiles at nearby targets."
	charge_max = 150
	spell_flags = NEEDSCLOTHES
	invocation = "Forti Gy-Ama!"
	invocation_type = INVOKE_SHOUT
	range = 7
	level_max = list(UPGRADE_TOTAL = 3, UPGRADE_SPEED = 3, UPGRADE_POWER = 3)
	cooldown_min = 90 //15 deciseconds reduction per rank

	max_targets = 0

	proj_type = /obj/item/projectile/spell_projectile/seeking/magic_missile
	duration = 10
	proj_step_delay = 5

	hud_state = "wiz_mm"
	cast_sound = 'sounds/magic/magic_missile.ogg'
	amt_weakened = 2

	amt_dam_fire = 10

	spell_cost = 2
	mana_cost = 10

/datum/spell/targeted/projectile/magic_missile/prox_cast(list/targets, atom/spell_holder)
	spell_holder.visible_message("<span class='danger'>\The [spell_holder] pops with a flash!</span>")
	playsound(src, 'sounds/magic/mm_hit.ogg', 40)
	for(var/mob/living/M in targets)
		apply_spell_damage(M)
	return

/datum/spell/targeted/projectile/magic_missile/ImproveSpellPower()
	if(!..())
		return 0

	if(spell_levels[UPGRADE_POWER] == level_max[UPGRADE_POWER])
		amt_weakened += 2
		return "[src] will now stun people for a longer duration."
	amt_dam_fire += 5
	return "[src] does more damage now."


//PROJECTILE

/obj/item/projectile/spell_projectile/seeking/magic_missile
	name = "magic missile"
	icon_state = "magicm"

	// Very slow
	speed = 2.5

	proj_trail = 1
	proj_trail_lifespan = 5
	proj_trail_icon_state = "magicmd"
