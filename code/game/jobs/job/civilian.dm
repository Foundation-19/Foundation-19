//Food
/*
/datum/job/bartender
	title = "Bartender"
	department = "Civilian"
	department_flag = SRV
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
	selection_color = "#515151"
	access = list(access_dclassbotany, access_dclasskitchen, access_dclasskitchen)
	minimal_access = list(access_dclasskitchen)
	outfit_type = /decl/hierarchy/outfit/job/service/bartender

/datum/job/chef
	title = "Chef"
	department = "Civilian"
	department_flag = SRV
	total_positions = 2
	spawn_positions = 2
	supervisors = "the head of personnel"
	selection_color = "#515151"
	access = list(access_dclassbotany, access_dclasskitchen, access_dclasskitchen)
	minimal_access = list(access_dclasskitchen)
	alt_titles = list("Cook")
	outfit_type = /decl/hierarchy/outfit/job/service/chef

/datum/job/hydro
	title = "Gardener"
	department = "Service"
	department_flag = SRV
	total_positions = 2
	spawn_positions = 1
	supervisors = "the head of personnel"
	selection_color = "#515151"
	access = list(access_dclassbotany, access_dclasskitchen, access_dclasskitchen)
	minimal_access = list(access_dclassbotany)
	alt_titles = list("Hydroponicist")
	outfit_type = /decl/hierarchy/outfit/job/service/gardener

//Cargo
/datum/job/qm
	title = "Quartermaster"
	department = "Supply"
	department_flag = SUP
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
	selection_color = "#515151"
	economic_power = 5
	access = list(access_maint_tunnels, access_logistics, access_logistics, access_logistics, access_adminlvl2, access_dclassmining, access_mining_eva)
	minimal_access = list(access_maint_tunnels, access_logistics, access_logistics, access_logistics, access_adminlvl2, access_dclassmining, access_mining_eva)
	minimal_player_age = 3
	ideal_character_age = 40
	outfit_type = /decl/hierarchy/outfit/job/cargo/qm

/datum/job/cargo_tech
	title = "Cargo Technician"
	department = "Supply"
	department_flag = SUP
	total_positions = 2
	spawn_positions = 2
	supervisors = "the quartermaster and the head of personnel"
	selection_color = "#515151"
	access = list(access_maint_tunnels, access_logistics, access_logistics, access_logistics, access_adminlvl2, access_dclassmining, access_mining_eva)
	minimal_access = list(access_maint_tunnels, access_logistics, access_logistics, access_logistics)
	outfit_type = /decl/hierarchy/outfit/job/cargo/cargo_tech

/datum/job/mining
	title = "Shaft Miner"
	department = "Supply"
	department_flag = SUP
	total_positions = 3
	spawn_positions = 3
	supervisors = "the quartermaster and the head of personnel"
	selection_color = "#515151"
	economic_power = 5
	access = list(access_maint_tunnels, access_logistics, access_logistics, access_logistics, access_adminlvl2, access_dclassmining, access_mining_eva)
	minimal_access = list(access_dclassmining, access_mining_eva, access_logistics)
	alt_titles = list("Drill Technician","Prospector")
	outfit_type = /decl/hierarchy/outfit/job/cargo/mining

/datum/job/janitor
	title = "Janitor"
	department = "Service"
	department_flag = SRV
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
	selection_color = "#515151"
	access = list(access_dclassjanitorial, access_maint_tunnels, access_engineeringlvl2, access_sciencelvl2, access_securitylvl1, access_medicallvl2)
	minimal_access = list(access_dclassjanitorial, access_maint_tunnels, access_engineeringlvl2, access_sciencelvl2, access_securitylvl1, access_medicallvl2)
	alt_titles = list("Custodian","Sanitation Technician")
	outfit_type = /decl/hierarchy/outfit/job/service/janitor

//More or less assistants
/datum/job/librarian
	title = "Librarian"
	department = "Civilian"
	department_flag = CIV
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
	selection_color = "#515151"
	access = list(access_library, access_maint_tunnels)
	minimal_access = list(access_library)
	alt_titles = list("Journalist")
	outfit_type = /decl/hierarchy/outfit/job/librarian

/datum/job/lawyer
	title = "Internal Affairs Agent"
	department = "Support"
	department_flag = SPT
	total_positions = 2
	spawn_positions = 2
	supervisors = "company officials and Corporate Regulations"
	selection_color = "#515151"
	economic_power = 7
	access = list(access_adminlvl1, access_securitylvl1, access_maint_tunnels, access_adminlvl4)
	minimal_access = list(access_adminlvl1, access_securitylvl1, access_adminlvl4)
	minimal_player_age = 10
	outfit_type = /decl/hierarchy/outfit/job/internal_affairs_agent

/datum/job/lawyer/equip(var/mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.implant_loyalty(H)
*/

/datum/job/janitor
	title = "Janitor"
	department = "Civilian"
	department_flag = CIV
	total_positions = 2
	spawn_positions = 2
	supervisors = "the Head of Personnel"
	ideal_character_age = 24
	alt_titles = list("Interior caretaker", "Custodian")
	selection_color = "#515151"
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/civ/janitor
	allowed_branches = list(
		/datum/mil_branch/civilian
	)
	allowed_ranks = list(
	/datum/mil_rank/civ/classc
	)

	access = list()
	minimal_access = list()

/datum/job/chef

	title = "Chef"
	department = "Civilian"
	department_flag = CIV
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Head of Personnel"
	selection_color = "#515151"
	ideal_character_age = 24
	alt_titles = list("Cook")
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/civ/chef
	allowed_branches = list(
		/datum/mil_branch/civilian
	)
	allowed_ranks = list(
	/datum/mil_rank/civ/classc
	)

	access = list()

	minimal_access = list()

/datum/job/bartender

	title = "Bartender"
	department = "Civilian"
	department_flag = CIV
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Head of Personnel"
	selection_color = "#515151"
	ideal_character_age = 24
	alt_titles = list("Waiter")
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/civ/bartender
	allowed_branches = list(
		/datum/mil_branch/civilian
	)
	allowed_ranks = list(
	/datum/mil_rank/civ/classc
	)
	access = list()
	minimal_access = list()
