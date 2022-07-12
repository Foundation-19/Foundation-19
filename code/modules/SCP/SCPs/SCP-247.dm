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

	status_flags = NO_ANTAG

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
	var/charging = FALSE

/*
/mob/living/simple_animal/hostile/scp247/Move()
	if(charging)
		new /obj/effect/temp_visual/decoy/fading(loc,src)
		DestroySurroundings()
	. = ..()
	if(charging)
		DestroySurroundings()

/mob/living/simple_animal/hostile/scp247/proc/Charge()
	var/turf/T = get_turf(target)
	if(!T || T == loc)
		return
	charging = TRUE
	visible_message("<span class='danger'>[src] charges!</span>")
	DestroySurroundings()
	walk(src, 0)
	setDir(get_dir(src, T))
	var/obj/effect/temp_visual/decoy/D = new /obj/effect/temp_visual/decoy(loc,src)
	animate(D, alpha = 0, color = "#FF0000", transform = matrix()*2, time = 1)
	sleep(3)
	throw_at(T, get_dist(src, T), 1, src, 0, callback = CALLBACK(src, .proc/charge_end))

/mob/living/simple_animal/hostile/scp247/proc/charge_end(list/effects_to_destroy)
	charging = FALSE
	if(target_mob)
		Goto(target, move_to_delay, minimum_distance)
*/