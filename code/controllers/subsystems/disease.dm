SUBSYSTEM_DEF(disease)
	name = "Disease"
	flags = SS_NO_FIRE

	/// List of all possible disease types.
	var/list/diseases
	/// Associative list of all normal diseases. Excludes advanced types.
	var/list/archive_diseases = list()
	// This is more or less for test; A list similar to above, but for advance presets
	var/list/advance_diseases = list()
	///List of Active disease in all mobs; purely for quick referencing.
	var/list/active_diseases = list()

	var/static/list/list_symptoms = subtypesof(/datum/symptom)

/datum/controller/subsystem/disease/PreInit()
	if(!diseases)
		diseases = subtypesof(/datum/disease)

/datum/controller/subsystem/disease/Initialize(timeofday)
	var/list/all_common_diseases = diseases - typesof(/datum/disease/advance)
	for(var/common_disease_type in all_common_diseases)
		var/datum/disease/prototype = new common_disease_type()
		archive_diseases[prototype.GetDiseaseID()] = prototype
	for(var/advance_disease_type in subtypesof(/datum/disease/advance))
		var/datum/disease/advance/prototype = new advance_disease_type()
		advance_diseases[prototype.GetDiseaseID()] = prototype
	return ..()

/datum/controller/subsystem/disease/stat_entry(msg)
	..("P:[length(active_diseases)]")

/datum/controller/subsystem/disease/proc/get_disease_name(id)
	var/datum/disease/advance/A = archive_diseases[id]
	if(A.name)
		return A.name
	else
		return "Unknown"
