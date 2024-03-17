/datum/spell/targeted/torment
	name = "Torment"
	desc = "this spell causes pain to all those in its radius."
	charge_max = 150
	spell_flags = NOFACTION
	invocation = "Rai Di-Kaal!"
	invocation_type = INVOKE_SHOUT
	range = 5
	level_max = list(UPGRADE_TOTAL = 1, UPGRADE_SPEED = 0, UPGRADE_POWER = 1)
	cooldown_min = 50
	message = "<span class='danger'>So much pain! All you can hear is screaming!</span>"

	max_targets = 0
	compatible_mobs = list(/mob/living/carbon/human)

	var/loss = 30

	hud_state = "wiz_horse"
	cast_sound = 'sounds/magic/cowhead_curse.ogg'

	spell_cost = 2
	mana_cost = 10

/datum/spell/targeted/torment/cast(var/list/targets, var/mob/user)
	gibs(user.loc)
	for(var/mob/living/carbon/human/H in targets)
		H.adjustHalLoss(loss)

/datum/spell/targeted/torment/ImproveSpellPower()
	if(!..())
		return 0

	loss += 30

	return "[src] will now cause more pain."