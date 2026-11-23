/obj/structure/closet/coffin/scp895
	name = "oak coffin"
	desc = "an ornate oak coffin"
	var/exposure_time = 0
	var/static_radius = 5

/obj/structure/closet/coffin/scp895/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src,
		"oak coffin",
		SCP_EUCLID,
		"895",
		SCP_MEMETIC
	)
	SCP.memeticFlags = MCAMERA
	SCP.memetic_proc = TYPE_PROC_REF(/obj/structure/closet/coffin/scp895, effect)
	SCP.compInit()
	START_PROCESSING(SSobj, src)

/obj/structure/closet/coffin/scp895/Process()
	if(opened)
		exposure_time += 1
	else
		exposure_time = max(0, exposure_time - 1)

/obj/structure/closet/coffin/scp895/proc/effect(mob/living/carbon/human/target)
	if(!target)
		return
	switch(exposure_time)
		if(0 to 50)
			target.do_unique_hallucination(list(/datum/hallucination/mirage/carnage))
		if(51 to 150)
			target.do_unique_hallucination(list(/datum/hallucination/mirage/carnage))
			target.adjustBrainLoss(1)
			if(prob(20))
				to_chat(target, SPAN_WARNING("You feel a sense of dread washing over you..."))
		if(151 to 300)
			target.do_unique_hallucination(list(/datum/hallucination/mirage/carnage))
			target.adjustBrainLoss(3)
			if(prob(30))
				target.adjust_drowsiness(5 SECONDS)
			if(prob(15))
				to_chat(target, SPAN_DANGER("Your heart races as the images become more vivid!"))
		if(301 to INFINITY)
			target.do_unique_hallucination(list(/datum/hallucination/mirage/carnage))
			target.adjustBrainLoss(5)
			if(prob(40))
				var/obj/item/organ/internal/heart/H = target.internal_organs_by_name[BP_HEART]
				if(H)
					H.take_internal_damage(5)
				to_chat(target, SPAN_USERDANGER("The images burn into your mind! Your chest hurts!"))
