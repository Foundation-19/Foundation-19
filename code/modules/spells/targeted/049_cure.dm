/datum/spell/targeted/curepestillence
	name = "Cure Pestillence"
	desc = "Cure someone of the pestillence, or simply experiment to improve your techniques."
	compatible_mobs = list(/mob/living/carbon/human)
	range = 1
	max_targets = 1
	spell_flags = null
	charge_max = 0
	var/using = FALSE

/datum/spell/targeted/curepestillence/cast(list/targets, mob/user)
	if(!using)
		var/mob/living/carbon/human/scp049/player = user
		for(var/mob/living/carbon/human/target in targets)
			using = TRUE
			player.conversion_act()
		using = FALSE

