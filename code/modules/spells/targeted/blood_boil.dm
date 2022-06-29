/datum/spell/targeted/blood_boil
	name = "Blood Boil"
	desc = "This spell allows the caster to heat up an adversary's body so much their blood boils."
	feedback = "BO"
	school = "transmutation"
	charge_max = 300
	spell_flags = 0
	invocation_type = INVOKE_NONE
	range = 5
	max_targets = 1
	compatible_mobs = list(/mob/living/carbon/human)

	time_between_channels = 30
	number_of_channels = 0

	hud_state = "wiz_boilblood"

/datum/spell/targeted/blood_boil/cast(list/targets, mob/user)
	for(var/mob/living/carbon/human/H in targets)
		H.bodytemperature += 80
		if(prob(10))
			to_chat(H, "<span class='warning'>\The [user] seems to radiate an uncomfortable amount of heat your direction.</span>")
		if(H.bodytemperature > H.getSpeciesOrSynthTemp(HEAT_LEVEL_3)) //Burst into flames
			H.fire_stacks += 50
			H.IgniteMob()
