// Abstract type for jobtime record providers

/datum/job_record_reader

/datum/job_record_reader/New()
	CRASH("abstract - must be overridden")

/datum/job_record_reader/proc/get_version()
	CRASH("abstract - must be overridden")

/datum/job_record_reader/proc/read(key)
	CRASH("abstract - must be overridden")

/datum/job_record_reader/proc/copy_to(datum/job_record_writer/json_list/W)
	CRASH("abstract - must be overridden")

// Abstract type for jobtime record writers
/datum/job_record_writer

/datum/job_record_writer/New()
	CRASH("abstract - must be overridden")

/datum/job_record_writer/proc/write(key, val)
	CRASH("abstract - must be overridden")

// jobtime reader for assoc lists
// Version should be in the "__VERSION" key
/datum/job_record_reader/json_list
	var/list/data

/datum/job_record_reader/json_list/New(list/data)
	src.data = data
	ASSERT(istype(data))
	ASSERT(isnum(get_version()))

/datum/job_record_reader/json_list/get_version()
	return read("__VERSION")

/datum/job_record_reader/json_list/read(key)
	return data[key]

/datum/job_record_reader/json_list/copy_to(datum/job_record_writer/json_list/W)
	for(var/dat in data)
		W.write(dat, data[dat])

// Null jobtime reader
// Returns null for all keys; used when initializing records
/datum/job_record_reader/null
	var/version

/datum/job_record_reader/null/New(version)
	src.version = version

/datum/job_record_reader/null/get_version()
	return version

/datum/job_record_reader/null/read(key)
	return null


// jobtime writer for assoc lists
// Version should be passed in, will be placed in "__VERSION"
/datum/job_record_writer/json_list
	var/list/data

/datum/job_record_writer/json_list/New(version)
	ASSERT(isnum(version))
	data = list("__VERSION"=version)

/datum/job_record_writer/json_list/write(key, val)
	data[key] = val


