/*
//////////////////////////////////////

Pain Inhibitor

	Slightly hidden.
	Decreases resistance.
	Reduces stage speed.
	Increases transmittability.
	High Level.

Bonus
	Increases amount of pain done
	Stuns the host

//////////////////////////////////////
*/

/datum/symptom/painkiller
	name = "Pain Inhibitor"
	desc = "The virus produces painkilling chemicals using body natural reserves, thus making it more resistant to pain."
	stealth = 1
	resistance = -1
	stage_speed = -1
	transmittable = 1
	level = 4
	threshold_descs = list(
		"Stage Speed 6" = "Increases painkilling properties.",
		"Stage Speed 12" = "Further increases painkilling properties."
	)
	/// Amount of chems applied to the host on each activation.
	var/painkiller_count = 2
	/// Maximum volume of chem, which we will not exceed.
	var/painkiller_limit = 10
	/// Type of chemical we inject each activation.
	var/datum/reagent/painkiller_type = /datum/reagent/medicine/painkiller/tramadol/disease

/datum/symptom/painkiller/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.properties["stage_rate"] >= 6)
		painkiller_type = /datum/reagent/medicine/painkiller/tramadol/disease/two
	if(A.properties["stage_rate"] >= 12)
		painkiller_type = /datum/reagent/medicine/painkiller/tramadol/disease/three

/datum/symptom/painkiller/Activate(datum/disease/advance/A)
	if(!..())
		return
	var/mob/living/carbon/C = A.affected_mob
	// Over the limit
	if(C.reagents.has_reagent(painkiller_type, painkiller_limit))
		return
	C.reagents.add_reagent(painkiller_type, 5)
