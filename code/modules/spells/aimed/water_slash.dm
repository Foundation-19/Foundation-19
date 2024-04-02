/datum/spell/aimed/water_slash
	name = "Water Slash"
	desc = "This spell manifests a sharp stream of water that slices everyone in its way."
	deactive_msg = "You discharge the slash spell..."
	active_msg = "You charge the slash spell!"

	charge_max = 20 SECONDS
	cooldown_reduc = 5 SECONDS

	invocation = "Wa Sli!"
	invocation_type = INVOKE_SHOUT
	level_max = list(UPGRADE_TOTAL = 3, UPGRADE_SPEED = 2, UPGRADE_POWER = 2)

	range = 8
	hud_state = "wiz_slash"
	cast_sound = 'sounds/magic/water.ogg'
	spell_cost = 2
	mana_cost = 10

	var/slash_damage = 50
	var/slash_distance = 4
	var/slash_color = COLOR_DEEP_SKY_BLUE

/datum/spell/aimed/water_slash/TargetCastCheck(mob/living/user, mob/living/target)
	if(get_dist(user, target) > range)
		to_chat(user, SPAN_WARNING("The target is too far away!"))
		return FALSE
	return ..()

/datum/spell/aimed/water_slash/fire_projectile(mob/living/user, mob/living/target)
	. = ..()
	var/turf/start_turf = get_turf(user)
	var/turf/target_turf = get_ranged_target_turf_direct(start_turf, target, slash_distance)
	/// The turf where the slash effect will visibly travel
	var/turf/move_turf = start_turf
	var/list/attack_line = list()
	for(var/turf/T in getline(start_turf, target_turf))
		if(T == start_turf)
			continue
		if(T.density)
			break
		var/dense_obj = FALSE
		for(var/obj/O in T)
			if(O.density && !istype(O, /obj/structure/table) && !istype(O, /obj/structure/railing))
				dense_obj = TRUE
				break
		if(dense_obj)
			break
		attack_line += T
		move_turf = T

	var/obj/effect/temp_visual/slash/S = new(start_turf)
	S.color = slash_color
	var/matrix/M = new
	M.Turn(Get_Angle(start_turf, target_turf))
	S.transform = M
	animate(S, alpha = 225, pixel_x = (move_turf.x - start_turf.x) * world.icon_size, pixel_y = (move_turf.y - start_turf.y) * world.icon_size, transform = matrix(S.transform) * 3, time = 1.5)
	addtimer(CALLBACK(S, TYPE_PROC_REF(/obj/effect/temp_visual/slash, FadeOut)), 1.5)
	var/list/already_hit = list()
	for(var/turf/T in attack_line)
		for(var/turf/TT in range(1, T))
			for(var/mob/living/L in TT)
				if(L == user)
					continue
				if(L in already_hit)
					continue
				already_hit |= L
				L.apply_damage(slash_damage, BRUTE, null, DAM_EDGE|DAM_SHARP)
				var/turf/simulated/LT = get_turf(L)
				var/blood_col = COLOR_RED
				if(isanimal(L))
					var/mob/living/simple_animal/SA = L
					blood_col = SA.bleed_colour
				else if(ishuman(L))
					var/mob/living/carbon/human/H = L
					blood_col = H.species.blood_color
				// BLOOD BLOOD BLOOD
				for(var/i = 1 to min(round(slash_damage * 0.05), 15))
					new /obj/effect/temp_visual/bloodsplatter(LT, prob(25) ? pick(GLOB.alldirs) : get_dir(LT, start_turf), blood_col)
				if(!istype(LT))
					continue
				LT.add_blood(L)

/datum/spell/aimed/water_slash/ImproveSpellPower()
	if(!..())
		return FALSE

	slash_damage += 25
	return "The [src] spell now deals [slash_damage] damage."
