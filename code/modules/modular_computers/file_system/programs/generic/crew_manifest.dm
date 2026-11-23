/datum/computer_file/program/crew_manifest
	filename = "crewmanifest"
	filedesc = "Personnel Manifest"
	extended_desc = "This program allows access to the manifest of active on-site personnel."
	program_icon_state = "generic"
	program_key_state = "generic_key"
	program_menu_icon = "clipboard-list"
	size = 4
	requires_ntnet = TRUE
	available_on_ntnet = TRUE
	nanomodule_path = /datum/nano_module/crew_manifest
	usage_flags = PROGRAM_ALL

/datum/nano_module/crew_manifest
	name = "Crew Manifest"

/datum/nano_module/crew_manifest/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "CrewManifest", name)
		ui.open()

/datum/nano_module/crew_manifest/tgui_data(mob/user)
	var/list/data = host.initial_data()
	data["crew_manifest"] = html_crew_manifest(TRUE)
	return data
