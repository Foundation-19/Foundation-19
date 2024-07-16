/datum/job/classd
	title = "Class D"
	department = "Civilian"
	selection_color = "#E55700"
	economic_power = 1
	total_positions = 999
	spawn_positions = 999
	supervisors = "all Foundation Personnel"
	access = list()
	minimal_access = list()
	outfit_type = /decl/hierarchy/outfit/job/civ/classd
	class = CLASS_D
	hud_icon = "huddclass"
	var/static/list/used_numbers = list()

	max_skill = list(
		SKILL_COMBAT = SKILL_TRAINED,
		SKILL_WEAPONS = SKILL_TRAINED
	)

	roleplay_difficulty = "Variable"
	mechanical_difficulty = "Variable"
	duties = "You're a prisoner. You have no duties!"

/datum/job/classd/equip(mob/living/carbon/human/H)
	H.fully_replace_character_name(random_name(H.gender, H.species.name))
	. = ..()
	var/r = rand(100,9000)
	while (used_numbers.Find(r))
		r = rand(100,9000)
	used_numbers += r
	if(istype(H.wear_id, /obj/item/card/id))
		var/obj/item/card/id/ID = H.wear_id
		ID.registered_name = "D-[used_numbers[used_numbers.len]]"

// LOGISTICS DEPARTMENT
/datum/job/qm
	title = "Logistics Officer"
	department = "Logistics"
	department_flag = SUP|BUR
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Site Director"
	selection_color = "#c4a071"
	economic_power = 5
	minimal_player_age = 7
	ideal_character_age = 35
	requirements = list("Logistics Specialist" = 300)
	outfit_type = /decl/hierarchy/outfit/job/command/logisticsofficer
	hud_icon = "huddeckchief"
	class = CLASS_B

	access = list(
		ACCESS_ADMIN_LVL1,
		ACCESS_ADMIN_LVL2,
		ACCESS_ADMIN_LVL3,
		ACCESS_LOG_COMMS,
		ACCESS_MAINT_TUNNELS,
		ACCESS_EMERGENCY_STORAGE,
		ACCESS_CARGO,
		ACCESS_CARGO_BOT,
		ACCESS_MAILSORTING
	)
	minimal_access = list()


	min_skill = list(
		SKILL_FINANCE     = SKILL_BASIC,
		SKILL_HAULING     = SKILL_BASIC
	)

	max_skill = list()
	skill_points = 18

	software_on_spawn = list(/datum/computer_file/program/supply,
							/datum/computer_file/program/reports)

	roleplay_difficulty = "Medium"
	mechanical_difficulty = "Medium"
	duties = "Manage the Logistics department. Facilitate logistics throughout the site. Buy supplies."

/datum/job/cargo_tech
	title = "Logistics Specialist"
	department = "Logistics"
	department_flag = SUP|BUR
	total_positions = 2
	spawn_positions = 2
	selection_color = "#927248"
	supervisors = "the Logistics Officer"
	minimal_player_age = 3
	ideal_character_age = 24
	outfit_type = /decl/hierarchy/outfit/job/command/logisticspecialist
	class = CLASS_C
	hud_icon = "huddecktechnician"

	access = list(
		ACCESS_LOG_COMMS,
		ACCESS_MAINT_TUNNELS,
		ACCESS_EMERGENCY_STORAGE,
		ACCESS_CARGO,
		ACCESS_CARGO_BOT,
		ACCESS_ADMIN_LVL1,
		ACCESS_MAILSORTING
	)
	minimal_access = list()


	min_skill = list(
		SKILL_FINANCE     = SKILL_BASIC,
		SKILL_HAULING     = SKILL_BASIC
	)

	max_skill = list()
	skill_points = 18

	software_on_spawn = list(/datum/computer_file/program/supply,
							/datum/computer_file/program/reports)

	roleplay_difficulty = "Easy - Medium"
	mechanical_difficulty = "Medium"
	duties = "Facilitate logistics throughout the site. Buy supplies."

//Office Worker

/datum/job/officeworker
	title = "Office Worker"
	department = "Civilian"
	department_flag = CIV|BUR
	total_positions = 100
	spawn_positions = 100
	minimal_player_age = 10
	economic_power = 2
	minimal_player_age = 5
	ideal_character_age = 30
	alt_titles = list("Administrative Assistant", "Accountant", "Auditor", "Secretary")
	outfit_type = /decl/hierarchy/outfit/job/civ/officeworker
	class = CLASS_C
	hud_icon = "hudcrewman"

	access = list(
		ACCESS_CIV_COMMS,
		ACCESS_ADMIN_LVL1,
		ACCESS_SCIENCE_LVL1,
		ACCESS_SCIENCE_LVL2,
		ACCESS_MEDICAL_LVL1,
		ACCESS_MEDICAL_LVL2,
	)

	minimal_access = list()

	roleplay_difficulty = "Medium"
	mechanical_difficulty = "Easy - Medium"
	duties = "Work with, and for, various departments. Fill out forms. Maximize bureaucracy."
	codex_guides = list("<l>Paperwork</l>")

// MISC JOBS

/datum/job/janitor
	title = "Janitor"
	department = "Civilian"
	department_flag = CIV|SRV
	selection_color = "#515151"
	total_positions = 3
	spawn_positions = 3
	supervisors = "the Human Resources Officer"
	ideal_character_age = 16
	alt_titles = list("Interior caretaker")
	outfit_type = /decl/hierarchy/outfit/job/civ/janitor
	class = CLASS_C
	hud_icon = "hudsanitationtechnician"

	access = list(
		ACCESS_CIV_COMMS,
		ACCESS_SCIENCE_LVL1,
		ACCESS_MEDICAL_LVL1,
		ACCESS_DCLASS_JANITORIAL,
		ACCESS_DCLASS_MEDICAL
)
	minimal_access = list()

	min_skill = list(
		SKILL_HAULING = SKILL_BASIC
	)

	roleplay_difficulty = "Easy"
	mechanical_difficulty = "Easy - Medium"
	duties = "Keep the site clean at all costs."

/datum/job/chef
	title = "Chef"
	department = "Civilian"
	department_flag = CIV|SRV
	selection_color = "#515151"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Human Resources Officer"
	ideal_character_age = 18
	alt_titles = list("Cook")
	outfit_type = /decl/hierarchy/outfit/job/civ/chef
	class = CLASS_C
	hud_icon = "hudcook"

	access = list(
		ACCESS_CIV_COMMS,
		ACCESS_DCLASS_KITCHEN,
		ACCESS_DCLASS_BOTANY,
		ACCESS_BAR,
		ACCESS_KITCHEN,
		ACCESS_HYDROPONICS
	) // Limited internal D-Block access e.g. when training D-Class or unlocking their crates
	minimal_access = list()

	min_skill = list(
		SKILL_COOKING   = SKILL_EXPERIENCED,
		SKILL_CHEMISTRY = SKILL_BASIC
	)

	roleplay_difficulty = "Easy - Medium"
	mechanical_difficulty = "Medium"
	duties = "Cook up delicious meals (or inedible slop). Manage the kitchen."


/datum/job/bartender
	title = "Bartender"
	department = "Civilian"
	department_flag = CIV|SRV
	selection_color = "#515151"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Human Resources Officer"
	ideal_character_age = 21
	alt_titles = list("Waiter")
	outfit_type = /decl/hierarchy/outfit/job/civ/bartender
	class = CLASS_C
	hud_icon = "hudbartender"

	access = list(
		ACCESS_CIV_COMMS,
		ACCESS_DCLASS_KITCHEN,
		ACCESS_DCLASS_BOTANY,
		ACCESS_BAR,
		ACCESS_KITCHEN,
		ACCESS_HYDROPONICS
	) // Limited internal D-Block access e.g. when training D-Class or unlocking their crates
	minimal_access = list()

	min_skill = list(
		SKILL_COOKING   = SKILL_EXPERIENCED,
		SKILL_CHEMISTRY = SKILL_BASIC
	)

	roleplay_difficulty = "Easy - Medium"
	mechanical_difficulty = "Medium"
	duties = "Mix up drinks for the staff. Manage the bar."

/datum/job/chaplain
	title = "Chaplain"
	department = "Civilian"
	department_flag = CIV|SRV

	total_positions = 1
	spawn_positions = 1
	supervisors = null

	access = list(
	ACCESS_MEDICAL_LVL1,
	ACCESS_CHAPEL_OFFICE
	)

	minimal_access = list()
	outfit_type = /decl/hierarchy/outfit/job/chaplain
	class = CLASS_C

	roleplay_difficulty = "Medium"
	mechanical_difficulty = "Easy"

/datum/job/chaplain/equip(mob/living/carbon/human/H, alt_title, ask_questions = TRUE)
	. = ..()
	if(!. || !ask_questions)
		return

	var/obj/item/storage/bible/B = locate(/obj/item/storage/bible) in H
	if(!B)
		return

	spawn(0)
		var/religion_name = "Christianity"
		var/new_religion = sanitize(input(H, "You are the crew services officer. Would you like to change your religion? Default is Christianity.", "Name change", religion_name), MAX_NAME_LEN)

		if (!new_religion)
			new_religion = religion_name
		switch(lowertext(new_religion))
			if("christianity")
				B.SetName("The Holy Bible")
			if("satanism")
				B.SetName("The Unholy Bible")
			if("cthulu")
				B.SetName("The Necronomicon")
			if("islam")
				B.SetName("Quran")
			if("scientology")
				B.SetName(pick("The Biography of L. Ron Hubbard","Dianetics"))
			if("chaos")
				B.SetName("The Book of Lorgar")
			if("imperium")
				B.SetName("Uplifting Primer")
			if("toolboxia")
				B.SetName("Toolbox Manifesto")
			if("homosexuality")
				B.SetName("Guys Gone Wild")
			if("science")
				B.SetName(pick("Principle of Relativity", "Quantum Enigma: Physics Encounters Consciousness", "Programming the Universe", "Quantum Physics and Theology", "String Theory for Dummies", "How To: Build Your Own Warp Drive", "The Mysteries of Bluespace", "Playing God: Collector's Edition"))
			else
				B.SetName("The Holy Book of [new_religion]")
		SSstatistics.set_field_details("religion_name","[new_religion]")

	spawn(1)
		var/deity_name = "Space Jesus"
		var/new_deity = sanitize(input(H, "Would you like to change your deity? Default is Space Jesus.", "Name change", deity_name), MAX_NAME_LEN)

		if ((length(new_deity) == 0) || (new_deity == "Space Jesus") )
			new_deity = deity_name
		B.deity_name = new_deity

		var/accepted = 0
		var/outoftime = 0
		spawn(200) // 20 seconds to choose
			outoftime = 1
		var/new_book_style = "Bible"

		while(!accepted)
			if(!B) break // prevents possible runtime errors
			new_book_style = input(H,"Which bible style would you like?") in list("Bible", "Koran", "Scrapbook", "Creeper", "White Bible", "Holy Light", "Athiest", "Tome", "The King in Yellow", "Ithaqua", "Scientology", "the bible melts", "Necronomicon")
			switch(new_book_style)
				if("Koran")
					B.icon_state = "koran"
					B.item_state = "koran"
				if("Scrapbook")
					B.icon_state = "scrapbook"
					B.item_state = "scrapbook"
				if("Creeper")
					B.icon_state = "creeper"
					B.item_state = "syringe_kit"
				if("White Bible")
					B.icon_state = "white"
					B.item_state = "syringe_kit"
				if("Holy Light")
					B.icon_state = "holylight"
					B.item_state = "syringe_kit"
				if("Athiest")
					B.icon_state = "athiest"
					B.item_state = "syringe_kit"
				if("Tome")
					B.icon_state = "tome"
					B.item_state = "syringe_kit"
				if("The King in Yellow")
					B.icon_state = "kingyellow"
					B.item_state = "kingyellow"
				if("Ithaqua")
					B.icon_state = "ithaqua"
					B.item_state = "ithaqua"
				if("Scientology")
					B.icon_state = "scientology"
					B.item_state = "scientology"
				if("the bible melts")
					B.icon_state = "melted"
					B.item_state = "melted"
				if("Necronomicon")
					B.icon_state = "necronomicon"
					B.item_state = "necronomicon"
				else
					B.icon_state = "bible"
					B.item_state = "bible"

			H.update_inv_l_hand() // so that it updates the bible's item_state in his hand

			switch(input(H,"Look at your bible - is this what you want?") in list("Yes","No"))
				if("Yes")
					accepted = 1
				if("No")
					if(outoftime)
						to_chat(H, "Welp, out of time, buddy. You're stuck. Next time choose faster.")
						accepted = 1

		SSstatistics.set_field_details("religion_deity","[new_deity]")
		SSstatistics.set_field_details("religion_book","[new_book_style]")
	return 1
