/obj/item/modular_computer/console/preset/chatserver/install_default_programs()
	..()
	var/datum/computer_file/program/chatserver/server = new()
	hard_drive.store_file(server)

	turn_on()
	run_program(server.filename)

	server.server_name = "SCiPnet Chatroom"

	for(var/thing in subtypesof(/datum/chatserver_channel/template))
		var/datum/chatserver_channel/template/channel = new thing()

		server.channel_list += channel

	server.set_hosting(TRUE)

/*
 * Channel templates
 *
 * Enter IDs into req_accesses_user by name, they're set to the actual access datums on initialization
*/

/datum/chatserver_channel/template/New()
	var/list/datum/access/accesses_user = list()
	var/list/datum/access/accesses_admin = list()

	for(var/acc_id in req_accesses_user)
		accesses_user += get_access_by_id(acc_id)

	for(var/acc_id in req_accesses_admin)
		accesses_admin += get_access_by_id(acc_id)

	req_accesses_user = accesses_user
	req_accesses_admin = accesses_admin
	. = ..()

/datum/chatserver_channel/template/common
	title = "Site-wide"
	req_accesses_admin = list(ACCESS_NETWORK)

/datum/chatserver_channel/template/admin
	title = "Admin"
	req_accesses_user = list(ACCESS_ADMIN_LVL2)
	req_accesses_admin = list(ACCESS_NETWORK)

