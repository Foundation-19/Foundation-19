var/datum/announcement/minor/captain_announcement = new(do_newscast = 1)
/datum/job/captain

	title = "Site Director"
	supervisors = "the SCP Foundation and O5 Council"
//	duties = "<big><b>As the Site Director you are responsible for the operations happening in the Site that you manage.<br>You won't have access to SCP's, or the D-Class area.<br> As Site Director, you should worry about making sure all SOP and safety procedures are followed by delegating to the heads of staff.<br><span style = 'color:red'>It is not your job to jump in where necessary! Consistently bad roleplay will be punished under the CoHoS rule!</span>"
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
	supervisors = "the Facility Director"
	department = "Command"
	department_flag = COM
	total_positions = 0
	spawn_positions = 0
//	duties = "<big><b>As the Head of Personnel, you're the right hand of the Site Director.<br>You can go to places he, or she couldn't, but still won't have access to SCP's, or the D-Class Cells.<br>Your job is to be the Site Director's eyes and ears, as well as being in charge of personnel outside of the Security branch.<br>You reserve the right to promote and demote people in cases of emergencies, otherwise, approval of the Site Director is needed.<br><span style = 'color:red'>It is not your job to jump in where necessary! Bad roleplay will be punished!</span>"
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
	access_com_comms,
	access_civ_comms,
	access_adminlvl4,
	access_adminlvl3,
	access_adminlvl2,
	access_adminlvl1,
	access_keyauth
	)
	minimal_access = list()