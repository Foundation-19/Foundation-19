var/datum/announcement/minor/captain_announcement = new(do_newscast = 1)

/datum/job/captain
	title = "Site Director"
	department = "Command"
	head_position = 1
	department_flag = COM

	total_positions = 1
	spawn_positions = 1
	supervisors = "company officials and Corporate Regulations"
	selection_color = "#1d1d4f"
	req_admin_notify = 1
	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()
	minimal_player_age = 14
	economic_power = 20

	ideal_character_age = 70 // Old geezer captains ftw
	outfit_type = /decl/hierarchy/outfit/job/captain

/datum/job/captain/equip(var/mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.implant_loyalty(src)

/datum/job/captain/get_access()
	return get_all_site_access()

/datum/job/hop
	title = "Human Resources Officer"
	head_position = 1
	department_flag = COM|CIV

	total_positions = 1
	spawn_positions = 1
	supervisors = "the site director"
	selection_color = "#2f2f7f"
	req_admin_notify = 1
	minimal_player_age = 14
	economic_power = 10
	ideal_character_age = 50

	access = list(
		ACCESS_HOP,
		ACCESS_ADMIN_LVL1,
		ACCESS_ADMIN_LVL2,
		ACCESS_ADMIN_LVL3,
		ACCESS_ADMIN_LVL4,
		ACCESS_COM_COMMS,
		ACCESS_CIV_COMMS,
		ACCESS_KEYAUTH
	)

	minimal_access = list()

	outfit_type = /decl/hierarchy/outfit/job/hop

/datum/job/commsofficer
	title = "Communications Officer"
	supervisors = "the Security Commander and Site Director"
	department = "Command"
	selection_color = "#2f2f7f"
	department_flag = COM|ENG|SEC
	minimal_player_age = 15
	economic_power = 10
	ideal_character_age = 45
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/command/headofhr
	allowed_branches = list(/datum/mil_branch/security)
	allowed_ranks = list(
	/datum/mil_rank/security/w1,
	/datum/mil_rank/security/w2,
	/datum/mil_rank/security/w3,
	/datum/mil_rank/security/w4,
	/datum/mil_rank/security/w5
	)
	access = list(
		ACCESS_SECURITY_LVL1,
		ACCESS_SECURITY_LVL2,
		ACCESS_SECURITY_LVL3,
		ACCESS_SECURITY_LVL4,
		ACCESS_ADMIN_LVL1,
		ACCESS_ADMIN_LVL2,
		ACCESS_ADMIN_LVL3,
		ACCESS_ADMIN_LVL4,
		ACCESS_ENGINEERING_LVL1,
		ACCESS_ENGINEERING_LVL2,
		ACCESS_ENGINEERING_LVL3,
		ACCESS_ENGINEERING_LVL4,
		ACCESS_SCIENCE_LVL1,
		ACCESS_SCIENCE_LVL2,
		ACCESS_SCIENCE_LVL3,
		ACCESS_SCIENCE_LVL4,
		ACCESS_MEDICAL_LVL1,
		ACCESS_MEDICAL_LVL2,
		ACCESS_MEDICAL_LVL3
	)

	minimal_access = list()

/datum/job/o5rep

	title = "O5 Representative"
	department = "Civilian"
	selection_color = "#2f2f7f"
	department_flag = COM
	total_positions = 1
	spawn_positions = 1

	supervisors = "O-5 Council or the Site Director"
	economic_power = 4
	minimal_player_age = 5
	ideal_character_age = 30
	alt_titles = list("Ethics Committee Representative")
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/civ/o5rep
	allowed_branches = list(
		/datum/mil_branch/civilian
	)
	allowed_ranks = list(
		/datum/mil_rank/civ/classa
	)

	access = list(
		ACCESS_ADMIN_LVL1,
		ACCESS_ADMIN_LVL2,
		ACCESS_ADMIN_LVL3,
		ACCESS_ADMIN_LVL4,
		ACCESS_ADMIN_LVL5
	)

	minimal_access = list()

/datum/job/archivist

	title = "Archivist"
	department = "Civilian"
	selection_color = "#2f2f7f"
	department_flag = COM|SCI
	total_positions = 1
	spawn_positions = 1

	supervisors = "the Site Director"
	economic_power = 4
	minimal_player_age = 20
	ideal_character_age = 45
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/civ/archivist
	allowed_branches = list(
		/datum/mil_branch/civilian
	)
	allowed_ranks = list(
		/datum/mil_rank/civ/classa
	)

	access = list(
		ACCESS_CIV_COMMS,
		ACCESS_SCI_COMMS,
		ACCESS_MED_COMMS,
		ACCESS_RESEARCH,
		ACCESS_KEYAUTH,
		ACCESS_ADMIN_LVL1,
		ACCESS_ADMIN_LVL2,
		ACCESS_ADMIN_LVL3,
		ACCESS_ADMIN_LVL4,
		ACCESS_SCIENCE_LVL1,
		ACCESS_SCIENCE_LVL2,
		ACCESS_SCIENCE_LVL3,
		ACCESS_SCIENCE_LVL4,
		ACCESS_MEDICAL_LVL1,
		ACCESS_MEDICAL_LVL2,
		ACCESS_MEDICAL_LVL3,
		ACCESS_MEDICAL_LVL4
	)

	minimal_access = list()

/datum/job/goirep
	title = "Global Occult Coalition Representative"
	department = "Command"
	selection_color = "#2f2f7f"
	department_flag = COM
	total_positions = 1
	spawn_positions = 1
//	//duties = "<big><b>As the GOC Representative, your task is to assess the facility and generally advocate for hardline approaches in regards to anomalies and their containment, or destruction. You value human lives far over any anomaly, as does the Global Occult Coalition, and should see to it that lives are preserved where possible, even D-Class ones. Though combat is not your duty, you are issued a revolver to defend yourself with. This job is heavy roleplay: you're expected to be well-versed in actually talking to people on the matters described. Containment of SCPs and direct site matters are not your matters, so don't get involved.</big></b>"
//	//supervisors = "Global Occult Coalition Regional Command"
	economic_power = 5
	minimal_player_age = 5
	minimal_player_age = 9
	ideal_character_age = 30
	alt_titles = list("UIU Relations Agent" = /decl/hierarchy/outfit/job/site90/crew/civ/uiu,"Horizon Initiative Scribe" = /decl/hierarchy/outfit/job/, "Marshall, Carter, and Dark Corporate Liaison" = /decl/hierarchy/outfit/job/site90/crew/civ/MCDRep)
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/civ/gocrep
	allowed_branches = list(
		/datum/mil_branch/civilian
	)
	allowed_ranks = list(
		/datum/mil_rank/civ/classa
	)
	hud_icon = "hudgoi"

	access = list(
		ACCESS_COM_COMMS,
		ACCESS_ADMIN_LVL1
	)

	minimal_access = list()

/datum/job/mtf
	title = "Mobile Task Force Operative"
	department = "Regional Dispatch"
	department_flag = COM
	total_positions = 0
	spawn_positions = 0
	supervisors = "O5 Regional Dispatch and O5 Command"
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/command/event/mtfbasic
	hud_icon = "hudseniorenlistedadvisor"
	access = list()
	minimal_access = list()

/datum/job/mtf/get_access()
	return get_all_site_access()

/datum/job/physics
	title = "UNGOC Physics Operative"
	department = "Regional Dispatch"
	department_flag = COM
	total_positions = 0
	spawn_positions = 0
	supervisors = "UNGOC Regional Dispatch and UNGOC Central Command"
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/command/event/ungoc
	hud_icon = "hudseniorenlistedadvisor"
	access = list()
	minimal_access = list()

/datum/job/physics/get_access()
	return get_all_site_access()
