/////////////
//READ THIS//
/////////////
// WARNING: DO NOT ADD INTEGER VALUES ABOVE 20 FOR ANY STAT OR SKILL OTHER THAN INTELLIGENCE, MEDICAL AND ENGINEERING. - LION

/datum/map/site_ds90
/datum/map/site_ds90/setup_map()

/datum/job/assistant
	title = "Class D"
	department = "Civilian"
	supervisors = "Foundation Personnel"
	selection_color = "#E55700"
	economic_modifier = 1
	total_positions = 15
	spawn_positions = 15
	duties = "<big><b>Будучи сотрудником Фонда класса D, скорее всего, вы были сняты с пожизненного срока, или смертной казни в какой-либо из тюрем неподалёку отсюда. Вы вступили в Фонд добровольно, приняв участие в одной из многочисленных реабилитационных программ, нацеленных, в первую очередь, на ваше скорейшее освобождение(говоря точнее - 30 дней).<br> Покажите, что вы вновь готовы вернуться в общество, примерив на себе одну из предложенных комплексом работ - работой на шахтах/кухне/ферме или займитесь уборкой/помощью научным сотрудникам в различного рода экспериментах и исследованиях. <br> <span style = 'color:red'>ЗАПОМНИТЕ!</span> Беспричинные бунты(особенно в начале раунда) - могут привести к бану, или вовсе перме. У Класса D НЕТУ причин проявлять к Фонду и его сотрудникам агрессию. По-крайней мере изначально. <br>ВАЖНО! Не пытайтесь вырваться из своей клетки в начале игры. Вы сломаете свой единственный выход наружу!</span>"
	access = list()			//See /datum/job/assistant/get_access()
	minimal_access = list()	//See /datum/job/assistant/get_access()
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/civ/classd
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
	duties = "<big><b>Директор Зоны - является руководителем Участка 53, который напрямую отчитывается Совету Смотрителей. Директору Зоны подчиняется весь персонал и главы отделов включительно.<br>Несмотря на свой высокий ранг - вы крайне ограничены в посещении каких-либо объектов, или, тем более, тюремного блока Зоны.<br> В ваши задачи входит - управление другими главами и офицерским составом комплекса, отслеживание соблюдения СОП и прочих протоколов, а также поднятие общего настроя персонала. В конце концов - вы их духовный лидер. Ну, до нарушения условий содержания.<br><span style = 'color:red'>Директор Зоны - крайне важная и авторитетная шишка. Его смерть - это большая трагедия, приносящая Фонду лишь убытки. Именно поэтому, было решено ограничить полномочия Директоров касательно взаимодействия с объектами на территории комплекса.</span><br><span style = 'color:red'>За излишнее геройство, а также нарушения этих самых ограничений, вас могут понизить в должности не только ингейм, но также и на уровне джоббана.</span>"
	minimal_player_age = 20
	economic_modifier = 15
	ideal_character_age = 50
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/command/facilitydir
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classa)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(7,10), rand(7,10), rand(12,16))
		H.add_skills(rand(25,40), rand(25,40), rand(65,85), rand(50,70))

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
	has_email = TRUE
	title = "Head of Personnel"
	supervisors = "the Facility Director"
	department = "Command"
	department_flag = COM
	total_positions = 0
	spawn_positions = 0
	duties = "<big><b>As the Head of Personnel, you're the right hand of the Site Director.<br>You can go to places he, or she couldn't, but still won't have access to SCP's, or the D-Class Cells.<br>Your job is to be the Site Director's eyes and ears, as well as being in charge of personnel outside of the Security branch.<br>You reserve the right to promote and demote people in cases of emergencies, otherwise, approval of the Site Director is needed.<br><span style = 'color:red'>It is not your job to jump in where necessary! Bad roleplay will be punished!</span>"
	minimal_player_age = 15
	economic_modifier = 10
	ideal_character_age = 45
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/command/headofhr
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classa)
	alt_titles = list("Personnel Director")
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(7,10), rand(7,10), rand(11,14))
		H.add_skills(rand(25,40), rand(25,40), rand(45,65), rand(40,60))


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

// COMMUNICATIONS

/datum/job/commsofficer
	has_email = TRUE
	title = "Communications Officer"
	supervisors = "the Guard Commander"
	department = "Command"
	department_flag = COM
	total_positions = 1
	spawn_positions = 1
	duties = "<big><b>Вы - глаза и уши Зоны 53. Будучи Офицером Коммуникации, в ваши обязанности входит - координация потерявшегося персонала, устранение возможных неполадок со связью, а также содействие Представителю Совета О5, если тому понадобится отправить что-либо на большую землю. Старайтесь сохранять анонимность при общении по общим незащищённым частотам.<br>Вы НЕ ДОЛЖНЫ покидать телевышку, если на то нет каких-либо серьёзных причин."
	minimal_player_age = 15
	economic_modifier = 10
	ideal_character_age = 45
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/command/commsofficer
	allowed_branches = list(/datum/mil_branch/security)
	allowed_ranks = list(
	/datum/mil_rank/security/w5,
	/datum/mil_rank/security/w6
	)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(7,10), rand(7,10), rand(11,14))
		H.add_skills(rand(25,40), rand(25,40), rand(45,65), rand(40,60))


	access = list(
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
	access_telecommsgen,
	access_servers,
	access_commtower,
	access_sciencelvl1,
	access_sciencelvl3,
	access_mtflvl1

	)
	minimal_access = list()

/datum/job/commeng
	has_email = TRUE
	selection_color = "#5b4d20"
	title = "Communications Technician"
	total_positions = 2
	spawn_positions = 2
	duties = "<big><b>As a member of the Communications team it is your job to maintain long-range comms, monitor the happenings on the Telecomms servers and assess situations by mere observation. Your job may entail being a dispatch center of the likes.<br>You should not ever leave your tower unless under specific circumstances."
	department_flag = ENG
	supervisors = "the Communications Officer"
	economic_modifier = 5
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
		H.add_stats(rand(5,7), rand(5,7), rand(20,25)) // Str, Dex, Int.
		H.add_skills(rand(25,30), rand(25,30), rand(5,10), rand(50,60)) // Melee, Ranged, Medical, Engineering.

	access = list(
	access_com_comms,
	access_sci_comms,
	access_civ_comms,
	access_log_comms,
	access_med_comms,
	access_eng_comms,
	access_sec_comms,
	access_adminlvl1,
	access_telecommsgen,
	access_servers,
	access_commtower)
/*
## END OF GENERIC COMMAND ##
*/

// CELLS
/* CANDIDATE FOR REMOVAL
/datum/job/cellguardlieutenant
	has_email = TRUE
	title = "Cell Warden"
	department = "Security"
	department_flag = SEC
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Security Commander"
	economic_modifier = 4
	alt_titles = null
	duties = "<big><b>As the Cell Warden, it is your job to coordinate the cell guards, prevent riots and breakouts. <br>It's also important to note that if you're an asshole or intentionally trying to be one, Class D's are more likely to riot.<br> If a Class D is requested for testing it is not your, or the Cell Guard's job to deliver them to the tests. Hand them over to one of the zone guards, instead.</span>"
	minimal_player_age = 7
	ideal_character_age = 30
	alt_titles = null
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/security/cellguardlieutenant

	allowed_branches = list(
		/datum/mil_branch/security
	)
	allowed_ranks = list(
		/datum/mil_rank/security/o1,
		/datum/mil_rank/security/o2
	)


	access = list(access_mtflvl1, access_mtflvl2, access_mtflvl3, access_mtflvl4, access_dclassjanitorial, access_dclassmining, access_dclasskitchen, access_dclassbotany)
	minimal_access = list()
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(10), rand(10), rand(15,20)) // Str, Dex, Int.
		H.add_skills(rand(70,90), rand(70,90), rand(15,30), rand(5,10)) // Melee, Ranged, Medical, Engineering.


/datum/job/brigofficer
	has_email = TRUE
	title = "Cell Guard"
	department = "Security"
	department_flag = SEC
	total_positions = 7
	spawn_positions = 7
	supervisors = "the Cell Warden"
	duties = "<big><b>As the Cell Guard, it is your job to prevent riots and breakouts. <br>It's also important to note that if you're an asshole or intentionally trying to be one, Class D's are more likely to riot.<br> If a Class D is requested for testing it is not your, or the Cell Guard's job to deliver them to the tests. Hand them over to one of the zone guards, instead.</span>"
	economic_modifier = 4
	alt_titles = null
	minimal_player_age = 5
	ideal_character_age = 23
	alt_titles = null
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/security/brigofficer
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
	access = list(access_mtflvl1, access_mtflvl2, access_dclassjanitorial, access_dclassmining, access_dclasskitchen, access_dclassbotany)
	minimal_access = list()
*/
// SECURITY
/datum/job/hos
	has_email = TRUE
	title = "Guard Commander"
	supervisors = "The Facility Director"
	department = "Command"
	department_flag = SEC|COM
	duties = "<big><b>ГО распоряжается практически всей охраной на территории Зоны 53. Ваша основная задача - размещение сил по ключевым областям комплекса и их дальнейшее координирование с перенаправлением в зависимости от ситуации. Сам же ГО не привязан к какой-либо из зон(тяжёлой или лёгкой), и волен сам решать, где будет нужнее. Вы также подчиняетесь Главнокомандующему Зоны и её окрестностей. Потому, при присутствии оного на смене - старайтесь сверять ваши решения с его мнением.</span>"
	economic_modifier = 8
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
		H.add_stats(rand(10,25), rand(10,15), rand(15,20)) // Str, Dex, Int.
		H.add_skills(rand(90,100), rand(90,100), rand(15,30), rand(5,10)) // Melee, Ranged, Medical, Engineering.

	access = list(
		access_com_comms,
		access_sec_comms,
		access_mtflvl1,
		access_mtflvl2,
		access_mtflvl3,
		access_mtflvl4,
		access_mtflvl5,
		access_sciencelvl1,
		access_sciencelvl2,
		access_sciencelvl3,
		access_sciencelvl4,
		access_keyauth
	)
	minimal_access = list()
//##
//ZONE COMMANDERS
//##

// COMMENT FOR LATER THIS WEEK, OUTFITS NEED TO BE RE-CODED. ~Lion. 09-10-18

/datum/job/ltofficerhcz
	has_email = TRUE
	title = "Second Guard Commander"
	department = "Security"
	selection_color = "#8e2929"
	department_flag = SEC
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Guard Commander"
	duties = "<big><b>Вы являетесь заместителем ГО. Ни больше ни меньше. При его отсутствии - можете смело брать на себя все тяготы и обязанности оного. Хотя, кто вас будет спрашивать?</span>"
	economic_modifier = 4
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
		H.add_stats(rand(10,15), rand(10,15), rand(15,20)) // Str, Dex, Int.
		H.add_skills(rand(80,100), rand(80,100), rand(15,30), rand(5,10)) // Melee, Ranged, Medical, Engineering.

	access = list(access_mtflvl1, access_mtflvl2, access_mtflvl3, access_mtflvl4, access_sciencelvl1, access_sciencelvl2, access_sciencelvl3, access_sciencelvl4, access_adminlvl1, access_adminlvl2, access_adminlvl3, access_adminlvl4)
	minimal_access = list()

/datum/job/ncoofficerhcz
	has_email = TRUE
	title = "Security Guard"
	department = "Security"
	selection_color = "#601c1c"
	department_flag = SEC
	total_positions = 10
	spawn_positions = 10
	duties = "<big><b>Вы - основная ударная сила и охрана Зоны 53. В ваши обязанности входит - наблюдение за младшими офицерами службы безопасности при наличии таковых, охрана D-класса при отсутствии первых. Ваше основное рабочее место - тяжёлая зона содержания. Охраняйте особо опасные объекты как зеницу ока, помогайте научному персоналу с проведением опыта на оных в случае надобности."
	supervisors = "the Zone Commander"
	economic_modifier = 4
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
		H.add_stats(rand(10,20), rand(10,20), rand(15,20)) // Str, Dex, Int.
		H.add_skills(rand(60,80), rand(60,80), rand(15,30), rand(5,10)) // Melee, Ranged, Medical, Engineering.

	access = list(access_mtflvl1, access_mtflvl2, access_mtflvl3, access_sciencelvl1, access_sciencelvl2, access_sciencelvl3, access_adminlvl1, access_adminlvl2, access_adminlvl3)
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
	alt_titles = null
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/science/juniorscientist
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classc)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(3,5), rand(3,5), rand(20,25)) // Str, Dex, Int.
		H.add_skills(rand(0,25), rand(0,10), rand(50,70), rand(5,10)) // Melee, Ranged, Medical, Engineering.


	access = list(access_sci_comms, access_sciencelvl1)
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
	alt_titles = null
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/science/scientist
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classc)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(3,5), rand(3,5), rand(25,35)) // Str, Dex, Int.
		H.add_skills(rand(0,25), rand(0,10), rand(50,70), rand(5,10)) // Melee, Ranged, Medical, Engineering.


	access = list(access_sci_comms, access_sciencelvl1, access_sciencelvl2)
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
	alt_titles = null
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/science/seniorscientist
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classb)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(3,5), rand(3,5), rand(35,45)) // Str, Dex, Int.
		H.add_skills(rand(0,25), rand(0,10), rand(50,70), rand(5,10)) // Melee, Ranged, Medical, Engineering.


	access = list(access_sci_comms, access_sciencelvl1, access_sciencelvl2, access_sciencelvl3, access_sciencelvl4)
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
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/science/researchdirector
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/classa)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(3,5), rand(3,5), rand(45,60)) // Str, Dex, Int.
		H.add_skills(rand(0,25), rand(0,10), rand(50,70), rand(5,10)) // Melee, Ranged, Medical, Engineering.

	access = list(
	access_com_comms,
	access_sci_comms,
	access_sciencelvl5,
	access_sciencelvl4,
	access_sciencelvl3,
	access_sciencelvl2,
	access_sciencelvl1,
	access_keyauth)
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
		H.add_stats(rand(5,7), rand(5,7), rand(20,25)) // Str, Dex, Int.
		H.add_skills(rand(25,30), rand(25,30), rand(5,10), rand(30,50)) // Melee, Ranged, Medical, Engineering.

	access = list(access_eng_comms, access_mtflvl1, access_mtflvl2)
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
		H.add_stats(rand(5,7), rand(5,7), rand(20,25)) // Str, Dex, Int.
		H.add_skills(rand(25,30), rand(25,30), rand(5,10), rand(50,60)) // Melee, Ranged, Medical, Engineering.

	access = list(access_eng_comms, access_mtflvl1, access_mtflvl2, access_mtflvl3)
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
		H.add_stats(rand(5,7), rand(5,7), rand(20,25)) // Str, Dex, Int.
		H.add_skills(rand(25,30), rand(25,30), rand(5,10), rand(60,70)) // Melee, Ranged, Medical, Engineering.

	access = list(access_eng_comms, access_mtflvl1, access_mtflvl2, access_mtflvl3, access_mtflvl4)
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
		H.add_stats(rand(5,7), rand(5,7), rand(20,25)) // Str, Dex, Int.
		H.add_skills(rand(25,30), rand(25,30), rand(5,10), rand(60,80)) // Melee, Ranged, Medical, Engineering.

	access = list(access_eng_comms, access_mtflvl1, access_mtflvl2, access_mtflvl3, access_mtflvl4, access_sciencelvl1, access_sciencelvl2, access_sciencelvl3, access_sciencelvl4)
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
	outfit_type = /decl/hierarchy/outfit/job/ds90/crew/command/chief_engineer
	allowed_branches = list(/datum/mil_branch/security)
	allowed_ranks = list(
	/datum/mil_rank/security/o2,
	/datum/mil_rank/security/o3
	)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(5,7), rand(5,7), rand(20,25)) // Str, Dex, Int.
		H.add_skills(rand(25,30), rand(25,30), rand(5,10), rand(80,100)) // Melee, Ranged, Medical, Engineering.

	access = list(access_eng_comms, access_mtflvl1, access_mtflvl2, access_mtflvl3, access_mtflvl4, access_mtflvl4, access_sciencelvl1, access_sciencelvl2, access_sciencelvl3, access_sciencelvl4, access_keyauth)
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
	outfit_type = /decl/hierarchy/outfit/job/ds90/crew/command/cmo
	allowed_branches = list(/datum/mil_branch/security)
	allowed_ranks = list(
	/datum/mil_rank/security/o3,
	/datum/mil_rank/security/o4,
	/datum/mil_rank/security/o5
	)

	access = list(access_com_comms, access_med_comms, access_medicalgen, access_medicalequip, access_medicalviro, access_medicalchem, access_s53cmo, access_keyauth, access_mtflvl1, access_mtflvl2)
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
	outfit_type = /decl/hierarchy/outfit/job/ds90/medical/chemist
	allowed_branches = list(/datum/mil_branch/security)
	allowed_ranks = list(
		/datum/mil_rank/security/o1)

	access = list(access_med_comms, access_medicalgen, access_medicalchem, access_medicalequip)
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
	outfit_type = /decl/hierarchy/outfit/job/ds90/medical/psychiatrist
	allowed_branches = list(
	/datum/mil_branch/civilian)
	allowed_ranks = list(
		/datum/mil_rank/civ/classb)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(1,3), rand(3,5), rand(25,30))
		H.add_skills(rand(10,25), rand(10,25), rand(70,90), rand(5,10))

	access = list(access_med_comms, access_medicalgen, access_medicalpsych, access_medicalequip)
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
	outfit_type = /decl/hierarchy/outfit/job/ds90/medical/medicaldoctor
	allowed_branches = list(
	/datum/mil_branch/security)
	allowed_ranks = list(
		/datum/mil_rank/security/o1,
		/datum/mil_rank/security/o2)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(3,6), rand(7,10), rand(20,25))
		H.add_skills(rand(10,25), rand(10,25), rand(70,90), rand(5,10))


	access = list(access_med_comms, access_medicalgen, access_medicalequip, access_mtflvl1, access_mtflvl2)
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
	outfit_type = /decl/hierarchy/outfit/job/ds90/medical/virologist
	allowed_branches = list(
	/datum/mil_branch/civilian)
	allowed_ranks = list(
		/datum/mil_rank/civ/classb)
	equip(var/mob/living/carbon/human/H)
		..()
		H.add_stats(rand(3,6), rand(7,10), rand(20,25))
		H.add_skills(rand(10,25), rand(10,25), rand(70,90), rand(5,10))


	access = list(access_med_comms, access_medicalgen, access_medicalequip, access_medicalviro)
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
	outfit_type = /decl/hierarchy/outfit/job/ds90/medical/surgeon
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
	duties = "<big><b>Ваша основная задача, как парамедика - поддержание жизнеспособности класса D и сотрудников лёгкой зоны. Мед-пункт, вблизи КПП тюремного отсека - по сути является вашим храмом и домом, старайтесь не покидать его без нужды. Учитывайте также и то, что запас медикаментов достаточно сильно ограничен - решайте кого спасать с умом."
	supervisors = "the Chief Medical Officer"
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
	alt_titles = list("Interior caretaker")
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/civ/janitor
	allowed_branches = list(
		/datum/mil_branch/civilian
	)
	allowed_ranks = list(
	/datum/mil_rank/civ/classd
	)

	access = list(access_civ_comms, access_sciencelvl1, access_dclassjanitorial) // Limited internal D-Block access e.g. when training D-Class or unlocking their crates
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
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/civ/chef
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
	access = list(access_civ_comms, access_s53bar, access_s53kitchen, access_dclasskitchen, access_dclassbotany)// Limited internal D-Block access e.g. when training D-Class or unlocking their crates
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
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/civ/bartender
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
	access = list(access_civ_comms, access_s53bar, access_s53kitchen, access_dclasskitchen, access_dclassbotany) // Limited internal D-Block access e.g. when training D-Class or unlocking their crates
	minimal_access = list()

/datum/job/archivist
	has_email = TRUE
	title = "Archivist"
	department = "Civilian"
	department_flag = CIV
	total_positions = 1
	spawn_positions = 1
	minimal_player_age = 9
	duties = "<big><b>Ваша работа, как Архивариуса, преобладающе состоит из проверки и составления документов и отчётов, касающихся проводимых на территории Зоны 53 испытаний или операций, с дальнейшим помещением оных в архив комплекса. <span style = 'color:red'>ЗАПОМНИТЕ!</span> Относитесь к роли со всей серьёзностью, как и к Представителю О5. За помещение в архив каких-либо незначительных записей или паст с двачей - вы рискуете получить перманентный бан на профу.</span>"
	supervisors = "the Research Director"
	economic_modifier = 4
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
		H.add_stats(rand(1,3), rand(0,3), rand(5,10)) // Str, Dex, Int.
		H.add_skills(rand(5,10), rand(5,10), rand(5,10), rand(5,10)) // Melee, Ranged, Medical, Engineering.

	access = list(access_civ_comms, access_archive)
	minimal_access = list()

/datum/job/o5rep
	has_email = TRUE
	title = "O5 Representative"
	department = "Civilian"
	department_flag = COM
	total_positions = 1
	spawn_positions = 1
	duties = "<big><b>Как представитель Совета Смотрящих(Кратко - Совета О5), вашей основной сферой деятельности является наблюдение за соблюдением протоколов Фонда, конфликтами, и любым другим социально-информационным взаимодействием персонала, с дальнейшей переправкой полученных данных в Совет. В случае необходимости, вы также можете выступить в качестве посредника между О5 и кем-либо из сотрудников Зоны 53. <span style = 'color:red'>ЗАПОМНИТЕ!</span> Игра на данной роли подразумевает наличие ХОРОШИХ навыков отыгрыша. Наблюдение и взаимодействие с объектами Фонда к вашей работе НЕ ОТНОСИТСЯ. Пускай у вас и есть доступ к оным, до момента заявления нарушения условий содержания того или иного номера - они находятся вне вашей юрисдикции."
	supervisors = "the Research Director"
	economic_modifier = 4
	minimal_player_age = 5
	minimal_player_age = 9
	ideal_character_age = 30
	alt_titles = null
	outfit_type = /decl/hierarchy/outfit/job/site90/crew/civ/o5rep
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

	access = list(access_com_comms, access_adminlvl1, access_adminlvl2, access_adminlvl3, access_adminlvl4, access_adminlvl5)
	minimal_access = list()
