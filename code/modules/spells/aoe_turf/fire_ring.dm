/datum/spell/aoe_turf/fire_ring
	name = "Ring of Fire"
	desc = "The spell envelopes the area around user in fire."
	spell_flags = NEEDSCLOTHES | IGNOREDENSE
	invocation = "Ignis anulus!"
	invocation_type = INVOKE_SHOUT

	range = 1
	inner_radius = 0

	level_max = list(UPGRADE_TOTAL = 3, UPGRADE_SPEED = 2, UPGRADE_POWER = 2)

	charge_max = 30 SECONDS
	cooldown_min = 5 SECONDS
	cooldown_reduc = 10 SECONDS

	hud_state = "wiz_fire_ring"
	cast_sound = 'sounds/magic/fire.ogg'

	spell_cost = 3
	mana_cost = 15
	categories = list(SPELL_CATEGORY_FIRE)

	var/flame_power = 20
	var/flame_color = COLOR_ORANGE

/datum/spell/aoe_turf/fire_ring/cast(list/targets, mob/user)
	if(!LAZYLEN(targets))
		return

	var/turf/user_turf = get_turf(user)
	for(var/turf/T in targets)
		var/obj/effect/turf_fire/TF = T.IgniteTurf(flame_power, flame_color)
		if(istype(TF))
			TF.interact_with_atmos = FALSE
			TF.pixel_x = (user_turf.x - T.x) * world.icon_size
			TF.pixel_y = (user_turf.y - T.y) * world.icon_size
			animate(TF, pixel_x = 0, pixel_y = 0, time = 3, easing = EASE_OUT)

/datum/spell/aoe_turf/fire_ring/ImproveSpellPower()
	if(!..())
		return FALSE

	range += 1

	return "You've increased the radius of [src]."
