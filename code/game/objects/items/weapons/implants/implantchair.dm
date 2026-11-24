/obj/machinery/implantchair
	name = "loyalty implanter"
	desc = "Used to implant occupants with loyalty implants."
	icon = 'icons/obj/machines/implantchair.dmi'
	icon_state = "implantchair"
	density = TRUE
	opacity = 0
	anchored = TRUE

	var/ready = 1
	var/malfunction = 0
	var/list/obj/item/implant/loyalty/implant_list = list()
	var/max_implants = 5
	var/injection_cooldown = 600
	var/replenish_cooldown = 6000
	var/replenishing = 0
	var/mob/living/carbon/occupant = null
	var/injecting = 0

/obj/machinery/implantchair/New()
	..()
	add_implants()


/obj/machinery/implantchair/attack_hand(mob/user as mob)
	tgui_interact(user)

/obj/machinery/implantchair/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "ImplantChair", "Implanter")
		ui.open()

/obj/machinery/implantchair/tgui_data(mob/user)
	var/list/data = list()
	data["has_occupant"] = occupant ? TRUE : FALSE
	if(occupant)
		data["occupant_name"] = occupant.name
		data["occupant_health"] = round(occupant.health, 0.1)
		data["occupant_dead"] = occupant.health <= -100
	data["implant_count"] = implant_list.len
	data["ready"] = ready
	return data

/obj/machinery/implantchair/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	if((get_dist(src, usr) > 1) && !istype(usr, /mob/living/silicon/ai))
		return TRUE
	switch(action)
		if("implant")
			if(occupant)
				injecting = 1
				go_out()
				ready = 0
				spawn(injection_cooldown)
					ready = 1
			add_fingerprint(usr)
			return TRUE
		if("replenish")
			ready = 0
			spawn(replenish_cooldown)
				add_implants()
				ready = 1
			add_fingerprint(usr)
			return TRUE
	return FALSE


/obj/machinery/implantchair/attackby(obj/item/G as obj, mob/user as mob)
	if(istype(G, /obj/item/grab))
		var/obj/item/grab/grab = G
		if(!ismob(grab.affecting))
			return
		for(var/mob/living/carbon/slime/M in range(1, grab.affecting))
			if(M.Victim == grab.affecting)
				to_chat(usr, "[grab.affecting.name] will not fit into the [src.name] because they have a slime latched onto their head.")
				return
		var/mob/M = grab.affecting
		if(put_mob(M))
			qdel(G)
	SStgui.update_uis(src)
	return


/obj/machinery/implantchair/proc/go_out(mob/M)
	if(!( src.occupant ))
		return
	if(M == occupant) // so that the guy inside can't eject himself -Agouri
		return
	if (src.occupant.client)
		src.occupant.client.eye = src.occupant.client.mob
		src.occupant.client.perspective = MOB_PERSPECTIVE
	occupant.dropInto(loc)
	if(injecting)
		implant(src.occupant)
		injecting = 0
	src.occupant = null
	icon_state = "implantchair"
	return


/obj/machinery/implantchair/proc/put_mob(mob/living/carbon/M as mob)
	if(!iscarbon(M))
		to_chat(usr, SPAN_WARNING("\The [src] cannot hold this!"))
		return
	if(src.occupant)
		to_chat(usr, SPAN_WARNING("\The [src] is already occupied!"))
		return
	if(M.client)
		M.client.perspective = EYE_PERSPECTIVE
		M.client.eye = src
	M.stop_pulling()
	M.forceMove(src)
	src.occupant = M
	src.add_fingerprint(usr)
	icon_state = "implantchair_on"
	return 1


/obj/machinery/implantchair/proc/implant(mob/M)
	if (!istype(M, /mob/living/carbon))
		return
	if(!implant_list.len)	return
	for(var/obj/item/implant/loyalty/imp in implant_list)
		if(!imp)	continue
		if(istype(imp, /obj/item/implant/loyalty))
			for (var/mob/O in viewers(M, null))
				O.show_message(SPAN_WARNING("\The [M] has been implanted by \the [src]."), 1)

			if(imp.implanted(M))
				imp.forceMove(M)
				imp.imp_in = M
				imp.implanted = 1
			implant_list -= imp
			break
	return


/obj/machinery/implantchair/proc/add_implants()
	for(var/i=0, i<src.max_implants, i++)
		var/obj/item/implant/loyalty/I = new /obj/item/implant/loyalty(src)
		implant_list += I
	return

/obj/machinery/implantchair/verb/get_out()
	set name = "Eject occupant"
	set category = "Object"
	set src in oview(1)
	if(usr.stat != 0)
		return
	src.go_out(usr)
	add_fingerprint(usr)
	return


/obj/machinery/implantchair/verb/move_inside()
	set name = "Move Inside"
	set category = "Object"
	set src in oview(1)
	if(usr.stat != 0 || stat & (NOPOWER|BROKEN))
		return
	put_mob(usr)
	return
