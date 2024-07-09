/proc/_log_admin(text)
	GLOB.admin_log.Add(text)
	if (config.log_admin)
		game_log("ADMIN", text)
