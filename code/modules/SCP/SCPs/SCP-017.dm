//For now its just a simple mob, i aint got the knowledge to make a highly intelligent creature.
/mob/living/simple_animal/friendly/scp_017
	name = "SCP-017"
	desc = "An odd looking shadow."
	icon = 'icons/SCP/scp-017.dmi'
	icon_state = "scp-017"
	speak_emote = list("whispers")
	turns_per_move = 5
	response_help = "pets"
	response_disarm = "gently pushes aside"
	response_harm = "stomps"
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