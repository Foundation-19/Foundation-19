/datum/spell/targeted/heal_target/area
	name = "Cure Area"
	desc = "This spell heals everyone in an area."
	charge_max = 1 MINUTE
	spell_flags = INCLUDEUSER
	invocation = "Nal Di'Nath!"
	invocation_type = INVOKE_SHOUT
	range = 2
	max_targets = 0
	level_max = list(UPGRADE_TOTAL = 3, UPGRADE_SPEED = 2, UPGRADE_POWER = 2)
	cooldown_reduc = 300
	hud_state = "heal_area"
	amt_dam_robo = -6
	amt_dam_brute = -25
	amt_dam_fire = -25

	spell_cost = 3
	mana_cost = 25

/datum/spell/targeted/heal_target/area/ImproveSpellPower()
	if(!..())
		return 0
	amt_dam_brute -= 15
	amt_dam_fire -= 15
	amt_dam_robo -= 4
	range += 2

	return "[src] now heals more in a wider area."
