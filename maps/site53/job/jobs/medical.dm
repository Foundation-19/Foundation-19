// MEDICAL JOBS.

/datum/job/cmo
	title = "Chief Medical Officer"
	//supervisors = "the Security Commander"
	economic_power = 10
	minimal_player_age = 15
	ideal_character_age = 48
	alt_titles = list("Medical Director")
	outfit_type = /decl/hierarchy/outfit/job/ds90/crew/command/cmo
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(
						/datum/mil_rank/civ/classb,
						/datum/mil_rank/civ/classa
						)
	hud_icon = "hudchiefmedicalofficer"

	access = list(
		access_com_comms,
		access_med_comms,
		access_medical_equip,
		access_keyauth,
		access_medicallvl1,
		access_medicallvl2,
		access_medicallvl3,
		access_medicallvl4,
		access_medicallvl5,
		access_securitylvl1,
		access_sciencelvl1,
		access_adminlvl1
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_MEDICAL     = SKILL_EXPERIENCED,
	                    SKILL_ANATOMY     = SKILL_EXPERIENCED,
	                    SKILL_CHEMISTRY   = SKILL_BASIC,
						SKILL_DEVICES     = SKILL_TRAINED)

	max_skill = list(   SKILL_MEDICAL     = SKILL_MASTER,
	                    SKILL_ANATOMY     = SKILL_MASTER,
	                    SKILL_CHEMISTRY   = SKILL_MASTER)
	skill_points = 28

/datum/job/chemist
	title = "Chemist"
	department = "Medical"
	department_flag = MED
	minimal_player_age = 3
	total_positions = 2
	spawn_positions = 2
	//supervisors = "the Chief Medical Officer"
	selection_color = "#013d3b"
	economic_power = 4
	ideal_character_age = 30
	outfit_type = /decl/hierarchy/outfit/job/ds90/medical/chemist
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classc)
	hud_icon = "hudpharmacist"

	access = list(
		access_med_comms,
		access_medical_equip,
		access_medicallvl1,
		access_medicallvl2
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_MEDICAL     = SKILL_TRAINED,
	                    SKILL_ANATOMY     = SKILL_TRAINED,
	                    SKILL_CHEMISTRY   = SKILL_EXPERIENCED,
						SKILL_DEVICES     = SKILL_TRAINED)

	max_skill = list(   SKILL_MEDICAL     = SKILL_MASTER,
	                    SKILL_ANATOMY     = SKILL_MASTER,
	                    SKILL_CHEMISTRY   = SKILL_MASTER)
	skill_points = 24

/datum/job/psychiatrist
	title = "Psychiatrist"
	department = "Medical"
	department_flag = MED
	selection_color = "#013d3b"
	total_positions = 1
	spawn_positions = 1
	ideal_character_age = 40
	economic_power = 5
	//supervisors = "the Chief Medical Officer"
	alt_titles = list("Counselor")
	outfit_type = /decl/hierarchy/outfit/job/ds90/medical/psychiatrist
	allowed_branches = list(
	/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classb)
	hud_icon = "hudcounselor"

	access = list(
		access_med_comms,
		access_medical_equip,
		access_medicallvl1
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_MEDICAL     = SKILL_TRAINED,
	                    SKILL_ANATOMY     = SKILL_TRAINED,
	                    SKILL_CHEMISTRY   = SKILL_BASIC,
						SKILL_DEVICES     = SKILL_TRAINED)

	max_skill = list(   SKILL_MEDICAL     = SKILL_MASTER,
	                    SKILL_ANATOMY     = SKILL_MASTER,
	                    SKILL_CHEMISTRY   = SKILL_MASTER)
	skill_points = 24

/datum/job/medicaldoctor
	title = "Medical Doctor"
	department = "Medical"
	department_flag = MED
	selection_color = "#013d3b"
	total_positions = 3
	spawn_positions = 3
	ideal_character_age = 40
	minimal_player_age = 3
	economic_power = 5
	alt_titles = list("Coroner")
	outfit_type = /decl/hierarchy/outfit/job/ds90/medical/medicaldoctor
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classb)
	hud_icon = "hudphysician"

	access = list(
		access_med_comms,
		access_medical_equip,
		access_medicallvl1,
		access_medicallvl2,
		access_medicallvl3,
		access_securitylvl1,
		access_sciencelvl1
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_MEDICAL     = SKILL_TRAINED,
	                    SKILL_ANATOMY     = SKILL_TRAINED,
	                    SKILL_CHEMISTRY   = SKILL_TRAINED,
						SKILL_DEVICES     = SKILL_TRAINED)

	max_skill = list(   SKILL_MEDICAL     = SKILL_MASTER,
	                    SKILL_ANATOMY     = SKILL_MASTER,
	                    SKILL_CHEMISTRY   = SKILL_MASTER)
	skill_points = 24

/datum/job/virologist
	title = "Virologist"
	department = "Medical"
	department_flag = MED
	selection_color = "#013d3b"
	total_positions = 2
	spawn_positions = 2
	minimal_player_age = 3
	ideal_character_age = 40
	economic_power = 5
	//supervisors = "the Chief Medical Officer"
	outfit_type = /decl/hierarchy/outfit/job/ds90/medical/virologist
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classc)
	hud_icon = "hudvirologist"

	access = list(
		access_med_comms,
		access_medical_equip,
		access_medicallvl1,
		access_medicallvl2,
		access_medicallvl3,
		access_medicallvl4
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_MEDICAL     = SKILL_TRAINED,
	                    SKILL_ANATOMY     = SKILL_TRAINED,
	                    SKILL_CHEMISTRY   = SKILL_BASIC,
						SKILL_DEVICES     = SKILL_TRAINED)

	max_skill = list(   SKILL_MEDICAL     = SKILL_MASTER,
	                    SKILL_ANATOMY     = SKILL_MASTER,
	                    SKILL_CHEMISTRY   = SKILL_MASTER)
	skill_points = 23

/datum/job/surgeon
	title = "Surgeon"
	department = "Medical"
	department_flag = MED
	selection_color = "#013d3b"
	total_positions = 2
	spawn_positions = 2
	ideal_character_age = 40
	economic_power = 5
	//supervisors = "the Chief Medical Officer"
	minimal_player_age = 3
	outfit_type = /decl/hierarchy/outfit/job/ds90/medical/surgeon
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classb)
	hud_icon = "hudsurgeon"

	access = list(
		access_med_comms,
		access_medical_equip,
		access_medicallvl1,
		access_medicallvl2,
		access_medicallvl3,
		access_sciencelvl1,
		access_sciencelvl2
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_MEDICAL     = SKILL_EXPERIENCED,
	                    SKILL_ANATOMY     = SKILL_EXPERIENCED,
	                    SKILL_CHEMISTRY   = SKILL_BASIC,
						SKILL_DEVICES     = SKILL_TRAINED)

	max_skill = list(   SKILL_MEDICAL     = SKILL_MASTER,
	                    SKILL_ANATOMY     = SKILL_MASTER,
	                    SKILL_CHEMISTRY   = SKILL_MASTER)
	skill_points = 27

/datum/job/emt
	title = "Emergency Medical Technician"
	department = "Medical"
	department_flag = MED
	selection_color = "#013d3b"
	total_positions = 2
	spawn_positions = 2
	ideal_character_age = 40
	economic_power = 5
	//duties = "<big><b>As the EMT it is your job to man the medical post near the Class D cell block, and treat any injuries there of the guards or Class D's. You only have limited supplies, so it's best to make them count.</b></big>"
	//supervisors = "the Chief Medical Officer"
	outfit_type = /decl/hierarchy/outfit/job/ds90/medical/emt
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classc)
	hud_icon = "hudemt"

	access = list(
		access_med_comms,
		access_medical_equip,
		access_securitylvl1,
		access_sciencelvl1,
		access_engineeringlvl1,
		access_adminlvl1,
		access_medicallvl1,
		access_medicallvl2
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_MEDICAL     = SKILL_TRAINED,
	                    SKILL_ANATOMY     = SKILL_TRAINED,
	                    SKILL_CHEMISTRY   = SKILL_BASIC,
						SKILL_DEVICES     = SKILL_TRAINED)

	max_skill = list(   SKILL_MEDICAL     = SKILL_MASTER,
	                    SKILL_ANATOMY     = SKILL_MASTER,
	                    SKILL_CHEMISTRY   = SKILL_MASTER)
	skill_points = 20
