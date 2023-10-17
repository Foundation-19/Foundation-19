/obj/item/modular_computer/console/preset/SCP_dataserver/install_default_programs()
	..()
	hard_drive.store_file(new /datum/computer_file/program/upload_database())

	for(var/thing in subtypesof(/datum/computer_file/data/SCP_doc))
		var/datum/computer_file/data/SCP_doc/doc = thing

		hard_drive.store_file(new doc())

/datum/computer_file/data/SCP_doc
	filetype = "SCP"
	filename = "BuggedFilename"
	stored_data = "Something's bugged out - contact a coder!"
