/datum/disease
	//Flags
	var/visibility_flags = 0
	var/disease_flags = CURABLE|CAN_CARRY|CAN_RESIST
	var/spread_flags = DISEASE_SPREAD_AIRBORNE | DISEASE_SPREAD_CONTACT_FLUIDS | DISEASE_SPREAD_CONTACT_SKIN

	//Fluff
	var/form = "Virus"
	var/name = "No disease"
	var/desc = ""
	var/agent = "some microbes"
	var/spread_text = ""
	var/cure_text = ""

	//Stages
	var/stage = 1
	var/max_stages = 0
	var/stage_prob = 4

	//Other
	/// Typepaths of viable mobs
	var/list/viable_mobtypes = list()
	var/mob/living/carbon/affected_mob = null
	/// List of cures if the disease has the CURABLE flag, these are reagent ids
	var/list/cures = list()
	var/infectivity = 65
	var/cure_chance = 8
	/// If our host is only a carrier
	var/carrier = FALSE
	/// Does it skip species virus immunity check? Some things may be diseases and not viruses
	var/bypasses_immunity = FALSE
	var/permeability_mod = 1
	var/severity = DISEASE_SEVERITY_NONTHREAT
	var/list/required_organs = list()
	var/needs_all_cures = TRUE
	var/list/strain_data = list() //dna_spread special bullshit
	var/process_dead = FALSE //if this ticks while the host is dead
	var/copy_type = null //if this is null, copies will use the type of the instance being copied

/datum/disease/Destroy()
	. = ..()
	if(affected_mob)
		RemoveDisease()
	SSdisease.active_diseases.Remove(src)

//add this disease if the host does not already have too many
/datum/disease/proc/TryInfect(mob/living/target, make_copy = TRUE)
	Infect(target, make_copy)
	return TRUE

//add the disease with no checks
/datum/disease/proc/Infect(mob/living/target, make_copy = TRUE)
	var/datum/disease/D = make_copy ? Copy() : src
	LAZYADD(target.diseases, D)
	D.affected_mob = target
	SSdisease.active_diseases += D //Add it to the active diseases list, now that it's actually in a mob and being processed.

	D.AfterAdd()

	BITSET(target.hud_updateflag, LIFE_HUD)
	BITSET(target.hud_updateflag, STATUS_HUD)

	//log_virus("[key_name(target)] was infected by virus: [src.AdminDetails()] at [loc_name(get_turf(target))]")

//Return a string for admin logging uses, should describe the disease in detail
/datum/disease/proc/AdminDetails()
	return "[src.name] : [src.type]"

///Proc to process the disease and decide on whether to advance, cure or make the sympthoms appear. Returns a boolean on whether to continue acting on the symptoms or not.
/datum/disease/proc/StageAct()
	if(HasCure())
		if(prob(cure_chance))
			UpdateStage(max(stage - 1, 1))

		if(stage <= 1 && disease_flags & CURABLE && prob(cure_chance))
			Cure()
			return FALSE

	// Penicillin may slow down the progression of the disease
	else if(AntiViralEffect())
		// Can decrease the stage slightly
		if(stage > 3 && prob(15))
			UpdateStage(stage - 1)

	else if(prob(stage_prob))
		UpdateStage(min(stage + 1, max_stages))

	return !carrier

/datum/disease/proc/UpdateStage(new_stage)
	stage = new_stage

/datum/disease/proc/HasCure()
	if(!(disease_flags & CURABLE))
		return FALSE

	. = cures.len
	for(var/C_id in cures)
		if(!(locate(C_id) in affected_mob.chem_doses))
			.--
	if(!. || (needs_all_cures && . < cures.len))
		return FALSE

/datum/disease/proc/AntiViralEffect()
	return prob(affected_mob.has_chem_effect(CE_ANTIVIRAL, round(50 / cure_chance)))

//Airborne spreading
/datum/disease/proc/Spread(force_spread = 0)
	if(!affected_mob)
		return

	if(!(spread_flags & DISEASE_SPREAD_AIRBORNE) && !force_spread)
		return

	if(affected_mob.reagents.has_reagent(/datum/reagent/medicine/penicillin))
		return

	var/spread_range = 2

	if(force_spread)
		spread_range = force_spread

	var/turf/T = affected_mob.loc
	if(istype(T))
		for(var/mob/living/carbon/C in view(spread_range, affected_mob))
			var/turf/V = get_turf(C)
			if(DiseaseAirSpreadWalk(T, V))
				C.AirborneContractDisease(src, force_spread)

/proc/DiseaseAirSpreadWalk(turf/start, turf/end)
	if(!start || !end)
		return FALSE

	for(var/turf/T in getline(start, end)) // Should probably be replaced with something else
		if(T.density)
			return FALSE
		// Shitty check for fulltile windows
		for(var/obj/structure/window/W in T)
			if(W.is_fulltile())
				return FALSE
	return TRUE

/datum/disease/proc/Cure(add_resistance = TRUE)
	if(affected_mob)
		if(add_resistance && (disease_flags & CAN_RESIST))
			affected_mob.disease_resistances |= GetDiseaseID()
	qdel(src)

/datum/disease/proc/IsSame(datum/disease/D)
	if(istype(D, type))
		return TRUE
	return FALSE

/datum/disease/proc/Copy()
	//note that stage is not copied over - the copy starts over at stage 1
	var/static/list/copy_vars = list("name", "visibility_flags", "disease_flags", "spread_flags", "form",
									"desc", "agent", "spread_text", "cure_text", "max_stages", "stage_prob",
									"viable_mobtypes", "cures", "infectivity", "cure_chance",
									"bypasses_immunity", "permeability_mod", "severity", "required_organs",
									"needs_all_cures", "strain_data","process_dead")

	var/datum/disease/D = copy_type ? new copy_type() : new type()
	for(var/V in copy_vars)
		var/val = vars[V]
		if(islist(val))
			var/list/L = val
			val = L.Copy()
		D.vars[V] = val
	return D

/datum/disease/proc/AfterAdd()
	return

/datum/disease/proc/GetDiseaseID()
	return "[type]"

/datum/disease/proc/RemoveDisease()
	LAZYREMOVE(affected_mob.diseases, src)	//remove the datum from the list
	BITSET(affected_mob.hud_updateflag, LIFE_HUD)
	BITSET(affected_mob.hud_updateflag, STATUS_HUD)
	affected_mob = null

/**
 * Checks the given typepath against the list of viable mobtypes.
 *
 * Returns TRUE if the mob_type path is derived from of any entry in the viable_mobtypes list.
 * Returns FALSE otherwise.
 *
 * Arguments:
 * * mob_type - Type path to check against the viable_mobtypes list.
 */
/datum/disease/proc/IsViableMobtype(mob_type)
	for(var/viable_type in viable_mobtypes)
		if(ispath(mob_type, viable_type))
			return TRUE
	return FALSE

//Use this to compare severities
/proc/GetDiseaseSeverityValue(severity)
	switch(severity)
		if(DISEASE_SEVERITY_POSITIVE)
			return 1
		if(DISEASE_SEVERITY_NONTHREAT)
			return 2
		if(DISEASE_SEVERITY_MINOR)
			return 3
		if(DISEASE_SEVERITY_MEDIUM)
			return 4
		if(DISEASE_SEVERITY_HARMFUL)
			return 5
		if(DISEASE_SEVERITY_DANGEROUS)
			return 6
		if(DISEASE_SEVERITY_BIOHAZARD)
			return 7
