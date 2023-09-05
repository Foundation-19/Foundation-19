/client/proc/smite(mob/living/target as mob)
	set category = "Fun"
	set name = "Smite"
	if(!check_rights(R_ADMIN) || !check_rights(R_FUN))
		return

	var/punishment = input("Choose a punishment", "DIVINE SMITING") as null|anything in subtypesof(/datum/smite)

	if(QDELETED(target) || !punishment)
		return

	var/datum/smite/smite = new punishment
	var/configuration_success = smite.configure(usr)
	if (configuration_success == FALSE)
		return
	smite.effect(src, target)
