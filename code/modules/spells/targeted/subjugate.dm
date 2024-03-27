/datum/spell/targeted/subjugation
	name = "Subjugation"
	desc = "This spell temporarily subjugates a target's mind and does not require wizard garb."
	charge_max = 500
	spell_flags = NOFACTION
	invocation = "Dii Oda Baji."
	invocation_type = INVOKE_WHISPER

	message = "<span class='danger'>You suddenly feel completely overwhelmed!</span>"

	max_targets = 1

	level_max = list(UPGRADE_TOTAL = 3, UPGRADE_SPEED = 0, UPGRADE_POWER = 3)

	amt_dizziness = 20
	amt_confused = 20
	amt_stuttering = 75

	compatible_mobs = list(/mob/living/carbon/human)

	hud_state = "wiz_subj"

	spell_cost = 3
	mana_cost = 25

/datum/spell/targeted/subjugation/ImproveSpellPower()
	if(!..())
		return 0

	if(spell_levels[UPGRADE_POWER] == level_max[UPGRADE_POWER])
		max_targets = 0

		return "[src] will now effect everyone in the area."
	else
		max_targets++
		return "[src] will now effect [max_targets] people."
