/obj/structure/closet/coffin/scp895
	name = "oak coffin"
	desc = "an ornate oak coffin"

/obj/structure/closet/coffin/scp895/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"oak coffin", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_EUCLID, //Obj Class
		"895", //Numerical Designation
		SCP_MEMETIC
	)
	SCP.memeticFlags = MCAMERA
	SCP.memetic_proc = TYPE_PROC_REF(/obj/structure/closet/coffin/scp895, effect)
	SCP.compInit()

/obj/structure/closet/coffin/scp895/proc/effect(mob/living/carbon/human/target)
	target.do_unique_hallucination(list(/datum/hallucination/mirage/carnage))
