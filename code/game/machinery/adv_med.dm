// Pretty much everything here is stolen from the dna scanner FYI


/obj/machinery/bodyscanner
	var/mob/living/carbon/human/occupant
	var/locked
	name = "Body Scanner"
	icon = 'icons/obj/Cryogenic2.dmi'
	icon_state = "body_scanner_0"
	density = TRUE
	anchored = TRUE

	use_power = 1
	idle_power_usage = 60
	active_power_usage = 10000	//10 kW. It's a big all-body scanner.

/obj/machinery/bodyscanner/relaymove(mob/user as mob)
	if (user.stat)
		return
	src.go_out()
	return

/obj/machinery/bodyscanner/verb/eject()
	set src in oview(1)
	set category = "Object"
	set name = "Eject Body Scanner"

	if (usr.stat != 0)
		return
	src.go_out()
	add_fingerprint(usr)
	return

/obj/machinery/bodyscanner/verb/move_inside()
	set src in oview(1)
	set category = "Object"
	set name = "Enter Body Scanner"

	if (usr.stat != 0)
		return
	if (src.occupant)
		to_chat(usr, SPAN_WARNING("The scanner is already occupied!"))
		return
	if (usr.abiotic())
		to_chat(usr, SPAN_WARNING("The subject cannot have abiotic items on."))
		return
	usr.pulling = null
	usr.client.perspective = EYE_PERSPECTIVE
	usr.client.eye = src
	usr.forceMove(src)
	src.occupant = usr
	update_use_power(2)
	src.icon_state = "body_scanner_1"
	for(var/obj/O in src)
		//O = null
		qdel(O)
		//Foreach goto(124)
	src.add_fingerprint(usr)
	return

/obj/machinery/bodyscanner/proc/go_out()
	if ((!( src.occupant ) || src.locked))
		return
	for(var/obj/O in src)
		O.dropInto(loc)
		//Foreach goto(30)
	if (src.occupant.client)
		src.occupant.client.eye = src.occupant.client.mob
		src.occupant.client.perspective = MOB_PERSPECTIVE
	src.occupant.dropInto(loc)
	src.occupant = null
	update_use_power(1)
	src.icon_state = "body_scanner_0"
	return

/obj/machinery/bodyscanner/attackby(obj/item/grab/normal/G, user as mob)
	if(!istype(G))
		return ..()
	if (!ismob(G.affecting))
		return
	if (src.occupant)
		to_chat(user, SPAN_WARNING("The scanner is already occupied!"))
		return
	if (G.affecting.abiotic())
		to_chat(user, SPAN_WARNING("Subject cannot have abiotic items on."))
		return
	var/mob/M = G.affecting
	M.forceMove(src)
	src.occupant = M
	update_use_power(2)
	src.icon_state = "body_scanner_1"
	for(var/obj/O in src)
		O.forceMove(loc)
	src.add_fingerprint(user)
	qdel(G)

//Like grap-put, but for mouse-drop.
/obj/machinery/bodyscanner/MouseDrop_T(mob/target, mob/user)
	if(!istype(target))
		return
	if (!CanMouseDrop(target, user))
		return
	if (src.occupant)
		to_chat(user, SPAN_WARNING("The scanner is already occupied!"))
		return
	if (target.abiotic())
		to_chat(user, SPAN_WARNING("The subject cannot have abiotic items on."))
		return
	if (target.buckled)
		to_chat(user, SPAN_WARNING("Unbuckle the subject before attempting to move them."))
		return
	user.visible_message(SPAN_NOTICE("\The [user] begins placing \the [target] into \the [src]."), SPAN_NOTICE("You start placing \the [target] into \the [src]."))
	if(!do_after(user, 30, src))
		return
	var/mob/M = target
	M.forceMove(src)
	src.occupant = M
	update_use_power(2)
	src.icon_state = "body_scanner_1"
	for(var/obj/O in src)
		O.forceMove(loc)
	src.add_fingerprint(user)

/obj/machinery/bodyscanner/ex_act(severity)
	switch(severity)
		if(1.0)
			for(var/atom/movable/A as mob|obj in src)
				A.dropInto(loc)
				ex_act(severity)
				//Foreach goto(35)
			//SN src = null
			qdel(src)
			return
		if(2.0)
			if (prob(50))
				for(var/atom/movable/A as mob|obj in src)
					A.dropInto(loc)
					ex_act(severity)
					//Foreach goto(108)
				//SN src = null
				qdel(src)
				return
		if(3.0)
			if (prob(25))
				for(var/atom/movable/A as mob|obj in src)
					A.dropInto(loc)
					ex_act(severity)
					//Foreach goto(181)
				//SN src = null
				qdel(src)
				return
		else
	return

/obj/machinery/body_scanconsole/ex_act(severity)

	switch(severity)
		if(1.0)
			//SN src = null
			qdel(src)
			return
		if(2.0)
			if (prob(50))
				//SN src = null
				qdel(src)
				return
		else
	return

/obj/machinery/body_scanconsole/update_icon()
	if(stat & BROKEN)
		icon_state = "body_scannerconsole-p"
	else if (stat & NOPOWER)
		spawn(rand(0, 15))
			src.icon_state = "body_scannerconsole-p"
	else
		icon_state = initial(icon_state)

/obj/machinery/body_scanconsole
	var/obj/machinery/bodyscanner/connected
	var/delete
	var/temphtml
	name = "Body Scanner Console"
	icon = 'icons/obj/Cryogenic2.dmi'
	icon_state = "body_scannerconsole"
	density = FALSE
	anchored = TRUE


/obj/machinery/body_scanconsole/Initialize()
	for(var/D in GLOB.cardinal)
		src.connected = locate(/obj/machinery/bodyscanner, get_step(src, D))
		if(src.connected)
			break
	return ..()

/*

/obj/machinery/body_scanconsole/process() //not really used right now
	if(stat & (NOPOWER|BROKEN))
		return
	//use_power(250) // power stuff

//	var/mob/M //occupant
//	if (!( src.status )) //remove this
//		return
//	if ((src.connected && src.connected.occupant)) //connected & occupant ok
//		M = src.connected.occupant
//	else
//		if (istype(M, /mob))
//		//do stuff
//		else
///			src.temphtml = "Process terminated due to lack of occupant in scanning chamber."
//			src.status = null
//	src.updateDialog()
//	return

*/

/obj/machinery/body_scanconsole/attack_ai(user as mob)
	return src.attack_hand(user)

/obj/machinery/body_scanconsole/attack_hand(user as mob)
	if(..())
		return
	if(stat & (NOPOWER|BROKEN))
		return
	if(!connected || (connected.stat & (NOPOWER|BROKEN)))
		to_chat(user, SPAN_WARNING("This console is not connected to a functioning body scanner."))
		return
	if(!ishuman(connected.occupant))
		to_chat(user, SPAN_WARNING("This device can only scan compatible lifeforms."))
		return

	var/dat
	if (src.delete && src.temphtml) //Window in buffer but its just simple message, so nothing
		src.delete = src.delete
	else if (!src.delete && src.temphtml) //Window in buffer - its a menu, dont add clear message
		dat = text("[]<BR><BR><A href='?src=\ref[];clear=1'>Main Menu</A>", src.temphtml, src)
	else
		if (src.connected) //Is something connected?
			dat = connected.occupant.get_medical_data()
			dat += "<br><HR><A href='?src=\ref[src];print=1'>Print</A><BR>"
		else
			dat = SPAN_WARNING("Error: No Body Scanner connected.")

	dat += text("<BR><A href='?src=\ref[];mach_close=scanconsole'>Close</A>", user)
	user << browse(dat, "window=scanconsole;size=430x600")
	return


/obj/machinery/body_scanconsole/OnTopic(user, href_list)
	if (href_list["print"])
		if (!src.connected)
			to_chat(user, "\icon[src]<span class='warning'>Error: No body scanner connected.</span>")
			return TOPIC_REFRESH
		var/mob/living/carbon/human/occupant = src.connected.occupant
		if (!src.connected.occupant)
			to_chat(user, "\icon[src]<span class='warning'>The body scanner is empty.</span>")
			return TOPIC_REFRESH
		if (!istype(occupant,/mob/living/carbon/human))
			to_chat(user, "\icon[src]<span class='warning'>The body scanner cannot scan that lifeform.</span>")
			return TOPIC_REFRESH
		new/obj/item/weapon/paper/(loc, "<tt>[connected.occupant.get_medical_data()]</tt>", "Body scan report - [occupant]")
		return TOPIC_REFRESH

/proc/get_severity(amount)
	if(!amount)
		return "none"
	. = "minor"
	if(amount > 50)
		. = "severe"
	else if(amount > 25)
		. = "significant"
	else if(amount > 10)
		. = "moderate"

/mob/living/carbon/human/proc/get_medical_data()
	var/mob/living/carbon/human/H = src
	var/dat = "<meta charset=\"utf-8\">"
	dat +="<b>SCAN RESULTS FOR: [H]</b>"
	dat +="Scan performed at [station_time_timestamp("hh:mm")]<br>"

	var/brain_result = "normal"
	if(H.should_have_organ(BP_BRAIN))
		var/obj/item/organ/internal/brain/brain = H.internal_organs_by_name[BP_BRAIN]
		if(!brain || H.stat == DEAD || (H.status_flags & FAKEDEATH))
			brain_result = SPAN_DANGER("none, patient is braindead")
		else if(H.stat != DEAD)
			brain_result = "[round(max(0,(1 - brain.damage/brain.max_damage)*100))]%"
	else
		brain_result = SPAN_DANGER("ERROR - Nonstandard biology")
	dat += "<b>Brain activity:</b> [brain_result]"

	var/pulse_result = "normal"
	if(H.should_have_organ(BP_HEART))
		if(H.status_flags & FAKEDEATH)
			pulse_result = 0
		else
			pulse_result = H.get_pulse(GETPULSE_TOOL)
	else
		pulse_result = "ERROR - Nonstandard biology"
	dat += "<b>Pulse rate:</b> [pulse_result]bpm."

	// Blood pressure. Based on the idea of a normal blood pressure being 120 over 80.
	if(H.get_blood_volume() <= 70)
		dat += SPAN_DANGER("Severe blood loss detected.")
	dat += "<b>Blood pressure:</b> [H.get_blood_pressure()] ([H.get_blood_oxygenation()]% blood oxygenation)"
	dat += "<b>Blood volume:</b> [H.vessel.get_reagent_amount(/datum/reagent/blood)]/[H.species.blood_volume]u"

	// Body temperature.
	dat += "<b>Body temperature:</b> [H.bodytemperature-T0C]&deg;C ([H.bodytemperature*1.8-459.67]&deg;F)"

	dat += "<b>Physical Trauma:</b>\t[get_severity(H.getBruteLoss())]"
	dat += "<b>Burn Severity:</b>\t[get_severity(H.getFireLoss())]"
	dat += "<b>Systematic Organ Failure:</b>\t[get_severity(H.getToxLoss())]"
	dat += "<b>Oxygen Deprivation:</b>\t[get_severity(H.getOxyLoss())]"

	dat += "<b>Radiation Level:</b>\t[get_severity(H.radiation/5)]"
	dat += "<b>Genetic Tissue Damage:</b>\t[get_severity(H.getCloneLoss())]"
	if(H.paralysis)
		dat += "Paralysis Summary: approx. [H.paralysis/4] seconds left"

	dat += "Antibody levels and immune system perfomance are at [round(H.virus_immunity()*100)]% of baseline."
	if (H.virus2.len)
		dat += FONT_COLORED("red","Viral pathogen detected in blood stream.")

	if(H.has_brain_worms())
		dat += "Large growth detected in frontal lobe, possibly cancerous. Surgical removal is recommended."

	if(H.reagents.total_volume)
		var/reagentdata[0]
		for(var/A in H.reagents.reagent_list)
			var/datum/reagent/R = A
			if(R.scannable)
				reagentdata[R.type] = "[round(H.reagents.get_reagent_amount(R.type), 1)]u [R.name]"
		if(reagentdata.len)
			dat += "Beneficial reagents detected in subject's blood:"
			for(var/d in reagentdata)
				dat += reagentdata[d]

	var/list/table = list()
	table += "<table border='1'><tr><th>Organ</th><th>Damage</th><th>Status</th></tr>"
	for(var/obj/item/organ/external/E in H.organs)
		table += "<tr><td>[E.name]</td>"
		if(E.is_stump())
			table += "<td>N/A</td><td>Missing</td>"
		else
			table += "<td>"
			if(E.brute_dam)
				table += "[capitalize(get_wound_severity(E.brute_ratio, E.vital))] physical trauma"
			if(E.burn_dam)
				table += " [capitalize(get_wound_severity(E.burn_ratio, E.vital))] burns"
			if(E.brute_dam + E.burn_dam == 0)
				table += "None"
			table += "</td><td>[english_list(E.get_scan_results(), nothing_text = "", and_text = ", ")]</td></tr>"

	table += "<tr><td>---</td><td><b>INTERNAL ORGANS</b></td><td>---</td></tr>"
	for(var/obj/item/organ/internal/I in H.internal_organs)
		table += "<tr><td>[I.name]</td>"
		table += "<td>"
		if(I.is_broken())
			table += "Severe"
		else if(I.is_bruised())
			table += "Moderate"
		else if(I.is_damaged())
			table += "Minor"
		else
			table += "None"
		table += "</td><td>[english_list(I.get_scan_results(), nothing_text = "", and_text = ", ")]</td></tr>"
	table += "</table>"
	dat += jointext(table,null)
	table.Cut()
	for(var/organ_name in H.species.has_organ)
		if(!locate(H.species.has_organ[organ_name]) in H.internal_organs)
			dat += text("No [organ_name] detected.")

	if(H.sdisabilities & BLIND)
		dat += text("Cataracts detected.")
	if(H.sdisabilities & NEARSIGHTED)
		dat += text("Retinal misalignment detected.")

	. = jointext(dat,"<br>")
