/client/proc/restart_controller(controller in list("Master", "Failsafe"))
	set category = "Debug"
	set name = "Restart Controller"
	var/client/client = usr?.client
	if(!check_rights(R_ADMIN, TRUE, client))
		return
	if(controller == "Master")
		Recreate_MC()
	else if(controller == "Failsafe")
		new /datum/controller/failsafe
	message_staff("[key_name_admin(client)] has restarted the [controller] controller.")
