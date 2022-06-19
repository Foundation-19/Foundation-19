/obj/item/natural_weapon/bite/tiger
	force = 75
	sharp = TRUE
	attack_verb = list("chomped")

/datum/scp/scp_247
	name = "SCP-247"
	designation = "247"
	classification = EUCLID

/mob/living/simple_animal/hostile/scp247
	name = "Kitty"
	desc = "A cute cat."
	icon = 'icons/scp/scp-247.dmi'
	icon_state = "scp-247"
	icon_living = "scp-247"
	icon_dead = "dead"


	maxHealth = 300
	health = 300
	attacktext = list("bitten")
	attack_sound = 'sound/weapons/bite.ogg'

	response_help = "pets the"
	response_disarm = "gently pushes aside the"
	response_harm = "hits the"

	harm_intent_damage = 5

	natural_weapon = /obj/item/natural_weapon/bite/tiger

	ai_holder_type = /datum/ai_holder/simple_animal/melee/evasive
