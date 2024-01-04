/datum/disease/cold
	name = "The Cold"
	desc = "If left untreated the subject's body temperature will continuously fall."
	max_stages = 3
	spread_text = "On contact"
	spread_flags = DISEASE_SPREAD_BLOOD | DISEASE_SPREAD_CONTACT_SKIN | DISEASE_SPREAD_CONTACT_FLUIDS
	cure_text = "Penicillin"
	cures = list(/datum/reagent/medicine/penicillin)
	agent = "ICE9-rhinovirus"
	viable_mobtypes = list(/mob/living/carbon/human)
	severity = DISEASE_SEVERITY_MINOR

/datum/disease/cold/StageAct()
	. = ..()
	if(!.)
		return

	switch(stage)
		if(2)
			if(affected_mob.bodytemperature > 290)
				affected_mob.bodytemperature -= 2
			if(prob(0.1))
				to_chat(affected_mob, "<span class='notice'>You feel better.</span>")
				Cure()
				return FALSE
			if(prob(1))
				affected_mob.emote("sneeze")
			if(prob(1))
				affected_mob.emote("cough")
			if(prob(1))
				to_chat(affected_mob, "<span class='danger'>Your throat feels sore.</span>")
			if(prob(3))
				to_chat(affected_mob, "<span class='danger'>You feel cold.</span>")
		if(3)
			if(affected_mob.bodytemperature > 280)
				affected_mob.bodytemperature -= 4
			if(prob(1))
				affected_mob.emote("sneeze")
			if(prob(1))
				affected_mob.emote("cough")
			if(prob(1))
				to_chat(affected_mob, "<span class='danger'>Your throat feels sore.</span>")
			if(prob(6))
				to_chat(affected_mob, "<span class='danger'>You feel stiff.</span>")
