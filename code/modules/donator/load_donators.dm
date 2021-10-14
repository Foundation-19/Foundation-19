GLOBAL_LIST_EMPTY(donator_keys)
GLOBAL_LIST_EMPTY(donators)

/hook/startup/proc/loadDonators()
	load_donators()
	return 1

proc/load_donators()
	GLOB.donator_keys.Cut()

	for(var/client/C in GLOB.donators)
		C.donator_holder.remove_flags(C.donator_holder.flags)
		C.donator_holder = null
	GLOB.donators.Cut()

	//load text from file
	var/list/Lines = file2list("config/donators.txt")

	//process each line seperately
	for(var/line in Lines)
		if(!length(line))				continue
		if(copytext(line,1,2) == "#")	continue

		//Split the line at every "-"
		var/list/List = splittext(line, " - ")  //fuck you, sincereley Time-Green
		if(!List.len)					continue

		//ckey is before the first "-"
		var/ckey = ckey(List[1])
		if(!ckey)						continue

		//rank follows the first "-"
		var/rank = ""
		if(List.len >= 2)
			rank = ckeyEx(List[2])

		//load permissions associated with this rank
		var/perms = 0
		if(rank == "donator")
			perms |= D_TAG + D_OOCCOLOUR + D_DOOC

		var/datum/donator/D = new /datum/donator(GLOB.ckey_directory[ckey], perms)

		//find the client for a ckey if they are connected and associate them with the new admin datum
		GLOB.donators += D.client
		GLOB.donator_keys[ckey] = perms
	WRITE_LOG(world.log, "FINISHED LOADING DONATORS...")