/datum/admin_secret_item/fun_secret/break_all_lights
	name = "Break All Lights"

/datum/admin_secret_item/fun_secret/break_all_lights/execute(mob/user)
	. = ..()
	if(.)
		for (var/datum/powernet/PN in SSmachines.powernets)
			PN.apcs_overload(overload_chance = 100)
