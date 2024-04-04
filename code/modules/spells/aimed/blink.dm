/datum/spell/aimed/blink
	name = "Blink"
	desc = "This spell teleports the user a short distance towards their destination."
	deactive_msg = "You discharge the blink spell..."
	active_msg = "You charge the blink spell!"

	charge_max = 10 SECONDS
	cooldown_reduc = 4 SECONDS

	spell_flags = 0
	invocation = "none"
	invocation_type = INVOKE_NONE

	level_max = list(UPGRADE_TOTAL = 2, UPGRADE_SPEED = 2, UPGRADE_POWER = 2)

	range = 4
	hud_state = "wiz_blink"
	cast_sound = 'sounds/magic/blink.ogg'

	categories = list(SPELL_CATEGORY_MOBILITY)
	spell_cost = 2
	mana_cost = 3

/datum/spell/aimed/blink/TargetCastCheck(mob/living/user, atom/target)
	if(!istype(target))
		return FALSE
	if(get_dist(user, target) > range)
		to_chat(user, SPAN_WARNING("The target turf is too far away!"))
		return FALSE
	return ..()

/datum/spell/aimed/blink/fire_projectile(mob/living/user, mob/living/target)
	. = ..()
	var/turf/target_turf = get_turf(target)
	if(target_turf.density)
		target_turf = pick_turf_in_range(target_turf, 2, list(GLOBAL_PROC_REF(not_turf_contains_dense_objects)))
	if(!istype(target_turf))
		to_chat(user, SPAN_WARNING("Failed to find any open floors to blink to!"))
		return
	var/list/line_list = getline(user, target_turf)
	for(var/i = 1 to length(line_list))
		var/turf/T = line_list[i]
		var/obj/effect/temp_visual/decoy/D = new /obj/effect/temp_visual/decoy(T, user.dir, user)
		D.alpha = min(150 + i*15, 255)
		animate(D, alpha = 0, time = 2 + i*2)
	user.forceMove(target_turf)

/datum/spell/aimed/blink/ImproveSpellPower()
	if(!..())
		return FALSE

	range += 2
	return "You've increased the maximum range of [src] to [range] tiles."
