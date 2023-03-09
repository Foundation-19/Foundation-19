/proc/report_progress(progress_message)
	admin_notice(SPAN_CLASS("boldannounce","[progress_message]"), R_DEBUG)
	to_world_log(progress_message)
