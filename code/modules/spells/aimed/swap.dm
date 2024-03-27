/datum/spell/aimed/swap
	name = "Swap"
	desc = "This spell swaps the positions of the wizard and a target."
	deactive_msg = "You discharge the swap spell..."
	active_msg = "You charge the swap spell!"

	invocation = "Joyo!"
	invocation_type = INVOKE_WHISPER

	level_max = list(UPGRADE_TOTAL = 2, UPGRADE_SPEED = 0, UPGRADE_POWER = 2)

	spell_flags = 0
	range = 6

	hud_state = "wiz_swap"

	cast_sound = 'sounds/magic/blink.ogg'

	spell_cost = 1
	mana_cost = 5

	var/eye_blind = 0

/datum/spell/aimed/swap/TargetCastCheck(mob/living/user, mob/living/target)
	if(!isliving(target))
		to_chat(user, SPAN_WARNING("The target must be a living creature!"))
		return FALSE
	if(get_dist(user, target) > range)
		to_chat(user, SPAN_WARNING("The target is too far away!"))
		return FALSE
	return ..()

/datum/spell/aimed/swap/fire_projectile(mob/living/user, mob/living/target)
	. = ..()
	var/turf/target_turf = get_turf(target)
	var/turf/user_turf = get_turf(user)

	target.forceMove(user_turf)
	user.forceMove(target_turf)

	target.adjust_temp_blindness(eye_blind)

/datum/spell/aimed/swap/ImproveSpellPower()
	if(!..())
		return FALSE

	eye_blind += 2
	return "The [src] spell will now blind the target[eye_blind > 2 ? " even more" : ""]."
