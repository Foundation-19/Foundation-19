/datum/job/captain
	title = "Site Director"
	department = "Command"
	head_position = 1
	department_flag = COM
	selection_color = "#1d1d4f"
	req_admin_notify = 1
	//duties = "<big><b>As the Site Director you are responsible for the operations happening in the Site that you manage.<br>You won't have access to SCP's, or the D-Class area.<br> As Site Director, you should worry about making sure all SOP and safety procedures are followed by delegating to the heads of staff.<br><span style = 'color:red'>It is not your job to jump in where necessary! Consistently bad roleplay will be punished under the CoHoS rule!</span></b></big>"
	minimal_player_age = 20
	economic_power = 15
	alt_titles = list("Facility Director")
	ideal_character_age = 50
	outfit_type = /decl/hierarchy/outfit/job/command/facilitydir
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classa)
	hud_icon = "hudsitedirector"

	total_positions = 1
	spawn_positions = 1

	access = list()				// see get_access() override
	minimal_access = list()		// see get_access() override

	requirements = list(EXP_TYPE_COMMAND = 1800)

/datum/job/captain/get_access()
	return get_all_site_access()

/datum/job/hop
	title = "Human Resources Officer"
	department = "Command"
	supervisors = "The Site Director"
	department_flag = COM|CIV|BUR|SRV
	selection_color = "#2f2f7f"
	head_position = 1
	total_positions = 1
	spawn_positions = 1
	//duties = "<big><b>As the Head of Personnel, you're the right hand of the Site Director.<br>You can go to places he, or she couldn't, but still won't have access to SCP's, or the D-Class Cells.<br>Your job is to be the Site Director's eyes and ears, as well as being in charge of personnel outside of the Security branch.<br>You reserve the right to promote and demote people in cases of emergencies, otherwise, approval of the Site Director is needed.<br><span style = 'color:red'>It is not your job to jump in where necessary! Bad roleplay will be punished!</span></b></big>"
	req_admin_notify = 1
	economic_power = 10
	minimal_player_age = 15
	ideal_character_age = 45
	outfit_type = /decl/hierarchy/outfit/job/command/headofhr
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classa)
	hud_icon = "hudhumanresources"
	alt_titles = list("Head of Personnel")
	requirements = list(EXP_TYPE_COMMAND = 120, EXP_TYPE_SERVICE = 480, EXP_TYPE_BUR = 480)

	access = list(
		ACCESS_HOP,
		ACCESS_ADMIN_LVL1,
		ACCESS_ADMIN_LVL2,
		ACCESS_ADMIN_LVL3,
		ACCESS_ADMIN_LVL4,
		ACCESS_COM_COMMS,
		ACCESS_CHANGE_IDS,
		ACCESS_CIV_COMMS,
		ACCESS_KEYAUTH,
		ACCESS_CHAPEL_OFFICE
	)

	minimal_access = list()

// COMMUNICATIONS

/datum/job/commsofficer
	title = "Communications Officer"
	department = "Command"
	department_flag = COM|ENG|SEC
	supervisors = "the Guard Commander and Site Director"
	selection_color = "#2f2f7f"
	total_positions = 1
	spawn_positions = 1
	//duties = "<big><b>As the Communications Officer it is your job to monitor the radio, help coordinate departments, and dispatch help where it is needed. Keep sensitive communications off the Common channel.<br>You should not ever leave your tower unless under specific circumstances.</b></big>"
	economic_power = 10
	minimal_player_age = 15
	ideal_character_age = 45
	outfit_type = /decl/hierarchy/outfit/job/command/commsofficer
	allowed_branches = list(/datum/mil_branch/security)
	hud_icon = "hudcommsofficer"
	requirements = list(EXP_TYPE_ENGINEERING = 600, EXP_TYPE_SECURITY = 300, "Communications Technician" = 900)
	allowed_ranks = list(
	/datum/mil_rank/security/w5,
	/datum/mil_rank/security/w6
	)

	access = list(
		ACCESS_SCIENCE_LVL1,
		ACCESS_SCIENCE_LVL3,
		ACCESS_COM_COMMS,
		ACCESS_SCI_COMMS,
		ACCESS_CIV_COMMS,
		ACCESS_LOG_COMMS,
		ACCESS_MED_COMMS,
		ACCESS_ENG_COMMS,
		ACCESS_SEC_COMMS,
		ACCESS_ADMIN_LVL4,
		ACCESS_ADMIN_LVL3,
		ACCESS_ADMIN_LVL2,
		ACCESS_ADMIN_LVL1,
		ACCESS_ENGINEERING_LVL1,
		ACCESS_ENGINEERING_LVL2,
		ACCESS_ENGINEERING_LVL3,
		ACCESS_NETWORK,
		ACCESS_SECURITY_LVL1,
		ACCESS_SCIENCE_LVL1,
		ACCESS_SCIENCE_LVL2,
		ACCESS_SCIENCE_LVL3
	)

	minimal_access = list()

	min_skill = list(
		SKILL_COMPUTER      = SKILL_EXPERIENCED,
		SKILL_CONSTRUCTION  = SKILL_EXPERIENCED,
		SKILL_ELECTRICAL    = SKILL_EXPERIENCED,
		SKILL_ATMOS         = SKILL_EXPERIENCED,
		SKILL_ENGINES       = SKILL_TRAINED
	)

	max_skill = list(
		SKILL_CONSTRUCTION  = SKILL_MASTER,
		SKILL_ELECTRICAL    = SKILL_MASTER,
		SKILL_ATMOS         = SKILL_MASTER,
		SKILL_ENGINES       = SKILL_MASTER
	)
	skill_points = 30

/datum/job/commeng
	title = "Communications Technician"
	selection_color = "#5b4d20"
	total_positions = 2
	spawn_positions = 2
	//duties = "<big><b>As a member of the Communications team it is your job to maintain long-range comms, monitor the happenings on the Telecomms servers and assess situations by mere observation. Your job may entail being a dispatch center of the likes.<br>You should not ever leave your tower unless under specific circumstances.</b></big>"
	supervisors = "the Communications Officer"
	department_flag = ENG
	economic_power = 5
	minimal_player_age = 7
	ideal_character_age = 30
	requirements = list(EXP_TYPE_ENGINEERING = 300)
	alt_titles = list(
		"Communications Programmer",
		"Communications Dispatcher"
		)
	outfit_type = /decl/hierarchy/outfit/job/command/commstech
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classc)
	hud_icon = "hudcommsprogrammer"

	access = list(
		ACCESS_COM_COMMS,
		ACCESS_SCI_COMMS,
		ACCESS_CIV_COMMS,
		ACCESS_LOG_COMMS,
		ACCESS_MED_COMMS,
		ACCESS_ENG_COMMS,
		ACCESS_SEC_COMMS,
		ACCESS_ADMIN_LVL1,
		ACCESS_ENGINEERING_LVL1,
		ACCESS_ENGINEERING_LVL2,
		ACCESS_ENGINEERING_LVL3
	)

	min_skill = list(
		SKILL_COMPUTER      = SKILL_BASIC,
		SKILL_CONSTRUCTION  = SKILL_EXPERIENCED,
		SKILL_ELECTRICAL    = SKILL_BASIC,
		SKILL_ATMOS         = SKILL_BASIC,
		SKILL_ENGINES       = SKILL_BASIC
	)

	max_skill = list(
		SKILL_CONSTRUCTION  = SKILL_MASTER,
		SKILL_ELECTRICAL    = SKILL_MASTER,
		SKILL_ATMOS         = SKILL_MASTER,
		SKILL_ENGINES       = SKILL_MASTER
	)
	skill_points = 20

// MISC

/datum/job/tribunal

	title = "Internal Tribunal Department Officer"
	department = "Civilian"
	selection_color = "#2f2f7f"
	department_flag = COM
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Tribunal Department"
	economic_power = 4
	minimal_player_age = 5
	ideal_character_age = 30
	outfit_type = /decl/hierarchy/outfit/job/civ/tribunal
	requirements = list(EXP_TYPE_COMMAND = 600, EXP_TYPE_SECURITY = 900, EXP_TYPE_BUR = 120)
	allowed_branches = list(
		/datum/mil_branch/civilian
	)
	allowed_ranks = list(
		/datum/mil_rank/civ/classb
	)
	hud_icon = "hud05rep"
	access = list(
		ACCESS_ADMIN_LVL1,
		ACCESS_ADMIN_LVL2,
		ACCESS_ADMIN_LVL3,
		ACCESS_ADMIN_LVL4,
		ACCESS_ADMIN_LVL5
	)

	minimal_access = list()

/datum/job/ethicsliaison

	title = "Ethics Committee Liaison"
	department = "Civilian"
	selection_color = "#2f2f7f"
	department_flag = COM|BUR
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Ethics Committee"
	economic_power = 4
	minimal_player_age = 5
	ideal_character_age = 30
	outfit_type = /decl/hierarchy/outfit/job/civ/o5rep
	requirements = list(EXP_TYPE_COMMAND = 180, EXP_TYPE_BUR = 480)
	allowed_branches = list(
		/datum/mil_branch/civilian
	)
	allowed_ranks = list(
		/datum/mil_rank/civ/classb
	)
	hud_icon = "hud05rep"
	access = list(
		ACCESS_ADMIN_LVL1,
		ACCESS_ADMIN_LVL2,
		ACCESS_ADMIN_LVL3,
		ACCESS_ADMIN_LVL4,
		ACCESS_ADMIN_LVL5
	)

	minimal_access = list()

/datum/job/goirep
	title = "Global Occult Coalition Representative"
	department = "Command"
	department_flag = REP
	selection_color = "#2f2f7f"
	supervisors = "Your respective Group of Interest leaders"
	total_positions = 1
	spawn_positions = 1
//	//duties = "<big><b>As the GOC Representative, your task is to assess the facility and generally advocate for hardline approaches in regards to anomalies and their containment, or destruction. You value human lives far over any anomaly, as does the Global Occult Coalition, and should see to it that lives are preserved where possible, even D-Class ones. Though combat is not your duty, you are issued a revolver to defend yourself with. This job is heavy roleplay: you're expected to be well-versed in actually talking to people on the matters described. Containment of SCPs and direct site matters are not your matters, so don't get involved.</b></big>"
	economic_power = 5
	minimal_player_age = 9
	ideal_character_age = 30
	alt_titles = list("UIU Relations Agent" = /decl/hierarchy/outfit/job/civ/uiu, "Horizon Initiative Scribe" = /decl/hierarchy/outfit/job/civ/thirep, "Marshall, Carter, and Dark Corporate Liaison" = /decl/hierarchy/outfit/job/civ/MCDRep )
	outfit_type = /decl/hierarchy/outfit/job/civ/gocrep
	allowed_branches = list(
		/datum/mil_branch/civilian
	)
	allowed_ranks = list(
		/datum/mil_rank/civ/classa
	)
	hud_icon = "hudgoi"

	access = list(
		ACCESS_COM_COMMS,
		ACCESS_ADMIN_LVL1,
		ACCESS_CHAPEL_OFFICE
	)

	minimal_access = list()
