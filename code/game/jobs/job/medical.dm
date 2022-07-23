/datum/job/cmo
	title = "Chief Medical Officer"
	head_position = 1
	department = "Medical"
	department_flag = MED|COM

	total_positions = 1
	spawn_positions = 1
	supervisors = "the captain"
	selection_color = "#026865"
	req_admin_notify = 1
	economic_power = 10
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

	minimal_player_age = 14
	ideal_character_age = 50
	outfit_type = /decl/hierarchy/outfit/job/medical/cmo

/datum/job/chemist
	title = "Chemist"
	department = "Medical"
	department_flag = MED

	minimal_player_age = 7
	total_positions = 2
	spawn_positions = 2
	supervisors = "the chief medical officer"
	selection_color = "#013d3b"
	economic_power = 5
	access = list(
		access_med_comms,
		access_medical_equip,
		access_medicallvl1,
		access_medicallvl2
	)
	outfit_type = /decl/hierarchy/outfit/job/medical/chemist

/datum/job/psychiatrist
	title = "Psychiatrist"
	department = "Medical"
	department_flag = MED

	total_positions = 1
	spawn_positions = 1
	economic_power = 5
	minimal_player_age = 3
	supervisors = "the chief medical officer"
	selection_color = "#013d3b"
	access = list(
		access_med_comms,
		access_medical_equip,
		access_medicallvl1
	)
	outfit_type = /decl/hierarchy/outfit/job/medical/psychiatrist

/datum/job/medicaldoctor
	title = "Medical Doctor"
	department = "Medical"
	department_flag = MED
	selection_color = "#013d3b"
	total_positions = 3
	spawn_positions = 3
	ideal_character_age = 40
	economic_power = 5
	supervisors = "the Chief Medical Officer"
	outfit_type = /decl/hierarchy/outfit/job/ds90/medical/medicaldoctor
	allowed_branches = list(
	/datum/mil_branch/civilian)
	allowed_ranks = list(
		/datum/mil_rank/security/e1,
		/datum/mil_rank/security/e2
	)
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

/datum/job/surgeon
	title = "Surgeon"
	department = "Medical"
	department_flag = MED
	selection_color = "#013d3b"
	total_positions = 2
	spawn_positions = 2
	ideal_character_age = 40
	economic_power = 5
	supervisors = "the Chief Medical Officer"
	outfit_type = /decl/hierarchy/outfit/job/ds90/medical/surgeon
	allowed_branches = list(
	/datum/mil_branch/security)
	allowed_ranks = list(/datum/mil_rank/security/e3)
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

/datum/job/emt

	title = "Emergency Medical Technician"
	department = "Medical"
	department_flag = MED
	selection_color = "#013d3b"
	total_positions = 1
	spawn_positions = 1
	ideal_character_age = 40
	economic_power = 5
	supervisors = "the Chief Medical Officer"
	outfit_type = /decl/hierarchy/outfit/job/ds90/medical/emt
	allowed_branches = list(
	/datum/mil_branch/security)
	allowed_ranks = list(/datum/mil_rank/security/e4)
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
