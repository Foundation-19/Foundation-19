//Randomly generated Disease, for virus crates and events
/datum/disease/advance/random
	name = "Experimental Disease"
	desc = "An naturally formed variant of an engineered disease which can contain a multitude of symptoms."
	form = "Mutated Advance Disease"
	copy_type = /datum/disease/advance

/datum/disease/advance/random/New(max_symptoms, max_level = 8)
	if(!max_symptoms)
		max_symptoms = rand(1, VIRUS_SYMPTOM_LIMIT)
	var/list/datum/symptom/possible_symptoms = list()
	for(var/symptom in subtypesof(/datum/symptom))
		var/datum/symptom/S = symptom
		if(initial(S.level) > max_level)
			continue
		if(initial(S.level) <= 0) //unobtainable symptoms
			continue
		possible_symptoms += S
	for(var/i in 1 to max_symptoms)
		var/datum/symptom/chosen_symptom = pick_n_take(possible_symptoms)
		if(chosen_symptom)
			var/datum/symptom/S = new chosen_symptom
			symptoms += S
	Refresh()

	name = "Sample #[rand(1,10000)]"

// Cold
/datum/disease/advance/cold
	copy_type = /datum/disease/advance

/datum/disease/advance/cold/New()
	name = "Cold"
	symptoms += new /datum/symptom/sneeze
	..()

// Flu
/datum/disease/advance/flu
	copy_type = /datum/disease/advance

/datum/disease/advance/flu/New()
	name = "Flu"
	symptoms += new /datum/symptom/cough
	..()

// Paranoia
/datum/disease/advance/paranoia
	copy_type = /datum/disease/advance

/datum/disease/advance/paranoia/New()
	name = "Paranoia"
	symptoms += new /datum/symptom/paranoia
	..()

// Conspiracy! Paranoia that spreads and is difficult to notice
/datum/disease/advance/conspiracy
	copy_type = /datum/disease/advance

/datum/disease/advance/conspiracy/New()
	name = "Conspirological Virus"
	symptoms += new /datum/symptom/paranoia
	symptoms += new /datum/symptom/viraladaptation
	var/datum/symptom/itching/I = new
	I.neutered = TRUE
	symptoms += I
	var/datum/symptom/fever/F = new
	F.neutered = TRUE
	symptoms += F
	var/datum/symptom/sneeze/S = new
	S.neutered = TRUE
	symptoms += S
	var/datum/symptom/cough/C = new
	C.neutered = TRUE
	symptoms += C
	..()
