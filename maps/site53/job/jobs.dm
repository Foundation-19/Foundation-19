/////////////
//READ THIS//
/////////////
// WARNING: DO NOT ADD INTEGER VALUES ABOVE 20 FOR ANY STAT OR SKILL OTHER THAN INTELLIGENCE, MEDICAL AND ENGINEERING. - LION

/datum/map/site_ds90
/datum/map/site_ds90/setup_map()

/datum/job/assistant
	title = "Class D"
	department = "Civilian"
	selection_color = "#E55700"
	economic_power = 1
	total_positions = 999
	spawn_positions = 999
	//duties = "<big><b>As a Class D Foundation Employee, you are most likely a former convict who faced a life sentence or the death penalty. You are extremely grateful to have been offered the chance to participate in the Foundation's rapid rehabilitation program, at a facility which aims to release you into the free world in just 30 days.<br> Find a way to show you're ready to re-integrate into society: work in mining, botany, the kitchens, or volunteer yourself as a participant in scientific studies.<br> <span style = 'color:red'>REMEMBER!</span> Rioting as Class D has been prohibited without staff approval, under rule 15. <br>IMPORTANT! Do not try to break out of your cell at game start. You will break your only way out!</span>"
	access = list()			//See /datum/job/assistant/get_access()
	minimal_access = list()	//See /datum/job/assistant/get_access()
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/civ/classd
	allowed_ranks = list(/datum/mil_rank/civ/classd)
	var/static/list/used_numbers = list()



/datum/job/assistant/equip(mob/living/carbon/human/H)
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
		ID.update_name()



/datum/job/captain
	title = "Site Director"
	//duties = "<big><b>As the Site Director you are responsible for the operations happening in the Site that you manage.<br>You won't have access to SCP's, or the D-Class area.<br> As Site Director, you should worry about making sure all SOP and safety procedures are followed by delegating to the heads of staff.<br><span style = 'color:red'>It is not your job to jump in where necessary! Consistently bad roleplay will be punished under the CoHoS rule!</span>"
	minimal_player_age = 20
	economic_power = 15
	ideal_character_age = 50
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/command/facilitydir
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classa)
	equip(var/mob/living/carbon/human/H)
		..()

	access = list(
		access_com_comms, // SD and HoP do not want to hear all the details, either meet your Commander in person or talk to the Tower
		access_sci_comms,
		access_adminlvl1,
		access_securitylvl1,
		access_securitylvl2,
		access_securitylvl3,
		access_securitylvl4,
		access_securitylvl5,
		access_sciencelvl1,
		access_sciencelvl2,
		access_sciencelvl3,
		access_sciencelvl4,
		access_sciencelvl5,
		access_engineeringlvl1,
		access_engineeringlvl2,
		access_engineeringlvl3,
		access_engineeringlvl4,
		access_engineeringlvl5,
		access_medicallvl1,
		access_medicallvl2,
		access_medicallvl3,
		access_medicallvl4,
		access_medicallvl5,
		access_adminlvl5,
		access_adminlvl4,
		access_adminlvl3,
		access_adminlvl2,
		access_adminlvl1,
		access_keyauth
	)
	minimal_access = list()



/datum/job/hop
	title = "Head of Personnel"
	department = "Command"
	department_flag = COM
	total_positions = 0
	spawn_positions = 0
	//duties = "<big><b>As the Head of Personnel, you're the right hand of the Site Director.<br>You can go to places he, or she couldn't, but still won't have access to SCP's, or the D-Class Cells.<br>Your job is to be the Site Director's eyes and ears, as well as being in charge of personnel outside of the Security branch.<br>You reserve the right to promote and demote people in cases of emergencies, otherwise, approval of the Site Director is needed.<br><span style = 'color:red'>It is not your job to jump in where necessary! Bad roleplay will be punished!</span>"
	minimal_player_age = 15
	economic_power = 10
	ideal_character_age = 45
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/command/headofhr
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classa)
	alt_titles = list("Personnel Director")
	equip(var/mob/living/carbon/human/H)
		..()

	access = list(
		access_adminlvl1,
		access_adminlvl2,
		access_adminlvl3,
		access_adminlvl4,
		access_com_comms,
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
	//duties = "<big><b>As the Communications Officer it is your job to monitor the radio, help coordinate departments, and dispatch help where it is needed. Keep sensitive communications off the Common channel.<br>You should not ever leave your tower unless under specific circumstances."
	minimal_player_age = 15
	economic_power = 10
	ideal_character_age = 45
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/command/commsofficer
	allowed_branches = list(/datum/mil_branch/security)
	allowed_ranks = list(
	/datum/mil_rank/security/w5,
	/datum/mil_rank/security/w6
	)
	equip(var/mob/living/carbon/human/H)
		..()


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
		access_securitylvl1,
		access_sciencelvl1,
		access_sciencelvl2,
		access_sciencelvl3,
		access_sciencelvl3,
		access_securitylvl1,
		access_engineeringlvl1,
		access_engineeringlvl2,
		access_engineeringlvl3,
		access_keyauth
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY  = SKILL_BASIC,
	                    SKILL_COMPUTER     = SKILL_ADEPT,
	                    SKILL_EVA          = SKILL_ADEPT,
	                    SKILL_CONSTRUCTION = SKILL_ADEPT,
	                    SKILL_ELECTRICAL   = SKILL_ADEPT,
	                    SKILL_ATMOS        = SKILL_ADEPT,
	                    SKILL_ENGINES      = SKILL_EXPERT)

	max_skill = list(   SKILL_CONSTRUCTION = SKILL_MAX,
	                    SKILL_ELECTRICAL   = SKILL_MAX,
	                    SKILL_ATMOS        = SKILL_MAX,
	                    SKILL_ENGINES      = SKILL_MAX)
	skill_points = 30

/datum/job/commeng
	selection_color = "#5b4d20"
	title = "Communications Technician"
	total_positions = 2
	spawn_positions = 2
	//duties = "<big><b>As a member of the Communications team it is your job to maintain long-range comms, monitor the happenings on the Telecomms servers and assess situations by mere observation. Your job may entail being a dispatch center of the likes.<br>You should not ever leave your tower unless under specific circumstances."
	department_flag = ENG
	economic_power = 5
	minimal_player_age = 7
	ideal_character_age = 30
	alt_titles = list(
		"Communications Programmer",
		"Communications Dispatcher"
		)
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/command/commstech
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/w1
	)
	equip(var/mob/living/carbon/human/H)
		..()

	access = list(
	access_com_comms,
	access_sci_comms,
	access_civ_comms,
	access_log_comms,
	access_med_comms,
	access_eng_comms,
	access_sec_comms,
	access_adminlvl1,
	access_adminlvl1,
	access_adminlvl2,
	access_engineeringlvl1,
	access_engineeringlvl2,
	access_engineeringlvl3
	)

	min_skill = list(   SKILL_COMPUTER     = SKILL_BASIC,
	                    SKILL_EVA          = SKILL_BASIC,
	                    SKILL_CONSTRUCTION = SKILL_ADEPT,
	                    SKILL_ELECTRICAL   = SKILL_BASIC,
	                    SKILL_ATMOS        = SKILL_BASIC,
	                    SKILL_ENGINES      = SKILL_BASIC)

	max_skill = list(   SKILL_CONSTRUCTION = SKILL_MAX,
	                    SKILL_ELECTRICAL   = SKILL_MAX,
	                    SKILL_ATMOS        = SKILL_MAX,
	                    SKILL_ENGINES      = SKILL_MAX)
	skill_points = 20

/*
## END OF GENERIC COMMAND ##
*/

// SECURITY
/datum/job/hos
	title = "Guard Commander"
	department = "Command"
	department_flag = SEC|COM
	//duties = "<big><b>As the Guard Commander, you have direct say over the Security department. You're not assigned to any zone, but instead should jump in where necessary or requested. You are to speak with your Zone Commanders oftenly, and assign new guards to the right zone, or where it's needed mostly.</span>"
	economic_power = 8
	minimal_player_age = 15
	ideal_character_age = 55
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/command/cos
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/o3,
		/datum/mil_rank/security/o4,
		/datum/mil_rank/security/o5
	)
	equip(var/mob/living/carbon/human/H)
		..()

	access = list(
		access_com_comms,
		access_sec_comms,
		access_securitylvl1,
		access_securitylvl2,
		access_securitylvl3,
		access_securitylvl4,
		access_securitylvl5,
		access_adminlvl1,
		access_adminlvl2,
		access_adminlvl3,
		access_adminlvl4,
		access_sciencelvl1,
		access_sciencelvl2,
		access_sciencelvl3,
		access_sciencelvl4,
		access_keyauth
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_ADEPT,
	                    SKILL_EVA         = SKILL_BASIC,
	                    SKILL_COMBAT      = SKILL_BASIC,
	                    SKILL_WEAPONS     = SKILL_ADEPT,
	                    SKILL_FORENSICS   = SKILL_BASIC)

	max_skill = list(   SKILL_COMBAT      = SKILL_MAX,
	                    SKILL_WEAPONS     = SKILL_MAX,
	                    SKILL_FORENSICS   = SKILL_MAX)
	skill_points = 28

	software_on_spawn = list(/datum/computer_file/program/digitalwarrant,
							 /datum/computer_file/program/camera_monitor)
//##
//ZONE COMMANDERS
//##


/datum/job/ltofficerlcz

	title = "LCZ Zone Commander"
	department = "Light Containment Personnel"
	department_flag = SEC
	total_positions = 1
	spawn_positions = 1
	//duties = "<big><b>As the Zone Commander, you're the right hand of the Guard Commander, and in charge of a specific zone. In this zone, you have full command of the guards stationed there in every situation, except Code Red or higher. You also carry the responsibility of guarding the D-Cells. You should not leave your zone under usual SoP</span>"
	economic_power = 4
	minimal_player_age = 10
	ideal_character_age = 45
	alt_titles = null
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/security/ltofficerlcz
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/o1
	)
	equip(var/mob/living/carbon/human/H)
		..()

	access = list(
		access_sec_comms,
		access_securitylvl1,
		access_securitylvl2,
		access_securitylvl3,
		access_securitylvl4,
		access_adminlvl1,
		access_adminlvl2,
		access_sciencelvl1,
		access_sciencelvl2,
		access_sciencelvl3,
		access_keyauth
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_COMPUTER    = SKILL_BASIC,
	                    SKILL_EVA         = SKILL_BASIC,
	                    SKILL_COMBAT      = SKILL_BASIC,
	                    SKILL_WEAPONS     = SKILL_BASIC,
	                    SKILL_FORENSICS   = SKILL_ADEPT)

	max_skill = list(   SKILL_COMBAT      = SKILL_EXPERT,
	                    SKILL_WEAPONS     = SKILL_EXPERT,
	                    SKILL_FORENSICS   = SKILL_MAX)
	skill_points = 20

/datum/job/ltofficerhcz
	title = "HCZ Zone Commander"
	department = "Heavy Containment Personnel"
	department_flag = SEC
	total_positions = 1
	spawn_positions = 1
	//duties = "<big><b>As the Zone Commander, you're the right hand of the Guard Commander, and in charge of a specific zone. In this zone, you have full command of the guards stationed there in every situation, except Code Red or higher. You should not leave your zone under usual SoP</span>"
	economic_power = 4
	minimal_player_age = 10
	ideal_character_age = 45
	alt_titles = null
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/security/ltofficerhcz
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/o2
	)
	equip(var/mob/living/carbon/human/H)
		..()

	access = list(
		access_sec_comms,
		access_securitylvl1,
		access_securitylvl2,
		access_securitylvl3,
		access_securitylvl4,
		access_adminlvl1,
		access_adminlvl2,
		access_sciencelvl1,
		access_sciencelvl2,
		access_sciencelvl3,
		access_sciencelvl4,
		access_keyauth
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_COMPUTER    = SKILL_BASIC,
	                    SKILL_EVA         = SKILL_BASIC,
	                    SKILL_COMBAT      = SKILL_BASIC,
	                    SKILL_WEAPONS     = SKILL_BASIC,
	                    SKILL_FORENSICS   = SKILL_ADEPT)

	max_skill = list(   SKILL_COMBAT      = SKILL_EXPERT,
	                    SKILL_WEAPONS     = SKILL_EXPERT,
	                    SKILL_FORENSICS   = SKILL_MAX)
	skill_points = 20

/datum/job/ltofficerez
	title = "EZ Supervisor"
	department = "Entrance Personnel"
	department_flag = SEC
	total_positions = 1
	spawn_positions = 1
	//duties = "<big><b>As the Entrance Zone Senior Agent, you and your team work independently from the guard commander and regular security structure. In this zone, you are tasked with the protection of administrative personnel, together with the agents stationed here. You should not leave your zone under usual SoP, or allow administration to go without protection detail into the facility.</span>"
	economic_power = 4
	minimal_player_age = 10
	ideal_character_age = 45
	alt_titles = null
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/security/ltofficerez
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/w5
	)
	equip(var/mob/living/carbon/human/H)
		..()

	access = list(
		access_sec_comms,
		access_securitylvl1,
		access_securitylvl2,
		access_securitylvl3,
		access_securitylvl4,
		access_adminlvl1,
		access_adminlvl2,
		access_adminlvl3,
		access_adminlvl4,
		access_sciencelvl1,
		access_sciencelvl2,
		access_engineeringlvl1,
		access_engineeringlvl2,
		access_medicallvl1,
		access_medicallvl2,
		access_medicallvl3,
		access_medicallvl4,
		access_keyauth
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_COMPUTER    = SKILL_BASIC,
	                    SKILL_EVA         = SKILL_BASIC,
	                    SKILL_COMBAT      = SKILL_BASIC,
	                    SKILL_WEAPONS     = SKILL_BASIC,
	                    SKILL_FORENSICS   = SKILL_ADEPT)

	max_skill = list(   SKILL_COMBAT      = SKILL_EXPERT,
	                    SKILL_WEAPONS     = SKILL_EXPERT,
	                    SKILL_FORENSICS   = SKILL_MAX)
	skill_points = 28

//##
// OFFICERS
//##

/datum/job/ncoofficerlcz

	title = "LCZ Sergeant"
	department = "Light Containment Personnel"
	department_flag = SEC
	total_positions = 4
	spawn_positions = 4
	//duties = "<big><b>As the Guard you have more access than a Junior Guard, but do not control them. You are to guard tests and SCP's in the zone you spawned in. If in doubt, ask your Zone or Guard Commander. You also have the duty of guarding the D-Class Cell Blocks. You should not leave your zone under usual SoP."
	economic_power = 4
	minimal_player_age = 5
	ideal_character_age = 25
	alt_titles = null
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/security/ncoofficerlcz
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/e2,
		/datum/mil_rank/security/e3,
		/datum/mil_rank/security/e4,
		/datum/mil_rank/security/e5
	)
	equip(var/mob/living/carbon/human/H)
		..()

	access = list(
		access_sec_comms,
		access_securitylvl1,
		access_securitylvl2,
		access_sciencelvl1,
		access_sciencelvl2,
		access_dclasskitchen,
		access_dclassbotany,
		access_dclassmining,
		access_dclassjanitorial
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_COMPUTER    = SKILL_BASIC,
	                    SKILL_EVA         = SKILL_BASIC,
	                    SKILL_COMBAT      = SKILL_BASIC,
	                    SKILL_WEAPONS     = SKILL_BASIC,
	                    SKILL_FORENSICS   = SKILL_ADEPT)

	max_skill = list(   SKILL_COMBAT      = SKILL_EXPERT,
	                    SKILL_WEAPONS     = SKILL_EXPERT,
	                    SKILL_FORENSICS   = SKILL_MAX)
	skill_points = 20

/datum/job/ncoofficerhcz
	title = "HCZ Sergeant"
	department = "Heavy Containment Personnel"
	department_flag = SEC
	total_positions = 3
	spawn_positions = 3
	//duties = "<big><b>As the Guard you have more access than a Junior Guard, but do not control them. You are to guard tests and SCP's in the zone you spawned in. If in doubt, ask your Zone or Guard Commander. You also have the duty of guarding the D-Class Cell Blocks. You should not leave your zone under usual SoP."
	economic_power = 4
	minimal_player_age = 5
	ideal_character_age = 25
	alt_titles = null
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/security/ncoofficerhcz
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/e4,
		/datum/mil_rank/security/e5,
		/datum/mil_rank/security/e6
	)
	equip(var/mob/living/carbon/human/H)
		..()

	access = list(
	access_sec_comms,
	access_securitylvl1,
	access_securitylvl2,
	access_securitylvl3,
	access_sciencelvl1,
	access_sciencelvl2,
	access_sciencelvl3
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_COMPUTER    = SKILL_BASIC,
	                    SKILL_EVA         = SKILL_BASIC,
	                    SKILL_COMBAT      = SKILL_BASIC,
	                    SKILL_WEAPONS     = SKILL_BASIC,
	                    SKILL_FORENSICS   = SKILL_ADEPT)

	max_skill = list(   SKILL_COMBAT      = SKILL_EXPERT,
	                    SKILL_WEAPONS     = SKILL_EXPERT,
	                    SKILL_FORENSICS   = SKILL_MAX)
	skill_points = 20

/datum/job/ncoofficerez
	title = "EZ Senior Agent"
	department = "Entrance Zone Personnel"
	department_flag = SEC
	total_positions = 2
	spawn_positions = 2
	//duties = "<big><b>As the Agent you have more access than a Junior Agent, but do not control them. You are to guard tests and SCP's in the zone you spawned in. If in doubt, ask your Zone or Guard Commander. You also have the duty of guarding the D-Class Cell Blocks. You should not leave your zone under usual SoP."
	economic_power = 4
	minimal_player_age = 5
	ideal_character_age = 30
	alt_titles = null
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/security/ncoofficerez
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/e7,
		/datum/mil_rank/security/e8
	)
	equip(var/mob/living/carbon/human/H)
		..()

	access = list(
		access_sec_comms,
		access_sciencelvl1,
		access_medicallvl1,
		access_medicallvl2,
		access_medicallvl3,
		access_engineeringlvl1,
		access_securitylvl1,
		access_securitylvl2,
		access_securitylvl3,
		access_adminlvl1,
		access_adminlvl2,
		access_adminlvl3
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_COMPUTER    = SKILL_BASIC,
	                    SKILL_EVA         = SKILL_BASIC,
	                    SKILL_COMBAT      = SKILL_BASIC,
	                    SKILL_WEAPONS     = SKILL_BASIC,
	                    SKILL_FORENSICS   = SKILL_ADEPT)

	max_skill = list(   SKILL_COMBAT      = SKILL_EXPERT,
	                    SKILL_WEAPONS     = SKILL_EXPERT,
	                    SKILL_FORENSICS   = SKILL_MAX)
	skill_points = 20
//##
//JUNIOR OFFICER
//##

/datum/job/enlistedofficerlcz

	title = "LCZ Guard"
	department = "Light Containment Personnel"
	department_flag = SEC
	total_positions = 10
	spawn_positions = 10
	//duties = "<big><b>As the Junior Guard you have minimal access. You are to guard tests, SCP's and provide support in the zone you spawned in. If in doubt, ask your Zone or Guard Commander. You also have the duty of guarding the D-Class Cell Blocks. You should not leave your zone under usual SoP."
	economic_power = 4
//	minimal_player_age = 0
	ideal_character_age = 25
	alt_titles = null
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/security/enlistedofficerlcz
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/e1,
		/datum/mil_rank/security/e2
	)
	equip(var/mob/living/carbon/human/H)
		..()

	access = list(
		access_sec_comms,
		access_securitylvl1,
		access_securitylvl2,
		access_sciencelvl1,
		access_sciencelvl2,
		access_dclasskitchen,
		access_dclassbotany,
		access_dclassmining,
		access_dclassjanitorial
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_COMPUTER    = SKILL_BASIC,
	                    SKILL_EVA         = SKILL_BASIC,
	                    SKILL_COMBAT      = SKILL_BASIC,
	                    SKILL_WEAPONS     = SKILL_BASIC,
	                    SKILL_FORENSICS   = SKILL_ADEPT)

	max_skill = list(   SKILL_COMBAT      = SKILL_EXPERT,
	                    SKILL_WEAPONS     = SKILL_EXPERT,
	                    SKILL_FORENSICS   = SKILL_MAX)
	skill_points = 15

/datum/job/enlistedofficerhcz

	title = "HCZ Guard"
	department = "Heavy Containment Personnel"
	department_flag = SEC
	total_positions = 2
	spawn_positions = 2
	//duties = "<big><b>As the Junior Guard you have minimal access. You are to guard tests, SCP's and provide support in the zone you spawned in. If in doubt, ask your Zone or Guard Commander. You should not leave your zone under usual SoP."
	//supervisors = "the Guard/Zone Commander"
	economic_power = 4
//	minimal_player_age = 0
	ideal_character_age = 25
	alt_titles = null
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/security/enlistedofficerhcz
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/e3,
		/datum/mil_rank/security/e4
	)
	equip(var/mob/living/carbon/human/H)
		..()

	access = list(
		access_sec_comms,
		access_securitylvl1,
		access_securitylvl2,
		access_securitylvl3,
		access_sciencelvl1,
		access_sciencelvl2,
		access_sciencelvl3
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_COMPUTER    = SKILL_BASIC,
	                    SKILL_EVA         = SKILL_BASIC,
	                    SKILL_COMBAT      = SKILL_BASIC,
	                    SKILL_WEAPONS     = SKILL_BASIC,
	                    SKILL_FORENSICS   = SKILL_ADEPT)

	max_skill = list(   SKILL_COMBAT      = SKILL_EXPERT,
	                    SKILL_WEAPONS     = SKILL_EXPERT,
	                    SKILL_FORENSICS   = SKILL_MAX)
	skill_points = 15

/datum/job/enlistedofficerez

	title = "EZ Agent"
	department = "Entrance Personnel"
	department_flag = SEC
	total_positions = 2
	spawn_positions = 2
	//duties = "<big><b>As the Junior Agent you have minimal access. You are to guard tests, SCP's and provide support in the zone you spawned in. If in doubt, ask your Zone or Guard Commander. You should not leave your zone under usual SoP."
	economic_power = 4
	minimal_player_age = 0
	ideal_character_age = 27
	alt_titles = null
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/security/enlistedofficerez
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/e4,
		/datum/mil_rank/security/e5
	)
	equip(var/mob/living/carbon/human/H)
		..()
	access = list(
		access_sciencelvl1,
		access_sec_comms,
		access_securitylvl1,
		access_securitylvl2,
		access_securitylvl3,
		access_adminlvl1,
		access_adminlvl2,
		access_adminlvl3,
		access_sciencelvl1,
		access_sciencelvl2,
		access_medicallvl1,
		access_medicallvl2,
		access_medicallvl3
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_COMPUTER    = SKILL_BASIC,
	                    SKILL_EVA         = SKILL_BASIC,
	                    SKILL_COMBAT      = SKILL_BASIC,
	                    SKILL_WEAPONS     = SKILL_BASIC,
	                    SKILL_FORENSICS   = SKILL_ADEPT)

	max_skill = list(   SKILL_COMBAT      = SKILL_EXPERT,
	                    SKILL_WEAPONS     = SKILL_EXPERT,
	                    SKILL_FORENSICS   = SKILL_MAX)
	skill_points = 20
// SCIENCE

/datum/job/juniorscientist

	title = "Researcher Associate"
	department = "Science"
	department_flag = SCI
	total_positions = 6
	spawn_positions = 6
	//supervisors = "the Research Director and anyone in a higher position than you"
	economic_power = 4
	alt_titles = list("Xenobiologist Associate", "Xenoarcheologist Associate")
	ideal_character_age = 22
	alt_titles = null
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/science/juniorscientist
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classc)
	equip(var/mob/living/carbon/human/H)
		..()

	access = list(
	access_sci_comms,
	access_sciencelvl1,
	access_sciencelvl2
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_COMPUTER    = SKILL_BASIC,
	                    SKILL_DEVICES     = SKILL_BASIC,
	                    SKILL_SCIENCE     = SKILL_ADEPT)

	max_skill = list(   SKILL_ANATOMY     = SKILL_MAX,
	                    SKILL_DEVICES     = SKILL_MAX,
	                    SKILL_SCIENCE     = SKILL_MAX)

	skill_points = 10

/datum/job/scientist

	title = "Researcher"
	department = "Science"
	department_flag = SCI
	total_positions = 6
	spawn_positions = 6
	//supervisors = "the Research Director and anyone in a higher position than you"
	economic_power = 4
	alt_titles = list("Xenobiologist", "Xenoarcheologist")
	minimal_player_age = 5
	ideal_character_age = 22
	alt_titles = null
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/science/scientist
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classc)
	equip(var/mob/living/carbon/human/H)
		..()

	access = list(
		access_sci_comms,
		access_sciencelvl1,
		access_sciencelvl2,
		access_sciencelvl3,
		access_robotics
		)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_COMPUTER    = SKILL_BASIC,
	                    SKILL_DEVICES     = SKILL_BASIC,
	                    SKILL_SCIENCE     = SKILL_ADEPT)

	max_skill = list(   SKILL_ANATOMY     = SKILL_MAX,
	                    SKILL_DEVICES     = SKILL_MAX,
	                    SKILL_SCIENCE     = SKILL_MAX)

	skill_points = 15

/datum/job/seniorscientist

	title = "Senior Researcher"
	department = "Science"
	department_flag = SCI
	total_positions = 6
	spawn_positions = 6
	//supervisors = "the Research Director and anyone in a higher position than you"
	economic_power = 4
	alt_titles = list("Senior Xenobiologist", "Senior Xenoarcheologist")
	minimal_player_age = 10
	ideal_character_age = 22
	alt_titles = null
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/science/seniorscientist
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classb)
	equip(var/mob/living/carbon/human/H)
		..()


	access = list(
		access_sci_comms,
		access_sciencelvl1,
		access_sciencelvl2,
		access_sciencelvl3,
		access_sciencelvl4,
		access_adminlvl1,
		access_adminlvl2,
		access_adminlvl3,
		access_robotics
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_COMPUTER    = SKILL_BASIC,
	                    SKILL_DEVICES     = SKILL_BASIC,
	                    SKILL_SCIENCE     = SKILL_ADEPT)

	max_skill = list(   SKILL_ANATOMY     = SKILL_MAX,
	                    SKILL_DEVICES     = SKILL_MAX,
	                    SKILL_SCIENCE     = SKILL_MAX)

	skill_points = 20

/datum/job/rd

	title = "Research Director"
	//supervisors = "Facility Director and the Head of Human Resources"
	total_positions = 1
	spawn_positions = 1
	economic_power = 20
	minimal_player_age = 15
	ideal_character_age = 60
	spawn_positions = 6
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/science/researchdirector
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classa)
	equip(var/mob/living/carbon/human/H)
		..()

	access = list(
		access_com_comms,
		access_sci_comms,
		access_sciencelvl5,
		access_sciencelvl4,
		access_sciencelvl3,
		access_sciencelvl2,
		access_sciencelvl1,
		access_adminlvl2,
		access_adminlvl3,
		access_adminlvl4,
		access_keyauth,
		access_robotics,
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_COMPUTER    = SKILL_BASIC,
	                    SKILL_DEVICES     = SKILL_BASIC,
	                    SKILL_SCIENCE     = SKILL_ADEPT)

	max_skill = list(   SKILL_ANATOMY     = SKILL_MAX,
	                    SKILL_DEVICES     = SKILL_MAX,
	                    SKILL_SCIENCE     = SKILL_MAX)

	skill_points = 25

// ENGINEERING


/datum/job/juneng

	title = "Junior Engineer"
	total_positions = 4
	spawn_positions = 4
	department_flag = ENG
	//supervisors = "the Chief Engineer"
	economic_power = 5
	ideal_character_age = 30
	alt_titles = list(
		"Junior Maintenance Technician",
		"Junior Engine Technician",
		"Junior Damage Control Technician",
		"Junior Electrician"
		)
	outfit_type = /decl/hierarchy/outfit/job/ds90/crew/engineering/juneng
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/e1,
		/datum/mil_rank/security/e2
	)
	equip(var/mob/living/carbon/human/H)
		..()

	access = list(
		access_eng_comms,
		access_engineeringlvl1
	)
	minimal_access = list()

	max_skill = list(   SKILL_ANATOMY     = SKILL_MAX,
	                    SKILL_DEVICES     = SKILL_MAX,
	                    SKILL_SCIENCE     = SKILL_MAX)

/datum/job/eng

	title = "Engineer"
	total_positions = 3
	spawn_positions = 3
	department_flag = ENG
	//supervisors = "the Chief Engineer"
	economic_power = 5
	minimal_player_age = 7
	ideal_character_age = 30
	alt_titles = list(
		"Maintenance Technician",
		"Engine Technician",
		"Damage Control Technician",
		"Electrician"
		)
	outfit_type = /decl/hierarchy/outfit/job/ds90/crew/engineering/juneng
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/e3,
		/datum/mil_rank/security/e4,
		/datum/mil_rank/security/e5
	)
	equip(var/mob/living/carbon/human/H)
		..()

	access = list(
	access_eng_comms,
	access_securitylvl1,
	access_sciencelvl1,
	access_sciencelvl2,
	access_engineeringlvl1,
	access_engineeringlvl2,
	)
	minimal_access = list()

	min_skill = list(   SKILL_COMPUTER     = SKILL_BASIC,
	                    SKILL_HAULING      = SKILL_ADEPT,
	                    SKILL_EVA          = SKILL_ADEPT,
	                    SKILL_CONSTRUCTION = SKILL_ADEPT,
	                    SKILL_ELECTRICAL   = SKILL_ADEPT,
	                    SKILL_ATMOS        = SKILL_ADEPT,
	                    SKILL_ENGINES      = SKILL_ADEPT)

	max_skill = list(   SKILL_CONSTRUCTION = SKILL_MAX,
	                    SKILL_ELECTRICAL   = SKILL_MAX,
	                    SKILL_ATMOS        = SKILL_MAX,
	                    SKILL_ENGINES      = SKILL_MAX)

/datum/job/seneng

	title = "Senior Engineer"
	total_positions = 2
	spawn_positions = 2
	department_flag = ENG
	//supervisors = "the Chief Engineer"
	economic_power = 5
	minimal_player_age = 7
	ideal_character_age = 30
	alt_titles = list(
		"Senior Maintenance Technician",
		"Senior Engine Technician",
		"Senior Damage Control Technician",
		"Senior Electrician"
		)
	outfit_type = /decl/hierarchy/outfit/job/ds90/crew/engineering/seneng
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/e6,
		/datum/mil_rank/security/e7,
		/datum/mil_rank/security/e8
	)
	equip(var/mob/living/carbon/human/H)
		..()

	access = list(
		access_eng_comms,
		access_securitylvl1,
		access_sciencelvl1,
		access_sciencelvl2,
		access_engineeringlvl1,
		access_engineeringlvl2,
		access_engineeringlvl3,
		access_engineeringlvl4
	)
	minimal_access = list()

	min_skill = list(   SKILL_COMPUTER     = SKILL_BASIC,
	                    SKILL_HAULING      = SKILL_ADEPT,
	                    SKILL_EVA          = SKILL_ADEPT,
	                    SKILL_CONSTRUCTION = SKILL_ADEPT,
	                    SKILL_ELECTRICAL   = SKILL_ADEPT,
	                    SKILL_ATMOS        = SKILL_ADEPT,
	                    SKILL_ENGINES      = SKILL_ADEPT)

	max_skill = list(   SKILL_CONSTRUCTION = SKILL_MAX,
	                    SKILL_ELECTRICAL   = SKILL_MAX,
	                    SKILL_ATMOS        = SKILL_MAX,
	                    SKILL_ENGINES      = SKILL_MAX)

/datum/job/conteng

	title = "Containment Engineer"
	total_positions = 1
	spawn_positions = 1
	department_flag = ENG
	//supervisors = "the Chief Engineer"
	economic_power = 5
	minimal_player_age = 7
	ideal_character_age = 30
	outfit_type = /decl/hierarchy/outfit/job/ds90/crew/engineering/conteng
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/e9,
		/datum/mil_rank/security/w2,
		/datum/mil_rank/security/w3,
		/datum/mil_rank/security/w4
	)
	equip(var/mob/living/carbon/human/H)
		..()

	access = list(
		access_eng_comms,
		access_securitylvl1,
		access_securitylvl2,
		access_securitylvl3,
		access_sciencelvl1,
		access_sciencelvl2,
		access_sciencelvl3,
		access_sciencelvl4,
		access_engineeringlvl1,
		access_engineeringlvl2,
		access_engineeringlvl3,
		access_engineeringlvl4
	)
	minimal_access = list()

	min_skill = list(   SKILL_COMPUTER     = SKILL_BASIC,
	                    SKILL_HAULING      = SKILL_ADEPT,
	                    SKILL_EVA          = SKILL_ADEPT,
	                    SKILL_CONSTRUCTION = SKILL_ADEPT,
	                    SKILL_ELECTRICAL   = SKILL_ADEPT,
	                    SKILL_ATMOS        = SKILL_ADEPT,
	                    SKILL_ENGINES      = SKILL_ADEPT)

	max_skill = list(   SKILL_CONSTRUCTION = SKILL_MAX,
	                    SKILL_ELECTRICAL   = SKILL_MAX,
	                    SKILL_ATMOS        = SKILL_MAX,
	                    SKILL_ENGINES      = SKILL_MAX)

/datum/job/chief_engineer

	title = "Chief Engineer"
	//supervisors = "the Security Commander and Facility Director"
	total_positions = 1
	spawn_positions = 1
	economic_power = 9
	ideal_character_age = 40
	minimal_player_age = 15
	outfit_type = /decl/hierarchy/outfit/job/ds90/crew/command/chief_engineer
	allowed_branches = list(/datum/mil_branch/security)
	allowed_ranks = list(
	/datum/mil_rank/security/o2,
	/datum/mil_rank/security/o3
	)
	equip(var/mob/living/carbon/human/H)
		..()

	access = list(
	access_eng_comms,
	access_securitylvl1,
	access_securitylvl2,
	access_securitylvl3,
	access_securitylvl4,
	access_sciencelvl1,
	access_sciencelvl2,
	access_sciencelvl3,
	access_sciencelvl4,
	access_adminlvl1,
	access_adminlvl2,
	access_engineeringlvl1,
	access_engineeringlvl2,
	access_engineeringlvl3,
	access_engineeringlvl4,
	access_engineeringlvl5,
	access_keyauth,
	access_robotics
	)
	minimal_access = list()

	min_skill = list(   SKILL_COMPUTER     = SKILL_BASIC,
	                    SKILL_HAULING      = SKILL_ADEPT,
	                    SKILL_EVA          = SKILL_ADEPT,
	                    SKILL_CONSTRUCTION = SKILL_ADEPT,
	                    SKILL_ELECTRICAL   = SKILL_ADEPT,
	                    SKILL_ATMOS        = SKILL_ADEPT,
	                    SKILL_ENGINES      = SKILL_ADEPT)

	max_skill = list(   SKILL_CONSTRUCTION = SKILL_MAX,
	                    SKILL_ELECTRICAL   = SKILL_MAX,
	                    SKILL_ATMOS        = SKILL_MAX,
	                    SKILL_ENGINES      = SKILL_MAX)

// MEDICAL JOBS.

/datum/job/cmo

	title = "Chief Medical Officer"
	//supervisors = "the Security Commander"
	economic_power = 10
	minimal_player_age = 15
	ideal_character_age = 48
	alt_titles = list("Medical Director")
	outfit_type = /decl/hierarchy/outfit/job/ds90/crew/command/cmo
	allowed_branches = list(/datum/mil_branch/security)
	allowed_ranks = list(
	/datum/mil_rank/security/o3,
	/datum/mil_rank/security/o4,
	/datum/mil_rank/security/o5
	)

	access = list(access_com_comms,
	access_med_comms,
	access_medical_equip,
	access_keyauth,
	access_medicallvl1,
	access_medicallvl2,
	access_medicallvl3,
	access_medicallvl4,
	access_medicallvl5,
	access_adminlvl1,
	access_adminlvl2
	)
	minimal_access = list()
	equip(var/mob/living/carbon/human/H)
		..()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_MEDICAL     = SKILL_EXPERT,
	                    SKILL_ANATOMY     = SKILL_EXPERT,
	                    SKILL_CHEMISTRY   = SKILL_BASIC,
						SKILL_DEVICES     = SKILL_ADEPT)

	max_skill = list(   SKILL_MEDICAL     = SKILL_MAX,
	                    SKILL_ANATOMY     = SKILL_MAX,
	                    SKILL_CHEMISTRY   = SKILL_MAX)
	skill_points = 20

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
	allowed_branches = list(/datum/mil_branch/security)
	allowed_ranks = list(
		/datum/mil_rank/security/o1)

	access = list(
		access_med_comms,
		access_medical_equip,
		access_medicallvl1,
		access_medicallvl2
	)
	minimal_access = list()
	equip(var/mob/living/carbon/human/H)
		..()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_MEDICAL     = SKILL_ADEPT,
	                    SKILL_ANATOMY     = SKILL_ADEPT,
	                    SKILL_CHEMISTRY   = SKILL_BASIC,
						SKILL_DEVICES     = SKILL_ADEPT)

	max_skill = list(   SKILL_MEDICAL     = SKILL_MAX,
	                    SKILL_ANATOMY     = SKILL_MAX,
	                    SKILL_CHEMISTRY   = SKILL_MAX)
	skill_points = 10

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
	allowed_ranks = list(
		/datum/mil_rank/civ/classb)
	equip(var/mob/living/carbon/human/H)
		..()

	access = list(
		access_med_comms,
		access_medical_equip,
		access_medicallvl1
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_MEDICAL     = SKILL_ADEPT,
	                    SKILL_ANATOMY     = SKILL_ADEPT,
	                    SKILL_CHEMISTRY   = SKILL_BASIC,
						SKILL_DEVICES     = SKILL_ADEPT)

	max_skill = list(   SKILL_MEDICAL     = SKILL_MAX,
	                    SKILL_ANATOMY     = SKILL_MAX,
	                    SKILL_CHEMISTRY   = SKILL_MAX)
	skill_points = 10

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
	outfit_type = /decl/hierarchy/outfit/job/ds90/medical/medicaldoctor
	allowed_branches = list(
	/datum/mil_branch/security)
	allowed_ranks = list(
		/datum/mil_rank/security/o1,
		/datum/mil_rank/security/o2)
	equip(var/mob/living/carbon/human/H)
		..()

	access = list(
	access_med_comms,
	access_medical_equip,
	access_medicallvl1,
	access_medicallvl2,
	access_medicallvl3,
	access_securitylvl1
	)
	minimal_access = list()

	min_skill = list(   SKILL_BUREAUCRACY = SKILL_BASIC,
	                    SKILL_MEDICAL     = SKILL_EXPERT,
	                    SKILL_ANATOMY     = SKILL_ADEPT,
	                    SKILL_CHEMISTRY   = SKILL_ADEPT,
						SKILL_DEVICES     = SKILL_ADEPT)

	max_skill = list(   SKILL_MEDICAL     = SKILL_MAX,
	                    SKILL_ANATOMY     = SKILL_MAX,
	                    SKILL_CHEMISTRY   = SKILL_MAX)
	skill_points = 10

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
	allowed_branches = list(
	/datum/mil_branch/civilian)
	allowed_ranks = list(
		/datum/mil_rank/civ/classb)
	equip(var/mob/living/carbon/human/H)
		..()

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
	                    SKILL_MEDICAL     = SKILL_ADEPT,
	                    SKILL_ANATOMY     = SKILL_ADEPT,
	                    SKILL_CHEMISTRY   = SKILL_BASIC,
						SKILL_DEVICES     = SKILL_ADEPT)

	max_skill = list(   SKILL_MEDICAL     = SKILL_MAX,
	                    SKILL_ANATOMY     = SKILL_MAX,
	                    SKILL_CHEMISTRY   = SKILL_MAX)
	skill_points = 25

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
	allowed_branches = list(
	/datum/mil_branch/security)
	allowed_ranks = list(
		/datum/mil_rank/security/o2)
	equip(var/mob/living/carbon/human/H)
		..()

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
	                    SKILL_MEDICAL     = SKILL_EXPERT,
	                    SKILL_ANATOMY     = SKILL_EXPERT,
	                    SKILL_CHEMISTRY   = SKILL_BASIC,
						SKILL_DEVICES     = SKILL_ADEPT)

	max_skill = list(   SKILL_MEDICAL     = SKILL_MAX,
	                    SKILL_ANATOMY     = SKILL_MAX,
	                    SKILL_CHEMISTRY   = SKILL_MAX)
	skill_points = 10

/datum/job/emt

	title = "Emergency Medical Technician"
	department = "Medical"
	department_flag = MED
	selection_color = "#013d3b"
	total_positions = 2
	spawn_positions = 2
	ideal_character_age = 40
	economic_power = 5
	//duties = "<big><b>As the EMT it is your job to man the medical post near the Class D cell block, and treat any injuries there of the guards or Class D's. You only have limited supplies, so it's best to make them count."
	//supervisors = "the Chief Medical Officer"
	outfit_type = /decl/hierarchy/outfit/job/ds90/medical/emt
	allowed_branches = list(
	/datum/mil_branch/security)
	allowed_ranks = list(
		/datum/mil_rank/security/e2,
		/datum/mil_rank/security/e3,
		/datum/mil_rank/security/e4,
		/datum/mil_rank/security/e5
		)
	equip(var/mob/living/carbon/human/H)
		..()


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
	                    SKILL_MEDICAL     = SKILL_ADEPT,
	                    SKILL_ANATOMY     = SKILL_ADEPT,
	                    SKILL_CHEMISTRY   = SKILL_BASIC,
						SKILL_DEVICES     = SKILL_ADEPT)

	max_skill = list(   SKILL_MEDICAL     = SKILL_MAX,
	                    SKILL_ANATOMY     = SKILL_MAX,
	                    SKILL_CHEMISTRY   = SKILL_MAX)
	skill_points = 10

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
	allowed_branches = list(
		/datum/mil_branch/security,
	)
	allowed_ranks = list(
		/datum/mil_rank/security/e7,
		/datum/mil_rank/security/e8,
		/datum/mil_rank/security/e9,
		/datum/mil_rank/security/w1

	)

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


	min_skill = list(   SKILL_BUREAUCRACY = SKILL_ADEPT,
	                    SKILL_FINANCE     = SKILL_BASIC,
	                    SKILL_HAULING     = SKILL_BASIC,
	                    SKILL_EVA         = SKILL_BASIC,
	                    SKILL_PILOT       = SKILL_BASIC)

	max_skill = list(   SKILL_PILOT       = SKILL_MAX)
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
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
	/datum/mil_rank/security/e1,
	/datum/mil_rank/security/e2,
	/datum/mil_rank/security/e3,
	/datum/mil_rank/security/e4,
	/datum/mil_rank/security/e5,
	/datum/mil_rank/security/e6
	)

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


	min_skill = list(   SKILL_BUREAUCRACY = SKILL_ADEPT,
	                    SKILL_FINANCE     = SKILL_BASIC,
	                    SKILL_HAULING     = SKILL_BASIC,
	                    SKILL_EVA         = SKILL_BASIC,
	                    SKILL_PILOT       = SKILL_BASIC)

	max_skill = list(   SKILL_PILOT       = SKILL_MAX)
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
	/datum/mil_rank/civ/classd
	)

	access = list(
	access_civ_comms,
	access_sciencelvl1,
	access_dclassjanitorial // Limited internal D-Block access e.g. when training D-Class or unlocking their crates
	)
	minimal_access = list()
	equip(var/mob/living/carbon/human/H)
		..()

	min_skill = list(   SKILL_HAULING = SKILL_BASIC)

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
	allowed_ranks = list(
	/datum/mil_rank/civ/classd
	)
	equip(var/mob/living/carbon/human/H)
		..()
	access = list(
		access_civ_comms,
		access_dclasskitchen,
		access_dclassbotany
	) // Limited internal D-Block access e.g. when training D-Class or unlocking their crates
	minimal_access = list()

	min_skill = list(   SKILL_COOKING   = SKILL_ADEPT,
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
	/datum/mil_rank/civ/classd
	)
	equip(var/mob/living/carbon/human/H)
		..()
	access = list(
		access_civ_comms,
		access_dclasskitchen,
		access_dclassbotany
	) // Limited internal D-Block access e.g. when training D-Class or unlocking their crates
	minimal_access = list()

	min_skill = list(   SKILL_COOKING   = SKILL_ADEPT,
	                    SKILL_BOTANY    = SKILL_BASIC,
	                    SKILL_CHEMISTRY = SKILL_BASIC)


/datum/job/archivist

	title = "Archivist"
	department = "Civilian"
	department_flag = CIV
	total_positions = 1
	spawn_positions = 1
	minimal_player_age = 9
	//duties = "<big><b>As the Archivist, it is your job to make sure the proper test logs are digitalized and saved in the digital archive, thus safekeeping them forever. You must be picky and selective, and only get those with great quality out! <span style = 'color:red'>REMEMBER!</span> If you put in nonsensical things, or copypasta's such as Woody's got Wood, you will be permanently job banned WITHOUT chance to appeal.</span>"
	//supervisors = "the Research Director"
	economic_power = 4
	minimal_player_age = 5
	ideal_character_age = 30
	alt_titles = null
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/civ/archivist
	allowed_branches = list(
		/datum/mil_branch/civilian
	)
	allowed_ranks = list(
		/datum/mil_rank/civ/classa
	)
	equip(var/mob/living/carbon/human/H)
		..()

	access = list(
	access_civ_comms,
	access_adminlvl1,
	access_adminlvl2,
	access_adminlvl3,
	access_sciencelvl1,
	access_sciencelvl2,
	access_sciencelvl3,
	access_sciencelvl4,
	access_keyauth
	)
	minimal_access = list()

/datum/job/o5rep

	title = "O5 Representative"
	department = "Civilian"
	department_flag = COM
	total_positions = 1
	spawn_positions = 1
//	//duties = "<big><b>As the GOC Representative, your task is to assess the facility and generally advocate for hardline approaches in regards to anomalies and their containment, or destruction. You value human lives far over any anomaly, as does the Global Occult Coalition, and should see to it that lives are preserved where possible, even D-Class ones. Though combat is not your duty, you are issued a revolver to defend yourself with. This job is heavy roleplay: you're expected to be well-versed in actually talking to people on the matters described. Containment of SCPs and direct site matters are not your matters, so don't get involved."
//	//supervisors = "Global Occult Coalition Regional Command"
	economic_power = 5
	minimal_player_age = 5
	minimal_player_age = 9
	ideal_character_age = 30
	alt_titles = list("Global Occult Coalition Representative" = /decl/hierarchy/outfit/job/site90/crew/civ/gocrep)
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/civ/o5rep
	allowed_branches = list(
		/datum/mil_branch/civilian
	)
	allowed_ranks = list(
		/datum/mil_rank/civ/classa
	)
	equip(var/mob/living/carbon/human/H)
		..()

	access = list(
		access_com_comms,
		access_adminlvl1,
		access_adminlvl2,
		access_adminlvl3,
		access_adminlvl4,
		access_adminlvl5,
		access_keyauth
		)
	minimal_access = list()
