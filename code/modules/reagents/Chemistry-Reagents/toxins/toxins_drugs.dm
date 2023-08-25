// For our cases, "drug" is a blanket term relating to things that would be produced and used recreationally, even if ilegally.
// They can be harmless, or insanely deadly. We only include drugs with immediate/short-term effects;
// even though nicotine can eventually kill you from lung cancer, it doesn't cause immediate effects stronger than intermittent messages.

/datum/reagent/space_drugs
	name = "Space Drugs"
	description = "Concentrated extract of the <i>ambrosia vulgaris</i> plant and its mutations. Causes heavy effects on thinking and cognition."
	taste_description = "bitterness"
	taste_mult = 0.4
	reagent_state = LIQUID
	color = "#60a584"
	metabolism = REM * 0.5
	overdose = REAGENTS_OVERDOSE
	value = 2.8
	should_admin_log = TRUE

/datum/reagent/space_drugs/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien == IS_DIONA)
		return

	var/drug_strength = 15
	if (alien == IS_SKRELL)
		drug_strength = drug_strength * 0.8

	M.druggy = max(M.druggy, drug_strength)
	if (alien != IS_SKRELL)
		if (prob(10))
			M.SelfMove(pick(GLOB.cardinal))
		if (prob(7))
			M.emote(pick("twitch", "drool", "moan", "giggle"))
	M.add_chemical_effect(CE_PULSE, -1)



/datum/reagent/serotrotium
	name = "Serotrotium"
	description = "A chemical compound that promotes concentrated production of the serotonin neurotransmitter in humans."
	taste_description = "bitterness"
	reagent_state = LIQUID
	color = "#202040"
	metabolism = REM * 0.25
	overdose = REAGENTS_OVERDOSE
	value = 2.5

/datum/reagent/serotrotium/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien == IS_DIONA)
		return
	if (prob(7))
		M.emote(pick("twitch", "drool", "moan", "gasp"))
	return



/datum/reagent/mindbreaker_toxin
	name = "Mindbreaker Toxin"
	description = "A powerful hallucinogen that can cause fatal effects in users."
	taste_description = "sourness"
	reagent_state = LIQUID
	color = "#b31008"
	metabolism = REM * 0.25
	overdose = REAGENTS_OVERDOSE
	value = 0.6
	should_admin_log = TRUE

/datum/reagent/mindbreaker_toxin/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien == IS_DIONA)
		return
	M.add_chemical_effect(CE_HALLUCINATION, -2)
	if (alien == IS_SKRELL)
		M.hallucination(25, 30)
	else
		M.hallucination(50, 50)



/datum/reagent/psilocybin
	name = "Psilocybin"
	description = "A strong psychotropic derived from certain species of mushroom."
	taste_description = "mushroom"
	color = "#e700e7"
	overdose = REAGENTS_OVERDOSE
	metabolism = REM * 0.5
	value = 0.7

/datum/reagent/psilocybin/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien == IS_DIONA)
		return

	var/threshold = 1
	if (alien == IS_SKRELL)
		threshold = 1.2

	M.druggy = max(M.druggy, 30)

	if (M.chem_doses[type] < 1 * threshold)
		M.apply_effect(3, STUTTER)
		M.make_dizzy(5)
		if (prob(5))
			M.emote(pick("twitch", "giggle"))
	else if (M.chem_doses[type] < 2 * threshold)
		M.apply_effect(3, STUTTER)
		M.make_jittery(5)
		M.make_dizzy(5)
		M.druggy = max(M.druggy, 35)
		if (prob(10))
			M.emote(pick("twitch", "giggle"))
	else
		M.add_chemical_effect(CE_HALLUCINATION, -1)
		M.apply_effect(3, STUTTER)
		M.make_jittery(10)
		M.make_dizzy(10)
		M.druggy = max(M.druggy, 40)
		if (prob(15))
			M.emote(pick("twitch", "giggle"))



/datum/reagent/three_eye
	name = "Three Eye"
	taste_description = "liquid starlight"
	description = "Out on the edge of human space, at the limits of scientific understanding and \
	cultural taboo, people develop and dose themselves with substances that would curl the hair on \
	a brinker's vatgrown second head. Three Eye is one of the most notorious narcotics to ever come \
	out of the independant habitats, and has about as much in common with recreational drugs as a \
	Stok does with an Unathi strike trooper. It is equally effective on humans, Skrell, dionaea and \
	probably the Captain's cat, and distributing it will get you guaranteed jail time in every \
	human territory."
	reagent_state = LIQUID
	color = "#ccccff"
	metabolism = REM
	overdose = 25
	should_admin_log = TRUE

	// M A X I M U M C H E E S E
	var/global/list/dose_messages = list(
		"Your name is called. It is your time.",
		"You are dissolving. Your hands are wax...",
		"It all runs together. It all mixes.",
		"It is done. It is over. You are done. You are over.",
		"You won't forget. Don't forget. Don't forget.",
		"Light seeps across the edges of your vision...",
		"Something slides and twitches within your sinus cavity...",
		"Your bowels roil. It waits within.",
		"Your gut churns. You are heavy with potential.",
		"Your heart flutters. It is winged and caged in your chest.",
		"There is a precious thing, behind your eyes.",
		"Everything is ending. Everything is beginning.",
		"Nothing ends. Nothing begins.",
		"Wake up. Please wake up.",
		"Stop it! You're hurting them!",
		"It's too soon for this. Please go back.",
		"We miss you. Where are you?",
		"Come back from there. Please."
	)

	var/global/list/overdose_messages = list(
		"THE SIGNAL THE SIGNAL THE SIGNAL THE SIGNAL",
		"IT CRIES IT CRIES IT WAITS IT CRIES",
		"NOT YOURS NOT YOURS NOT YOURS NOT YOURS",
		"THAT IS NOT FOR YOU",
		"IT RUNS IT RUNS IT RUNS IT RUNS",
		"THE BLOOD THE BLOOD THE BLOOD THE BLOOD",
		"THE LIGHT THE DARK A STAR IN CHAINS"
	)

/datum/reagent/three_eye/affect_blood(mob/living/carbon/M, alien, removed)
	M.add_client_color(/datum/client_color/thirdeye)
	M.add_chemical_effect(CE_THIRDEYE, 1)
	M.add_chemical_effect(CE_HALLUCINATION, -2)
	M.hallucination(50, 50)
	M.make_jittery(3)
	M.make_dizzy(3)
	if (prob(0.1) && ishuman(M))
		var/mob/living/carbon/human/H = M
		H.seizure()
		H.adjustBrainLoss(rand(8, 12))
	if (prob(5))
		to_chat(M, SPAN_WARNING("<font size = [rand(1,3)]>[pick(dose_messages)]</font>"))

/datum/reagent/three_eye/on_leaving_metabolism(mob/parent, metabolism_class)
	parent.remove_client_color(/datum/client_color/thirdeye)

/datum/reagent/three_eye/overdose(mob/living/carbon/M, alien)
	..()
	M.adjustBrainLoss(rand(1, 5))
	if (ishuman(M) && prob(10))
		var/mob/living/carbon/human/H = M
		H.seizure()
	if (prob(10))
		to_chat(M, SPAN_DANGER("<font size = [rand(2,4)]>[pick(overdose_messages)]</font>"))
	if (M.psi)
		M.psi.check_latency_trigger(45, "a Three Eye overdose")

/datum/reagent/jerraman
	name = "Jerraman"
	taste_description = "liquid starlight"
	description = "A rare and expensive drug used legally by professionals to awaken psionic latencies in those who possess them, dangerous in higher doses."
	reagent_state = LIQUID
	color = "#d0ff00"
	metabolism = 1
	overdose = 5

	var/global/list/dose_messages = list(
		"Your name is called. It is your time.",
		"It all runs together. It all mixes.",
		"You won't forget. Don't forget. Don't forget.",
		"Everything is ending. Everything is beginning."
	)

	var/global/list/overdose_messages = list(
		"THE SIGNAL THE SIGNAL THE SIGNAL THE SIGNAL",
		"IT CRIES IT CRIES IT WAITS IT CRIES",
		"NOT YOURS NOT YOURS NOT YOURS NOT YOURS",
		"IT RUNS IT RUNS IT RUNS IT RUNS",
		"THE BLOOD THE BLOOD THE BLOOD THE BLOOD",
		"GET IT OUT GET IT OUT GET IT OUT",
		"THE LIGHT THE DARK A STAR IN CHAINS"
	)

/datum/reagent/jerraman/affect_blood(mob/living/carbon/M, alien, removed)
	M.add_chemical_effect(CE_THIRDEYE, 1)
	M.add_chemical_effect(CE_HALLUCINATION, -2)
	M.make_dizzy(5)
	if(prob(30))
		to_chat(M, SPAN_WARNING("<font size = [rand(1,2)]>[pick(dose_messages)]</font>"))
	if(M.psi)
		M.psi.check_latency_trigger(70, "a Jerraman dose")

/datum/reagent/jerraman/overdose(mob/living/carbon/M, alien)
	..()
	to_chat(M, SPAN_DANGER("You feel like the voices are tearing you apart, you lose control over your body and mind, going into a berserk."))
	M.hallucination(50, 50)
	M.make_jittery(5)
	M.adjustBrainLoss(rand(5, 10))
	if(ishuman(M) && prob(20))
		var/mob/living/carbon/human/H = M
		H.seizure()
	if(prob(10))
		to_chat(M, SPAN_DANGER("<font size = [rand(3,4)]>[pick(overdose_messages)]</font>"))
