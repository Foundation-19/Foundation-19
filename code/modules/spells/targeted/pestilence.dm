/datum/spell/targeted/pestilence
	name = "Pestilence"
	desc = "Infects everyone nearby with a disease. You are made immune to it."
	invocation = "Decay!"
	invocation_type = INVOKE_SHOUT
	max_targets = 0
	charge_max = 400
	range = 3

	hud_state = "wiz_pestilence"
	cast_sound = 'sounds/magic/pestilence.ogg'

	spell_cost = 2
	mana_cost = 10
	compatible_mobs = list(/mob/living/carbon/human)

	level_max = list(UPGRADE_TOTAL = 5, UPGRADE_SPEED = 0, UPGRADE_POWER = 5)

	var/disease_symptoms = 2
	var/disease_severity = 3

/datum/spell/targeted/pestilence/cast(list/targets, mob/living/carbon/human/user)
	var/datum/disease/D = new /datum/disease/advance/random(disease_symptoms, disease_severity)
	user.disease_resistances |= D.GetDiseaseID()
	for(var/i = 1 to 8)
		new /obj/effect/temp_visual/pestilence_glow/self(get_turf(user))
	for(var/mob/living/carbon/human/H in targets)
		if(LAZYLEN(H.diseases))
			continue
		if(!H.CanContractDisease(D))
			continue

		H.ForceContractDisease(D, FALSE, TRUE)
		for(var/i = 1 to 4)
			new /obj/effect/temp_visual/pestilence_glow(get_turf(H))

/datum/spell/targeted/pestilence/ImproveSpellPower()
	if(!..())
		return FALSE

	disease_symptoms += 1
	disease_severity += 1

	return "The symptoms of the disease created with spell [src] are now more powerful and their amount is [disease_symptoms]."
