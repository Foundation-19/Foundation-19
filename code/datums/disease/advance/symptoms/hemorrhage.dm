/*
//////////////////////////////////////

Hemorrhage

	Quite noticeable.
	Reduces resistance.
	Increases stage speed.
	Increases transmittablity.
	Medium Level.

BONUS
	Causes internal bleeding.

//////////////////////////////////////
*/

/datum/symptom/hemorrhage
	name = "Hemorrhage"
	desc = "The virus damages blood vessels, causing external or, in severe cases, internal bleeding."
	stealth = -2
	resistance = -3
	stage_speed = 2
	transmittable = 2
	level = 4
	severity = 3
	symptom_delay_min = 4
	symptom_delay_max = 10
	base_message_chance = 10
	threshold_descs = list(
		"Stealth 5" = "Symptom remains hidden until active.",
		"Resistance 10" = "Additionally causes internal bleeding.",
	)
	var/internal_bleed = FALSE

/datum/symptom/hemorrhage/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.properties["stealth"] >= 5)
		base_message_chance = 0
	// Internal bleeding
	if(A.properties["resistance"] >= 10)
		internal_bleed = TRUE

/datum/symptom/hemorrhage/Activate(datum/disease/advance/A)
	if(!..())
		return
	if(A.stage < 4)
		if(prob(base_message_chance))
			to_chat(A.affected_mob, SPAN_WARNING("Your skin feels incredibly frail..."))
		return
	if(prob(base_message_chance))
		to_chat(A.affected_mob, SPAN_WARNING("The blood drips from every cut on your body..."))
	var/mob/living/carbon/human/H = A.affected_mob
	H.drip(rand(1, 3))
	if(!prob(10 * A.stage))
		return

	// Internal bleeding!
	if(internal_bleed)
		var/obj/item/organ/external/E = pick(H.organs)
		if(istype(E) && !(E.status & ORGAN_ARTERY_CUT) && prob(10))
			E.sever_artery()
			to_chat(H, SPAN_WARNING("You feel a sudden burst in your [E.name]!"))

	// List of wounds in the body
	var/list/valid_wounds = list()
	for(var/obj/item/organ/external/E in H.organs)
		for(var/datum/wound/W in E.wounds)
			if(W.bleed_timer >= 50)
				continue
			valid_wounds += W

	// Just make one
	if(!LAZYLEN(valid_wounds))
		var/obj/item/organ/external/E = pick(H.organs)
		var/wound_type = get_wound_type(CUT, 5)
		if(!wound_type)
			return

		var/datum/wound/W = new wound_type(5, E)
		W.bleed_timer += 10
		//Check whether we can add the wound to an existing wound
		for(var/datum/wound/other in E.wounds)
			if(other.can_merge(W))
				other.merge_wound(W)
				return
		LAZYADD(E.wounds, W)
		E.update_damages()
		return

	// Extend the bleeding of existing wounds
	for(var/datum/wound/W in valid_wounds)
		W.bleed_timer += rand(5, 10)
		W.parent_organ.update_damages()
