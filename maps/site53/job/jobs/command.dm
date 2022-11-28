// COMMAND

/datum/job/captain
	title = "Site Director"
	//duties = "<big><b>As the Site Director you are responsible for the operations happening in the Site that you manage.<br>You won't have access to SCP's, or the D-Class area.<br> As Site Director, you should worry about making sure all SOP and safety procedures are followed by delegating to the heads of staff.<br><span style = 'color:red'>It is not your job to jump in where necessary! Consistently bad roleplay will be punished under the CoHoS rule!</span></b></big>"
	minimal_player_age = 40 //also no
	economic_power = 15
	alt_titles = list("Facility Director")
	ideal_character_age = 50
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/command/facilitydir
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classa)
	hud_icon = "hudsitedirector"

	access = list(
		ACCESS_COM_COMMS, //The site director wants to be aware of the situation on his site at any and all times, if he didn't, he would personally turn off the comms on his radio.
		ACCESS_SCI_COMMS,
		ACCESS_CIV_COMMS,
		ACCESS_LOG_COMMS,
		ACCESS_MED_COMMS,
		ACCESS_ENG_COMMS,
		ACCESS_SEC_COMMS,
		ACCESS_ADMIN_LVL1,
		ACCESS_ADMIN_LVL2,
		ACCESS_ADMIN_LVL3,
		ACCESS_ADMIN_LVL4,
		ACCESS_ADMIN_LVL5,
		ACCESS_KEYAUTH,
		ACCESS_CHAPEL_OFFICE
	)

	minimal_access = list()
	
	min_skill = list(SKILL_BUREAUCRACY = SKILL_MASTER,
					SKILL_FINANCE      = SKILL_TRAINED,
					SKILL_HAULING      = SKILL_TRAINED,
					SKILL_COMBAT      = SKILL_TRAINED,
					SKILL_WEAPONS     = SKILL_BASICS,
					SKILL_EVA          = SKILL_BASICS,
					SKILL_PILOT        = SKILL_BASICS)

	max_skill = list(   SKILL_COMBAT      = SKILL_MASTER,
	                    SKILL_WEAPONS     = SKILL_MASTER)


/datum/job/hop
	title = "Human Resources Officer"
	department = "Command"
	department_flag = COM
	total_positions = 1
	spawn_positions = 1
	//duties = "<big><b>As the Head of Personnel, you're the right hand of the Site Director.<br>You can go to places he, or she couldn't, but still won't have access to SCP's, or the D-Class Cells.<br>Your job is to be the Site Director's eyes and ears, as well as being in charge of personnel outside of the Security branch.<br>You reserve the right to promote and demote people in cases of emergencies, otherwise, approval of the Site Director is needed.<br><span style = 'color:red'>It is not your job to jump in where necessary! Bad roleplay will be punished!</span></b></big>"
	minimal_player_age = 30 //N o .
	economic_power = 10
	ideal_character_age = 45
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/command/headofhr
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classa)
	hud_icon = "hudhumanresources"
	alt_titles = list("Head of Personnel")

	access = list(
		ACCESS_COM_COMMS,
		ACCESS_SCI_COMMS,
		ACCESS_CIV_COMMS,
		ACCESS_LOG_COMMS,
		ACCESS_MED_COMMS,
		ACCESS_ENG_COMMS,
		ACCESS_SEC_COMMS,
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

	min_skill = list(SKILL_BUREAUCRACY = SKILL_MASTER,
					SKILL_FINANCE      = SKILL_TRAINED,
					SKILL_HAULING      = SKILL_TRAINED,
					SKILL_COMBAT      = SKILL_TRAINED,
					SKILL_WEAPONS     = SKILL_BASICS,
					SKILL_EVA          = SKILL_BASICS,
					SKILL_PILOT        = SKILL_BASICS)

	max_skill = list(   SKILL_COMBAT      = SKILL_MASTER,
	                    SKILL_WEAPONS     = SKILL_MASTER)



// COMMUNICATIONS

/datum/job/commsofficer
	title = "Communications Officer"
	department = "Command"
	department_flag = COM
	total_positions = 1
	spawn_positions = 1
	//duties = "<big><b>As the Communications Officer it is your job to monitor the radio, help coordinate departments, and dispatch help where it is needed. Keep sensitive communications off the Common channel.<br>You should not ever leave your tower unless under specific circumstances.</b></big>"
	minimal_player_age = 25 //no sense for command staff to be less than 30, but considering this is the Comms Officer, maybe
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
		ACCESS_SCIENCE_LVL1,
		ACCESS_SCIENCE_LVL2,
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
	)

	minimal_access = list()

	min_skill = list(SKILL_BUREAUCRACY  = SKILL_BASIC,
					SKILL_COMPUTER      = SKILL_EXPERIENED,
					SKILL_EVA           = SKILL_EXPERIENCED,
					SKILL_CONSTRUCTION  = SKILL_TRAINED,
					SKILL_ELECTRICAL    = SKILL_EXPERIENCED,
					SKILL_ATMOS         = SKILL_BASIC,
					SKILL_ENGINES       = SKILL_BASIC)

	max_skill = list(SKILL_CONSTRUCTION = SKILL_MASTER,
					SKILL_ELECTRICAL    = SKILL_MASTER,
					SKILL_ATMOS         = SKILL_MASTER,
					SKILL_ENGINES       = SKILL_MASTER)
	skill_points = 20

/datum/job/commeng
	selection_color = "#5b4d20"
	title = "Communications Technician"
	total_positions = 2
	spawn_positions = 2
	//duties = "<big><b>As a member of the Communications team it is your job to maintain long-range comms, monitor the happenings on the Telecomms servers and assess situations by mere observation. Your job may entail being a dispatch center of the likes.<br>You should not ever leave your tower unless under specific circumstances.</b></big>"
	department_flag = ENG
	economic_power = 5
	minimal_player_age = 25 //never seen a 20 year old communications tech
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
		ACCESS_SCIENCE_LVL1,
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
		ACCESS_ENGINEERING_LVL4,
		ACCESS_NETWORK,
		ACCESS_SECURITY_LVL1,
	)

	min_skill = list(SKILL_COMPUTER     = SKILL_MASTER,
					SKILL_EVA           = SKILL_EXPERIENCED,
					SKILL_CONSTRUCTION  = SKILL_EXPERIENCED,
					SKILL_ELECTRICAL    = SKILL_MASTER,
					SKILL_ATMOS         = SKILL_EXPERIENCED,
					SKILL_ENGINES       = SKILL_BASIC)

	max_skill = list(SKILL_CONSTRUCTION = SKILL_MASTER,
					SKILL_ELECTRICAL    = SKILL_MASTER,
					SKILL_ATMOS         = SKILL_MASTER,
					SKILL_ENGINES       = SKILL_MASTER)
	skill_points = 18

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
	minimal_player_age = 40 //but my judge is 19 year old!!
	ideal_character_age = 30
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/civ/tribunal
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

	min_skill = list(SKILL_BUREAUCRACY = SKILL_MASTER,
					SKILL_FINANCE      = SKILL_TRAINED,
					SKILL_HAULING      = SKILL_TRAINED,
					SKILL_COMBAT      = SKILL_TRAINED,
					SKILL_WEAPONS     = SKILL_BASICS,
					SKILL_FORENSICS   = SKILL_MASTER,
					SKILL_EVA          = SKILL_BASICS,
					SKILL_PILOT        = SKILL_TRAINED)

	max_skill = list(   SKILL_COMBAT      = SKILL_MASTER,
	                    SKILL_WEAPONS     = SKILL_MASTER,
	                    SKILL_FORENSICS   = SKILL_MASTER)


/datum/job/ethicsliaison
	title = "Ethics Committee Liaison"
	department = "Civilian"
	selection_color = "#2f2f7f"
	department_flag = COM
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Ethics Committee"
	economic_power = 4
	minimal_player_age = 30
	ideal_character_age = 50
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/civ/o5rep
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

	min_skill = list(SKILL_BUREAUCRACY = SKILL_MASTER,
					SKILL_FINANCE      = SKILL_MASTER,
					SKILL_HAULING      = SKILL_TRAINED,
					SKILL_WEAPONS     = SKILL_BASICS,
					SKILL_EVA          = SKILL_BASICS,
					SKILL_PILOT        = SKILL_TRAINED)

	max_skill = list(   SKILL_COMBAT      = SKILL_EXPERIENCED,
	                    SKILL_WEAPONS     = SKILL_TRAINED,
	                    SKILL_FORENSICS   = SKILL_EXPERIENCED)

/datum/job/goirep
	title = "Global Occult Coalition Representative"
	department = "Command"
	department_flag = COM
	total_positions = 1
	spawn_positions = 1
//	//duties = "<big><b>As the GOC Representative, your task is to assess the facility and generally advocate for hardline approaches in regards to anomalies and their containment, or destruction. You value human lives far over any anomaly, as does the Global Occult Coalition, and should see to it that lives are preserved where possible, even D-Class ones. Though combat is not your duty, you are issued a revolver to defend yourself with. This job is heavy roleplay: you're expected to be well-versed in actually talking to people on the matters described. Containment of SCPs and direct site matters are not your matters, so don't get involved.</b></big>"
//	//supervisors = "Global Occult Coalition Regional Command"
	economic_power = 5
	minimal_player_age = 40 //b-but muh 20 year old chad manly GOC fanfic!!!
	ideal_character_age = 40
	alt_titles = list("UIU Relations Agent" = /decl/hierarchy/outfit/job/site90/crew/civ/uiu, "Horizon Initiative Scribe" = /decl/hierarchy/outfit/job/thirep, "Marshall, Carter, and Dark Corporate Liaison" = /decl/hierarchy/outfit/job/site90/crew/civ/MCDRep )
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
		ACCESS_ADMIN_LVL1,
		ACCESS_CHAPEL_OFFICE
	)

	minimal_access = list()
	min_skill = list(SKILL_BUREAUCRACY = SKILL_MASTER,
					SKILL_FINANCE      = SKILL_TRAINED,
					SKILL_HAULING      = SKILL_TRAINED,
					SKILL_COMBAT      = SKILL_EXPERIENCED,
					SKILL_WEAPONS     = SKILL_TRAINED,
					SKILL_EVA          = SKILL_BASICS,
					SKILL_PILOT        = SKILL_TRAINED)

	max_skill = list(   SKILL_COMBAT      = SKILL_MASTER,
	                    SKILL_WEAPONS     = SKILL_MASTER,
	                    SKILL_FORENSICS   = SKILL_MASTER)

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
