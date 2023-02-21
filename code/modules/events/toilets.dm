/datum/event/toilet_clog
	var/clog_amount = severity^2 + 1
	var/clog_severity_min = 1
	var/clog_severity_max = severity

/datum/event/toilet_clog/start()
	var/list/toilets = SSfluids.hygiene_props.Copy()
	while(clog_amount && toilets.len)
		var/obj/structure/hygiene/toilet = pick_n_take(toilets)
		if((toilet.z in affecting_z) && toilet.clog(rand(clog_severity_min, clog_severity_max))) clog_amount--
