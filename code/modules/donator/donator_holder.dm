/datum/donator/
	var/flags = 0
	var/client/client

	New(var/client/C, var/flgs = 0)
		client = C
		add_flags(flgs)

	proc/add_flags(var/flgs)
		if(flgs & D_DOOC)
			client.verbs += /client/proc/dooc
			client.verbs += /client/proc/dcolorooc
		flags |= flgs

	proc/remove_flags(var/flgs)
		if(flgs & D_DOOC)
			client.verbs -= /client/proc/dcolorooc
			client.verbs -= /client/proc/dooc
		flags &= ~flgs