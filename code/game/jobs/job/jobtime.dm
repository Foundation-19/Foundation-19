/datum/jobtime
	var/list/jobtime_list //raw db list of jobs and associated playtime tracked
	var/client/parentclient //parent client of the datum

/datum/jobtime/New(client/pclient)
	parentclient = pclient
	update_jobtime()
	..()

/datum/jobtime/proc/update_jobtime() //updates our play time from DB
	jobtime_list = parentclient.get_jobtime_list_db()

	for(var/jtitle in jobtime_list) //checks and calculates sub categories and department times
		var/datum/job/jtype = SSjobs.get_by_title(jtitle)
		if(!jtype || !LAZYLEN(jtype.get_flags_to_exp()))
			continue
		for(var/category in jtype.get_flags_to_exp())
			jobtime_list[category] += jobtime_list[jtitle]

/datum/jobtime/proc/get_jobtime_by_job(datum/job/tjob)
	return jobtime_list[tjob.title]

/datum/jobtime/proc/get_jobtime_by_title(job_title)
	return jobtime_list[job_title]

/datum/jobtime/proc/get_jobtime_by_path(job_path)
	var/datum/job/current_job = SSjobs.get_by_path(job_path)
	return jobtime_list[current_job.title]

/datum/jobtime/proc/get_jobtime_by_category(category)
	return FALSE

/mob/verb/get_playtime_current()
	set name = "Get Playtime"
	set category = "OOC"

	var/datum/jobtime/jb = src.client.jobtime
	jb.update_jobtime()
	for(var/job in jb.jobtime_list)
		to_chat(src, "[job] : [jb.get_jobtime_by_title(job)]")

