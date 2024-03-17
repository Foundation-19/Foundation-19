/datum/disease/advance
	name = "Unknown" // We will always let our Virologist name our disease.
	desc = "An engineered disease which can contain a multitude of symptoms."
	form = "Advance Disease" // Will let med-scanners know that this disease was engineered.
	agent = "advance microbes"
	max_stages = 5
	spread_text = "Unknown"
	viable_mobtypes = list(/mob/living/carbon/human)

	var/list/properties = list()
	var/list/symptoms = list() // The symptoms of the disease.
	var/id = ""
	var/processing = FALSE
	var/mutable = TRUE //set to FALSE to prevent most in-game methods of altering the disease via virology
	var/oldres //To prevent setting new cures unless resistance changes.

	// The order goes from easy to cure to hard to cure. Keep in mind that sentient diseases pick two cures from tier 6 and up, ensure they won't react away in bodies.
	var/static/list/advance_cures = list(
		list(/datum/reagent/water, /datum/reagent/copper, /datum/reagent/iron),
		list(/datum/reagent/carbon, /datum/reagent/lithium, /datum/reagent/silicon),
		list(/datum/reagent/acetone, /datum/reagent/ethanol, /datum/reagent/mercury, /datum/reagent/radium, /datum/reagent/ammonia),
		list(/datum/reagent/ethanol/beer, /datum/reagent/medicine/inaprovaline, /datum/reagent/medicine/noexcutite),
		list(/datum/reagent/medicine/fluff/antidexafen),
		list(/datum/reagent/medicine/cryogenic/cryoxadone, /datum/reagent/hydrazine, /datum/reagent/medicine/sterilizine, /datum/reagent/medicine/tricordrazine, /datum/reagent/medicine/alkysine),
		list(/datum/reagent/medicine/bicaridine, /datum/reagent/medicine/kelotane, /datum/reagent/medicine/ethylredoxrazine, /datum/reagent/medicine/imidazoline),
		list(/datum/reagent/medicine/meraline, /datum/reagent/medicine/dermaline, /datum/reagent/medicine/hyronalin, /datum/reagent/medicine/peridaxon),
		list(/datum/reagent/medicine/dylovene/venaxilin),
		list(/datum/reagent/medicine/arithrazine),
		list(/datum/reagent/medicine/rezadone),
	)

/datum/disease/advance/New()
	Refresh()

/datum/disease/advance/Destroy()
	if(processing)
		for(var/datum/symptom/S in symptoms)
			S.End(src)
	return ..()

/datum/disease/advance/TryInfect(mob/living/infectee, make_copy = TRUE)
	//see if we are more transmittable than enough diseases to replace them
	//diseases replaced in this way do not confer immunity
	var/list/advance_diseases = list()
	for(var/datum/disease/advance/P in infectee.diseases)
		advance_diseases += P
	var/replace_num = advance_diseases.len + 1 - DISEASE_LIMIT //amount of diseases that need to be removed to fit this one
	if(replace_num > 0)
		sortTim(advance_diseases, GLOBAL_PROC_REF(cmp_advdisease_resistance_asc))
		for(var/i in 1 to replace_num)
			var/datum/disease/advance/competition = advance_diseases[i]
			if(TotalTransmittable() > competition.TotalResistance())
				competition.Cure(FALSE)
			else
				return FALSE //we are not strong enough to bully our way in
	Infect(infectee, make_copy)
	return TRUE

// Randomly pick a symptom to activate.
/datum/disease/advance/StageAct()
	. = ..()
	if(!.)
		return FALSE

	if(!length(symptoms))
		return FALSE

	if(!processing)
		processing = TRUE
		for(var/datum/symptom/symptom in symptoms)
			if(symptom.Start(src)) //this will return FALSE if the symptom is neutered
				symptom.next_activation = world.time + rand(symptom.symptom_delay_min SECONDS, symptom.symptom_delay_max SECONDS)
			symptom.on_stage_change(src)

	for(var/datum/symptom/S in symptoms)
		S.Activate(src)
	return TRUE

// Tell symptoms stage changed
/datum/disease/advance/UpdateStage(new_stage)
	..()
	for(var/datum/symptom/S in symptoms)
		S.on_stage_change(src)

// Compares type then ID.
/datum/disease/advance/IsSame(datum/disease/advance/D)

	if(!(istype(D, /datum/disease/advance)))
		return FALSE

	if(GetDiseaseID() != D.GetDiseaseID())
		return FALSE
	return TRUE

// Returns the advance disease with a different reference memory.
/datum/disease/advance/Copy()
	var/datum/disease/advance/A = ..()
	QDEL_LIST(A.symptoms)
	for(var/datum/symptom/S in symptoms)
		A.symptoms += S.Copy()
	A.properties = properties.Copy()
	A.id = id
	A.mutable = mutable
	A.oldres = oldres
	//this is a new disease starting over at stage 1, so processing is not copied
	return A

/datum/disease/advance/AntiViralEffect()
	return affected_mob.has_chem_effect(CE_ANTIVIRAL, max(1, properties["resistance"]))

// Mix the symptoms of two diseases (the src and the argument)
/datum/disease/advance/proc/Mix(datum/disease/advance/D)
	if(!(IsSame(D)))
		var/list/possible_symptoms = shuffle(D.symptoms)
		for(var/datum/symptom/S in possible_symptoms)
			AddSymptom(S.Copy())

/datum/disease/advance/proc/HasSymptom(datum/symptom/S)
	for(var/datum/symptom/symp in symptoms)
		if(symp.type == S.type)
			return TRUE
	return FALSE

// Will generate new unique symptoms, use this if there are none. Returns a list of symptoms that were generated.
/datum/disease/advance/proc/GenerateSymptoms(level_min, level_max, amount_get = 0)

	. = list() // Symptoms we generated.

	// Generate symptoms. By default, we only choose non-deadly symptoms.
	var/list/possible_symptoms = list()
	for(var/symp in SSdisease.list_symptoms)
		var/datum/symptom/S = new symp
		if(S.naturally_occuring && S.level >= level_min && S.level <= level_max)
			if(!HasSymptom(S))
				possible_symptoms += S

	if(!possible_symptoms.len)
		return

	// Random chance to get more than one symptom
	var/number_of = amount_get
	if(!amount_get)
		number_of = 1
		while(prob(20))
			number_of += 1

	for(var/i = 1; number_of >= i && possible_symptoms.len; i++)
		. += pick_n_take(possible_symptoms)

/datum/disease/advance/proc/Refresh(new_name = FALSE)
	GenerateProperties()
	AssignProperties()
	if(processing && symptoms?.len)
		for(var/datum/symptom/S in symptoms)
			S.Start(src)
			S.on_stage_change(src)
	id = null

	var/the_id = GetDiseaseID()
	if(!SSdisease.archive_diseases[the_id])
		SSdisease.archive_diseases[the_id] = src // So we don't infinite loop
		SSdisease.archive_diseases[the_id] = Copy()
		if(new_name)
			AssignName()

//Generate disease properties based on the effects. Returns an associated list.
/datum/disease/advance/proc/GenerateProperties()
	properties = list("resistance" = 0, "stealth" = 0, "stage_rate" = 0, "transmittable" = 0, "severity" = 0)

	for(var/datum/symptom/S in symptoms)
		properties["resistance"] += S.resistance
		properties["stealth"] += S.stealth
		properties["stage_rate"] += S.stage_speed
		properties["transmittable"] += S.transmittable
		if(!S.neutered)
			properties["severity"] = max(properties["severity"], S.severity) // severity is based on the highest severity non-neutered symptom

// Assign the properties that are in the list.
/datum/disease/advance/proc/AssignProperties()

	if(properties?.len)
		if(properties["stealth"] >= 9)
			visibility_flags |= HIDDEN_PANDEMIC
		if(properties["stealth"] >= 6)
			visibility_flags |= HIDDEN_ADVSCANNER
		if(properties["stealth"] >= 4)
			visibility_flags |= HIDDEN_SCANNER
		if(properties["stealth"] >= 2)
			visibility_flags |= HIDDEN_HUD
		else
			visibility_flags = 0

		if(properties["transmittable"]>=11)
			SetSpread(DISEASE_SPREAD_AIRBORNE)
		else if(properties["transmittable"]>=7)
			SetSpread(DISEASE_SPREAD_CONTACT_SKIN)
		else if(properties["transmittable"]>=3)
			SetSpread(DISEASE_SPREAD_CONTACT_FLUIDS)
		else
			SetSpread(DISEASE_SPREAD_BLOOD)

		permeability_mod = max(CEILING(0.4 * properties["transmittable"], 1), 1)
		cure_chance = 15 - clamp(properties["resistance"], -5, 5) // can be between 10 and 20
		stage_prob = max(properties["stage_rate"], 2)
		SetSeverity(properties["severity"])
		GenerateCure(properties)
	else
		CRASH("Our properties were empty or null!")


// Assign the spread type and give it the correct description.
/datum/disease/advance/proc/SetSpread(spread_id)
	switch(spread_id)
		if(DISEASE_SPREAD_NON_CONTAGIOUS)
			spread_flags = DISEASE_SPREAD_NON_CONTAGIOUS
			spread_text = "None"
		if(DISEASE_SPREAD_SPECIAL)
			spread_flags = DISEASE_SPREAD_SPECIAL
			spread_text = "None"
		if(DISEASE_SPREAD_BLOOD)
			spread_flags = DISEASE_SPREAD_BLOOD
			spread_text = "Blood"
		if(DISEASE_SPREAD_CONTACT_FLUIDS)
			spread_flags = DISEASE_SPREAD_BLOOD | DISEASE_SPREAD_CONTACT_FLUIDS
			spread_text = "Fluids"
		if(DISEASE_SPREAD_CONTACT_SKIN)
			spread_flags = DISEASE_SPREAD_BLOOD | DISEASE_SPREAD_CONTACT_FLUIDS | DISEASE_SPREAD_CONTACT_SKIN
			spread_text = "On contact"
		if(DISEASE_SPREAD_AIRBORNE)
			spread_flags = DISEASE_SPREAD_BLOOD | DISEASE_SPREAD_CONTACT_FLUIDS | DISEASE_SPREAD_CONTACT_SKIN | DISEASE_SPREAD_AIRBORNE
			spread_text = "Airborne"

/datum/disease/advance/proc/SetSeverity(level_sev)

	switch(level_sev)

		if(-INFINITY to 0)
			severity = DISEASE_SEVERITY_POSITIVE
		if(1)
			severity = DISEASE_SEVERITY_NONTHREAT
		if(2)
			severity = DISEASE_SEVERITY_MINOR
		if(3)
			severity = DISEASE_SEVERITY_MEDIUM
		if(4)
			severity = DISEASE_SEVERITY_HARMFUL
		if(5)
			severity = DISEASE_SEVERITY_DANGEROUS
		if(6 to INFINITY)
			severity = DISEASE_SEVERITY_BIOHAZARD
		else
			severity = "Unknown"


// Will generate a random cure, the more resistance the symptoms have, the harder the cure.
/datum/disease/advance/proc/GenerateCure()
	if(properties?.len)
		var/res = clamp(properties["resistance"] - (symptoms.len / 2), 1, advance_cures.len)
		if(res == oldres)
			return
		cures = list(pick(advance_cures[res]))
		oldres = res
		// Get the cure name
		var/datum/reagent/D = cures[1]
		cure_text = initial(D.name)

// Randomly generate a symptom, has a chance to lose or gain a symptom.
/datum/disease/advance/proc/Evolve(min_level, max_level, ignore_mutable = FALSE)
	if(!mutable && !ignore_mutable)
		return
	var/list/generated_symptoms = GenerateSymptoms(min_level, max_level, 1)
	if(length(generated_symptoms))
		var/datum/symptom/S = pick(generated_symptoms)
		AddSymptom(S)
		Refresh(TRUE)

// Randomly remove a symptom.
/datum/disease/advance/proc/Devolve(ignore_mutable = FALSE)
	if(!mutable && !ignore_mutable)
		return
	if(length(symptoms) > 1)
		var/datum/symptom/S = pick(symptoms)
		if(S)
			RemoveSymptom(S)
			Refresh(TRUE)

// Randomly neuter a symptom.
/datum/disease/advance/proc/Neuter(ignore_mutable = FALSE)
	if(!mutable && !ignore_mutable)
		return
	if(length(symptoms))
		var/datum/symptom/S = pick(symptoms)
		if(S)
			NeuterSymptom(S)
			Refresh(TRUE)

// Name the disease.
/datum/disease/advance/proc/AssignName(name = "Unknown")
	var/datum/disease/advance/A = SSdisease.archive_diseases[GetDiseaseID()]
	A.name = name

// Return a unique ID of the disease.
/datum/disease/advance/GetDiseaseID()
	if(!id)
		var/list/L = list()
		for(var/datum/symptom/S in symptoms)
			if(S.neutered)
				L += "[S.id]N"
			else
				L += S.id
		L = sortList(L) // Sort the list so it doesn't matter which order the symptoms are in.
		var/result = jointext(L, ":")
		id = result
	return id


// Add a symptom, if it is over the limit we take a random symptom away and add the new one.
/datum/disease/advance/proc/AddSymptom(datum/symptom/S)
	if(HasSymptom(S))
		return

	if(symptoms.len >= VIRUS_SYMPTOM_LIMIT)
		RemoveSymptom(pick(symptoms))
	symptoms += S
	S.OnAdd(src)

// Simply removes the symptom.
/datum/disease/advance/proc/RemoveSymptom(datum/symptom/S)
	symptoms -= S
	S.OnRemove(src)

// Neuter a symptom, so it will only affect stats
/datum/disease/advance/proc/NeuterSymptom(datum/symptom/S)
	if(!S.neutered)
		S.neutered = TRUE
		S.name += " (neutered)"
		S.OnRemove(src)

/*

	Static Procs

*/

// Mix a list of advance diseases and return the mixed result.
/proc/AdvanceMix(list/D_list)
	var/list/diseases = list()

	for(var/datum/disease/advance/A in D_list)
		diseases += A.Copy()

	if(!diseases.len)
		return null
	if(diseases.len <= 1)
		return pick(diseases) // Just return the only entry.

	var/i = 0
	// Mix our diseases until we are left with only one result.
	while(i < 20 && diseases.len > 1)

		i++

		var/datum/disease/advance/D1 = pick(diseases)
		diseases -= D1

		var/datum/disease/advance/D2 = pick(diseases)
		D2.Mix(D1)

	// Should be only 1 entry left, but if not let's only return a single entry
	var/datum/disease/advance/to_return = pick(diseases)
	to_return.Refresh(TRUE)
	return to_return

/proc/SetViruses(datum/reagent/R, list/data)
	if(data)
		var/list/preserve = list()
		if(istype(data) && data["viruses"])
			for(var/datum/disease/A in data["viruses"])
				preserve += A.Copy()
			R.data = data.Copy()
		if(preserve.len)
			R.data["viruses"] = preserve

/proc/AdminCreateVirus(client/user)
	if(!user)
		return

	var/i = VIRUS_SYMPTOM_LIMIT

	var/datum/disease/advance/D = new()
	D.symptoms = list()

	var/list/symptoms = list()
	symptoms += "Done"
	symptoms += SSdisease.list_symptoms.Copy()
	do
		if(user)
			var/symptom = input(user, "Choose a symptom to add ([i] remaining)", "Choose a Symptom") in sortList(symptoms, GLOBAL_PROC_REF(cmp_typepaths_asc))
			if(isnull(symptom))
				return
			else if(istext(symptom))
				i = 0
			else if(ispath(symptom))
				var/datum/symptom/S = new symptom
				if(!D.HasSymptom(S))
					D.AddSymptom(S)
					i -= 1
	while(i > 0)

	if(D.symptoms.len > 0)

		var/new_name = stripped_input(user, "Name your new disease.", "New Name")
		if(!new_name)
			return
		D.Refresh()
		D.AssignName(new_name)	//Updates the master copy
		D.name = new_name //Updates our copy

		var/list/targets = list("Random")
		targets += sortNames(GLOB.human_mob_list)
		var/target = input(user, "Pick a viable human target for the disease.", "Disease Target") as null|anything in targets

		var/mob/living/carbon/human/H
		if(!target)
			return
		if(target == "Random")
			for(var/human in shuffle(GLOB.human_mob_list))
				H = human
				var/found = FALSE
				if(!(H.z in GLOB.using_map.player_levels))
					continue
				if(!H.HasDisease(D))
					found = H.ForceContractDisease(D)
					break
				if(!found)
					to_chat(user, "Could not find a valid target for the disease.")
		else
			H = target
			H.ForceContractDisease(D)

		//message_admins("[key_name_admin(user)] has triggered a custom virus outbreak of [D.AdminDetails()] in [ADMIN_LOOKUPFLW(H)]")
		//log_virus("[key_name(user)] has triggered a custom virus outbreak of [D.AdminDetails()] in [H]!")


/datum/disease/advance/proc/TotalStageSpeed()
	return properties["stage_rate"]

/datum/disease/advance/proc/TotalStealth()
	return properties["stealth"]

/datum/disease/advance/proc/TotalResistance()
	return properties["resistance"]

/datum/disease/advance/proc/TotalTransmittable()
	return properties["transmittable"]
