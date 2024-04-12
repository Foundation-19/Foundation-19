//Due to how large this one is it gets its own file
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

/datum/job/chaplain/equip(mob/living/carbon/human/spawned, alt_title, ask_questions = TRUE)
	. = ..()
	if(!ishuman(spawned))
		return
	var/obj/item/book/bible/holy_bible = new
	if(GLOB.religion)
		if(spawned.mind)
			spawned.mind.holy_role = HOLY_ROLE_PRIEST
		holy_bible.deity_name = GLOB.deity
		holy_bible.name = GLOB.bible_name
		// These checks are important as there's no guarantee the "HOLY_ROLE_HIGHPRIEST" chaplain has selected a bible skin.
		if(GLOB.bible_icon_state)
			holy_bible.icon_state = GLOB.bible_icon_state
		if(GLOB.bible_inhand_icon_state)
			holy_bible.inhand_icon_state = GLOB.bible_inhand_icon_state
		to_chat(spawned, SPAN_BOLDNOTICE("There is already an established religion onboard the station. You are an acolyte of [GLOB.deity]. Defer to the Chaplain."))
		spawned.equip_to_slot_or_del(holy_bible, ITEM_SLOT_BACKPACK, indirect_action = TRUE)
		var/nrt = GLOB.holy_weapon_type || /obj/item/nullrod
		var/obj/item/nullrod/nullrod = new nrt(spawned)
		spawned.put_in_hands(nullrod)
		if(GLOB.religious_sect)
			GLOB.religious_sect.on_conversion(spawned)
		return
	if(spawned.mind)
		spawned.mind.holy_role = HOLY_ROLE_HIGHPRIEST

	var/new_religion = player_client?.prefs?.read_preference(/datum/preference/name/religion) || DEFAULT_RELIGION
	var/new_deity = player_client?.prefs?.read_preference(/datum/preference/name/deity) || DEFAULT_DEITY
	var/new_bible = player_client?.prefs?.read_preference(/datum/preference/name/bible) || DEFAULT_BIBLE

	holy_bible.deity_name = new_deity
	switch(lowertext(new_religion))
		if("homosexuality", "gay", "penis", "ass", "cock", "cocks")
			new_bible = pick("Guys Gone Wild","Coming Out of The Closet","War of Cocks")
			switch(new_bible)
				if("War of Cocks")
					holy_bible.deity_name = pick("Dick Powers", "King Cock")
				else
					holy_bible.deity_name = pick("Gay Space Jesus", "Gandalf", "Dumbledore")
			spawned.adjustOrganLoss(ORGAN_SLOT_BRAIN, 100) // starts off brain damaged as fuck
		if("lol", "wtf", "poo", "badmin", "shitmin", "deadmin", "meme", "memes")
			new_bible = pick("Woody's Got Wood: The Aftermath", "Sweet Bro and Hella Jeff: Expanded Edition","F.A.T.A.L. Rulebook")
			switch(new_bible)
				if("Woody's Got Wood: The Aftermath")
					holy_bible.deity_name = pick("Woody", "Andy", "Cherry Flavored Lube")
				if("Sweet Bro and Hella Jeff: Expanded Edition")
					holy_bible.deity_name = pick("Sweet Bro", "Hella Jeff", "Stairs", "AH")
				if("F.A.T.A.L. Rulebook")
					holy_bible.deity_name = "Twenty Ten-Sided Dice"
			spawned.adjustOrganLoss(ORGAN_SLOT_BRAIN, 100) // also starts off brain damaged as fuck
		if("servicianism", "partying")
			holy_bible.desc = "Happy, Full, Clean. Live it and give it."
		if("weeaboo","kawaii")
			new_bible = pick("Fanfiction Compendium","Japanese for Dummies","The Manganomicon","Establishing Your O.T.P")
			holy_bible.deity_name = "Anime"
		else
			if(new_bible == DEFAULT_BIBLE)
				new_bible = DEFAULT_BIBLE_REPLACE(new_bible)

	holy_bible.name = new_bible

	GLOB.religion = new_religion
	GLOB.bible_name = new_bible
	GLOB.deity = holy_bible.deity_name

	spawned.equip_to_slot_or_del(holy_bible, ITEM_SLOT_BACKPACK, indirect_action = TRUE)

	SSstatistics.set_field_details("religion_name", "[new_religion]")
	SSstatistics.set_field_details("religion_deity", "[new_deity]")
	SSstatistics.set_field_details("religion_bible", "[new_bible]")

	return TRUE
