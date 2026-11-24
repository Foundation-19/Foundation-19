/*
	Telecomms monitor tracks the overall trafficing of a telecommunications network
	and displays a heirarchy of linked machines.
*/


/obj/machinery/computer/telecomms/monitor
	name = "Telecommunications Monitor"
	icon_screen = "comm_monitor"
	machine_name = "telecomms monitor console"
	machine_desc = "Tracks the traffic of a telecommunications network, and maintains information about connected machines."

	var/screen = 0				// the screen number:
	var/list/machinelist = list()	// the machines located by the computer
	var/obj/machinery/telecomms/SelectedMachine

	var/network = "NULL"		// the network to probe

	var/temp = ""				// temporary feedback messages

/obj/machinery/computer/telecomms/monitor/interface_interact(mob/user)
	if(stat & (BROKEN|NOPOWER))
		return TRUE
	tgui_interact(user)
	return TRUE


/obj/machinery/computer/telecomms/monitor/tgui_interact(mob/user, datum/tgui/ui)
	if(stat & (BROKEN|NOPOWER))
		return
	user.set_machine(src)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Telemonitor", "Telecommunications Monitor")
		ui.open()


/obj/machinery/computer/telecomms/monitor/tgui_data(mob/user)
	var/list/data = list()
	data["screen"] = screen
	data["network"] = network
	data["temp"] = temp
	temp = ""
	var/list/machines = list()
	if(screen == 0)
		for(var/obj/machinery/telecomms/T in machinelist)
			machines += list(list("id" = T.id, "name" = T.name))
	data["machines"] = machines
	if(screen == 1 && SelectedMachine)
		data["selected"] = list("id" = SelectedMachine.id, "name" = SelectedMachine.name)
		var/list/linked = list()
		for(var/obj/machinery/telecomms/T in SelectedMachine.links)
			if(!T.hide)
				linked += list(list("id" = T.id, "name" = T.name))
		data["links"] = linked
	else
		data["selected"] = null
		data["links"] = list()
	return data


/obj/machinery/computer/telecomms/monitor/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	switch(action)
		if("viewmachine")
			screen = 1
			for(var/obj/machinery/telecomms/T in machinelist)
				if(T.id == params["id"])
					SelectedMachine = T
					break
			return TRUE
		if("operation")
			switch(params["operation"])
				if("release")
					machinelist = list()
					screen = 0
				if("mainmenu")
					screen = 0
				if("probe")
					if(machinelist.len > 0)
						temp = "<font color = #d70b00>- FAILED: CANNOT PROBE WHEN BUFFER FULL -</font>"
					else
						for(var/obj/machinery/telecomms/T in range(25, src))
							if(T.network == network)
								machinelist.Add(T)
						if(!machinelist.len)
							temp = "<font color = #d70b00>- FAILED: UNABLE TO LOCATE NETWORK ENTITIES IN \[[network]\] -</font>"
						else
							temp = "<font color = #336699>- [machinelist.len] ENTITIES LOCATED & BUFFERED -</font>"
						screen = 0
			return TRUE
		if("network")
			var/newnet = input(usr, "Which network do you want to view?", "Comm Monitor", network) as null|text
			if(newnet && ((usr in range(1, src) || issilicon(usr))))
				if(length(newnet) > 15)
					temp = "<font color = #d70b00>- FAILED: NETWORK TAG STRING TOO LENGHTLY -</font>"
				else
					network = newnet
					screen = 0
					machinelist = list()
					temp = "<font color = #336699>- NEW NETWORK TAG SET IN ADDRESS \[[network]\] -</font>"
			return TRUE
	return FALSE

/obj/machinery/computer/telecomms/monitor/emag_act(remaining_charges, mob/user)
	if(!emagged)
		playsound(src.loc, 'sounds/effects/sparks4.ogg', 75, 1)
		emagged = TRUE
		req_access.Cut()
		to_chat(user, SPAN_NOTICE("You you disable the security protocols"))
		SStgui.update_uis(src)
		return 1
