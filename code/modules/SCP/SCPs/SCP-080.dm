//SCP-080

/mob/living/simple_animal/friendly/scp080
	name = "SCP-080"
	desc = "An humanoid entity of sorts, it's smile is disturbing."
	icon = 'icons/SCP/scp-080.dmi'

	icon_state = "scp080"
	speak_emote = list("whispers")
	response_help = "pets"
	response_disarm = "gently pushes aside"
	response_harm = "stomps"
	pass_flags = PASS_FLAG_TABLE
	natural_armor = list(
		melee = ARMOR_MELEE_KNIVES
	)
	density = FALSE

	ai_holder_type = /datum/ai_holder/simple_animal/passive/crab
	say_list_type = /datum/say_list/crab

/mob/living/simple_animal/friendly/scp080/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"Shadowy Figure", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		EUCLID, //Obj Class
		"080", //Numerical Designation
		SCP_PLACEHOLDER
	)
