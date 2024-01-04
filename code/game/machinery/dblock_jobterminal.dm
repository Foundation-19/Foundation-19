/obj/machinery/job_terminal
	name = "auto-assignment machine"
	desc = "Tired of the line? Use this handy machine!"
	icon = 'icons/obj/computer.dmi'
	icon_state = "JobTerminal"
	req_access = list(ACCESS_SECURITY_LVL2)
	anchored = TRUE
	density = TRUE
	var/locked = TRUE // guards must activate it first
	var/paper_storage = 20 // can print 20 cards before running dry
	var/max_paper = 20

/obj/machinery/job_terminal/empty
	paper_storage = 0

/obj/machinery/job_terminal/unlocked
	locked = FALSE

/obj/machinery/job_terminal/proc/speak(message)
	if(stat & NOPOWER)
		return

	if (!message)
		return

	for(var/mob/O in hearers(src, null))
		O.show_message(SPAN_CLASS("game say","<span class='name'>\The [src]</span> beeps, \"[message]\""),2)
	return

/obj/machinery/job_terminal/attack_hand(mob/user)
	. = ..()
	if(locked)
		src.speak("This unit has been locked or not set-up properly, please contact your system administrator if you believe this to be an error!")
		return
	var/choice = tgui_input_list(user, "Choose Assignment:", "Welcome, [user.real_name]!", list("MINING", "BOTANY", "KITCHEN", "JANITORIAL", "MEDICAL", "--CANCEL--"))
	if(!choice || choice == "--CANCEL--")
		return
	if(paper_storage >= 1)
		paper_storage--
		flick("JobTerminal_w", src)
		sleep(1.55 SECONDS) // lenght of the animation
		switch(choice)
			if("MINING")
				new/obj/item/card/id/dassignment/dmining(get_turf(src))
			if("BOTANY")
				new/obj/item/card/id/dassignment/dbotany(get_turf(src))
			if("KITCHEN")
				new/obj/item/card/id/dassignment/dkitchen(get_turf(src))
			if("JANITORIAL")
				new/obj/item/card/id/dassignment/djanitorial(get_turf(src))
			if("MEDICAL")
				new/obj/item/card/id/dassignment/dmedical(get_turf(src))
		src.speak("Printing action complete!")
		playsound(loc, 'sounds/machines/ding.ogg', 50, 1)
	else
		src.speak("Insufficient paper in storage! Please refill!")

/obj/machinery/job_terminal/attackby(obj/item/I, mob/user)
	if (istype(I, /obj/item/card/id)||istype(I, /obj/item/modular_computer)||istype(I, /obj/item/card/robot))
		if(allowed(usr))
			locked = !locked
			to_chat(user, SPAN_NOTICE("You [ locked ? "lock" : "unlock"] [src]'s interface."))
		else
			to_chat(user, SPAN_WARNING("Access denied."))
	else if (istype(I, /obj/item/paper))
		if(paper_storage <= max_paper)
			paper_storage++
			qdel(I)
