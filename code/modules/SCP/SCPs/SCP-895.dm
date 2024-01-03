/obj/structure/closet/coffin/scp895
	name = "oak coffin"
	desc = "an ornate oak coffin"

/obj/structure/closet/coffin/scp895/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"oak coffin", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		EUCLID, //Obj Class
		"895", //Numerical Designation
		MEMETIC
	)
	SCP.memeticFlags = MCAMERA
	SCP.memetic_proc = /obj/structure/closet/coffin/scp895/proc/effect
	SCP.compInit()

/obj/structure/closet/coffin/scp895/proc/effect(mob/living/carbon/human/target)
	target.do_unique_hallucination(list(/datum/hallucination/mirage/carnage))
