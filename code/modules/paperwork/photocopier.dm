/obj/machinery/photocopier
	name = "photocopier"
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "photocopier"
	var/insert_anim = "photocopier_animation"
	anchored = TRUE
	density = TRUE
	idle_power_usage = 30
	active_power_usage = 200
	power_channel = EQUIP
	atom_flags = ATOM_FLAG_NO_TEMP_CHANGE | ATOM_FLAG_CLIMBABLE
	obj_flags = OBJ_FLAG_ANCHORABLE
	var/obj/item/copyitem = null	//what's in the copier!
	var/copies = 1	//how many copies to print!
	var/toner = 30 //how much toner is left! woooooo~
	var/maxcopies = 10	//how many copies can be copied at once- idea shamelessly stolen from bs12's copier!

	// Blank Foundation form templates the copier can print directly.
	var/list/form_templates = list(
		"Blank Paper"						= /obj/item/paper,
		"Incident Report"					= /obj/item/paper/foundation/incident_report,
		"SCP Testing Request"				= /obj/item/paper/foundation/testing_request,
		"Test Authorization"				= /obj/item/paper/foundation/test_authorization,
		"Test Result Report"				= /obj/item/paper/foundation/test_result,
		"Cross-SCP Interaction Report"		= /obj/item/paper/foundation/cross_scp_interaction_report,
		"Amnesticization Record"			= /obj/item/paper/foundation/amnestic_record,
		"Containment Breach Report"			= /obj/item/paper/foundation/breach_report,
		"D-Class Transfer Order"			= /obj/item/paper/foundation/dclass_transfer,
		"SCP Document Template"				= /obj/item/paper/foundation/scp_document,
		"Budget Request"					= /obj/item/paper/foundation/budget_request,
		"Ethics Violation Report"			= /obj/item/paper/foundation/ethics_violation,
		"Ethics Test Oversight"				= /obj/item/paper/foundation/ethics_test_oversight,
		"Psychological Evaluation"			= /obj/item/paper/foundation/psych_evaluation,
		"Anomalous Investigation Report"	= /obj/item/paper/foundation/investigation_report,
		"Intelligence Report"				= /obj/item/paper/foundation/intel_report,
		"GOI Communique"					= /obj/item/paper/foundation/goi_communique,
		"Research Summary"					= /obj/item/paper/foundation/research_summary,
	)

/obj/machinery/photocopier/interface_interact(mob/user)
	tgui_interact(user)
	return TRUE

/obj/machinery/photocopier/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Photocopier", "Photocopier", 380, 320)
		ui.open()

/obj/machinery/photocopier/tgui_data(mob/user)
	var/list/data = list()
	data["has_item"] = copyitem ? TRUE : FALSE
	if(copyitem)
		data["item_name"] = copyitem.name
	data["copies"] = copies
	data["max_copies"] = maxcopies
	data["toner"] = toner
	data["can_copy"] = copyitem && toner > 0
	data["is_silicon"] = istype(user, /mob/living/silicon)
	var/list/templates = list()
	for(var/form_name in form_templates)
		templates += list(list("name" = form_name))
	data["templates"] = templates
	return data

/obj/machinery/photocopier/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	if(stat & (BROKEN|NOPOWER))
		return
	. = TRUE
	switch(action)
		if("copy")
			if(!copyitem || toner <= 0)
				return
			for(var/i = 0, i < copies, i++)
				if(toner <= 0)
					break
				if (istype(copyitem, /obj/item/paper))
					copy(copyitem, 1)
					sleep(15)
				else if (istype(copyitem, /obj/item/photo))
					photocopy(copyitem)
					sleep(15)
				else if (istype(copyitem, /obj/item/paper_bundle))
					var/obj/item/paper_bundle/B = bundlecopy(copyitem)
					sleep(15*B.pages.len)
				else
					to_chat(usr, SPAN_WARNING("\The [copyitem] can't be copied by \the [src]."))
					break
				use_power_oneoff(active_power_usage)
		if("remove")
			OnRemove(usr)
		if("min")
			if(copies > 1)
				copies--
		if("add")
			if(copies < maxcopies)
				copies++
		if("print_template")
			var/form_name = params["template"]
			var/form_type = form_templates[form_name]
			if(!form_type || toner <= 0)
				return
			var/obj/item/paper/P = new form_type(loc)
			if(istype(P) && !istype(P, /obj/item/paper/foundation))
				P.SetName("paper") // blank stock shouldn't be called "photocopier paper"
			toner--
			if(toner == 0)
				visible_message(SPAN_NOTICE("A red light on \the [src] flashes, indicating that it is out of toner."))
			use_power_oneoff(active_power_usage)
			sleep(15)
		if("aipic")
			if(!istype(usr, /mob/living/silicon))
				return FALSE
			if(toner >= 5)
				var/mob/living/silicon/tempAI = usr
				var/obj/item/device/camera/siliconcam/camera = tempAI.silicon_camera
				if(!camera)
					return
				var/obj/item/photo/selection = camera.selectpicture()
				if (!selection)
					return
				var/obj/item/photo/p = photocopy(selection)
				if (p.desc == "")
					p.desc += "Copied by [tempAI.name]"
				else
					p.desc += " - Copied by [tempAI.name]"
				toner -= 5
				sleep(15)
		else
			return FALSE

/obj/machinery/photocopier/proc/OnRemove(mob/user)
	if(copyitem)
		user.put_in_hands(copyitem)
		to_chat(user, SPAN_NOTICE("You take \the [copyitem] out of \the [src]."))
		copyitem = null

/obj/machinery/photocopier/attackby(obj/item/O as obj, mob/user as mob)
	if(istype(O, /obj/item/paper) || istype(O, /obj/item/photo) || istype(O, /obj/item/paper_bundle))
		if(!copyitem)
			if(!user.unEquip(O, src))
				return
			copyitem = O
			to_chat(user, SPAN_NOTICE("You insert \the [O] into \the [src]."))
			flick(insert_anim, src)
			SStgui.update_uis(src)
		else
			to_chat(user, SPAN_NOTICE("There is already something in \the [src]."))
	else if(istype(O, /obj/item/device/toner))
		if(toner <= 10) //allow replacing when low toner is affecting the print darkness
			if(!user.unEquip(O, src))
				return
			to_chat(user, SPAN_NOTICE("You insert the toner cartridge into \the [src]."))
			var/obj/item/device/toner/T = O
			toner += T.toner_amount
			qdel(O)
			SStgui.update_uis(src)
		else
			to_chat(user, SPAN_NOTICE("This cartridge is not yet ready for replacement! Use up the rest of the toner."))
	else ..()

/obj/machinery/photocopier/ex_act(severity)
	switch(severity)
		if(1.0)
			qdel(src)
		if(2.0)
			if(prob(50))
				qdel(src)
			else
				if(toner > 0)
					new /obj/effect/decal/cleanable/blood/oil(get_turf(src))
					toner = 0
		else
			if(prob(50))
				if(toner > 0)
					new /obj/effect/decal/cleanable/blood/oil(get_turf(src))
					toner = 0
	return

/obj/machinery/photocopier/proc/copy(obj/item/paper/copy, need_toner = TRUE, copy_admin = FALSE)
	var/copy_type = copy.type
	if (istype(copy, /obj/item/paper/admin) && !copy_admin) // Edge case for admin faxes so that they don't show the editing form
		copy_type = /obj/item/paper

	var/obj/item/paper/c = new copy_type(loc, copy.text, copy.name, copy.metadata )

	c.color = COLOR_WHITE

	if(toner > 10)	//lots of toner, make it dark
		c.info = "<font color = #101010>"
	else			//no toner? shitty copies for you!
		c.info = "<font color = #808080>"
	var/copied = copy.info
	copied = replacetext(copied, "<font face=\"[c.deffont]\" color=", "<font face=\"[c.deffont]\" nocolor=")	//state of the art techniques in action
	copied = replacetext(copied, "<font face=\"[c.crayonfont]\" color=", "<font face=\"[c.crayonfont]\" nocolor=")	//This basically just breaks the existing color tag, which we need to do because the innermost tag takes priority.
	c.info += copied
	c.info += "</font>"//</font>
	c.SetName(copy.name) // -- Doohl
	c.fields = copy.fields
	c.stamps = copy.stamps
	c.stamped = copy.stamped
	c.ico = copy.ico
	c.offset_x = copy.offset_x
	c.offset_y = copy.offset_y
	var/list/temp_overlays = copy.overlays       //Iterates through stamps
	var/image/img                                //and puts a matching
	for (var/j = 1, j <= min(temp_overlays.len, copy.ico.len), j++) //gray overlay onto the copy
		if (findtext(copy.ico[j], "cap") || findtext(copy.ico[j], "cent"))
			img = image('icons/obj/bureaucracy.dmi', "paper_stamp-circle")
		else if (findtext(copy.ico[j], "deny"))
			img = image('icons/obj/bureaucracy.dmi', "paper_stamp-x")
		else
			img = image('icons/obj/bureaucracy.dmi', "paper_stamp-dots")
		img.pixel_x = copy.offset_x[j]
		img.pixel_y = copy.offset_y[j]
		c.add_overlay(img)
	c.updateinfolinks()
	c.update_space(c.info)
	if(need_toner)
		toner--
	if(toner == 0)
		visible_message(SPAN_NOTICE("A red light on \the [src] flashes, indicating that it is out of toner."))
	c.update_icon()
	return c

/obj/machinery/photocopier/proc/photocopy(obj/item/photo/photocopy, need_toner=1)
	var/obj/item/photo/p = photocopy.copy()
	p.dropInto(loc)

	if(toner > 10)	//plenty of toner, go straight greyscale
		p.img.MapColors(rgb(77,77,77), rgb(150,150,150), rgb(28,28,28), rgb(0,0,0))//I'm not sure how expensive this is, but given the many limitations of photocopying, it shouldn't be an issue.
		p.update_icon()
	else			//not much toner left, lighten the photo
		p.img.MapColors(rgb(77,77,77), rgb(150,150,150), rgb(28,28,28), rgb(100,100,100))
		p.update_icon()
	if(need_toner)
		toner -= 5	//photos use a lot of ink!
	if(toner < 0)
		toner = 0
		visible_message(SPAN_NOTICE("A red light on \the [src] flashes, indicating that it is out of toner."))

	return p

//If need_toner is 0, the copies will still be lightened when low on toner, however it will not be prevented from printing. TODO: Implement print queues for fax machines and get rid of need_toner
/obj/machinery/photocopier/proc/bundlecopy(obj/item/paper_bundle/bundle, need_toner=1)
	var/obj/item/paper_bundle/p = new /obj/item/paper_bundle (src)
	for(var/obj/item/W in bundle.pages)
		if(toner <= 0 && need_toner)
			toner = 0
			visible_message(SPAN_NOTICE("A red light on \the [src] flashes, indicating that it is out of toner."))
			break

		if(istype(W, /obj/item/paper))
			W = copy(W)
		else if(istype(W, /obj/item/photo))
			W = photocopy(W)
		W.forceMove(p)
		p.pages += W

	p.dropInto(loc)
	p.update_icon()
	p.icon_state = "paper_words"
	p.SetName(bundle.name)
	return p

/obj/item/device/toner
	name = "toner cartridge"
	icon_state = "tonercartridge"
	var/toner_amount = 30
