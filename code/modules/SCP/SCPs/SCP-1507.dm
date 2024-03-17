/mob/living/simple_animal/hostile/retaliate/scp1507
	name = "pink flamingo"
	desc = "A pink plastic flamingo that acts like a real one."
	icon = 'icons/SCP/scp-1507.dmi'
	maxHealth = 100
	health = 100
	icon_state = "flamingo"
	icon_living = "flamingo"
	icon_dead = "dead"
	var/icon_resting = "sleep"
	response_help = "strokes"
	response_disarm = "gently pushes aside"
	response_harm = "hits the"

	faction = "scp1507" //They team up with one another
	harm_intent_damage = 3
	holder_type = /obj/item/holder/flamingo1507
	var/enrage_potency = 4
	var/max_damage = 8
	var/static/spawn_count = 1 //Keeps track of how many have been spawned

	ai_holder_type = /datum/ai_holder/simple_animal/retaliate/cooperative/scp1507
	say_list_type = /datum/say_list/scp1507
	natural_weapon = /obj/item/natural_weapon/scp1507

/datum/ai_holder/simple_animal/retaliate/cooperative/scp1507/react_to_attack(atom/movable/attacker)
	. = ..()
	var/mob/living/simple_animal/hostile/retaliate/scp1507/G = holder
	if(G.stat == CONSCIOUS)
		G.Enrage(G.enrage_potency)

/obj/item/natural_weapon/scp1507
	name = "pink plastic"
	attack_verb = list("pecked", "jabbed", "poked")
	force = 4
	sharp = TRUE
	damtype = BRUTE
	armor_penetration = 100
	hitsound = SFX_SCP1507_ATTACK

/datum/say_list/scp1507
	emote_hear = list("flaps its wings")
	emote_see = list("flaps its wings", "scratches the ground")

/mob/living/simple_animal/hostile/retaliate/scp1507/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"pink plastic flamingo", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_EUCLID, //Obj Class
		"1507", //Numerical Designation
		SCP_PLAYABLE
	)
	name += " ([spawn_count])"
	spawn_count += 1

/mob/living/simple_animal/hostile/retaliate/scp1507/lay_down()
	..()
	icon_state = resting ? icon_resting : icon_living

/mob/living/simple_animal/hostile/retaliate/scp1507/proc/Enrage(potency)
	var/obj/item/W = get_natural_weapon()
	if(W)
		W.force = min((W.force + potency), max_damage)

/datum/ai_holder/simple_animal/retaliate/cooperative/scp1507 //A customized AI with shorter view range
	vision_range = 4
	hostile = TRUE
