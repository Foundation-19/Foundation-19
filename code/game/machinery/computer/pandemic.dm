#define MAIN_SCREEN 1
#define SYMPTOM_DETAILS 2

/obj/machinery/computer/pandemic
	name = "PanD.E.M.I.C 2200"
	desc = "Used to work with viruses."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "mixer0"
	machine_name = "PanD.E.M.I.C 2200 console"
	machine_desc = "PanD.E.M.I.C 2200 console is used to display ."

	var/vaccine_cooldown
	var/selected_symptom
	var/obj/item/reagent_containers/beaker

/obj/machinery/computer/pandemic/Destroy()
	QDEL_NULL(beaker)
	return ..()

/obj/machinery/computer/pandemic/examine(mob/user)
	. = ..()
	if(beaker)
		var/is_close
		if(Adjacent(user)) // Don't reveal exactly what's inside unless they're close enough to see the UI anyway.
			to_chat(user, "It contains \a [beaker].")
			is_close = TRUE
		else
			to_chat(user, "It has a beaker inside it.")
		to_chat(user, SPAN_INFO("Alt-click to eject [is_close ? beaker : "the beaker"]."))

/obj/machinery/computer/pandemic/AltClick(mob/user)
	. = ..()
	if(Adjacent(user))
		EjectBeaker()

/obj/machinery/computer/pandemic/dismantle()
	EjectBeaker()
	. = ..()

/obj/machinery/computer/pandemic/on_update_icon()
	if(stat & BROKEN)
		icon_state = (beaker ? "mixer1_b" : "mixer0_b")
	else
		icon_state = "mixer[(beaker) ? "1" : "0"][powered() ? "" : "_nopower"]"

/obj/machinery/computer/pandemic/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/reagent_containers) && I.is_open_container())
		. = TRUE //no afterattack
		if(stat & (NOPOWER|BROKEN))
			return
		if(beaker)
			to_chat(user, "<span class='warning'>A container is already loaded into [src]!</span>")
			return
		if(!user.unEquip(I, src))
			return

		beaker = I
		to_chat(user, "<span class='notice'>You insert [I] into [src].</span>")
		update_icon()
	else
		return ..()

/obj/machinery/computer/pandemic/interface_interact(mob/user)
	tgui_interact(user)
	return TRUE

/obj/machinery/computer/pandemic/tgui_interact(mob/user, datum/tgui/ui)
	if(!istype(beaker))
		to_chat(user, SPAN_WARNING("\The [src] does not have a beaker installed!"))
		return
	user.set_machine(src)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Pandemic", "Pan.D.E.M.I.C. 2200 console")
		ui.open()

/obj/machinery/computer/pandemic/tgui_data(mob/user)
	var/list/data = list()
	data["has_beaker"] = istype(beaker) ? 1 : 0
	var/datum/reagent/blood/B = null
	if(beaker)
		B = locate() in beaker.reagents.reagent_list
	data["has_blood"] = B ? 1 : 0
	data["selected_symptom"] = selected_symptom
	if(B)
		data["diseases"] = GetVirusesData(B)
		data["vaccines"] = GetResistanceData(B)
	else
		data["diseases"] = list()
		data["vaccines"] = list()
	return data

/obj/machinery/computer/pandemic/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	switch(action)
		if("choose_symptom")
			selected_symptom = params["name"]
			return TRUE
		if("rename_disease")
			var/id = GetVirusIdByIndex(text2num(params["index"]))
			var/datum/disease/advance/A = SSdisease.archive_diseases[id]
			if(!A || !A.mutable)
				return TRUE
			var/new_name = sanitize(html_encode(input(usr,"Name:","Enter new name","")), 64)
			if(!new_name)
				return TRUE
			A.AssignName(new_name)
			return TRUE
		if("create_vaccine_bottle")
			if(vaccine_cooldown > world.time)
				to_chat(usr, SPAN_WARNING("The vaccine bottle cannot be manufactered yet. Try again later."))
				return TRUE
			var/id = params["id"]
			var/datum/disease/D = SSdisease.archive_diseases[id]
			var/obj/item/reagent_containers/glass/bottle/B = new(get_turf(src))
			B.name = "[D.name] vaccine bottle"
			B.reagents.add_reagent(/datum/reagent/vaccine, 15, list(id))
			vaccine_cooldown = world.time + 30 SECONDS
			playsound(src, 'sounds/machines/ping.ogg', 30, TRUE)
			return TRUE
		if("remove_beacon")
			if(Adjacent(usr))
				EjectBeaker()
			return TRUE
	return FALSE


/obj/machinery/computer/pandemic/proc/GetByIndex(thing, index)
	if(!beaker || !beaker.reagents)
		return
	var/datum/reagent/blood/B = locate() in beaker.reagents.reagent_list
	if(B?.data[thing])
		return B.data[thing][index]

/obj/machinery/computer/pandemic/proc/GetVirusIdByIndex(index)
	var/datum/disease/D = GetByIndex("viruses", index)
	if(D)
		return D.GetDiseaseID()

/obj/machinery/computer/pandemic/proc/GetVirusesData(datum/reagent/blood/B)
	. = list()
	var/list/V = B.GetDiseases()
	var/index = 1
	for(var/virus in V)
		var/datum/disease/D = virus
		if(!istype(D) || D.visibility_flags & HIDDEN_PANDEMIC)
			continue

		var/list/this = list()
		this["name"] = D.name
		if(istype(D, /datum/disease/advance))
			var/datum/disease/advance/A = D
			var/disease_name = SSdisease.get_disease_name(A.GetDiseaseID())
			this["can_rename"] = ((disease_name == "Unknown") && A.mutable)
			this["name"] = disease_name
			this["is_adv"] = TRUE
			this["symptoms"] = list()
			for(var/symptom in A.symptoms)
				var/datum/symptom/S = symptom
				var/list/this_symptom = list()
				this_symptom = GetSymptomData(S)
				this["symptoms"] += list(this_symptom)
			this["resistance"] = A.TotalResistance()
			this["stealth"] = A.TotalStealth()
			this["stage_speed"] = A.TotalStageSpeed()
			this["transmission"] = A.TotalTransmittable()
		this["index"] = index++
		this["agent"] = D.agent
		this["description"] = D.desc || "none"
		this["spread"] = D.spread_text || "none"
		this["cure"] = D.cure_text || "none"

		. += list(this)

/obj/machinery/computer/pandemic/proc/GetSymptomData(datum/symptom/S)
	. = list()
	var/list/this = list()
	this["name"] = S.name
	this["desc"] = S.desc
	this["stealth"] = S.stealth
	this["resistance"] = S.resistance
	this["stage_speed"] = S.stage_speed
	this["transmission"] = S.transmittable
	this["level"] = S.level
	this["neutered"] = S.neutered
	this["threshold_desc"] = S.threshold_descs
	. += this

/obj/machinery/computer/pandemic/proc/GetResistanceData(datum/reagent/blood/B)
	. = list()
	if(!islist(B.data["resistances"]))
		return
	var/list/resistances = B.data["resistances"]
	for(var/id in resistances)
		var/list/this = list()
		var/datum/disease/D = SSdisease.archive_diseases[id]
		if(D)
			this["id"] = id
			this["name"] = D.name

		. += list(this)

/obj/machinery/computer/pandemic/proc/EjectBeaker()
	if(beaker)
		if(!usr.put_in_any_hand_if_possible(beaker))
			beaker.dropInto(get_turf(src))
		beaker = null
		update_icon()
