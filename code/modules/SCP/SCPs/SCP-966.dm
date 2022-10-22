/mob/living/carbon/human/scp966
	desc = "A hideous clawed creature."
	SCP = /datum/scp/scp_966
	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 8
	mob_size = MOB_GIANT

/datum/scp/scp_966
	name = "SCP-966"
	designation = "966"
	classification = EUCLID

/mob/living/carbon/human/scp966/IsAdvancedToolUser()
	return FALSE

/mob/living/scp_966/proc/OpenDoor(obj/machinery/door/A)
	if(!istype(A) || incapacitated())
		return

	if(istype(A, /obj/machinery/door/blast/regular))
		to_chat(src, "<span class='warning'>You cannot open blast doors.</span>")
		return

	if(!A.Adjacent(src))
		to_chat(src, "<span class='warning'>\The [A] is too far away.</span>")
		return

	if(!A.density)
		return

	visible_message("\The [src] begins to pry open \the [A]!")
	if(!do_after(src, 5 SECONDS, A))
		return

	if(!A.density)
		return

	if(istype(A, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/AR = A
		AR.unlock(TRUE) // No more bolting in the SCPs and calling it a day
	A.stat |= BROKEN
	var/check = A.open(TRUE)
	visible_message("\The [src] slices \the [A]'s controls[check ? ", ripping it open!" : ", breaking it!"]")
