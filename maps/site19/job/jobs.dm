/////////////
//READ THIS//
/////////////
// WARNING: DO NOT ADD INTEGER VALUES ABOVE 20 FOR ANY STAT OR SKILL OTHER THAN INTELLIGENCE, MEDICAL AND ENGINEERING. - LION

/datum/map/site_site19
/datum/map/site_site19/setup_map()

/datum/job/assistant
	title = "Class D"
	department = "Civilian"
	supervisors = "Foundation Personnel"
	selection_color = "#E55700"
	economic_modifier = 1
	total_positions = 15
	spawn_positions = 15
	duties = "<big><b>As a Class D Foundation Employee, you are most likely a former convict who faced a life sentence or the death penalty. You are extremely grateful to have been offered the chance to participate in the Foundation's rapid rehabilitation program, at a facility which aims to release you into the free world in just 30 days.<br> Find a way to show you're ready to re-integrate into society: work in mining, botany, the kitchens, or volunteer yourself as a participant in scientific studies.<br> <span style = 'color:red'>REMEMBER!</span> Rioting as Class D has been prohibited without staff approval, under rule 15. <br>IMPORTANT! Do not try to break out of your cell at game start. You will break your only way out!</b></big>"
	access = list()			//See /datum/job/assistant/get_access()
	minimal_access = list()	//See /datum/job/assistant/get_access()
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/civ/classd
	allowed_ranks = list(/datum/mil_rank/civ/classd)
	var/static/list/used_numbers = list()



/datum/job/assistant/equip(mob/living/carbon/human/H)
	..()
	H.add_stats(rand(1,6), rand(1,6), rand(1,7)) // Str, Dex, Int.
	H.add_skills(rand(10,20), rand(5,10), rand(0,5), rand(5,10)) // Melee, Ranged, Medical, Engineering.

	var/r = rand(100,9000)
	while (used_numbers.Find(r))
		r = rand(100,9000)
	used_numbers += r
	H.name = random_name(H.gender, H.species.name)
	H.real_name = H.name
	if(istype(H.wear_id, /obj/item/weapon/card/id))
		var/obj/item/weapon/card/id/ID = H.wear_id
		ID.registered_name = "D-[used_numbers[used_numbers.len]]"
		ID.update_name()



/datum/job/captain
	has_email = TRUE
	title = "Site Director"
	supervisors = "the SCP Foundation and O5 Council"
	duties = "<big><b>As the Site Director you are responsible for the operations happening in the Site that you manage.<br>You won't have access to SCP's, or the D-Class area.<br> As Site Director, you should worry about making sure all SOP and safety procedures are followed by delegating to the heads of staff.<br><span style = 'color:red'>It is not your job to jump in where necessary! Consistently bad roleplay will be punished under the CoHoS rule!</span></b></big>"
	minimal_player_age = 20
	economic_modifier = 15
	ideal_character_age = 50
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/command/facilitydir
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classa)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(7,10), rand(7,10), rand(12,16))
		H.add_skills(rand(25,40), rand(25,40), rand(65,85), rand(50,70))

	access = list()
	minimal_access = list()


/datum/job/hop
	has_email = TRUE
	title = "Head of Personnel"
	supervisors = "the Facility Director"
	department = "Command"
	department_flag = COM
	total_positions = 0
	spawn_positions = 0
	duties = "<big><b>As the Head of Personnel, you're the right hand of the Site Director.<br>You can go to places he, or she couldn't, but still won't have access to SCP's, or the D-Class Cells.<br>Your job is to be the Site Director's eyes and ears, as well as being in charge of personnel outside of the Security branch.<br>You reserve the right to promote and demote people in cases of emergencies, otherwise, approval of the Site Director is needed.<br><span style = 'color:red'>It is not your job to jump in where necessary! Bad roleplay will be punished!</span></b></big>"
	minimal_player_age = 15
	economic_modifier = 10
	ideal_character_age = 45
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/command/headofhr
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classa)
	alt_titles = list("Personnel Director")
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(7,10), rand(7,10), rand(11,14))
		H.add_skills(rand(25,40), rand(25,40), rand(45,65), rand(40,60))


	access = list()
	minimal_access = list()

// COMMUNICATIONS

/datum/job/commsofficer
	has_email = TRUE
	title = "Communications Officer"
	supervisors = "the Guard Commander"
	department = "Command"
	department_flag = COM
	total_positions = 1
	spawn_positions = 1
	duties = "<big><b>As the Communications Officer it is your job to monitor the radio, help coordinate departments, and dispatch help where it is needed. Keep sensitive communications off the Common channel.<br>You should not ever leave your tower unless under specific circumstances.</b></big>"
	minimal_player_age = 15
	economic_modifier = 10
	ideal_character_age = 45
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/command/commsofficer
	allowed_branches = list(/datum/mil_branch/security)
	allowed_ranks = list(
	/datum/mil_rank/security/w5,
	/datum/mil_rank/security/w6
	)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(7,10), rand(7,10), rand(11,14))
		H.add_skills(rand(25,40), rand(25,40), rand(45,65), rand(40,60))


	access = list()
	minimal_access = list()

/datum/job/commeng
	has_email = TRUE
	selection_color = "#5b4d20"
	title = "Communications Technician"
	total_positions = 2
	spawn_positions = 2
	duties = "<big><b>As a member of the Communications team it is your job to maintain long-range comms, monitor the happenings on the Telecomms servers and assess situations by mere observation. Your job may entail being a dispatch center of the likes.<br>You should not ever leave your tower unless under specific circumstances.</b></big>"
	department_flag = ENG
	supervisors = "the Communications Officer"
	economic_modifier = 5
	minimal_player_age = 7
	ideal_character_age = 30
	alt_titles = list(
		"Communications Programmer"
		)
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/command/commstech
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/w1
	)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(5,7), rand(5,7), rand(20,25)) // Str, Dex, Int.
		H.add_skills(rand(25,30), rand(25,30), rand(5,10), rand(50,60)) // Melee, Ranged, Medical, Engineering.

	access = list()
/*
## END OF GENERIC COMMAND ##
*/

// SECURITY
/datum/job/hos
	has_email = TRUE
	title = "Guard Commander"
	supervisors = "The Facility Director"
	department = "Command"
	department_flag = SEC|COM
	duties = "<big><b>As the Guard Commander, you have direct say over the Security department. You're not assigned to any zone, but instead should jump in where necessary or requested. You are to speak with your Zone Commanders oftenly, and assign new guards to the right zone, or where it's needed mostly.</b></big>"
	economic_modifier = 8
	minimal_player_age = 15
	ideal_character_age = 55
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/command/cos
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
		H.add_stats(rand(10), rand(10), rand(15,20)) // Str, Dex, Int.
		H.add_skills(rand(90,100), rand(90,100), rand(15,30), rand(5,10)) // Melee, Ranged, Medical, Engineering.

	access = list()
	minimal_access = list()
//##
//ZONE COMMANDERS
//##

// COMMENT FOR LATER THIS WEEK, OUTFITS NEED TO BE RE-CODED. ~Lion. 09-10-18

/datum/job/ltofficerlcz
	has_email = TRUE
	title = "LCZ Zone Commander"
	department = "Light Containment Personnel"
	department_flag = SEC
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Guard Commander"
	duties = "<big><b>As the Zone Commander, you're the right hand of the Guard Commander, and in charge of a specific zone. In this zone, you have full command of the guards stationed there in every situation, except Code Red or higher. You also carry the responsibility of guarding the D-Cells. You should not leave your zone under usual SoP</b></big>"
	economic_modifier = 4
	minimal_player_age = 10
	ideal_character_age = 45
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/security/ltofficerlcz
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/o1
	)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(10), rand(10), rand(15,20)) // Str, Dex, Int.
		H.add_skills(rand(80,100), rand(80,100), rand(15,30), rand(5,10)) // Melee, Ranged, Medical, Engineering.

	access = list()
	minimal_access = list()

/datum/job/ltofficerhcz
	has_email = TRUE
	title = "HCZ Zone Commander"
	department = "Heavy Containment Personnel"
	department_flag = SEC
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Guard Commander"
	duties = "<big><b>As the Zone Commander, you're the right hand of the Guard Commander, and in charge of a specific zone. In this zone, you have full command of the guards stationed there in every situation, except Code Red or higher. You should not leave your zone under usual SoP</b></big>"
	economic_modifier = 4
	minimal_player_age = 10
	ideal_character_age = 45
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/security/ltofficerhcz
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/o2
	)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(10), rand(10), rand(15,20)) // Str, Dex, Int.
		H.add_skills(rand(80,100), rand(80,100), rand(15,30), rand(5,10)) // Melee, Ranged, Medical, Engineering.

	access = list()
	minimal_access = list()

/datum/job/ltofficerez
	has_email = TRUE
	title = "EZ Senior Agent"
	department = "Entrance Personnel"
	department_flag = SEC
	total_positions = 1
	spawn_positions = 1
	supervisors = "the O5 Council"
	duties = "<big><b>As the Entrance Zone Senior Agent, you and your team work independently from the guard commander and regular security structure. In this zone, you are tasked with the protection of administrative personnel, together with the agents stationed here. You should not leave your zone under usual SoP, or allow administration to go without protection detail into the facility.</b></big>"
	economic_modifier = 4
	minimal_player_age = 10
	ideal_character_age = 45
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/security/ltofficerez
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/w5
	)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(10), rand(10), rand(15,20)) // Str, Dex, Int.
		H.add_skills(rand(80,100), rand(80,100), rand(15,30), rand(5,10)) // Melee, Ranged, Medical, Engineering.

	access = list()
	minimal_access = list()

//##
// OFFICERS
//##

/datum/job/ncoofficerlcz
	has_email = TRUE
	title = "LCZ Guard"
	department = "Light Containment Personnel"
	department_flag = SEC
	total_positions = 4
	spawn_positions = 4
	duties = "<big><b>As the Guard you have more access than a Junior Guard, but do not control them. You are to guard tests and SCP's in the zone you spawned in. If in doubt, ask your Zone or Guard Commander. You also have the duty of guarding the D-Class Cell Blocks. You should not leave your zone under usual SoP.</b></big>"
	supervisors = "the Guard/Zone Commander"
	economic_modifier = 4
	minimal_player_age = 5
	ideal_character_age = 25
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/security/ncoofficerlcz
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
		H.add_stats(rand(10), rand(10), rand(15,20)) // Str, Dex, Int.
		H.add_skills(rand(60,80), rand(60,80), rand(15,30), rand(5,10)) // Melee, Ranged, Medical, Engineering.

	access = list()
	minimal_access = list()

/datum/job/ncoofficerhcz
	has_email = TRUE
	title = "HCZ Guard"
	department = "Heavy Containment Personnel"
	department_flag = SEC
	total_positions = 3
	spawn_positions = 3
	duties = "<big><b>As the Guard you have more access than a Junior Guard, but do not control them. You are to guard tests and SCP's in the zone you spawned in. If in doubt, ask your Zone or Guard Commander. You also have the duty of guarding the D-Class Cell Blocks. You should not leave your zone under usual SoP.</b></big>"
	supervisors = "the Guard/Zone Commander"
	economic_modifier = 4
	minimal_player_age = 5
	ideal_character_age = 25
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/security/ncoofficerhcz
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
		H.add_stats(rand(10), rand(10), rand(15,20)) // Str, Dex, Int.
		H.add_skills(rand(60,80), rand(60,80), rand(15,30), rand(5,10)) // Melee, Ranged, Medical, Engineering.

	access = list()
	minimal_access = list()

/datum/job/ncoofficerez
	has_email = TRUE
	title = "EZ Agent"
	department = "Entrance Zone Personnel"
	department_flag = SEC
	total_positions = 2
	spawn_positions = 2
	duties = "<big><b>As the Agent you have more access than a Junior Agent, but do not control them. You are to guard tests and SCP's in the zone you spawned in. If in doubt, ask your Zone or Guard Commander. You also have the duty of guarding the D-Class Cell Blocks. You should not leave your zone under usual SoP.</b></big>"
	supervisors = "the Senior Agent"
	economic_modifier = 4
	minimal_player_age = 5
	ideal_character_age = 30
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/security/ncoofficerez
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/e7,
		/datum/mil_rank/security/e8
	)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(10), rand(10), rand(15,20)) // Str, Dex, Int.
		H.add_skills(rand(60,80), rand(60,80), rand(15,30), rand(5,10)) // Melee, Ranged, Medical, Engineering.

	access = list()
	minimal_access = list()

//##
//JUNIOR OFFICER
//##

/datum/job/enlistedofficerlcz
	has_email = TRUE
	title = "LCZ Junior Guard"
	department = "Light Containment Personnel"
	department_flag = SEC
	total_positions = 10
	spawn_positions = 10
	duties = "<big><b>As the Junior Guard you have minimal access. You are to guard tests, SCP's and provide support in the zone you spawned in. If in doubt, ask your Zone or Guard Commander. You also have the duty of guarding the D-Class Cell Blocks. You should not leave your zone under usual SoP.</b></big>"
	supervisors = "the Guard/Zone Commander"
	economic_modifier = 4
//	minimal_player_age = 0
	ideal_character_age = 25
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/security/enlistedofficerlcz
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/e1,
		/datum/mil_rank/security/e2
	)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(10), rand(10), rand(15,20)) // Str, Dex, Int.
		H.add_skills(rand(50,80), rand(50,80), rand(15,30), rand(5,10)) // Melee, Ranged, Medical, Engineering.

	access = list()
	minimal_access = list()

/datum/job/enlistedofficerhcz
	has_email = TRUE
	title = "HCZ Junior Guard"
	department = "Heavy Containment Personnel"
	department_flag = SEC
	total_positions = 2
	spawn_positions = 2
	duties = "<big><b>As the Junior Guard you have minimal access. You are to guard tests, SCP's and provide support in the zone you spawned in. If in doubt, ask your Zone or Guard Commander. You should not leave your zone under usual SoP.</b></big>"
	supervisors = "the Guard/Zone Commander"
	economic_modifier = 4
//	minimal_player_age = 0
	ideal_character_age = 25
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/security/enlistedofficerhcz
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/e3,
		/datum/mil_rank/security/e4
	)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(10), rand(10), rand(15,20)) // Str, Dex, Int.
		H.add_skills(rand(50,80), rand(50,80), rand(15,30), rand(5,10)) // Melee, Ranged, Medical, Engineering.

	access = list()
	minimal_access = list()

/datum/job/enlistedofficerez
	has_email = TRUE
	title = "EZ Junior Agent"
	department = "Entrance Personnel"
	department_flag = SEC
	total_positions = 2
	spawn_positions = 2
	duties = "<big><b>As the Junior Agent you have minimal access. You are to guard tests, SCP's and provide support in the zone you spawned in. If in doubt, ask your Zone or Guard Commander. You should not leave your zone under usual SoP.</b></big>"
	supervisors = "the Senior Agent"
	economic_modifier = 4
	minimal_player_age = 0
	ideal_character_age = 27
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/security/enlistedofficerez
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/e4,
		/datum/mil_rank/security/e5
	)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(10), rand(10), rand(15,20)) // Str, Dex, Int.
		H.add_skills(rand(50,80), rand(50,80), rand(15,30), rand(5,10)) // Melee, Ranged, Medical, Engineering.

	access = list()
	minimal_access = list()

// SCIENCE

/datum/job/juniorscientist
	has_email = TRUE
	title = "Scientist Associate"
	department = "Science"
	department_flag = SCI
	total_positions = 6
	spawn_positions = 6
	supervisors = "the Research Director and anyone in a higher position than you"
	economic_modifier = 4
	alt_titles = list("Xenobiologist Associate", "Xenoarcheologist Associate")
	minimal_player_age = 0
	ideal_character_age = 22
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/science/juniorscientist
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classc)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(3,5), rand(3,5), rand(20,25)) // Str, Dex, Int.
		H.add_skills(rand(0,25), rand(0,10), rand(50,70), rand(5,10)) // Melee, Ranged, Medical, Engineering.


	access = list()
	minimal_access = list()

/datum/job/scientist
	has_email = TRUE
	title = "Scientist"
	department = "Science"
	department_flag = SCI
	total_positions = 6
	spawn_positions = 6
	supervisors = "the Research Director and anyone in a higher position than you"
	economic_modifier = 4
	alt_titles = list("Xenobiologist", "Xenoarcheologist")
	minimal_player_age = 5
	ideal_character_age = 22
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/science/scientist
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classc)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(3,5), rand(3,5), rand(25,35)) // Str, Dex, Int.
		H.add_skills(rand(0,25), rand(0,10), rand(50,70), rand(5,10)) // Melee, Ranged, Medical, Engineering.


	access = list()
	minimal_access = list()

/datum/job/seniorscientist
	has_email = TRUE
	title = "Senior Scientist"
	department = "Science"
	department_flag = SCI
	total_positions = 6
	spawn_positions = 6
	supervisors = "the Research Director and anyone in a higher position than you"
	economic_modifier = 4
	alt_titles = list("Senior Xenobiologist", "Senior Xenoarcheologist")
	minimal_player_age = 10
	ideal_character_age = 22
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/science/seniorscientist
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classb)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(3,5), rand(3,5), rand(35,45)) // Str, Dex, Int.
		H.add_skills(rand(0,25), rand(0,10), rand(50,70), rand(5,10)) // Melee, Ranged, Medical, Engineering.


	access = list()
	minimal_access = list()

/datum/job/rd
	has_email = TRUE
	title = "Research Director"
	supervisors = "Facility Director and the Head of Human Resources"
	total_positions = 1
	spawn_positions = 1
	economic_modifier = 20
	minimal_player_age = 15
	ideal_character_age = 60
	spawn_positions = 6
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/science/researchdirector
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classa)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(3,5), rand(3,5), rand(45,60)) // Str, Dex, Int.
		H.add_skills(rand(0,25), rand(0,10), rand(50,70), rand(5,10)) // Melee, Ranged, Medical, Engineering.

	access = list()
	minimal_access = list()


// ENGINEERING


/datum/job/juneng
	has_email = TRUE
	title = "Junior Engineer"
	total_positions = 4
	spawn_positions = 4
	department_flag = ENG
	supervisors = "the Chief Engineer"
	economic_modifier = 5
	minimal_player_age = 2
	ideal_character_age = 30
	alt_titles = list(
		"Junior Maintenance Technician",
		"Junior Reactor Technician",
		"Junior Damage Control Technician",
		"Junior Electrician"
		)
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/engineering/juneng
	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/e1,
		/datum/mil_rank/security/e2
	)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(5,7), rand(5,7), rand(20,25)) // Str, Dex, Int.
		H.add_skills(rand(25,30), rand(25,30), rand(5,10), rand(30,50)) // Melee, Ranged, Medical, Engineering.

	access = list()
	minimal_access = list()

/datum/job/eng
	has_email = TRUE
	title = "Engineer"
	total_positions = 3
	spawn_positions = 3
	department_flag = ENG
	supervisors = "the Chief Engineer"
	economic_modifier = 5
	minimal_player_age = 7
	ideal_character_age = 30
	alt_titles = list(
		"Maintenance Technician",
		"Reactor Technician",
		"Damage Control Technician",
		"Electrician"
		)
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/engineering/juneng
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
		H.add_stats(rand(5,7), rand(5,7), rand(20,25)) // Str, Dex, Int.
		H.add_skills(rand(25,30), rand(25,30), rand(5,10), rand(50,60)) // Melee, Ranged, Medical, Engineering.

	access = list()
	minimal_access = list()

/datum/job/seneng
	has_email = TRUE
	title = "Senior Engineer"
	total_positions = 2
	spawn_positions = 2
	department_flag = ENG
	supervisors = "the Chief Engineer"
	economic_modifier = 5
	minimal_player_age = 7
	ideal_character_age = 30
	alt_titles = list(
		"Senior Maintenance Technician",
		"Reactor Engine Technician",
		"Senior Damage Control Technician",
		"Senior Electrician"
		)
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/engineering/seneng
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
		H.add_stats(rand(5,7), rand(5,7), rand(20,25)) // Str, Dex, Int.
		H.add_skills(rand(25,30), rand(25,30), rand(5,10), rand(60,70)) // Melee, Ranged, Medical, Engineering.

	access = list()
	minimal_access = list()

/datum/job/conteng
	has_email = TRUE
	title = "Containment Engineer"
	total_positions = 1
	spawn_positions = 1
	department_flag = ENG
	supervisors = "the Chief Engineer"
	economic_modifier = 5
	minimal_player_age = 7
	ideal_character_age = 30
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/engineering/conteng
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
		H.add_stats(rand(5,7), rand(5,7), rand(20,25)) // Str, Dex, Int.
		H.add_skills(rand(25,30), rand(25,30), rand(5,10), rand(60,80)) // Melee, Ranged, Medical, Engineering.

	access = list()
	minimal_access = list()



/datum/job/chief_engineer
	has_email = TRUE
	title = "Chief Engineer"
	supervisors = "the Security Commander and Facility Director"
	total_positions = 1
	spawn_positions = 1
	economic_modifier = 9
	ideal_character_age = 40
	minimal_player_age = 15
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/command/chief_engineer
	allowed_branches = list(/datum/mil_branch/security)
	allowed_ranks = list(
	/datum/mil_rank/security/o2,
	/datum/mil_rank/security/o3
	)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(5,7), rand(5,7), rand(20,25)) // Str, Dex, Int.
		H.add_skills(rand(25,30), rand(25,30), rand(5,10), rand(80,100)) // Melee, Ranged, Medical, Engineering.

	access = list()
	minimal_access = list()

// MEDICAL JOBS.

/datum/job/cmo
	has_email = TRUE
	title = "Chief Medical Officer"
	supervisors = "the Security Commander"
	economic_modifier = 10
	minimal_player_age = 15
	ideal_character_age = 48
	alt_titles = list("Medical Director")
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/command/cmo
	allowed_branches = list(/datum/mil_branch/security)
	allowed_ranks = list(
	/datum/mil_rank/security/o3,
	/datum/mil_rank/security/o4,
	/datum/mil_rank/security/o5
	)

	access = list()
	minimal_access = list()
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(3,6), rand(7,10), rand(20,25))
		H.add_skills(rand(10,25), rand(10,25), rand(90,100), rand(5,10))

/datum/job/chemist
	has_email = TRUE
	title = "Chemist"
	department = "Medical"
	department_flag = MED
	minimal_player_age = 3
	total_positions = 2
	spawn_positions = 2
	supervisors = "the Chief Medical Officer"
	selection_color = "#013d3b"
	economic_modifier = 4
	ideal_character_age = 30
	outfit_type = /decl/hierarchy/outfit/job/site19/medical/chemist
	allowed_branches = list(/datum/mil_branch/security)
	allowed_ranks = list(
		/datum/mil_rank/security/o1)

	access = list()
	minimal_access = list()
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(3,6), rand(7,10), rand(20,25))
		H.add_skills(rand(10,25), rand(10,25), rand(70,90), rand(5,10))

/datum/job/psychiatrist
	has_email = TRUE
	title = "Psychiatrist"
	department = "Medical"
	department_flag = MED
	selection_color = "#013d3b"
	total_positions = 1
	spawn_positions = 1
	ideal_character_age = 40
	economic_modifier = 5
	supervisors = "the Chief Medical Officer"
	alt_titles = list("Counselor")
	outfit_type = /decl/hierarchy/outfit/job/site19/medical/psychiatrist
	allowed_branches = list(
	/datum/mil_branch/civilian)
	allowed_ranks = list(
		/datum/mil_rank/civ/classb)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(1,3), rand(3,5), rand(25,30))
		H.add_skills(rand(10,25), rand(10,25), rand(70,90), rand(5,10))

	access = list()
	minimal_access = list()

/datum/job/medicaldoctor
	has_email = TRUE
	title = "Medical Doctor"
	department = "Medical"
	department_flag = MED
	selection_color = "#013d3b"
	total_positions = 3
	spawn_positions = 3
	ideal_character_age = 40
	minimal_player_age = 3
	economic_modifier = 5
	supervisors = "the Chief Medical Officer"
	outfit_type = /decl/hierarchy/outfit/job/site19/medical/medicaldoctor
	allowed_branches = list(
	/datum/mil_branch/security)
	allowed_ranks = list(
		/datum/mil_rank/security/o1,
		/datum/mil_rank/security/o2)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(3,6), rand(7,10), rand(20,25))
		H.add_skills(rand(10,25), rand(10,25), rand(70,90), rand(5,10))


	access = list()
	minimal_access = list()

/datum/job/virologist
	has_email = TRUE
	title = "Virologist"
	department = "Medical"
	department_flag = MED
	selection_color = "#013d3b"
	total_positions = 2
	spawn_positions = 2
	minimal_player_age = 3
	ideal_character_age = 40
	economic_modifier = 5
	supervisors = "the Chief Medical Officer"
	outfit_type = /decl/hierarchy/outfit/job/site19/medical/virologist
	allowed_branches = list(
	/datum/mil_branch/civilian)
	allowed_ranks = list(
		/datum/mil_rank/civ/classb)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(3,6), rand(7,10), rand(20,25))
		H.add_skills(rand(10,25), rand(10,25), rand(70,90), rand(5,10))


	access = list()
	minimal_access = list()

/datum/job/surgeon
	has_email = TRUE
	title = "Surgeon"
	department = "Medical"
	department_flag = MED
	selection_color = "#013d3b"
	total_positions = 2
	spawn_positions = 2
	ideal_character_age = 40
	economic_modifier = 5
	supervisors = "the Chief Medical Officer"
	minimal_player_age = 3
	outfit_type = /decl/hierarchy/outfit/job/site19/medical/surgeon
	allowed_branches = list(
	/datum/mil_branch/security)
	allowed_ranks = list(
		/datum/mil_rank/security/o2)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(3,6), rand(7,10), rand(20,25))
		H.add_skills(rand(10,25), rand(10,25), rand(70,90), rand(5,10))


	access = list(access_med_comms, access_medicalgen, access_medicalequip, access_mtflvl1, access_mtflvl2)
	minimal_access = list()

/datum/job/emt
	has_email = TRUE
	title = "Emergency Medical Technician"
	department = "Medical"
	department_flag = MED
	selection_color = "#013d3b"
	total_positions = 2
	spawn_positions = 2
	ideal_character_age = 40
	economic_modifier = 5
	duties = "<big><b>As the EMT it is your job to man the medical post near the Class D cell block, and treat any injuries there of the guards or Class D's. You only have limited supplies, so it's best to make them count.</b></big>"
	supervisors = "the Chief Medical Officer"
	outfit_type = /decl/hierarchy/outfit/job/site19/medical/emt
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
		H.add_stats(rand(3,6), rand(7,10), rand(20,25))
		H.add_skills(rand(10,25), rand(10,25), rand(50,70), rand(5,10))


	access = list(access_med_comms, access_medicalgen, access_medicalequip, access_mtflvl1)
	minimal_access = list()


//LOGISTICS

/datum/job/qm
	has_email = TRUE
	title = "Logistics Officer"
	department = "Logistics"
	department_flag = SUP
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Site Director"
	selection_color = "#515151"
	economic_modifier = 5
	minimal_player_age = 7
	ideal_character_age = 35
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/command/logisticsofficer
	allowed_branches = list(
		/datum/mil_branch/security,
	)
	allowed_ranks = list(
		/datum/mil_rank/security/e7,
		/datum/mil_rank/security/e8,
		/datum/mil_rank/security/e9,
		/datum/mil_rank/security/w1

	)

	access = list(access_log_comms, access_logofficer, access_logistics)
	minimal_access = list()


/datum/job/cargo_tech
	has_email = TRUE
	title = "Logistics Specialist"
	department = "Logistics"
	department_flag = SUP
	total_positions = 2
	spawn_positions = 2
	selection_color = "B4802B"
	supervisors = "the Logistics Officer"
	minimal_player_age = 3
	ideal_character_age = 24
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/command/logisticspecialist
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

	access = list(access_log_comms, access_logistics)
	minimal_access = list()

// MISC JOBS

/datum/job/janitor
	has_email = TRUE
	title = "Janitor"
	department = "Civilian"
	department_flag = CIV
	total_positions = 2
	spawn_positions = 2
	supervisors = "the Head of Personnel"
	ideal_character_age = 24
	alt_titles = list("Interior caretaker", "Sanitation Technician")
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/civ/janitor
	allowed_branches = list(
		/datum/mil_branch/civilian
	)
	allowed_ranks = list(
	/datum/mil_rank/civ/classd
	)

	access = list()
	minimal_access = list()
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(1,3), rand(0,3), rand(5,10)) // Str, Dex, Int.
		H.add_skills(rand(5,10), rand(5,10), rand(5,10), rand(5,10)) // Melee, Ranged, Medical, Engineering.

/datum/job/chef
	has_email = TRUE
	title = "Chef"
	department = "Civilian"
	department_flag = CIV
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Head of Personnel"
	selection_color = "#515151"
	ideal_character_age = 24
	alt_titles = list("Cook")
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/civ/chef
	allowed_branches = list(
		/datum/mil_branch/civilian
	)
	allowed_ranks = list(
	/datum/mil_rank/civ/classd
	)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(1,3), rand(0,3), rand(5,10)) // Str, Dex, Int.
		H.add_skills(rand(5,10), rand(5,10), rand(5,10), rand(5,10)) // Melee, Ranged, Medical, Engineering.
	access = list()
	minimal_access = list()

/datum/job/bartender
	has_email = TRUE
	title = "Bartender"
	department = "Civilian"
	department_flag = CIV
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Head of Personnel"
	selection_color = "#515151"
	ideal_character_age = 24
	alt_titles = list("Waiter")
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/civ/bartender
	allowed_branches = list(
		/datum/mil_branch/civilian
	)
	allowed_ranks = list(
	/datum/mil_rank/civ/classd
	)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(1,3), rand(0,3), rand(5,10)) // Str, Dex, Int.
		H.add_skills(rand(5,10), rand(5,10), rand(5,10), rand(5,10)) // Melee, Ranged, Medical, Engineering.
	access = list() // Limited internal D-Block access e.g. when training D-Class or unlocking their crates
	minimal_access = list()

/datum/job/archivist
	has_email = TRUE
	title = "Archivist"
	department = "Civilian"
	department_flag = CIV
	total_positions = 1
	spawn_positions = 1
	minimal_player_age = 9
	duties = "<big><b>As the Archivist, it is your job to make sure the proper test logs are digitalized and saved in the digital archive, thus safekeeping them forever. You must be picky and selective, and only get those with great quality out! <span style = 'color:red'>REMEMBER!</span> If you put in nonsensical things, or copypasta's such as Woody's got Wood, you will be permanently job banned WITHOUT chance to appeal.</b></big>"
	supervisors = "the Research Director"
	economic_modifier = 4
	minimal_player_age = 5
	ideal_character_age = 30
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/civ/archivist
	allowed_branches = list(
		/datum/mil_branch/civilian
	)
	allowed_ranks = list(
		/datum/mil_rank/civ/classa
	)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(1,3), rand(0,3), rand(5,10)) // Str, Dex, Int.
		H.add_skills(rand(5,10), rand(5,10), rand(5,10), rand(5,10)) // Melee, Ranged, Medical, Engineering.

	access = list(access_med_comms, access_sci_comms, access_medicalgen,access_civ_comms, access_archive,access_medicallvl1,access_medicallvl2)
	minimal_access = list()

/datum/job/o5rep
	has_email = TRUE
	title = "O5 Representative"
	department = "Civilian"
	department_flag = COM
	total_positions = 1
	spawn_positions = 1
	duties = "<big><b>As the O5 Representative, your task is to generally assess the situation, and you are to fax the O5 Council of any wrongdoings or SOP violations. You can also mediate between two employees if it is absolutely necessary. <span style = 'color:red'>REMEMBER!</span> This is a heavy roleplay job, and bad roleplay will be punished. Your job is not to assess SCP's, nor will you have access there. So don't try.</b></big>"
	supervisors = "the Research Director"
	economic_modifier = 4
	minimal_player_age = 5
	minimal_player_age = 9
	ideal_character_age = 30
	outfit_type = /decl/hierarchy/outfit/job/site19/crew/civ/o5rep
	allowed_branches = list(
		/datum/mil_branch/civilian
	)
	allowed_ranks = list(
		/datum/mil_rank/civ/classa
	)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(1,3), rand(0,3), rand(5,10)) // Str, Dex, Int.
		H.add_skills(rand(5,10), rand(5,10), rand(5,10), rand(5,10)) // Melee, Ranged, Medical, Engineering.

	access = list()
	minimal_access = list()
