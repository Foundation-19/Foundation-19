/obj/item/modular_computer/console/preset/paperwork_dataserver/install_default_programs()
	..()
	var/datum/computer_file/program/upload_database/UD = new()
	hard_drive.store_file(UD)

	turn_on()
	run_program(UD.filename)

	UD.server_name = "Paperwork Database"

	for(var/thing in subtypesof(/datum/computer_file/data/text/paperwork))
		var/datum/computer_file/data/text/paperwork/doc = new thing()

		hard_drive.store_file(doc)
		UD.enabled_files += doc.filename

		LAZYADDASSOC(UD.files_required_access, doc.filename, list())

	UD.set_hosting(TRUE)

/datum/computer_file/data/text/paperwork
	filename = "BuggedFilename"
	stored_data = "Something's bugged out - contact a coder!"

/*
 * PAPERWORK FILES
 *
 * Try to keep this sorted by department
*/

/datum/computer_file/data/text/paperwork/base
	filename = "BaseDocument"
	stored_data = @{"[center][h1]Document Name[/h1]
[scplogo]
[b]Secure. Contain. Protect.[/b][/center]
[hr][b]Example Field 1:[/b] [field]
[b]Example Field 2:[/b]"}

// SCIENCE

/datum/computer_file/data/text/paperwork/test_log
	filename = "TestLog"
	stored_data = @{"[center][h1]Test Log[/h1]
[scilogo]
[b]Secure. Contain. Protect.[/b][/center]
[hr][small][i]To be filled out prior to testing start[/i][/small]
[b]Test Designation:[/b] [field]
[b]Lead Researcher:[/b] [field]
[b]Additional Staff Present:[/b] [field]
[b]SCP Object(s) in Test:[/b] [field]
[b]Non-SCP Assets in Test:[/b] [field]
[b]Goal of Testing:[/b] [field]
[b]Date and Time of Test:[/b] [field]
[hr][small][i]To be filled out during testing[/i][/small]
[b]Testing Log:[/b]"}

// SECURITY

/datum/computer_file/data/text/paperwork/zone_permit
	filename = "ZonePermit"
	stored_data = @{"[center][h1]Zone Permit[/h1]
[seclogo]
[b]Secure. Contain. Protect.[/b][/center]
[hr][small][i]PERMIT MUST BE ISSUED ON ENTRY AND RETURNED UPON EXITING THE CHECKPOINT[/i][/small]
The entrant issued this permit is granted access to the zone listed.
[b]Zone:[/b] [field]
[b]Entrant Name:[/b] [field]
[b]Entrant Position:[/b] [field]
[b]Purpose of Entry:[/b] [field]
[hr][b]Signature of Issuer:[/b]"}

/datum/computer_file/data/text/paperwork/d_class_termination
	filename = "DClassTermination"
	stored_data = @{"[center][h1]D-Class Termination[/h1]
[seclogo]
[b]Secure. Contain. Protect.[/b][/center]
[hr][b]Identification #:[/b] [field]
[b]Offense(s):[/b] [field]
[b]Terminating Officer:[/b] [field]
[b]Date and Time of Termination:[/b] [field]
[hr][b]Authorizing Officer Signature:[/b]"}
