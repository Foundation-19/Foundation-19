/obj/item/modular_computer/console/preset/chatserver/install_default_programs()
	..()
	var/datum/computer_file/program/chatserver/server = new()
	hard_drive.store_file(server)

	turn_on()
	run_program(server.filename)

	server.server_name = "SCiPnet Chatroom"

	server.req_accesses_sysadmin = list(ACCESS_NETWORK)

	for(var/thing in subtypesof(/datum/chatserver_channel/template))
		var/datum/chatserver_channel/template/channel = new thing(server)

		server.channel_list += channel

	server.set_hosting(TRUE)

/*
 * Channel templates
*/

/datum/chatserver_channel/template/common
	title = "Site-wide"
	req_accesses_admin = list(ACCESS_NETWORK)

/datum/chatserver_channel/template/admin
	title = "Admin"
	req_accesses_user = list(ACCESS_ADMIN_LVL2)
	req_accesses_admin = list(ACCESS_NETWORK)

/datum/chatserver_channel/template/engineering
	title = "Engineering"
	req_accesses_user = list(ACCESS_ENGINEERING_LVL1)
	req_accesses_admin = list(ACCESS_NETWORK)

/datum/chatserver_channel/template/medical
	title = "Medical"
	req_accesses_user = list(ACCESS_MEDICAL_LVL1)
	req_accesses_admin = list(ACCESS_NETWORK)

/datum/chatserver_channel/template/science
	title = "Science"
	req_accesses_user = list(ACCESS_SCIENCE_LVL1)
	req_accesses_admin = list(ACCESS_NETWORK)

/datum/chatserver_channel/template/security
	title = "Security"
	req_accesses_user = list(ACCESS_SECURITY_LVL1)
	req_accesses_admin = list(ACCESS_NETWORK)

