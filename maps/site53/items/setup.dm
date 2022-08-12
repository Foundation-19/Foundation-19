/datum/controller/subsystem/setup/proc/setupSCPs()
	var/list/SCPs = subtypesof(/datum/scp)
	for(var/i in 1 to SCPs.len)
		var/path = SCPs[i]   //They don't like it if you put it in one line
		var/datum/scp/SCP = new path()
		GLOB.SCP_list += list(SCP.designation = SCP.type)
/*	for(var/i in 1 to GLOB.SCP_list.len)
		world < "<span class='notice'><b>&#91;DEBUG&#93;</b>SCP-[GLOB.SCP_list[i]] sucesfully initialized as [GLOB.SCP_list[GLOB.SCP_list[i]]].</span>"
*/
