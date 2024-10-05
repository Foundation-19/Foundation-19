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
[b]Lead Researcher (name and rank):[/b] [field]
[b]Additional Staff Present (name and rank):[/b] [field]
[b]SCP Object(s) in Test:[/b] [field]
[b]Non-SCP Assets in Test:[/b] [field]
[b]Testing Location (exact room):[/b] [field]
[b]Goal of Testing:[/b] [field]
[b]Date and Time of Test:[/b] [field]
[hr][small][i]To be filled out during testing[/i][/small]
[b]Testing Log:[/b]"}

/datum/computer_file/data/text/paperwork/test_auth_request
	filename = "TestAuthRequest"
	stored_data = @{"[center][h1]Testing Authorization Request[/h1]
[scilogo]
[b]Secure. Contain. Protect.[/b][/center]
[hr][b]Lead Researcher (name and rank):[/b] [field]
[b]Additional Staff Required:[/b] [field]
[b]SCP Object(s) in Test:[/b] [field]
[b]Non-SCP Assets Required:[/b] [field]
[b]Goal of Testing:[/b] [field]
[hr][b]Authorizing Party's Signature:[/b]:"}

// MEDICAL

/datum/computer_file/data/text/paperwork/autopsy_report
	filename = "AutopsyReport"
	stored_data = @{"[center][h1]Autopsy Report[/h1]
[medlogo]
[b]Secure. Contain. Protect.[/b][/center]
[hr][small][i]An audio transcript of the autopsy must be attached to this document.[/i][/small]
[b]Coroner (name and rank):[/b] [field]
[b]Coroner Signature:[/b] [field]
[hr][b]Autopsy notes:[/b]"}

// SECURITY

/datum/computer_file/data/text/paperwork/zone_permit
	filename = "ZonePermit"
	stored_data = @{"[center][h1]Zone Permit[/h1]
[seclogo]
[b]Secure. Contain. Protect.[/b][/center]
[hr][small][i]PERMIT MUST BE ISSUED ON ENTRY AND RETURNED UPON EXITING THE CHECKPOINT[/i][/small]
The entrant issued this permit is granted access to the zone listed.
[b]Zone:[/b] [field]
[b]Entrant (name and rank):[/b] [field]
[b]Purpose of Entry:[/b] [field]
[hr][b]Signature of Issuer:[/b]"}

/datum/computer_file/data/text/paperwork/d_class_termination
	filename = "DClassTermination"
	stored_data = @{"[center][h1]D-Class Termination[/h1]
[seclogo]
[b]Secure. Contain. Protect.[/b][/center]
[hr][b]Identification #:[/b] [field]
[b]Offense(s):[/b] [field]
[b]Terminating Officer (name and rank):[/b] [field]
[b]Date and Time of Termination:[/b] [field]
[hr][b]Authorizing Officer Signature:[/b]"}

/datum/computer_file/data/text/paperwork/department_audit_tribunal
	filename = "DepartmentAudit_Tribunal"
	stored_data = @{"[center][h1]Department Audit[/h1]
[triblogo]
[b]Secure. Contain. Protect.[/b][/center]
[hr][b]Audited Department:[/b] [field]
[b]Start of Audit (date and time):[/b] [field]
[b]End of Audit (date and time):[/b] [field]
[b]Department Grade (A to F):[/b] [field]
[hr][b]Audit Notes:[/b] [field]
[hr][b]Recommended Actions:[/b] [field]
[b]Tribunal Officer Signature:[/b]"}

/datum/computer_file/data/text/paperwork/department_audit_ethics
	filename = "DepartmentAudit_Ethics"
	stored_data = @{"[center][h1]Department Audit[/h1]
[ethicslogo]
[b]Secure. Contain. Protect.[/b][/center]
[hr][b]Audited Department:[/b] [field]
[b]Start of Audit (date and time):[/b] [field]
[b]End of Audit (date and time):[/b] [field]
[b]Department Grade (A to F):[/b] [field]
[hr][b]Audit Notes:[/b] [field]
[hr][b]Recommended Actions:[/b] [field]
[b]Ethics Liason Signature:[/b]"}

// LOGISTICS

/datum/computer_file/data/text/paperwork/material_inventory
	filename = "MaterialInventory"
	stored_data = @{"[center][h1]Material Collection[/h1]
[ethicslogo]
[b]Secure. Contain. Protect.[/b][/center]
[hr][b]Audited Department:[/b] [field]
[b]Start of Audit (date and time):[/b] [field]
[b]End of Audit (date and time):[/b] [field]
[b]Department Grade (A to F):[/b] [field]
[hr][b]Audit Notes:[/b] [field]
[hr][b]Recommended Actions:[/b] [field]
[b]Ethics Liason Signature:[/b]"}

/datum/computer_file/data/text/paperwork/material_inventory/New() // futureproofed paperwork here we go!
	. = ..()
	stored_data = @{"[center][h1]Material Collection[/h1]
[loglogo]
[b]Secure. Contain. Protect.[/b][/center]
[hr][table][row][cell][b]Material[/b][cell][b]Count[/b][cell][b]Type[/b][cell][b]Value[/b]
"}

	for(var/thing in SSmaterials.materials)
		var/material/mat = thing
		if(mat.hidden_from_codex || is_abstract(mat))
			continue

		stored_data += "\[row\]\[cell\][mat.display_name]\[cell\]\[field\]\[cell\]\[small\][mat.sheet_plural_name]\[cell\][mat.value]\n"

	stored_data += @{"[/table][hr][b]Inventory timestamp (date and time):[/b] [field]
[b]Signature of Officer Responsible for Inventory:[/b]"}
