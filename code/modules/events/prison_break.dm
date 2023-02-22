/datum/event/prison_break
	startWhen		= 5
	announceWhen	= 75

	var/releaseWhen = 60
	var/list/area/areas = list()		// List of areas to affect. Filled by start()

	// Chosen from a random prisonbreakarea datum on setup()
	var/eventDept					// Department name in announcement
	var/areaName					// Name of areas mentioned in AI and Engineering announcements
	var/list/areaType = list()		// Area types to include.
	var/list/areaNotType = list()	// Area types to specifically exclude.

/datum/event/prison_break/setup()

	var/d = pick(subtypesof(/datum/prisonbreakarea))
	var/datum/prisonbreakarea/D = new d

	eventDept = D.eventdept
	areaName = D.areaname
	areaType = D.areatype
	areaNotType = D.areanottype

	announceWhen = rand(50, 80) + (severity * 5)
	releaseWhen = rand(85, 115) - (severity * 5)

	src.endWhen = src.releaseWhen+2


/datum/event/prison_break/announce()
	if(areas && areas.len > 0)
		command_announcement.Announce("[pick("Gr3yT1d3 virus","Malignant trojan")] detected in [eventDept] environmental subroutines. Secure any compromised areas immediately.", "[location_name()] Anti-Virus Alert", zlevels = affecting_z)


/datum/event/prison_break/start()

	for(var/area/A in world)
		if(is_type_in_list(A,areaType) && !is_type_in_list(A,areaNotType))
			areas += A

	if(areas && areas.len > 0)
		var/sender = "[location_name()] Firewall Subroutines"
//		not only does engineering not HAVE a request console, request consoles appear to not even function correctly.
		var/rc_message = "An unknown malicious program has been detected in the [areaName] lighting and airlock control systems at [station_time_timestamp("hh:mm")]. Systems will be fully compromised within approximately three minutes. Direct intervention is required immediately.<br>"
		var/obj/machinery/message_server/MS = get_message_server()
		if(MS)
			MS.send_rc_message("Comms Officer", sender, rc_message, "", "", 2)
		for(var/mob/living/silicon/ai/A in GLOB.player_list)
			to_chat(A, "<span class='danger'>Malicious program detected in the [areaName] lighting and airlock control systems by [sender].</span>")

	else
		to_world_log("ERROR: Could not initate grey-tide. Unable to find suitable containment area.")
		kill()


/datum/event/prison_break/tick()
	if(activeFor == releaseWhen)
		if(areas && areas.len > 0)
			var/obj/machinery/power/apc/theAPC = null
			for(var/area/A in areas)
				theAPC = A.get_apc()
				if(theAPC && theAPC.operating)	//If the apc's off, it's a little hard to overload the lights.
					for(var/obj/machinery/light/L in A)
						L.flicker(10)


/datum/event/prison_break/end()
	for(var/area/A in shuffle(areas))
		A.prison_break()

/datum/prisonbreakarea
	var/eventdept
	var/areaname
	var/list/areatype
	var/list/areanottype

// Prison break area datums

/datum/prisonbreakarea/engineering
	eventdept = "Engineering"
	areaname = "Engineering"
	areatype = list(/area/site53/engineering)
	areanottype = list(
		/area/site53/engineering/maintenance,
		/area/site53/engineering/selfdestruct,
		/area/site53/engineering/lowernukeladders,
		/area/site53/engineering/uppernukeladders
	)

/datum/prisonbreakarea/medbay
	eventdept = "Medical"
	areaname = "Medbay"
	areatype = list(/area/site53/medical)
	areanottype = list(
		/area/site53/medical/mentalhealth/isolation,
		/area/site53/medical/isolation
	)

/datum/prisonbreakarea/research
	eventdept = "Research"
	areaname = "Research Wing"
	areatype = list(
		/area/site53/reswing,
		/area/site53/science
	)
	areanottype = list(
		/area/site53/reswing/xenobiology,
		/area/site53/science/aicobservation,
		/area/site53/science/aiccore
	)

/datum/prisonbreakarea/logistics
	eventdept = "Logistics"
	areaname = "Logistics"
	areatype = list(/area/site53/logistics)
	areanottype = list()

/datum/prisonbreakarea/lightcontainmentzone
	eventdept = "Light Containment Zone"
	areaname = "LCZ Hallways"
	areatype = list(
		/area/site53/ulcz/hallways,
		/area/site53/llcz/hallways
	)
	areanottype = list()

/datum/prisonbreakarea/heavycontainmentzone
	eventdept = "Heavy Containment Zone"
	areaname = "HCZ Hallways"
	areatype = list(
		/area/site53/uhcz/hallways,
		/area/site53/lhcz/hallway
	)
	areanottype = list()
