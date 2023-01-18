//SCP-080

/mob/living/simple_animal/friendly/scp_080
	name = "SCP-080"
	desc = "An humanoid entity of sorts, it's smile is disturbing."
	icon = 'icons/SCP/scp-080.dmi'
	icon_state = "scp_080"
	speak_emote = list("whispers")
	response_help = "pets"
	response_disarm = "gently pushes aside"
	response_harm = "stomps"
	possession_candidate = 1
	pass_flags = PASS_FLAG_TABLE
	natural_armor = list(
		melee = ARMOR_MELEE_KNIVES
	)
	density = FALSE

	ai_holder_type = /datum/ai_holder/simple_animal/passive/crab
	say_list_type = /datum/say_list/crab