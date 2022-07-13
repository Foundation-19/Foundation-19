/datum/component/scp
	var/datum/scp/SCP
	var/atom/owner

/datum/component/scp/New(datum/P, ...)
	. = ..()
	if(isdatum(args[2]))
		SCP = args[2]
	if(isatom(args[3]))
		owner = args[3]
