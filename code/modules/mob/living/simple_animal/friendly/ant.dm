/mob/living/simple_animal/friendly/ant
	name = "giant ant"
	desc = "A writhing mass of ants, glued together to make an adorable pet!"
	icon_state = "ant"
	icon_living = "ant"
	icon_dead = "ant_dead"
	mob_size = MOB_SMALL
	speak_emote = list("clicks")
	turns_per_move = 5
	response_help = "pets"
	response_disarm = "gently pushes aside"
	response_harm = "stomps"
	friendly = "bites"
	possession_candidate = 1
	can_escape = TRUE //snip snip
	pass_flags = PASS_FLAG_TABLE
	natural_armor = list(
		melee = ARMOR_MELEE_KNIVES
	)
	density = FALSE

	meat_amount =   3
	skin_material = MATERIAL_SKIN_CHITIN
	skin_amount =   10
	bone_material = null
	bone_amount =   0

	var/obj/item/inventory_head
	var/obj/item/inventory_mask

	ai_holder_type = /datum/ai_holder/simple_animal/passive/crab
	say_list_type = /datum/say_list/crab

/mob/living/simple_animal/ant/Life()
	. = ..()
	if(!.)
		return FALSE
	if(!ckey && !stat)
		if(isturf(src.loc) && !resting && !buckled)		//This is so it only moves if it's not inside a closet, gentics machine, etc.
			turns_since_move++
			if(turns_since_move >= turns_per_move)
				Move(get_step(src,pick(4,8)))
				turns_since_move = 0
	regenerate_icons()

/mob/living/simple_animal/friendly/ant/sam
	name = "Sam"
	real_name = "Sam"
	desc = "The Research Director's pet... Ant? Wait.. What? What have they been up to?"

/datum/ai_holder/simple_animal/passive/ant
	speak_chance = 1

/datum/say_list/ant
	emote_hear = list("clicks its mandibles")
	emote_see = list("clicks")
