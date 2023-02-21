/datum/event/toilet_clog
	var/clog_amount
	var/clog_severity_min
	var/clog_severity_max

/datum/event/toilet_clog/start()

	clog_amount = severity^2 + 1
	clog_severity_min = 1
	clog_severity_max = severity

	var/list/toilets = SSfluids.hygiene_props.Copy()
	while(clog_amount && toilets.len)
		var/obj/structure/hygiene/toilet = pick_n_take(toilets)
		if((toilet.z in affecting_z) && toilet.clog(rand(clog_severity_min, clog_severity_max))) clog_amount--
