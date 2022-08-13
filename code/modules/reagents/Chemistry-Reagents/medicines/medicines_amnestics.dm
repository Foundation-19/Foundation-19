/datum/reagent/amnestics
	name = "Amnestics"
	description = "Amnestics are applied to remove memories from a target, often to different degrees."
	taste_description = "something you already forgot"
	reagent_state = LIQUID
	color = "#ff0080"
	color_weight = 25
	var/isamnesticized = FALSE
	var/threshold = 5 //threshold for sleep.

/datum/reagent/amnestics/classa
	name = "Class-A Amnestics"
	color = "#dd0030"
	overdose = 5
	value = 15

/datum/reagent/amnestics/classa/affect_blood(mob/living/carbon/M, removed)

	if(M.chem_doses[type] >= 4.8 && !isamnesticized)
		isamnesticized = TRUE
		to_chat(M, "<span class='notice'>You feel your memory drifting away...</span>")
		M.visible_message("<span class='warning'>[M] looks confused for a moment.</span>")
		to_chat(M, "<font size='5' color='red'> Твои воспоминания уходят в небытие... Ты не можешь вспомнить события, предшествовавшие амнестизации.</font>")
	else
		if(prob(10))
			M.drowsyness += 5
		if(prob(35))
			if(M.dizziness <= 200)
				M.make_dizzy(15)

/datum/reagent/amnestics/classa/overdose(mob/living/carbon/M, removed)
	M.adjustBrainLoss(14 * removed) //Brain damage. Dont fuck with memories too much.

/datum/reagent/amnestics/classb
	name = "Class-B Amnestics"
	color = "#00D9D9"
	overdose = 5
	value = 20

/datum/reagent/amnestics/classb/affect_blood(mob/living/carbon/M, removed)
	if(M.chem_doses[type] >= 4.8 && !isamnesticized)
		isamnesticized = TRUE
		to_chat(M, "<span class='notice'>Your brain feels slightly emptier...</span>")
		M.visible_message("<span class='warning'>[M] looks deeply confused.</span>")
		to_chat(M, "<font size='5' color='red'> Твои воспоминания об этом дне уходят в небытие... Ты потерял все воспоминания вплоть до начала смены.</font>")
	else
		if(prob(15))
			M.drowsyness += 5
		if(prob(35))
			if(M.dizziness <= 200)
				M.make_dizzy(15) //will make you pretty dizzy to have your memories ripped out.

/datum/reagent/amnestics/classb/overdose(mob/living/carbon/M, removed)
	M.adjustBrainLoss(20 * removed) //Even bigger brain damage. DO NOT FUCK WITH MEMORIES.

/datum/reagent/amnestics/classc
	name = "Class-C Amnestics"
	color = "#ffd900"
	overdose = 10
	threshold = 5
	value = 25

/datum/reagent/amnestics/classc/affect_blood(mob/living/carbon/M, removed)
	if(M.chem_doses[type] >= 9.8 && !isamnesticized)
		isamnesticized = TRUE
		to_chat(M, "<span class='notice'>Memories are ripped out of your head!</span>")
		//No visible message because they are sleeping.
		to_chat(M, "<font size='5' color='red'> Твои воспоминания о прошедшей неделе уходят в небытие... Ты не можешь вспомнить что-либо с прошедшей недели.</font>") //TODO
	else
		M.add_chemical_effect(CE_SEDATE, 1) //sedative logic stolen from chloral hydrate.
		if (M.chem_doses[type] <= metabolism * threshold)
			M.confused += 2
			M.drowsyness += 2
		if (M.chem_doses[type] < 2 * threshold)
			M.Weaken(30)
			M.eye_blurry = max(M.eye_blurry, 10)
		else
			M.sleeping = max(M.sleeping, 30)
		if(prob(35))
			if(M.dizziness <= 200)
				M.make_dizzy(15) //will make you pretty dizzy to have your memories ripped out.

/datum/reagent/amnestics/classc/overdose(mob/living/carbon/M, removed)
	M.adjustBrainLoss(25 * removed) //Mega big brain damage. Amnestecize with caution.
	M.adjustToxLoss(5 * removed) //Also kinda toxic

/datum/reagent/amnestics/classd
	name = "Class-D Amnestics"
	color = "#5ac404"
	overdose = 5
	threshold = 2.5
	value = 50

/datum/reagent/amnestics/classd/affect_blood(mob/living/carbon/M, removed)
	if(M.chem_doses[type] >= 9.8 && !isamnesticized) //OD is lower than the amount of doses it needs to work. So you need to give it as an IV over a long time.
		isamnesticized = TRUE
		to_chat(M, "<span class='notice'>Memories are ripped out of your head!</span>")
		//No visible message because they are sleeping.
		to_chat(M, "<font size='5' color='red'> Твои воспоминания о последних неделях уходят в небытие... Ты не можешь вспомнить что-либо с последних нескольких недель.</font>")
	else
		M.add_chemical_effect(CE_SEDATE, 1) //sedative logic stolen from chloral hydrate.
		if (M.chem_doses[type] <= metabolism * threshold)
			M.confused += 2
			M.drowsyness += 2
		if (M.chem_doses[type] < 2 * threshold)
			M.Weaken(30)
			M.eye_blurry = max(M.eye_blurry, 10)
		else
			M.sleeping = max(M.sleeping, 30)

		M.add_chemical_effect(CE_BREATHLOSS, 1) //Target will have trouble breathing.
		if(prob(10))
			M.adjustBrainLoss(2.5 * removed) //Very minor chance to cause a little bit of brain damage.
		if(prob(35))
			if(M.dizziness <= 200)
				M.make_dizzy(10) //will make you pretty dizzy to have your memories ripped out.

/datum/reagent/amnestics/classd/overdose(mob/living/carbon/M, removed)
	M.adjustBrainLoss(30 * removed) // OD straight up melts your brain. Get it out ASAP!
	M.adjustToxLoss(10 * removed) //Very toxic.

/datum/reagent/amnestics/classf
	name = "Class-F Amnestics"
	color = "#a0a0a0"
	overdose = 5
	threshold = 1
	value = 75

/datum/reagent/amnestics/classf/affect_blood(mob/living/carbon/M, removed)
	M.Weaken(10) //Lying paralyzed and silenced on the floor before falling asleep. How ethical.
	if(M.chem_doses[type] >= 19.8 && !isamnesticized) //OD is lower than the amount of doses it needs to work. So you need to give it as an IV over a long time.
		isamnesticized = TRUE
		to_chat(M, "<span class='notice'>Who... Am... I?</span>")
		//No visible message because they are sleeping.
		to_chat(M, "<font size='5' color='red'> Все твои воспоминания уходят в небытие... Ты потерял все дорогие тебе воспоминания, а твоя личность был стерта, чтобы вновь быть слепленной, как из пластелина.</font>")
	else
		M.add_chemical_effect(CE_SEDATE, 1) //sedative logic stolen from chloral hydrate.
		if (M.chem_doses[type] <= metabolism * threshold)
			M.confused += 2
			M.drowsyness += 2
		if (M.chem_doses[type] < 2 * threshold)
			M.Weaken(30)
			M.eye_blurry = max(M.eye_blurry, 10)
		else
			M.sleeping = max(M.sleeping, 30)
		M.add_chemical_effect(CE_BREATHLOSS, 1.5) //Target will have trouble breathing.
		if(prob(20))
			M.adjustBrainLoss(2.5 * removed) //Very minor chance to cause a little bit of brain damage.
		if(prob(35))
			if(M.dizziness <= 200)
				M.make_dizzy(10) //will make you pretty dizzy to have your memories ripped out.

/datum/reagent/ethanol/regrettiforgetti
	name = "Regretti Forgetti" //Forgetti all those horrible regretti's!
	description = "Amnestics, Vodka, And powerful hallucinogenics. For when you literally want to drink your worries away."
	taste_description = "Vodka, Hardcore drugs, And something you cant quite remember."
	strength = 15
	color = "#d81d6b"
	overdose = 30
	value = 10
	glass_name = "Regretti Forgetti"
	glass_desc = "A popular foundation home-remedy for PTSD. For when you literally want to drink your worries away. Made with genuine amnestics!"
	var/list/dose_messages = list(
		"Where are you?",
		"Huh?",
		"What were you doing again?",
		"Whats your name again? Oh rights, Thats it...",
		"Its right on the tip of your tounge, You just cant quite remember...",
		"What did they say to you again?",
		"What were you sitting on again?",
		"Huh... Where are you?",
		"Black, White, Black, White, Black, White, Black, White, Black, White, Grey... Grey?",
		"Oh right... Thats what it was called.",
		"What do these numbers mean... Are they my name?",
		"Why does my brain taste like purple and... Forgotten yellow?",
		"What color is SCP-173? Wait, who is the SCP-173?"
	)
/datum/reagent/ethanol/regrettiforgetti/affect_ingest(var/mob/living/carbon/M, var/removed)
	M.make_dizzy(5)
	M.confused += 5
	if (prob(10))
		to_chat(M, SPAN_WARNING("<font size = [rand(1,3)]>[pick(dose_messages)]</font>"))

//Pills and autoinjectors.
/obj/item/storage/pill_bottle/amnesticsa
	name = "pill bottle (Class-A Amnestics)"
	desc = "Contains Class-A Amnestics, used to erase memories within 6-12hrs"
	startswith = list(/obj/item/reagent_containers/pill/amnestics/classa = 14)
	wrapper_color = COLOR_RED

/obj/item/reagent_containers/pill/amnestics/classa
	name = "class a amnestic pill (5u)"
	icon_state = "pill1"
	desc = "A pill to forget today's horrific highlights!"

/obj/item/reagent_containers/pill/amnestics/classa/New()
	..()
	reagents.add_reagent(/datum/reagent/amnestics/classa, 5)
	color = reagents.get_color()

/obj/item/storage/pill_bottle/amnesticsb
	name = "pill bottle (Class-B Amnestics)"
	desc = "Contains Class-B Amnestics, used to erase memories within 20-72hrs"
	startswith = list(/obj/item/reagent_containers/pill/amnestics/classb = 14)
	wrapper_color = COLOR_CYAN

/obj/item/reagent_containers/pill/amnestics/classb
	name = "class b amnestic pill (5u)"
	icon_state = "pill1"
	desc = "A pill to make you forget that akward date."

/obj/item/reagent_containers/pill/amnestics/classb/New()
	..()
	reagents.add_reagent(/datum/reagent/amnestics/classb, 5)
	color = reagents.get_color()

/obj/item/reagent_containers/syringe/amnesticsc
	name = "Syringe (Class-C Amnestics)"
	desc = "A syringe filled with Class-C Amnestics. Used to erase 4-9 days worth of memories. Side effects include : Sedation, Respiratory issues, Dizzyness. Use only under supervision of medical staff."

/obj/item/reagent_containers/syringe/amnesticsc/New()
	..()
	reagents.add_reagent(/datum/reagent/amnestics/classc, 15)
	update_icon()

/obj/item/reagent_containers/ivbag/amnesticsd
	name = "\improper IV bag Class-D Amnestics"
	desc = "An extra small IV bag filled with heavily dilluted Class-D Amnestics. Erases 3 weeks worth of memories. It has instructions on it that read : 'To avoid overdose, Configure IV drip to tranfer speed of 1u. Only inject one bag, Overdose will cause severe brain damage. Side effects include : Respiratory issues, Minor brain damage, Paralysis, and sedation.."
	volume = 25

/obj/item/reagent_containers/ivbag/amnesticsd/New()
	..()
	reagents.add_reagent(/datum/reagent/amnestics/classd, 10)
	reagents.add_reagent(/datum/reagent/water, 15)

/obj/item/reagent_containers/ivbag/amnesticsf
	name = "\improper IV bag Class-F Amnestics"
	desc = "A smaller than average IV bag filled with heavily dilluted Class-F Amnestics. Used to erase the patient's entire identity, Turning them into a blank slate to mold. It has instructions on it that read : 'To avoid overdose, Configure IV drip to tranfer speed of 1u. Only inject one bag, Overdose will cause severe brain damage. Side effects include : Respiratory issues, Minor brain damage, Paralysis, and sedation."
	volume = 50

/obj/item/reagent_containers/ivbag/amnesticsf/New()
	..()
	reagents.add_reagent(/datum/reagent/amnestics/classf, 20)
	reagents.add_reagent(/datum/reagent/water, 30)

//Amnestic chemical reactions.

/datum/chemical_reaction/classa
	name = "Class-A Amnestics"
	result = /datum/reagent/amnestics/classa
	required_reagents = list(/datum/reagent/mindbreaker_toxin = 1, /datum/reagent/medicine/alkysine = 1, /datum/reagent/impedrezene = 1)
	result_amount = 3

/datum/chemical_reaction/classb
	name = "Class-B Amnestics"
	result = /datum/reagent/amnestics/classb
	required_reagents = list(/datum/reagent/radium = 1, /datum/reagent/amnestics/classa = 1, /datum/reagent/medicine/fluff/citalopram = 1)
	result_amount = 3

/datum/chemical_reaction/classc
	name = "Class-C Amnestics"
	result = /datum/reagent/amnestics/classc
	required_reagents = list(/datum/reagent/amnestics/classb = 1, /datum/reagent/mindbreaker_toxin = 1, /datum/reagent/medicine/fluff/paroxetine = 1)
	result_amount = 3 //This was wrong

/datum/chemical_reaction/classd //VERY HARD TO MAKE AND DANGEROUS.
	name = "Class-D Amnestics"
	result = /datum/reagent/amnestics/classd
	required_reagents = list(/datum/reagent/amnestics/classc = 3, /datum/reagent/chloral_hydrate = 10,/datum/reagent/mindbreaker_toxin = 5, /datum/reagent/impedrezene = 5)
	result_amount = 3 //Unforgivingly expensive to make in the quantities needed.

/datum/chemical_reaction/regrettiforgetti
	name = "Regretti Forgetti"
	result = /datum/reagent/ethanol/regrettiforgetti
	required_reagents = list(/datum/reagent/ethanol/vodka = 1, /datum/reagent/mindbreaker_toxin = 1, /datum/reagent/amnestics/classa = 1)
	result_amount = 3
