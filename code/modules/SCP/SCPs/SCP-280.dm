// SCP-280 or also called "Eyes in the dark", be aware i got nearly no fucking idea on how to code, so dont come blaming me if this isnt using your favourite non binary gender or whatever.

/datum/scp/scp_280
	name = "SCP-280"
	designation = "280"
	classification = EUCLID

/mob/living/simple_animal/hostile/scp280
	name = "SCP-280"
	desc = "A human shaped-like mass of darkness."
	icon = 'icons/SCP/scp-280.dmi'
	icon_state = "scp_280"
	SCP = /datum/scp/scp_173
	status_flags = NO_ANTAG

	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 10

	speak_emote = list("whispers.")
	response_help  = "pets"
	response_disarm = "gently pushes aside"
	response_harm   = "pokes"
	maxHealth = 400 // Until someone can code that it takes damage by lighting (Like shadowlings on /TG/, then bullets will be necessary).
	health = 400
	natural_weapon = /obj/item/natural_weapon/shadowclaws
	heat_damage_per_tick = 20
	cold_damage_per_tick = 0
	pass_flags = PASS_FLAG_TABLE
	speed = 0.5
	attack_armor_pen = 4 // Its a fucking shadow, i dont have to explain right ?
	pry_time = 45 SECONDS
	pry_desc = "clawing"
	min_gas = null
	max_gas = null
	minbodytemp = 0
	natural_armor = list(
		melee = ARMOR_MELEE_KNIVES
		)

	ai_holder_type = /datum/ai_holder/simple_animal/melee

/obj/item/natural_weapon/shadowclaws
	force = 45
	sharp = TRUE
	edge = TRUE
	attack_verb = list("mauled", "slashed", "lacerates")
