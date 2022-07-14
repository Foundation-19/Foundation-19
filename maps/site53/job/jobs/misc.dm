/datum/job/classd
	title = "Class D"
	department = "Civilian"
	selection_color = "#E55700"
	economic_power = 1
	total_positions = 999
	spawn_positions = 999
	//duties = "<big><b>As a Class D Foundation Employee, you are most likely a former convict who faced a life sentence or the death penalty. You are extremely grateful to have been offered the chance to participate in the Foundation's rapid rehabilitation program, at a facility which aims to release you into the free world in just 30 days.<br> Find a way to show you're ready to re-integrate into society: work in mining, botany, the kitchens, or volunteer yourself as a participant in scientific studies.<br> <span style = 'color:red'>REMEMBER!</span> Rioting as Class D has been prohibited without staff approval, under rule 15. <br>IMPORTANT! Do not try to break out of your cell at game start. You will break your only way out!</b></big>"
	access = list()			//See /datum/job/classd/get_access()
	minimal_access = list()	//See /datum/job/classd/get_access()
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/civ/classd
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classd)
	hud_icon = "huddclass"
	var/static/list/used_numbers = list()

	max_skill = list(   SKILL_COMBAT      = SKILL_TRAINED,
	                    SKILL_WEAPONS     = SKILL_TRAINED)

/datum/job/classd/equip(mob/living/carbon/human/H)
	..()
	var/r = rand(100,9000)
	while (used_numbers.Find(r))
		r = rand(100,9000)
	used_numbers += r
	H.name = random_name(H.gender, H.species.name)
	H.real_name = H.name
	if(istype(H.wear_id, /obj/item/card/id))
		var/obj/item/card/id/ID = H.wear_id
		ID.registered_name = "D-[used_numbers[used_numbers.len]]"



//Office Worker

/datum/job/officeworker
	title = "Office Worker"
	department = "Civilian"
	department_flag = CIV
	total_positions = 100
	spawn_positions = 100
	minimal_player_age = 10
//	supervisors = "the Archivist and administrative staff"
//	duties = "<big><b>You are a low level pen pusher of the SCP Foundation. Your direct supervisor is the Archivist but you may also answer to the O5 and Ethics Committee Representative. Write reports, assist researchers and generally be a pain in the ass to everyone around you.</b></big>"
	economic_power = 2
	minimal_player_age = 5
	ideal_character_age = 30
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/civ/officeworker
	allowed_branches = list(
		/datum/mil_branch/civilian
	)
	allowed_ranks = list(
		/datum/mil_rank/civ/classc
	)
	hud_icon = "hudassistant"

	access = list(
		access_civ_comms,
		access_adminlvl1,
		access_sciencelvl1,
		access_sciencelvl2,
		access_medicallvl1,
		access_medicallvl2,

	)
	minimal_access = list()



//LOGISTICS

/datum/job/qm
	title = "Logistics Officer"
	department = "Logistics"
	department_flag = SUP
	total_positions = 1
	spawn_positions = 1
	//supervisors = "the Site Director"
	selection_color = "#515151"
	economic_power = 5
	minimal_player_age = 7
	ideal_character_age = 35
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/command/logisticsofficer
	hud_icon = "huddeckchief"
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classb)

	access = list(
		access_adminlvl1,
		access_adminlvl2,
		access_log_comms,
		access_maint_tunnels,
		access_emergency_storage,
		access_cargo,
		access_mailsorting
	)
	minimal_access = list()


	min_skill = list(   SKILL_BUREAUCRACY = SKILL_EXPERIENCED,
	                    SKILL_FINANCE     = SKILL_BASIC,
	                    SKILL_HAULING     = SKILL_BASIC,
	                    SKILL_EVA         = SKILL_BASIC,
	                    SKILL_PILOT       = SKILL_BASIC)

	max_skill = list(   SKILL_PILOT       = SKILL_MASTER)
	skill_points = 18

	software_on_spawn = list(/datum/computer_file/program/supply,
							 /datum/computer_file/program/deck_management,
							 /datum/computer_file/program/reports)


/datum/job/cargo_tech
	title = "Logistics Specialist"
	department = "Logistics"
	department_flag = SUP
	total_positions = 2
	spawn_positions = 2
	selection_color = "B4802B"
	//supervisors = "the Logistics Officer"
	minimal_player_age = 3
	ideal_character_age = 24
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/command/logisticspecialist
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classc)
	hud_icon = "huddecktechnician"

	access = list(
	access_log_comms,
	access_maint_tunnels,
	access_emergency_storage,
	access_cargo,
	access_cargo_bot,
	access_adminlvl1,
	access_mailsorting
	)
	minimal_access = list()


	min_skill = list(   SKILL_BUREAUCRACY = SKILL_EXPERIENCED,
	                    SKILL_FINANCE     = SKILL_BASIC,
	                    SKILL_HAULING     = SKILL_BASIC,
	                    SKILL_EVA         = SKILL_BASIC,
	                    SKILL_PILOT       = SKILL_BASIC)

	max_skill = list(   SKILL_PILOT       = SKILL_MASTER)
	skill_points = 18

	software_on_spawn = list(/datum/computer_file/program/supply,
							 /datum/computer_file/program/deck_management,
							 /datum/computer_file/program/reports)


// MISC JOBS

/datum/job/janitor
	title = "Janitor"
	department = "Civilian"
	department_flag = CIV
	total_positions = 3
	spawn_positions = 3
	//supervisors = "the Head of Personnel"
	ideal_character_age = 24
	alt_titles = list("Interior caretaker")
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/civ/janitor
	allowed_branches = list(
		/datum/mil_branch/civilian
	)
	allowed_ranks = list(
	/datum/mil_rank/civ/classc
	)
	hud_icon = "hudsanitationtechnician"

	access = list(
		access_civ_comms,
		access_sciencelvl1,
		access_dclassjanitorial
	) // Limited internal D-Block access e.g. when training D-Class or unlocking their crates

	minimal_access = list()

	min_skill = list(SKILL_HAULING = SKILL_BASIC)

/datum/job/chef
	title = "Chef"
	department = "Civilian"
	department_flag = CIV
	total_positions = 1
	spawn_positions = 1
	//supervisors = "the Head of Personnel"
	selection_color = "#515151"
	ideal_character_age = 24
	alt_titles = list("Cook")
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/civ/chef
	allowed_branches = list(
		/datum/mil_branch/civilian
	)
	hud_icon = "hudcook"
	allowed_ranks = list(
	/datum/mil_rank/civ/classc
	)

	access = list(
		access_civ_comms,
		access_dclasskitchen,
		access_dclassbotany
	) // Limited internal D-Block access e.g. when training D-Class or unlocking their crates
	minimal_access = list()

	min_skill = list(   SKILL_COOKING   = SKILL_EXPERIENCED,
	                    SKILL_BOTANY    = SKILL_BASIC,
	                    SKILL_CHEMISTRY = SKILL_BASIC)


/datum/job/bartender
	title = "Bartender"
	department = "Civilian"
	department_flag = CIV
	total_positions = 1
	spawn_positions = 1
	//supervisors = "the Head of Personnel"
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
	hud_icon = "hudbartender"

	access = list(
		access_civ_comms,
		access_dclasskitchen,
		access_dclassbotany
	) // Limited internal D-Block access e.g. when training D-Class or unlocking their crates
	minimal_access = list()

	min_skill = list(   SKILL_COOKING   = SKILL_EXPERIENCED,
	                    SKILL_BOTANY    = SKILL_BASIC,
	                    SKILL_CHEMISTRY = SKILL_BASIC)


/datum/job/archivist
	title = "Archivist"
	department = "Civilian"
	department_flag = CIV
	total_positions = 1
	spawn_positions = 1
	minimal_player_age = 9
	//duties = "<big><b>As the Archivist, it is your job to make sure the proper test logs are digitalized and saved in the digital archive, thus safekeeping them forever. You must be picky and selective, and only get those with great quality out! <span style = 'color:red'>REMEMBER!</span> If you put in nonsensical things, or copypasta's such as Woody's got Wood, you will be permanently job banned WITHOUT chance to appeal.</b></big>"
	//supervisors = "the Research Director"
	economic_power = 4
	minimal_player_age = 5
	ideal_character_age = 30
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/civ/archivist
	allowed_branches = list(
		/datum/mil_branch/civilian
	)
	allowed_ranks = list(
		/datum/mil_rank/civ/classa
	)
	hud_icon = "hudarchivist"

	access = list(
		access_civ_comms,
		access_sci_comms,
		access_med_comms,
		access_adminlvl1,
		access_adminlvl2,
		access_adminlvl3,
		access_adminlvl4,
		access_keyauth,
		access_research,
		access_sciencelvl1,
		access_sciencelvl2,
		access_sciencelvl3,
		access_sciencelvl4,
		access_medicallvl1,
		access_medicallvl2,
		access_medicallvl3,
		access_medicallvl4
	)
	minimal_access = list()





