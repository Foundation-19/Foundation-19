/*
//////////////////////////////////////

Itching

	Not noticable or unnoticable.
	Resistant.
	Increases stage speed.
	Little transmissibility.
	Low Level.

BONUS
	Displays an annoying message!
	Should be used for buffing your disease.

//////////////////////////////////////
*/

/datum/symptom/itching
	name = "Itching"
	desc = "The virus irritates the skin, causing itching."
	stealth = 0
	resistance = 3
	stage_speed = 3
	transmittable = 1
	level = 1
	severity = 1
	symptom_delay_min = 5
	symptom_delay_max = 25
	var/scratch = FALSE
	threshold_descs = list(
		"Transmission 6" = "Increases frequency of itching.",
		"Stage Speed 7" = "The host will scrath itself when itching, causing superficial damage.",
	)

/datum/symptom/itching/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.properties["transmittable"] >= 6) //itch more often
		symptom_delay_min = 1
		symptom_delay_max = 4
	if(A.properties["stage_rate"] >= 7) //scratch
		scratch = TRUE

/datum/symptom/itching/Activate(datum/disease/advance/A)
	if(!..())
		return
	var/mob/living/carbon/human/M = A.affected_mob
	var/picked_bodypart = pick(BP_HEAD, BP_CHEST, BP_L_ARM, BP_R_ARM, BP_L_LEG, BP_R_LEG)
	var/obj/item/organ/external/BP = M.get_organ(picked_bodypart)
	if(istype(BP) && !BP_IS_ROBOTIC(BP) && !BP_IS_CRYSTAL(BP) && !BP.is_stump())
		var/can_scratch = scratch && !M.incapacitated()
		to_chat(M, SPAN_WARNING("Your [BP.name] itches. [can_scratch ? " You scratch it." : ""]"))
		if(can_scratch)
			M.visible_message(SPAN_WARNING("[M] scratches [M.get_visible_gender() == MALE ? "his" : M.get_visible_gender() == FEMALE ? "her" : "their"] [BP.name]."))
			BP.take_external_damage(rand(1, 2))
