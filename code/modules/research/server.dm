/obj/machinery/r_n_d/server
	name = "R&D Server"
	icon = 'icons/obj/machines/research.dmi'
	icon_state = "server"
	base_type = /obj/machinery/r_n_d/server
	construct_state = /decl/machine_construction/default/panel_closed
	machine_name = "\improper R&D server"
	machine_desc = "A powerful piece of hardware used as the hub of a research matrix, containing every byte of data gleaned from an experiment."
	var/datum/research/files
	var/health = 100
	var/list/id_with_upload = list()	//List of R&D consoles with upload to server access.
	var/list/id_with_download = list()	//List of R&D consoles with download from server access.
	var/id_with_upload_string = ""		//String versions for easy editing in map editor.
	var/id_with_download_string = ""
	var/server_id = 0
	var/produces_heat = 1
	idle_power_usage = 800
	var/delay = 10
	req_access = list(access_sciencelvl5) //Only the R&D can change server settings.

/obj/machinery/r_n_d/server/RefreshParts()
	var/tot_rating = 0
	for(var/obj/item/stock_parts/SP in src)
		tot_rating += SP.rating
	change_power_consumption(initial(idle_power_usage)/max(1, tot_rating), POWER_USE_IDLE)

/obj/machinery/r_n_d/server/Initialize()
	. = ..()
	if(!files)
		files = new /datum/research(src)
	var/list/temp_list
	if(!id_with_upload.len)
		temp_list = list()
		temp_list = splittext(id_with_upload_string, ";")
		for(var/N in temp_list)
			id_with_upload += text2num(N)
	if(!id_with_download.len)
		temp_list = list()
		temp_list = splittext(id_with_download_string, ";")
		for(var/N in temp_list)
			id_with_download += text2num(N)

/obj/machinery/r_n_d/server/Process()
	..()
	var/datum/gas_mixture/environment = loc.return_air()
	switch(environment.temperature)
		if(0 to T0C)
			health = min(100, health + 1)
		if(T0C to (T20C + 20))
			health = between(0, health, 100)
		if((T20C + 20) to (T0C + 70))
			health = max(0, health - 1)
	if(health <= 0)
		files.known_designs = list()
		for(var/datum/tech/T in files.known_tech)
			if(prob(1))
				T.level--
		files.RefreshResearch()
	if(delay)
		delay--
	else
		produce_heat()
		delay = initial(delay)

/obj/machinery/r_n_d/server/proc/produce_heat()
	if(!produces_heat)
		return

	if(!use_power)
		return

	if(!(stat & (NOPOWER|BROKEN))) //Blatently stolen from telecoms
		var/turf/simulated/L = loc
		if(istype(L))
			var/datum/gas_mixture/env = L.return_air()

			var/transfer_moles = 0.25 * env.total_moles

			var/datum/gas_mixture/removed = env.remove(transfer_moles)

			if(removed)
				var/heat_produced = idle_power_usage	//obviously can't produce more heat than the machine draws from it's power source

				removed.add_thermal_energy(heat_produced)

			env.merge(removed)

/obj/machinery/r_n_d/server/centcom
	name = "Central R&D Database"
	server_id = -1

/obj/machinery/r_n_d/server/centcom/proc/update_connections()
	var/list/no_id_servers = list()
	var/list/server_ids = list()
	for(var/obj/machinery/r_n_d/server/S in SSmachines.machinery)
		switch(S.server_id)
			if(-1)
				continue
			if(0)
				no_id_servers += S
			else
				server_ids += S.server_id

	for(var/obj/machinery/r_n_d/server/S in no_id_servers)
		var/num = 1
		while(!S.server_id)
			if(num in server_ids)
				num++
			else
				S.server_id = num
				server_ids += num
		no_id_servers -= S

/obj/machinery/r_n_d/server/centcom/Process()
	return PROCESS_KILL //don't need process()

/obj/machinery/computer/rdservercontrol
	name = "R&D Server Controller"
	icon_keyboard = "rd_key"
	icon_screen = "rdcomp"
	light_color = "#a97faa"
	machine_name = "\improper R&D server control console"
	machine_desc = "If an R&D server is the heart of a research setup, this is the brain. Any kind of data manipulation on the server happens from this console."
	var/screen = 0
	var/obj/machinery/r_n_d/server/temp_server
	var/list/servers = list()
	var/list/consoles = list()
	var/badmin = 0

/obj/machinery/computer/rdservercontrol/CanUseTopic(user)
	if(!allowed(user) && !emagged)
		to_chat(user, "<span class='warning'>You do not have the required access level</span>")
		return STATUS_CLOSE
	return ..()

/obj/machinery/computer/rdservercontrol/OnTopic(user, href_list, state)
	if(href_list["main"])
		screen = 0
		. = TOPIC_REFRESH

	else if(href_list["access"] || href_list["data"] || href_list["transfer"])
		temp_server = null
		consoles = list()
		servers = list()
		for(var/obj/machinery/r_n_d/server/S in SSmachines.machinery)
			if(S.server_id == text2num(href_list["access"]) || S.server_id == text2num(href_list["data"]) || S.server_id == text2num(href_list["transfer"]))
				temp_server = S
				break
		if(href_list["access"])
			screen = 1
			for(var/obj/machinery/computer/rdconsole/C in SSmachines.machinery)
				if(C.sync)
					consoles += C
		else if(href_list["data"])
			screen = 2
		else if(href_list["transfer"])
			screen = 3
			for(var/obj/machinery/r_n_d/server/S in SSmachines.machinery)
				if(S == src)
					continue
				servers += S
		. = TOPIC_REFRESH

	else if(href_list["upload_toggle"])
		var/num = text2num(href_list["upload_toggle"])
		if(num in temp_server.id_with_upload)
			temp_server.id_with_upload -= num
		else
			temp_server.id_with_upload += num
		. = TOPIC_REFRESH

	else if(href_list["download_toggle"])
		var/num = text2num(href_list["download_toggle"])
		if(num in temp_server.id_with_download)
			temp_server.id_with_download -= num
		else
			temp_server.id_with_download += num
		. = TOPIC_REFRESH

	else if(href_list["reset_tech"])
		var/choice = alert(user, "Technology Data Reset", "Are you sure you want to reset this technology to its default data? Data lost cannot be recovered.", "Continue", "Cancel")
		if(choice == "Continue" && CanUseTopic(user, state))
			for(var/datum/tech/T in temp_server.files.known_tech)
				if(T.level > 0 && T.id == href_list["reset_tech"])
					T.level = 1
					break
		temp_server.files.RefreshResearch()
		. = TOPIC_REFRESH

	else if(href_list["reset_design"])
		var/choice = alert(user, "Design Data Deletion", "Are you sure you want to delete this design? If you still have the prerequisites for the design, it'll reset to its base reliability. Data lost cannot be recovered.", "Continue", "Cancel")
		if(choice == "Continue" && CanUseTopic(user, state))
			for(var/datum/design/D in temp_server.files.known_designs)
				if(D.id == href_list["reset_design"])
					temp_server.files.known_designs -= D
					break
		temp_server.files.RefreshResearch()
		. = TOPIC_REFRESH

/obj/machinery/computer/rdservercontrol/interface_interact(mob/user)
	interact(user)
	return TRUE

/obj/machinery/computer/rdservercontrol/interact(mob/user)
	user.set_machine(src)
	var/dat = ""

	switch(screen)
		if(0) //Main Menu
			dat += "Connected Servers:<BR><BR>"
			var/turf/T = get_turf(src)
			for(var/obj/machinery/r_n_d/server/S in SSmachines.machinery)
				var/turf/ST = get_turf(S)
				if((istype(S, /obj/machinery/r_n_d/server/centcom) && !badmin) || (ST && !AreConnectedZLevels(ST.z, T.z)))
					continue
				dat += "[S.name] || "
				dat += "<A href='?src=\ref[src];access=[S.server_id]'> Access Rights</A> | "
				dat += "<A href='?src=\ref[src];data=[S.server_id]'>Data Management</A>"
				if(badmin) dat += " | <A href='?src=\ref[src];transfer=[S.server_id]'>Server-to-Server Transfer</A>"
				dat += "<BR>"

		if(1) //Access rights menu
			dat += "[temp_server.name] Access Rights<BR><BR>"
			dat += "Consoles with Upload Access<BR>"
			for(var/obj/machinery/computer/rdconsole/C in consoles)
				var/turf/console_turf = get_turf(C)
				dat += "* <A href='?src=\ref[src];upload_toggle=[C.id]'>[console_turf.loc]" //FYI, these are all numeric ids, eventually.
				if(C.id in temp_server.id_with_upload)
					dat += " (Remove)</A><BR>"
				else
					dat += " (Add)</A><BR>"
			dat += "Consoles with Download Access<BR>"
			for(var/obj/machinery/computer/rdconsole/C in consoles)
				var/turf/console_turf = get_turf(C)
				dat += "* <A href='?src=\ref[src];download_toggle=[C.id]'>[console_turf.loc]"
				if(C.id in temp_server.id_with_download)
					dat += " (Remove)</A><BR>"
				else
					dat += " (Add)</A><BR>"
			dat += "<HR><A href='?src=\ref[src];main=1'>Main Menu</A>"

		if(2) //Data Management menu
			dat += "[temp_server.name] Data ManagementP<BR><BR>"
			dat += "Known Technologies<BR>"
			for(var/datum/tech/T in temp_server.files.known_tech)
				dat += "* [T.name] "
				dat += "<A href='?src=\ref[src];reset_tech=[T.id]'>(Reset)</A><BR>" //FYI, these are all strings.
			dat += "Known Designs<BR>"
			for(var/datum/design/D in temp_server.files.known_designs)
				dat += "* [D.name] "
				dat += "<A href='?src=\ref[src];reset_design=[D.id]'>(Delete)</A><BR>"
			dat += "<HR><A href='?src=\ref[src];main=1'>Main Menu</A>"

		if(3) //Server Data Transfer
			dat += "[temp_server.name] Server to Server Transfer<BR><BR>"
			dat += "Send Data to what server?<BR>"
			for(var/obj/machinery/r_n_d/server/S in servers)
				dat += "[S.name] <A href='?src=\ref[src];send_to=[S.server_id]'> (Transfer)</A><BR>"
			dat += "<HR><A href='?src=\ref[src];main=1'>Main Menu</A>"
	show_browser(user, "<TITLE>R&D Server Control</TITLE><HR>[dat]", "window=server_control;size=575x400")
	onclose(user, "server_control")
	return

/obj/machinery/computer/rdservercontrol/emag_act(var/remaining_charges, var/mob/user)
	if(!emagged)
		playsound(src.loc, 'sound/effects/sparks4.ogg', 75, 1)
		emagged = TRUE
		req_access.Cut()
		to_chat(user, "<span class='notice'>You you disable the security protocols.</span>")
		src.updateUsrDialog()
		return 1

/obj/machinery/r_n_d/server/robotics
	name = "Robotics R&D Server"
	id_with_upload_string = "1;2"
	id_with_download_string = "1;2"
	server_id = 2

/obj/machinery/r_n_d/server/core
	name = "Core R&D Server"
	id_with_upload_string = "1;3"
	id_with_download_string = "1;3"
	server_id = 1
