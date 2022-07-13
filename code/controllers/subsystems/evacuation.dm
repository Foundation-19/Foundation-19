SUBSYSTEM_DEF(evacuation)
	name = "Evacuation"
	priority = SS_PRIORITY_EVACUATION
	init_order = SS_INIT_EVACUATION
	flags = SS_BACKGROUND
	runlevels = RUNLEVEL_GAME
	wait = 2 SECONDS

/datum/controller/subsystem/evacuation/Initialize()
	if(!evacuation_controller)
		evacuation_controller = new GLOB.using_map.evac_controller_type
		evacuation_controller.set_up()
	return ..()

/datum/controller/subsystem/evacuation/fire()
	evacuation_controller.process()
