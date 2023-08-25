/mob/living/death(gibbed, deathmessage = "seizes up and falls limp...", show_dead_message = "You have died.")

	SEND_SIGNAL(src, COMSIG_LIVING_DEATH, gibbed)
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_MOB_DEATH, src, gibbed)

	if(hiding)
		hiding = FALSE
	. = ..()
