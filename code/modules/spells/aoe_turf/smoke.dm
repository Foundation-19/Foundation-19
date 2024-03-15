/datum/spell/aoe_turf/smoke
	name = "Smoke"
	desc = "This spell spawns a cloud of choking smoke at your location."
	charge_max = 120
	spell_flags = NO_SOMATIC
	invocation = "none"
	invocation_type = INVOKE_NONE
	range = 1
	inner_radius = -1
	level_max = list(UPGRADE_TOTAL = 3, UPGRADE_SPEED = 3, UPGRADE_POWER = 2)
	cooldown_min = 20 //25 deciseconds reduction per rank

	smoke_spread = 2
	smoke_amt = 5

	hud_state = "wiz_smoke"
	cast_sound = 'sounds/magic/smoke.ogg'

	spell_cost = 1
	mana_cost = 5

/datum/spell/aoe_turf/smoke/ImproveSpellPower()
	if(!..())
		return 0
	smoke_amt += 2

	return "[src] will now create more smoke."
