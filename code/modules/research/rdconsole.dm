#define CHECK_LATHE \
	if(!linked_lathe){\
		screen = 1;\
		return};\
	if(!linked_lathe.reagents){\
		crash_with("An rdconsole's linked lathe's reagents holder was deleted.");\
		screen = 1;\
		return}
#define CHECK_IMPRINTER \
	if(!linked_imprinter){\
		screen = 1;\
		return}
#define CHECK_DESTROY \
	if(!linked_destroy){\
		screen = 1;\
		return}
/*
Research and Development (R&D) Console

This is the main work horse of the R&D system. It contains the menus/controls for the Destructive Analyzer, Protolathe, and Circuit
imprinter. It also contains the /datum/research holder with all the known/possible technology paths and device designs.

Basic use: When it first is created, it will attempt to link up to related devices within 3 squares. It'll only link up if they
aren't already linked to another console. Any consoles it cannot link up with (either because all of a certain type are already
linked or there aren't any in range), you'll just not have access to that menu. In the settings menu, there are menu options that
allow a player to attempt to re-sync with nearby consoles. You can also force it to disconnect from a specific console.

The imprinting and construction menus do NOT require toxins access to access but all the other menus do. However, if you leave it
on a menu, nothing is to stop the person from using the options on that menu (although they won't be able to change to a different
one). You can also lock the console on the settings menu if you're feeling paranoid and you don't want anyone messing with it who
doesn't have toxins access.

When a R&D console is destroyed or even partially disassembled, you lose all research data on it. However, there are two ways around
this dire fate:
- The easiest way is to go to the settings menu and select "Sync Database with Network." That causes it to upload (but not download)
it's data to every other device in the game. Each console has a "disconnect from network" option that'll will cause data base sync
operations to skip that console. This is useful if you want to make a "public" R&D console or, for example, give the engineers
a circuit imprinter with certain designs on it and don't want it accidentally updating. The downside of this method is that you have
to have physical access to the other console to send data back. Note: An R&D console is on CentCom so if a random griffan happens to
cause a ton of data to be lost, an admin can go send it back.
- The second method is with Technology Disks and Design Disks. Each of these disks can hold a single technology or design datum in
it's entirety. You can then take the disk to any R&D console and upload it's data to it. This method is a lot more secure (since it
won't update every console in existence) but it's more of a hassle to do. Also, the disks can be stolen.
*/

/obj/machinery/computer/rdconsole
	name = "fabrication control console"
	desc = "Console controlling the various fabrication devices. Uses self-learning matrix to hold and optimize blueprints. Prone to corrupting said matrix, so back up often."
	icon_keyboard = "rd_key"
	icon_screen = "rdcomp"
	light_color = "#a97faa"
	base_type = /obj/machinery/computer/rdconsole/core
	machine_name = "\improper R&D control console"
	machine_desc = "Used to operate an R&D setup, including protolathes, circuit imprinters, and destructive analyzers. Can be configured with a screwdriver."
	var/datum/research/files							//Stores all the collected research data.
	var/obj/item/disk/tech_disk/t_disk = null	//Stores the technology disk.
	var/obj/item/disk/design_disk/d_disk = null	//Stores the design disk.

	var/obj/machinery/r_n_d/destructive_analyzer/linked_destroy = null	//Linked Destructive Analyzer
	var/obj/machinery/r_n_d/protolathe/linked_lathe = null				//Linked Protolathe
	var/obj/machinery/r_n_d/circuit_imprinter/linked_imprinter = null	//Linked Circuit Imprinter

	var/screen = 1.0	//Which screen is currently showing.
	var/id = 0			//ID of the computer (for server restrictions).
	var/sync = 1		//If sync = 0, it doesn't show up on Server Control Console
	var/can_analyze = TRUE //If the console is allowed to use destructive analyzers

/obj/machinery/computer/rdconsole/proc/CallMaterialName(ID)
	var/return_name = ID
	switch(return_name)
		if(MATERIAL_STEEL)
			return_name = "Steel"
		if(MATERIAL_ALUMINIUM)
			return_name = "Aluminium"
		if(MATERIAL_GLASS)
			return_name = "Glass"
		if(MATERIAL_PLASTIC)
			return_name = "Plastic"
		if(MATERIAL_GOLD)
			return_name = "Gold"
		if(MATERIAL_SILVER)
			return_name = "Silver"
		if(MATERIAL_PHORON)
			return_name = "Solid Phoron"
		if(MATERIAL_URANIUM)
			return_name = "Uranium"
		if(MATERIAL_DIAMOND)
			return_name = "Diamond"
	return return_name

/obj/machinery/computer/rdconsole/proc/CallReagentName(reagent_type)
	var/datum/reagent/R = reagent_type
	return ispath(reagent_type, /datum/reagent) ? initial(R.name) : "Unknown"

/obj/machinery/computer/rdconsole/proc/SyncRDevices() //Makes sure it is properly sync'ed up with the devices attached to it (if any).
	for(var/obj/machinery/r_n_d/D in range(4, src))
		if(D.linked_console != null || D.panel_open)
			continue
		if(istype(D, /obj/machinery/r_n_d/destructive_analyzer) && can_analyze == TRUE) // Only science R&D consoles can do research
			if(linked_destroy == null)
				linked_destroy = D
				D.linked_console = src
		else if(istype(D, /obj/machinery/r_n_d/protolathe))
			if(linked_lathe == null)
				linked_lathe = D
				D.linked_console = src
		else if(istype(D, /obj/machinery/r_n_d/circuit_imprinter))
			if(linked_imprinter == null)
				linked_imprinter = D
				D.linked_console = src
	return

/obj/machinery/computer/rdconsole/New()
	..()
	files = new /datum/research(src) //Setup the research data holder.
	if(!id)
		for(var/obj/machinery/r_n_d/server/centcom/S in SSmachines.machinery)
			S.update_connections()
			break

/obj/machinery/computer/rdconsole/Initialize()
	. = ..()
	// Device Initialize order within the same map-load pass is not
	// guaranteed — the console can run before the lathe/analyzer/imprinter
	// exist. Sync once everything has initialized.
	addtimer(CALLBACK(src, PROC_REF(SyncRDevices)), 1)

/obj/machinery/computer/rdconsole/attackby(obj/item/D as obj, mob/user as mob)
	//Loading a disk into it.
	if(istype(D, /obj/item/disk))
		if(t_disk || d_disk)
			to_chat(user, "A disk is already loaded into the machine.")
			return
		if(!user.canUnEquip(D))
			return
		if(istype(D, /obj/item/disk/tech_disk))
			t_disk = D
		else if (istype(D, /obj/item/disk/design_disk))
			d_disk = D
		else
			to_chat(user, SPAN_NOTICE("Machine cannot accept disks in that format."))
			return
		user.drop_from_inventory(D, src)
		to_chat(user, SPAN_NOTICE("You add \the [D] to the machine."))
	else
		//The construction/deconstruction of the console code.
		..()

	SStgui.update_uis(src)
	return



/obj/machinery/computer/rdconsole/emag_act(remaining_charges, mob/user)
	if(!emagged)
		playsound(src.loc, 'sounds/effects/sparks4.ogg', 75, 1)
		emagged = TRUE
		req_access.Cut()
		to_chat(user, SPAN_NOTICE("You you disable the security protocols."))
		return 1

/obj/machinery/computer/rdconsole/CanUseTopic(mob/user, datum/topic_state/state, href_list)
	if(href_list && href_list["menu"])
		var/temp_screen = text2num(href_list["menu"])
		if(!((temp_screen <= 1.1) || (3 <= temp_screen && 4.9 >= temp_screen) || allowed(user)))
			to_chat(user, "Unauthorized Access.")
			return STATUS_CLOSE
	return ..()

/obj/machinery/computer/rdconsole/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	// Access gate mirroring legacy CanUseTopic: everything except the main menu
	// (1.0), research viewer (1.1) and lathe/imprinter screens (3.x/4.x) needs access.
	if(action == "menu" && params["menu"])
		var/temp_screen = text2num(params["menu"])
		if(!((temp_screen <= 1.1) || (3 <= temp_screen && 4.9 >= temp_screen) || allowed(usr)))
			to_chat(usr, "Unauthorized Access.")
			return TRUE

	switch(action)
		if("menu")
			screen = text2num(params["menu"])
			return TRUE

		if("updt_tech")
			if(!t_disk)
				screen = 1
				return TRUE
			screen = 0.0
			spawn(50)
				if(!t_disk)
					screen = 1
					return
				screen = 1.2
				files.AddTech2Known(t_disk.stored)
				SStgui.update_uis(src)
			return TRUE

		if("clear_tech")
			if(!t_disk)
				screen = 1
				return TRUE
			t_disk.stored = null
			return TRUE

		if("eject_tech")
			if(t_disk)
				t_disk.dropInto(loc)
				t_disk = null
			screen = 1.0
			return TRUE

		if("copy_tech")
			if(!t_disk)
				screen = 1
				return TRUE
			for(var/datum/tech/T in files.known_tech)
				if(params["copy_tech_ID"] == T.id)
					t_disk.stored = T
					break
			screen = 1.2
			return TRUE

		if("updt_design")
			if(!d_disk)
				screen = 1
				return TRUE
			screen = 0.0
			spawn(50)
				if(!d_disk)
					screen = 1
					return
				screen = 1.4
				files.AddDesign2Known(d_disk.blueprint)
				SStgui.update_uis(src)
			return TRUE

		if("clear_design")
			if(!d_disk)
				screen = 1
				return TRUE
			d_disk.blueprint = null
			return TRUE

		if("eject_design")
			if(d_disk)
				d_disk.dropInto(loc)
				d_disk = null
			screen = 1.0
			return TRUE

		if("copy_design")
			if(!d_disk)
				screen = 1
				return TRUE
			for(var/datum/design/D in files.known_designs)
				if(params["copy_design_ID"] == D.id)
					d_disk.blueprint = D
					break
			screen = 1.4
			return TRUE

		if("eject_item")
			CHECK_DESTROY
			if(linked_destroy.busy)
				to_chat(usr, SPAN_NOTICE("The destructive analyzer is busy at the moment."))
			else if(linked_destroy.loaded_item)
				linked_destroy.loaded_item.dropInto(linked_destroy.loc)
				linked_destroy.loaded_item = null
				linked_destroy.icon_state = "d_analyzer"
				screen = 2.1
			return TRUE

		if("deconstruct")
			CHECK_DESTROY
			if(linked_destroy.busy)
				to_chat(usr, SPAN_NOTICE("The destructive analyzer is busy at the moment."))
				return TRUE
			var/choice = alert("Proceeding will destroy loaded item. Continue?", "Destructive analyzer confirmation", "Yes", "No")
			if(choice == "No")
				return TRUE
			CHECK_DESTROY
			linked_destroy.busy = 1
			screen = 0.1
			flick("d_analyzer_process", linked_destroy)
			addtimer(CALLBACK(src, PROC_REF(finish_deconstruct), weakref(usr)), 24)
			return TRUE

		if("lock")
			if(allowed(usr))
				screen = text2num(params["lock"])
			else
				to_chat(usr, "Unauthorized Access.")
			return TRUE

		if("sync")
			screen = 0.0
			if(!sync)
				to_chat(usr, SPAN_NOTICE("You must connect to the network first."))
			else
				spawn(30)
					if(src)
						for(var/obj/machinery/r_n_d/server/S in SSmachines.machinery)
							var/server_processed = 0
							if((id in S.id_with_upload) || istype(S, /obj/machinery/r_n_d/server/centcom))
								for(var/datum/tech/T in files.known_tech)
									S.files.AddTech2Known(T)
								for(var/datum/design/D in files.known_designs)
									S.files.AddDesign2Known(D)
								S.files.RefreshResearch()
								server_processed = 1
							if((id in S.id_with_download) && !istype(S, /obj/machinery/r_n_d/server/centcom))
								for(var/datum/tech/T in S.files.known_tech)
									files.AddTech2Known(T)
								for(var/datum/design/D in S.files.known_designs)
									files.AddDesign2Known(D)
								files.RefreshResearch()
								server_processed = 1
							if(!istype(S, /obj/machinery/r_n_d/server/centcom) && server_processed)
								S.produce_heat()
						screen = 1.6
						SStgui.update_uis(src)
			return TRUE

		if("togglesync")
			sync = !sync
			return TRUE

		if("build")
			CHECK_LATHE
			var/datum/design/being_built = null
			for(var/datum/design/D in files.known_designs)
				if(D.id == params["build"])
					being_built = D
					break
			if(being_built)
				linked_lathe.addToQueue(being_built)
			screen = 3.1
			return TRUE

		if("imprint")
			CHECK_IMPRINTER
			var/datum/design/being_built = null
			for(var/datum/design/D in files.known_designs)
				if(D.id == params["imprint"])
					being_built = D
					break
			if(being_built)
				linked_imprinter.addToQueue(being_built)
			screen = 4.1
			return TRUE

		if("disposeP")
			CHECK_LATHE
			for(var/datum/reagent/R in linked_lathe.reagents.reagent_list)
				if("[R.type]" == params["chem"])
					linked_lathe.reagents.del_reagent(R.type)
					break
			return TRUE

		if("disposeallP")
			CHECK_LATHE
			linked_lathe.reagents.clear_reagents()
			return TRUE

		if("removeP")
			CHECK_LATHE
			var/to_remove = text2num(params["remove"])
			if(sanitize_integer(to_remove, 1, length(linked_lathe.queue), 1) == to_remove)
				linked_lathe.removeFromQueue(to_remove)
			return TRUE

		if("lathe_ejectsheet")
			CHECK_LATHE
			linked_lathe.eject(params["mat"], text2num(params["amount"]))
			return TRUE

		if("disposeI")
			CHECK_IMPRINTER
			for(var/datum/reagent/R in linked_imprinter.reagents.reagent_list)
				if("[R.type]" == params["chem"])
					linked_imprinter.reagents.del_reagent(R.type)
					break
			return TRUE

		if("disposeallI")
			CHECK_IMPRINTER
			linked_imprinter.reagents.clear_reagents()
			return TRUE

		if("removeI")
			CHECK_IMPRINTER
			linked_imprinter.removeFromQueue(text2num(params["remove"]))
			return TRUE

		if("imprinter_ejectsheet")
			CHECK_IMPRINTER
			linked_imprinter.eject(params["mat"], text2num(params["amount"]))
			return TRUE

		if("find_device")
			screen = 0.0
			spawn(10)
				SyncRDevices()
				screen = 1.7
				SStgui.update_uis(src)
			return TRUE

		if("disconnect")
			switch(params["device"])
				if("destroy")
					CHECK_DESTROY
					linked_destroy.linked_console = null
					linked_destroy = null
				if("lathe")
					CHECK_LATHE
					linked_lathe.linked_console = null
					linked_lathe = null
				if("imprinter")
					CHECK_IMPRINTER
					linked_imprinter.linked_console = null
					linked_imprinter = null
			return TRUE

		if("reset")
			var/choice = alert("R&D Console Database Reset", "Are you sure you want to reset the R&D console's database? Data lost cannot be recovered.", "Continue", "Cancel")
			if(choice == "Continue")
				screen = 0.0
				qdel(files)
				files = new /datum/research(src)
				spawn(20)
					screen = 1.6
					SStgui.update_uis(src)
			return TRUE

		if("print")
			screen = 0.5
			spawn(20)
				var/obj/item/paper/PR = new/obj/item/paper
				PR.name = "fabricator report"
				PR.info = "<center><b>[station_name()] Fabricator Laboratory</b>"
				PR.info += "<h2>[ (text2num(params["print"]) == 2) ? "Detailed" : null ] Fabricator Status Report</h2>"
				PR.info += "<i>report prepared at [station_time_timestamp("hh:mm")] local time</i></center><br>"
				if(text2num(params["print"]) == 2)
					PR.info += GetResearchListInfo()
				else
					PR.info += GetResearchLevelsInfo()
				PR.info_links = PR.info
				PR.icon_state = "paper_words"
				PR.dropInto(loc)
				spawn(10)
					screen = ((text2num(params["print"]) == 2) ? 5.0 : 1.1)
					SStgui.update_uis(src)
			return TRUE
	return FALSE
/obj/machinery/computer/rdconsole/proc/finish_deconstruct(weakref/W)
	CHECK_DESTROY
	var/mob/user = W.resolve()
	linked_destroy.busy = 0
	if(!linked_destroy.loaded_item)
		to_chat(user, SPAN_NOTICE("The destructive analyzer appears to be empty."))
		screen = 1.0
		return
	for(var/T in linked_destroy.loaded_item.origin_tech)
		files.UpdateTech(T, linked_destroy.loaded_item.origin_tech[T])
	if(linked_lathe && linked_destroy.loaded_item.matter) // Also sends salvaged materials to a linked protolathe, if any.
		for(var/t in linked_destroy.loaded_item.matter)
			if(t in linked_lathe.materials)
				linked_lathe.materials[t] += min(linked_lathe.max_material_storage - linked_lathe.TotalMaterials(), linked_destroy.loaded_item.matter[t] * linked_destroy.decon_mod)

	linked_destroy.loaded_item = null
	for(var/obj/I in linked_destroy.contents)
		for(var/mob/M in I.contents)
			M.death()
			qdel(M)
		if(istype(I,/obj/item/stack/material))//Only deconsturcts one sheet at a time instead of the entire stack
			var/obj/item/stack/material/S = I
			if(S.use(1) && S.amount)
				linked_destroy.loaded_item = S
			else
				qdel(S)
				linked_destroy.icon_state = "d_analyzer"
		else
			if(!(I in linked_destroy.component_parts))
				qdel(I)
				linked_destroy.icon_state = "d_analyzer"

	use_power_oneoff(linked_destroy.active_power_usage)
	screen = 1.0
	SStgui.update_uis(src)

/obj/machinery/computer/rdconsole/proc/GetResearchLevelsInfo()
	var/dat
	dat += "<UL>"
	for(var/datum/tech/T in files.known_tech)
		if(T.level < 1)
			continue
		dat += "<LI>"
		dat += "[T.name]"
		dat += "<UL>"
		dat +=  "<LI>Level: [T.level]"
		dat +=  "<LI>Summary: [T.desc]"
		dat += "</UL>"
	return dat

/obj/machinery/computer/rdconsole/proc/GetResearchListInfo()
	var/dat
	dat += "<UL>"
	for(var/datum/design/D in files.known_designs)
		if(D.build_path)
			dat += "<LI><B>[D.name]</B>: [D.desc]"
	dat += "</UL>"
	return dat

/obj/machinery/computer/rdconsole/interface_interact(mob/user)
	interact(user)
	return TRUE

/obj/machinery/computer/rdconsole/interact(mob/user)
	tgui_interact(user)

/obj/machinery/computer/rdconsole/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "RDConsole", name)
		ui.open()

/obj/machinery/computer/rdconsole/tgui_data(mob/user)
	var/list/data = list()
	data["screen"] = "[screen]"
	data["sync"] = sync
	data["can_analyze"] = can_analyze
	data["t_disk"] = t_disk ? 1 : 0
	data["d_disk"] = d_disk ? 1 : 0
	data["has_destroy"] = linked_destroy ? 1 : 0
	data["has_lathe"] = linked_lathe ? 1 : 0
	data["has_imprinter"] = linked_imprinter ? 1 : 0

	if(t_disk)
		var/list/tech_info = list()
		if(t_disk.stored)
			tech_info["name"] = t_disk.stored.name
			tech_info["level"] = t_disk.stored.level
			tech_info["desc"] = t_disk.stored.desc
		data["tech_disk"] = tech_info
	if(d_disk)
		var/list/design_info = list()
		if(d_disk.blueprint)
			design_info["name"] = d_disk.blueprint.name
			var/build_type = d_disk.blueprint.build_type
			switch(build_type)
				if(IMPRINTER)
					design_info["lathe_type"] = "Circuit Imprinter"
				if(PROTOLATHE)
					design_info["lathe_type"] = "Proto-lathe"
			var/list/mat_list = list()
			for(var/M in d_disk.blueprint.materials)
				mat_list += list(list("name" = CallMaterialName(M), "amount" = d_disk.blueprint.materials[M]))
			design_info["materials"] = mat_list
		data["design_disk"] = design_info

	// Screen 1.1 — research levels
	var/list/techs = list()
	for(var/datum/tech/T in files.known_tech)
		if(T.level < 1)
			continue
		techs += list(list("name" = T.name, "level" = T.level, "desc" = T.desc))
	data["techs"] = techs
	// Screen 5.0 — known designs
	var/list/designs_known = list()
	for(var/datum/design/D in files.known_designs)
		if(D.build_path)
			designs_known += list(list("name" = D.name, "desc" = D.desc))
	data["known_designs"] = designs_known

	// Copy-to-disk source lists (screens 1.3 / 1.5)
	var/list/copyable_techs = list()
	for(var/datum/tech/T in files.known_tech)
		copyable_techs += list(list("name" = T.name, "id" = T.id))
	data["copyable_techs"] = copyable_techs
	var/list/copyable_designs = list()
	for(var/datum/design/D in files.known_designs)
		if(D.build_path)
			copyable_designs += list(list("name" = D.name, "id" = D.id))
	data["copyable_designs"] = copyable_designs

	// Destructive analyzer screens
	if(linked_destroy)
		var/list/destroy_data = list()
		destroy_data["busy"] = linked_destroy.busy
		if(linked_destroy.loaded_item)
			var/list/origin = list()
			for(var/T in linked_destroy.loaded_item.origin_tech)
				var/current = null
				for(var/datum/tech/F in files.known_tech)
					if(F.name == CallTechName(T))
						current = F.level
						break
				origin += list(list("name" = CallTechName(T), "value" = linked_destroy.loaded_item.origin_tech[T], "current" = current))
			destroy_data["item_name"] = linked_destroy.loaded_item.name
			destroy_data["origin_tech"] = origin
		data["destroy"] = destroy_data

	// Protolathe screens
	if(linked_lathe)
		data["lathe"] = build_lathe_imprinter_data(linked_lathe, TRUE)

	// Circuit imprinter screens
	if(linked_imprinter)
		data["imprinter"] = build_lathe_imprinter_data(linked_imprinter, FALSE)

	return data

/obj/machinery/computer/rdconsole/proc/build_lathe_imprinter_data(obj/machinery/r_n_d/machine, is_lathe)
	var/list/out = list()
	out["materials"] = machine.TotalMaterials()
	out["chem_volume"] = machine.reagents.total_volume
	out["chem_max"] = machine.reagents.maximum_volume
	out["busy"] = machine.busy

	var/list/mats = list()
	for(var/M in machine.materials)
		var/amount = machine.materials[M]
		var/list/ejects = list()
		if(amount >= SHEET_MATERIAL_AMOUNT)
			for(var/C in list(1, 3, 5, 10, 15, 20, 25, 30, 40))
				if(amount < C * SHEET_MATERIAL_AMOUNT)
					break
				ejects += C
		mats += list(list("name" = capitalize(M), "key" = M, "amount" = amount, "ejects" = ejects))
	out["mat_list"] = mats

	var/list/chems = list()
	for(var/datum/reagent/R in machine.reagents.reagent_list)
		chems += list(list("name" = R.name, "volume" = R.volume, "key" = "[R.type]"))
	out["chems"] = chems

	var/list/queue = list()
	var/qindex = 1
	var/list/machine_queue = list()
	if(is_lathe)
		var/obj/machinery/r_n_d/protolathe/PL = machine
		machine_queue = PL.queue
	else
		var/obj/machinery/r_n_d/circuit_imprinter/CI = machine
		machine_queue = CI.queue
	for(var/datum/design/D in machine_queue)
		var/busy_first = (qindex == 1 && machine.busy)
		queue += list(list("name" = D.name, "index" = qindex, "busy" = busy_first))
		qindex++
	out["queue"] = queue

	var/list/buildables = list()
	for(var/datum/design/D in files.known_designs)
		if(!D.build_path)
			continue
		var/build_type_flag = is_lathe ? PROTOLATHE : IMPRINTER
		if(!(D.build_type & build_type_flag))
			continue
		var/mat_efficiency = 1
		if(!is_lathe)
			var/obj/machinery/r_n_d/circuit_imprinter/CI = machine
			mat_efficiency = CI.mat_efficiency
		var/list/cost_parts = list()
		for(var/M in D.materials)
			cost_parts += "[D.materials[M]*(is_lathe ? 1 : mat_efficiency)] [CallMaterialName(M)]"
		for(var/T in D.chemicals)
			cost_parts += "[D.chemicals[T]*mat_efficiency] [CallReagentName(T)]"
		var/can_build = FALSE
		if(is_lathe)
			var/obj/machinery/r_n_d/protolathe/PL = machine
			can_build = PL.canBuild(D)
		else
			var/obj/machinery/r_n_d/circuit_imprinter/CI = machine
			can_build = CI.canBuild(D)
		buildables += list(list(
			"name" = D.name,
			"id" = D.id,
			"cost" = jointext(cost_parts, ", "),
			"can_build" = can_build
		))
	out["buildables"] = buildables
	return out


/obj/machinery/computer/rdconsole/robotics
	name = "robotics fabrication console"
	id = 2
	req_access = list(ACCESS_ROBOTICS)
	can_analyze = FALSE

/obj/machinery/computer/rdconsole/core
	name = "core fabricator console"
	id = 1


#undef CHECK_LATHE
#undef CHECK_IMPRINTER
#undef CHECK_DESTROY
