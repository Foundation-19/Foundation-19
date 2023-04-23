#define JOB_SER_VERSION 1

/datum/jobtime/proc/get_path(ckey, record_key, extension="json")
	return "data/player_saves/[copytext(ckey,1,2)]/[ckey]/[record_key].[extension]"

// Returns null if there's no record file. Crashes on other error conditions.
/datum/jobtime/proc/load_job_record(record_key)
	var/path = get_path(client_ckey, record_key)
	if(!fexists(path))
		return null
	var/text = file2text(path)
	if(text == null)
		CRASH("failed to read [path]")
	var/list/data = json_decode(text)
	if(!istype(data))
		CRASH("failed to decode JSON from [path]")
	return new /datum/job_record_reader/json_list(data)

/datum/jobtime/proc/save_job_record(record_key, list/data)
	var/path = get_path(client_ckey, record_key)
	var/text = json_encode(data)
	if(text == null)
		CRASH("failed to encode JSON for [path]")

	// Why this dance? If text2file fails, we want to leave the record as it was.

	var/tmp_path = "[path].tmp"
	// If we crashed at the end previously, we'll have a junk tmpfile, which text2file would append to.
	if(fexists(tmp_path))
		if(!fdel(tmp_path))
			CRASH("failed to remove junk existing tmpfile at [tmp_path]")
	if(!text2file(text,tmp_path))
		CRASH("failed to write record to tmpfile at [tmp_path]")
	if(!fcopy(tmp_path, path))
		CRASH("failed to copy tmpfile at [tmp_path] to [path]")
	if(!fdel(tmp_path))
		CRASH("failed to remove tmpfile at [tmp_path]")

/datum/jobtime/proc/load_job_time()
	var/datum/job_record_reader/R = load_job_record("jobtime")
	if(!R)
		R = new /datum/job_record_reader/null(JOB_SER_VERSION)
	for(var/job in jobtimes)
		jobtimes[job] = NULL_ZERO(R.read(job)) //if we havent played the job before we set it to zero

/datum/jobtime/proc/save_job_time()
	var/datum/job_record_writer/json_list/W = new(JOB_SER_VERSION)

	var/datum/job_record_reader/R = load_job_record("jobtime") //This is done because as maps have different jobtypes we dont want to wipe jobtimes for jobs that arent present on that map
	if(R)
		R.copy_to(W)

	for(var/job in jobtimes)
		W.write("[job]", jobtimes[job])
	save_job_record("jobtime", W.data)

/datum/jobtime/proc/sanitize_jobtime()
	//player_setup.sanitize_setup()
	return 1

#undef JOB_SER_VERSION
