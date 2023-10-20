#define SETUP_OK 1			// All good
#define SETUP_WARNING 2		// Something that shouldn't happen happened, but it's not critical so we will continue
#define SETUP_ERROR 3		// Something bad happened, and it's important so we won't continue setup.
#define SETUP_DELAYED 4		// Wait for other things first.

/datum/admins/proc/setup_fusion()
	set category = "Debug"
	set name = "Setup Fusion Core"
	set desc = "Allows you to start the R-UST engine."

	if (!istype(src,/datum/admins))
		src = usr.client.holder
	if (!istype(src,/datum/admins))
		to_chat(usr, "Error: you are not an admin!")
		return

	if(!(locate(/obj/machinery/power/fusion_core/mapped) in world))
		to_chat(usr, "This map is not appropriate for this verb.")
		return

	var/response = input(usr, "Are you sure?", "Engine setup") as null|anything in list("No", "Yes")
	if(!response || response == "No")
		return

	log_and_message_staff("## FUSION CORE SETUP - Setup initiated by [usr].")

	for(var/obj/machinery/fusion_fuel_injector/mapped/injector in SSmachines.machinery)
		injector.cur_assembly = new /obj/item/fuel_assembly/deuterium(injector)
		injector.BeginInjecting()

	var/obj/machinery/power/fusion_core/mapped/core = locate() in SSmachines.machinery
	if(!core.jumpstart(15000))
		log_and_message_staff("## FUSION CORE SETUP - Error encountered!")

#undef SETUP_OK
#undef SETUP_WARNING
#undef SETUP_ERROR
#undef SETUP_DELAYED
