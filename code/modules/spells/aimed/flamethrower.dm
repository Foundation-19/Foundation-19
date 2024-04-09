/datum/spell/aimed/flamethrower
	name = "Flamethrower"
	desc = "This spell sets a small targeted area on fire."
	deactive_msg = "You discharge the flamethrower spell..."
	active_msg = "You charge the flamethrower spell!"

	charge_max = 10 SECONDS
	cooldown_reduc = 4 SECONDS

	invocation = "Flamma!"
	invocation_type = INVOKE_SHOUT
	level_max = list(UPGRADE_TOTAL = 3, UPGRADE_SPEED = 2, UPGRADE_POWER = 2)

	range = 8
	hud_state = "wiz_flame"
	cast_sound = 'sounds/magic/fire.ogg'
	spell_cost = 2
	mana_cost = 6
	categories = list(SPELL_CATEGORY_FIRE)

	var/flame_power = 20
	var/flame_distance = 4
	var/flame_color = COLOR_ORANGE

/datum/spell/aimed/flamethrower/TargetCastCheck(mob/living/user, mob/living/target)
	if(get_dist(user, target) > range)
		to_chat(user, SPAN_WARNING("The target is too far away!"))
		return FALSE
	return ..()

/datum/spell/aimed/flamethrower/fire_projectile(mob/living/user, mob/living/target)
	. = ..()
	var/turf/start_turf = get_step(get_turf(user), get_dir(user, target))
	var/turf/target_turf = get_ranged_target_turf_direct(start_turf, target, flame_distance)
	var/list/flame_line = getline(start_turf, target_turf)
	for(var/i = 1 to length(flame_line))
		var/turf/T = flame_line[i]
		if(T.density)
			break
		var/dense_obj = FALSE
		for(var/obj/O in T)
			if(O.density)
				dense_obj = TRUE
				break
		if(dense_obj)
			break
		addtimer(CALLBACK(src, PROC_REF(PlaceFlame), T), i-1)

/datum/spell/aimed/flamethrower/proc/PlaceFlame(turf/T)
	var/obj/effect/turf_fire/TF = T.IgniteTurf(flame_power, flame_color)
	if(istype(TF))
		TF.interact_with_atmos = FALSE
	T.hotspot_expose((flame_power * 3) + 300, 50)

/datum/spell/aimed/flamethrower/ImproveSpellPower()
	if(!..())
		return FALSE

	flame_power += 20
	flame_color = flame_power >= 60 ? COLOR_PURPLE : COLOR_RED
	// This is generally only available with spell steal
	if(flame_power >= 80)
		flame_distance += 1

	return "The [src] spell is now [flame_power >= 60 ? "much " : ""]more powerful."
