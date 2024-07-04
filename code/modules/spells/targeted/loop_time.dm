/datum/spell/targeted/loop_time
	name = "Loop Time"
	desc = "this spell allows the caster to loop themselves in time, causing them to return to their location (with the same amount of health) after time has passed."
	charge_max = 40 SECONDS
	spell_flags = INCLUDEUSER
	invocation_type = INVOKE_SHOUT
	invocation = "Tempus Clausa!"
	range = 5
	max_targets = 1

	level_max = list(UPGRADE_TOTAL = 3, UPGRADE_SPEED = 2, UPGRADE_POWER = 2)
	cooldown_reduc = 10 SECOND

	hud_state = "wiz_timeloop"

	spell_cost = 3
	mana_cost = 20

	var/loop_interval = 10 SECONDS

/datum/spell/targeted/loop_time/cast(list/targets, mob/user)
	for(var/atom/atom in targets)
		atom.AddComponent(/datum/component/timeloop_individual, 1, loop_interval)

/datum/spell/targeted/loop_time/ImproveSpellPower()
	if(!..())
		return FALSE

	loop_interval += 10 SECONDS

	return "The [src] spell now returns you after [loop_interval / (1 SECOND)] seconds."
