GLOBAL_LIST_EMPTY(scp_whitelist)

/hook/startup/proc/loadSCPWhitelist()

	GLOB.scp_whitelist.Cut()

	//load text from file
	var/list/lines = file2list("config/scp_whitelist.txt")

	//process each line seperately
	for(var/line in lines)
		if(!length(line))				continue
		if(copytext(line,1,2) == "#")	continue

		//Split the line at every "-"
		var/list/L = splittext(line, " - ")
		if(L.len < 2)					continue

		//ckey is before the first "-"
		var/ckey = ckey(L[1])
		if(!ckey)						continue

		//scp follows the first "-"
		var/scp = ""
		if(L.len >= 2)
			scp = ckeyEx(L[2])

		if (!GLOB.scp_whitelist[ckey])
			GLOB.scp_whitelist[ckey] = list()

		GLOB.scp_whitelist[ckey] |= scp

	WRITE_LOG(world.log, "FINISHED LOADING THE SCP WHITELIST")