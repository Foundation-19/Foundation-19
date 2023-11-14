/mob/living/carbon/human/scp966
	desc = "A hideous clawed creature."
	SCP = /datum/scp/scp_966
	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 8

	roundstart_traits = list()


/datum/scp/scp_966
	name = "SCP-966"
	designation = "966"
	classification = EUCLID

/mob/living/scp_966/proc/OpenDoor(obj/machinery/door/A)
	if(!istype(A) || incapacitated())
		return

	if(istype(A, /obj/machinery/door/blast/regular))
		to_chat(src, SPAN_WARNING("You cannot open blast doors."))
		return

	if(!A.Adjacent(src))
		to_chat(src, SPAN_WARNING("\The [A] is too far away."))
		return

	if(!A.density)
		return

	visible_message("\The [src] begins to pry open \the [A]!")
	if(!do_after(src, 8 SECONDS, A, bonus_percentage = 25))
		return

	if(!A.density)
		return

	if(istype(A, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/AR = A
		AR.unlock(TRUE) // No more bolting in the SCPs and calling it a day
	A.set_broken(TRUE)
	var/check = A.open(TRUE)
	visible_message("\The [src] slices \the [A]'s controls[check ? ", ripping it open!" : ", breaking it!"]")
