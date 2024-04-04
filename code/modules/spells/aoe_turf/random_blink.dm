/datum/spell/aoe_turf/random_blink
	name = "Random blink"
	desc = "This spell randomly teleports you a short distance."

	spell_flags = Z2NOCAST | IGNOREDENSE | IGNORESPACE | NO_SOMATIC
	invocation = "none"
	invocation_type = INVOKE_NONE
	range = 4
	inner_radius = 1

	charge_max = 5 SECONDS
	cooldown_reduc = 1.5 SECONDS
	cooldown_min = 0.5 SECONDS

	level_max = list(UPGRADE_TOTAL = 4, UPGRADE_SPEED = 3, UPGRADE_POWER = 3)
	hud_state = "wiz_blink_random"
	cast_sound = 'sounds/magic/blink.ogg'

	categories = list(SPELL_CATEGORY_MOBILITY)
	spell_cost = 1
	mana_cost = 1

/datum/spell/aoe_turf/random_blink/cast(list/targets, mob/living/user)
	if(!targets.len)
		return

	var/turf/T = pick(targets)
	if(!istype(T))
		return

	if(user.buckled)
		user.buckled = null

	var/turf/starting = get_turf(user)
	user.forceMove(T)
	var/list/line_list = getline(starting, T)
	for(var/i = 1 to length(line_list))
		var/turf/TT = line_list[i]
		var/obj/effect/temp_visual/decoy/D = new /obj/effect/temp_visual/decoy(TT, user.dir, user)
		D.alpha = min(150 + i*15, 255)
		animate(D, alpha = 0, time = 2 + i*2)

	if(user.incapacitated(INCAPACITATION_STUNNED|INCAPACITATION_RESTRAINED|INCAPACITATION_BUCKLED_FULLY|INCAPACITATION_FORCELYING|INCAPACITATION_KNOCKOUT))
		charge_counter = -3 SECONDS
		to_chat(user, SPAN_WARNING("Castin [src] while incapacitated has put it on a higher cooldown!"))

	return

/datum/spell/aoe_turf/random_blink/ImproveSpellPower()
	range += 1
	return "You've increased the range of [src]."
