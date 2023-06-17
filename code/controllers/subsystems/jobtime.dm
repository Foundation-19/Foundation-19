SUBSYSTEM_DEF(jobtime)
	name = "Job Time Tracker"
	flags = SS_NO_TICK_CHECK
	wait = 50
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	init_order = SS_INIT_JOBTIME
	priority = SS_PRIORITY_JOBTIME

	var/last_fired


/datum/controller/subsystem/jobtime/Initialize()
	if(!SSdbcore.IsConnected())
		log_world("Jobtime tracking cannot function when DB is disconnected!")
	last_fired = world.time

/datum/controller/subsystem/jobtime/fire()
	update_jobtime(world.time - last_fired)
	last_fired = world.time

/datum/controller/subsystem/jobtime/proc/update_jobtime_db()
	set waitfor = FALSE
	var/list/old_minutes = GLOB.jobtime_to_update
	GLOB.jobtime_to_update = null
	SSdbcore.MassInsert(format_table_name("role_time"), old_minutes, duplicate_key = "ON DUPLICATE KEY UPDATE minutes = minutes + VALUES(minutes)")

/datum/controller/subsystem/jobtime/proc/update_jobtime(mins)
	if(!SSdbcore.Connect())
		return -1
	for(var/client/L in GLOB.clients)
		if(L.is_afk())
			continue
		L.update_jobtime_list(mins)

//Client Procs

/client/proc/update_jobtime_list(minutes) //this is stolen from fulp :/
	//if(!CONFIG_GET(flag/use_exp_tracking))
		//return -1
	if(!SSdbcore.Connect())
		return -1
	if (!isnum(minutes))
		return -1

	var/list/play_records = list()

	if(isobserver(mob))
		play_records[EXP_TYPE_GHOST] = minutes
	else if(isliving(mob))
		var/mob/living/living_mob = mob
		var/list/mob_exp_list = living_mob.get_exp_list(minutes)
		if(!length(mob_exp_list))
			play_records["Unknown"] = minutes
		else
			play_records |= mob_exp_list

		play_records[EXP_TYPE_LIVING] = minutes
	// Lobby surfing? /mob/dead/new_player? Not worth any exp!
	else
		return

	if(check_rights(R_ADMIN, FALSE, src))
		play_records[EXP_TYPE_ADMIN] = minutes

	for(var/jtype in play_records)
		var/jvalue = play_records[jtype]
		if (!jvalue)
			continue
		if (!isnum(jvalue))
			CRASH("invalid job value [jtype]:[jvalue]")
		LAZYINITLIST(GLOB.jobtime_to_update)
		GLOB.jobtime_to_update.Add(list(list(
			"job" = jtype,
			"ckey" = ckey,
			"minutes" = jvalue)))
		//prefs.exp[jtype] += jvalue
	addtimer(CALLBACK(SSjobtime, /datum/controller/subsystem/jobtime/proc/update_jobtime_db),20,TIMER_OVERRIDE|TIMER_UNIQUE)

/client/proc/get_jobtime_list_db()
	//if(!CONFIG_GET(flag/use_exp_tracking))
		//return -1
	if(!SSdbcore.Connect())
		return -1
	var/datum/db_query/exp_read = SSdbcore.NewQuery(
		"SELECT job, minutes FROM [format_table_name("role_time")] WHERE ckey = :ckey",
		list("ckey" = ckey)
	)
	if(!exp_read.Execute(async = TRUE))
		qdel(exp_read)
		return -1
	var/list/play_records = list()
	while(exp_read.NextRow())
		play_records[exp_read.item[1]] = text2num(exp_read.item[2])
	qdel(exp_read)

	var/list/valid_jobs = SSjobs.job_lists_by_map_name[GLOB.using_map.full_name]
	valid_jobs = valid_jobs["jobs"]

	for(var/datum/job/jtype in valid_jobs)
		if(!play_records[jtype.title])
			play_records[jtype.title] = 0

	return play_records
