/datum/jobtime
	var/list/jobtime_list //raw db list of jobs and associated playtime tracked
	var/client/parentclient //parent client of the datum

	var/last_updated_jl //last time jobtime_list was updated

/datum/jobtime/New(client/pclient)
	parentclient = pclient
	update_jobtime(FALSE)
	..()

/datum/jobtime/proc/update_jobtime(check_cooldown = TRUE) //updates our play time from DB. You must call this beforehand if you are using any of the get_jobtime procs or accessing jobtime_list.
	if((world.time - last_updated_jl < 1 MINUTE) && check_cooldown) //updating the jobtime list requires an SQL query which takes time, this prevents update_jobtime() from firing more than once per minute, as we can assume there have not been any significant changes in the db within that time.
		return FALSE

	jobtime_list = parentclient.get_jobtime_list_db()

	for(var/jtitle in jobtime_list) //checks and calculates sub categories and department times
		var/datum/job/jtype = SSjobs.get_by_title(jtitle)
		if(!jtype || !LAZYLEN(jtype.get_flags_to_exp()))
			continue
		for(var/category in jtype.get_flags_to_exp())
			jobtime_list[category] += jobtime_list[jtitle]

	last_updated_jl = world.time

/datum/jobtime/proc/get_jobtime_by_job(datum/job/tjob)
	if(!tjob)
		return 0
	return jobtime_list[tjob.title] ? jobtime_list[tjob.title] : 0

/datum/jobtime/proc/get_jobtime(job_title) //use title or category for this ONLY
	if(!job_title)
		return 0
	return jobtime_list[job_title] ? jobtime_list[job_title] : 0

/datum/jobtime/proc/get_jobtime_by_path(job_path)
	if(!job_path)
		return 0
	var/datum/job/current_job = SSjobs.get_by_path(job_path)
	return jobtime_list[current_job.title] ? jobtime_list[current_job.title] : 0

/mob/verb/get_playtime_current()
	set name = "See Playtime"
	set category = "OOC"

	var/datum/jobtime/jb = src.client.jobtime
	if(!jb || !SSdbcore.IsConnected())
		to_chat(src, SPAN_WARNING("Player time tracking data could not be retrieved!"))
		return

	jb.update_jobtime()
	to_chat(src, SPAN_BOLD("+---------([ckey]'s Playtime)---------+"))
	for(var/job in jb.jobtime_list)
		to_chat(src, "|[SPAN_CLASS("notice", "[job]")] played for [SPAN_CLASS("notice", "[jb.get_jobtime(job)] Minutes")]")
	to_chat(src, SPAN_BOLD("+-------------------------------------+"))
