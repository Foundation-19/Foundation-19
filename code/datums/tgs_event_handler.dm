
/datum/tgs_event_handler/impl
	var/datum/timedevent/reattach_timer

/datum/tgs_event_handler/impl/HandleEvent(event_code, ...)
	switch(event_code)
		if(TGS_EVENT_REBOOT_MODE_CHANGE)
			var/list/reboot_mode_lookup = list ("[TGS_REBOOT_MODE_NORMAL]" = "be normal", "[TGS_REBOOT_MODE_SHUTDOWN]" = "shutdown the server", "[TGS_REBOOT_MODE_RESTART]" = "hard restart the server")
			var/old_reboot_mode = args[2]
			var/new_reboot_mode = args[3]
			message_staff("TGS: Reboot will no longer [reboot_mode_lookup["[old_reboot_mode]"]], it will instead [reboot_mode_lookup["[new_reboot_mode]"]]")
		if(TGS_EVENT_PORT_SWAP)
			message_staff("TGS: Changing port from [world.port] to [args[2]]")
		if(TGS_EVENT_INSTANCE_RENAMED)
			message_staff("TGS: Instance renamed to from [world.TgsInstanceName()] to [args[2]]")
		if(TGS_EVENT_COMPILE_START)
			message_staff("TGS: Deployment started, new game version incoming...")
		if(TGS_EVENT_COMPILE_CANCELLED)
			message_staff("TGS: Deployment cancelled!")
		if(TGS_EVENT_COMPILE_FAILURE)
			message_staff("TGS: Deployment failed!")
		if(TGS_EVENT_DEPLOYMENT_COMPLETE)
			message_staff("TGS: Deployment complete!")
			to_chat(world, SPAN_CLASS("boldannounce","Server updated, changes will be applied on the next round..."))
		if(TGS_EVENT_WATCHDOG_DETACH)
			message_staff("TGS restarting...")
			reattach_timer = addtimer(CALLBACK(src, PROC_REF(LateOnReattach)), 1 MINUTES, TIMER_STOPPABLE)
		if(TGS_EVENT_WATCHDOG_REATTACH)
			var/datum/tgs_version/old_version = world.TgsVersion()
			var/datum/tgs_version/new_version = args[2]
			if(!old_version.Equals(new_version))
				to_chat(world, SPAN_CLASS("boldannounce","TGS updated to v[new_version.deprefixed_parameter]"))
			else
				message_staff("TGS: Back online")
			if(reattach_timer)
				deltimer(reattach_timer)
				reattach_timer = null
		if(TGS_EVENT_WATCHDOG_SHUTDOWN)
			to_chat_immediate(world, SPAN_CLASS("boldannounce","Server is shutting down!"))

/datum/tgs_event_handler/impl/proc/LateOnReattach()
	message_staff("Warning: TGS hasn't notified us of it coming back for a full minute! Is there a problem?")
