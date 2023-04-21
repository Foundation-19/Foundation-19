/datum/event/prison_break
	startWhen		= 5
	announceWhen	= 75

	var/releaseWhen = 60
	var/list/area/areas = list()		// List of areas to affect. Filled by start()

	// Chosen from a random prisonbreakarea datum on setup()
	var/datum/prisonbreakarea/chosen_area

/datum/event/prison_break/setup()

	var/d = pick(subtypesof(/datum/prisonbreakarea))
	chosen_area = new d

	// severity affects how much time there is to prepare
	announceWhen = rand(50, 80) + (severity * 5)
	releaseWhen = rand(85, 115) - (severity * 5)

	src.endWhen = src.releaseWhen+2


/datum/event/prison_break/announce()
	if(areas && areas.len > 0)
		command_announcement.Announce("[pick("Gr3yT1d3 virus","Malignant trojan")] detected in [chosen_area.eventDept] environmental subroutines. Secure any compromised areas immediately.", "[location_name()] Anti-Virus Alert", zlevels = affecting_z)


/datum/event/prison_break/start()

	for(var/area/A in world)
		if(is_type_in_list(A,chosen_area.areaType) && !is_type_in_list(A,chosen_area.areaNotType))
			areas += A

	if(areas && areas.len > 0)
		var/sender = "[location_name()] Firewall Subroutines"
		var/rc_message = "An unknown malicious program has been detected in the [chosen_area.areaName] lighting and airlock control systems at [station_time_timestamp("hh:mm")]. Systems will be fully compromised within approximately three minutes. Direct intervention is required immediately.<br>"
		var/obj/machinery/message_server/MS = get_message_server()
		if(MS)
			MS.send_rc_message("Engineering", sender, rc_message, "", "", 2)
		for(var/mob/living/silicon/ai/A in GLOB.player_list)
			to_chat(A, SPAN_DANGER("Malicious program detected in the [chosen_area.areaName] lighting and airlock control systems by [sender]."))

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
	var/eventDept
	var/areaName
	var/list/areaType
	var/list/areaNotType

// Prison break area datums

/datum/prisonbreakarea/engineering
	eventDept = "Engineering"
	areaName = "Engineering"
	areaType = list(/area/site53/engineering)
	areaNotType = list(
		/area/site53/engineering/maintenance,
		/area/site53/engineering/selfdestruct,
		/area/site53/engineering/lowernukeladders,
		/area/site53/engineering/uppernukeladders
	)

/datum/prisonbreakarea/medbay
	eventDept = "Medical"
	areaName = "Medbay"
	areaType = list(/area/site53/medical)
	areaNotType = list(
		/area/site53/medical/mentalhealth/isolation,
		/area/site53/medical/isolation
	)

/datum/prisonbreakarea/research
	eventDept = "Research"
	areaName = "Research Wing"
	areaType = list(
		/area/site53/reswing,
		/area/site53/science
	)
	areaNotType = list(
		/area/site53/reswing/xenobiology,
		/area/site53/science/aicobservation,
		/area/site53/science/aiccore
	)

/datum/prisonbreakarea/lightcontainmentzone
	eventDept = "Light Containment Zone"
	areaName = "LCZ Hallways"
	areaType = list(
		/area/site53/ulcz/hallways,
		/area/site53/llcz/hallways
	)
	areaNotType = list()

/datum/prisonbreakarea/heavycontainmentzone
	eventDept = "Heavy Containment Zone"
	areaName = "HCZ Hallways"
	areaType = list(
		/area/site53/uhcz/hallways,
		/area/site53/lhcz/hallway
	)
	areaNotType = list()

/datum/prisonbreakarea/entrancezone
	eventDept = "Entrance Zone"
	areaName = "EZ Area"
	areaType = list(
		/area/site53/uez
		)
