ut // COMMAND

/datum/job/captain
	title = "Site Director"
	//duties = "<big><b>As the Site Director you are responsible for the operations happening in the Site that you manage.<br>You won't have access to SCP's, or the D-Class area.<br> As Site Director, you should worry about making sure all SOP and safety procedures are followed by delegating to the heads of staff.<br><span style = 'color:red'>It is not your job to jump in where necessary! Consistently bad roleplay will be punished under the CoHoS rule!</span></b></big>"
	minimal_player_age = 20
	economic_power = 15
	ideal_character_age = 50
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/command/facilitydir
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classa)
	hud_icon = "hudsitedirector"

	access = list(
		access_com_comms, // SD and HoP do not want to hear all the details, either meet your Commander in person or talk to the Tower
		access_sci_comms,
		access_adminlvl1,
		access_adminlvl2,
		access_adminlvl3,
		access_adminlvl4,
		access_adminlvl5,
		access_keyauth
	)

	minimal_access = list()

/datum/job/hop
	title = "Human Resources Officer"
	department = "Command"
	department_flag = COM
	total_positions = 1
	spawn_positions = 1
	//duties = "<big><b>As the Head of Personnel, you're the right hand of the Site Director.<br>You can go to places he, or she couldn't, but still won't have access to SCP's, or the D-Class Cells.<br>Your job is to be the Site Director's eyes and ears, as well as being in charge of personnel outside of the Security branch.<br>You reserve the right to promote and demote people in cases of emergencies, otherwise, approval of the Site Director is needed.<br><span style = 'color:red'>It is not your job to jump in where necessary! Bad roleplay will be punished!</span></b></big>"
	minimal_player_age = 15
	economic_power = 10
	ideal_character_age = 45
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/command/headofhr
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classa)
	hud_icon = "hudhumanresources"
	alt_titles = list("Head of Personnel")

	access = list(
		access_hop,
		access_adminlvl1,
		access_adminlvl2,
		access_adminlvl3,
		access_adminlvl4,
		access_com_comms,
		access_change_ids,
		access_civ_comms,
		access_keyauth
	)

	minimal_access = list()

// COMMUNICATIONS

/datum/job/commsofficer
	title = "Communications Officer"
	department = "Command"
	department_flag = COM
	total_positions = 1
	spawn_positions = 1
	//duties = "<big><b>As the Communications Officer it is your job to monitor the radio, help coordinate departments, and dispatch help where it is needed. Keep sensitive communications off the Common channel.<br>You should not ever leave your tower unless under specific circumstances.</b></big>"
	minimal_player_age = 15
	economic_power = 10
	ideal_character_age = 45
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/command/commsofficer
	allowed_branches = list(/datum/mil_branch/security)
	hud_icon = "hudcommsofficer"
	allowed_ranks = list(
	/datum/mil_rank/security/w5,
	/datum/mil_rank/security/w6
	)

	access = list(
		access_sciencelvl1,
		access_sciencelvl3,
		access_com_comms,
		access_sci_comms,
		access_civ_comms,
		access_log_comms,
		access_med_comms,
		access_eng_comms,
		access_sec_comms,
		access_adminlvl4,
		access_adminlvl3,
		access_adminlvl2,
		access_adminlvl1,
		access_engineeringlvl1,
		access_engineeringlvl2,
		access_engineeringlvl3,
		access_securitylvl1,
		access_sciencelvl1,
		access_sciencelvl2,
		access_sciencelvl3
	)

	minimal_access = list()

	min_skill = list(SKILL_BUREAUCRACY  = SKILL_BASIC,
					SKILL_COMPUTER      = SKILL_EXPERIENCED,
					SKILL_EVA           = SKILL_EXPERIENCED,
					SKILL_CONSTRUCTION  = SKILL_EXPERIENCED,
					SKILL_ELECTRICAL    = SKILL_EXPERIENCED,
					SKILL_ATMOS         = SKILL_EXPERIENCED,
					SKILL_ENGINES       = SKILL_TRAINED)

	max_skill = list(SKILL_CONSTRUCTION = SKILL_MASTER,
					SKILL_ELECTRICAL    = SKILL_MASTER,
					SKILL_ATMOS         = SKILL_MASTER,
					SKILL_ENGINES       = SKILL_MASTER)
	skill_points = 30

/datum/job/commeng
	selection_color = "#5b4d20"
	title = "Communications Technician"
	total_positions = 2
	spawn_positions = 2
	//duties = "<big><b>As a member of the Communications team it is your job to maintain long-range comms, monitor the happenings on the Telecomms servers and assess situations by mere observation. Your job may entail being a dispatch center of the likes.<br>You should not ever leave your tower unless under specific circumstances.</b></big>"
	department_flag = ENG
	economic_power = 5
	minimal_player_age = 7
	ideal_character_age = 30
	alt_titles = list(
		"Communications Programmer",
		"Communications Dispatcher"
		)
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/command/commstech
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classc)
	hud_icon = "hudcommsprogrammer"

	access = list(
		access_com_comms,
		access_sci_comms,
		access_civ_comms,
		access_log_comms,
		access_med_comms,
		access_eng_comms,
		access_sec_comms,
		access_adminlvl1,
		access_engineeringlvl1,
		access_engineeringlvl2,
		access_engineeringlvl3
	)

	min_skill = list(SKILL_COMPUTER     = SKILL_BASIC,
					SKILL_EVA           = SKILL_BASIC,
					SKILL_CONSTRUCTION  = SKILL_EXPERIENCED,
					SKILL_ELECTRICAL    = SKILL_BASIC,
					SKILL_ATMOS         = SKILL_BASIC,
					SKILL_ENGINES       = SKILL_BASIC)

	max_skill = list(SKILL_CONSTRUCTION = SKILL_MASTER,
					SKILL_ELECTRICAL    = SKILL_MASTER,
					SKILL_ATMOS         = SKILL_MASTER,
					SKILL_ENGINES       = SKILL_MASTER)
	skill_points = 20

// MISC

/datum/job/o5rep
	title = "O5 Representative"
	department = "Command"
	department_flag = COM
	total_positions = 1
	spawn_positions = 1
//	//duties = "<big><b>As the GOC Representative, your task is to assess the facility and generally advocate for hardline approaches in regards to anomalies and their containment, or destruction. You value human lives far over any anomaly, as does the Global Occult Coalition, and should see to it that lives are preserved where possible, even D-Class ones. Though combat is not your duty, you are issued a revolver to defend yourself with. This job is heavy roleplay: you're expected to be well-versed in actually talking to people on the matters described. Containment of SCPs and direct site matters are not your matters, so don't get involved.</b></big>"
//	//supervisors = "Global Occult Coalition Regional Command"
	economic_power = 5
	minimal_player_age = 5
	minimal_player_age = 9
	ideal_character_age = 30
	alt_titles = list("Ethics Committee Representative")
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/civ/o5rep
	allowed_branches = list(
		/datum/mil_branch/civilian
	)
	allowed_ranks = list(
		/datum/mil_rank/civ/classa
	)
	hud_icon = "hud05rep"

	access = list(
		access_com_comms,
		access_adminlvl1,
		access_adminlvl2,
		access_adminlvl3,
		access_adminlvl4,
		access_adminlvl5
	)
	minimal_access = list()

/datum/job/goirep
	title = "Global Occult Coalition Representative"
	department = "Command"
	department_flag = COM
	total_positions = 1
	spawn_positions = 1
//	//duties = "<big><b>As the GOC Representative, your task is to assess the facility and generally advocate for hardline approaches in regards to anomalies and their containment, or destruction. You value human lives far over any anomaly, as does the Global Occult Coalition, and should see to it that lives are preserved where possible, even D-Class ones. Though combat is not your duty, you are issued a revolver to defend yourself with. This job is heavy roleplay: you're expected to be well-versed in actually talking to people on the matters described. Containment of SCPs and direct site matters are not your matters, so don't get involved.</b></big>"
//	//supervisors = "Global Occult Coalition Regional Command"
	economic_power = 5
	minimal_player_age = 5
	minimal_player_age = 9
	ideal_character_age = 30
	alt_titles = list("UIU Relations Agent" = /decl/hierarchy/outfit/job/site90/crew/civ/uiu)
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/civ/gocrep
	allowed_branches = list(
		/datum/mil_branch/civilian
	)
	allowed_ranks = list(
		/datum/mil_rank/civ/classa
	)
	hud_icon = "hudgoi"

	access = list(
		access_com_comms,
		access_adminlvl1
	)

	minimal_access = list()
