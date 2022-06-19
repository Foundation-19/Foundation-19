/datum/event/communications_blackout/announce()
	var/alert = pick(	"Warning! System failure, local telecommunications tower power net undergoing failure, please remain calm as the system reboots.", \
						"Warn*w7ng! System ###lure, local telecommunications tower {39810} undergoing fail----ure, please remain calm as the system )(*$%¨$#.", \
						"Warn*w7ng! System failure, local tel&%$#%¨$@", \
						"Failu341241re, local telecommunications tower'fZ\\kg5_0-BZZZZZT", \
						"teleco:%£ MCayj^j<.3-BZZZZZZT", \
						"#4nd%;f4y6,>£%-BZZZZZZZT")

	for(var/mob/living/silicon/ai/A in GLOB.player_list)	//AIs are always aware of communication blackouts.
		if(A.z in affecting_z)
			to_chat(A, "<br>")
			to_chat(A, "<span class='warning'><b>[alert]</b></span>")
			to_chat(A, "<br>")

	if(prob(80))	//Announce most of the time, just not always to give some wiggle room for possible sabotages.
		command_announcement.Announce(alert, new_sound = sound('sound/misc/interference.ogg', volume=25), zlevels = affecting_z)


/datum/event/communications_blackout/start()
	for(var/obj/machinery/telecomms/T in telecomms_list)
		if(T.z in affecting_z)
			if(prob(T.outage_probability))
				T.overloaded_for = max(severity * rand(90, 120), T.overloaded_for)

