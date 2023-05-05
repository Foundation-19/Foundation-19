/mob/living/simple_animal/hostile/infestation/larva
	name = "larva"
	desc = "A weird insect-like creature."
	icon_state = "larva"
	icon_living = "larva"
	icon_dead = "larva_dead"
	response_help = "pets"
	response_disarm = "pushes aside"
	response_harm = "stomps on"
	destroy_surroundings = FALSE
	mob_size = MOB_MINISCULE
	density = FALSE
	layer = LYING_MOB_LAYER
	speak_emote = list("gurgles")
	pass_flags = PASS_FLAG_TABLE | PASS_FLAG_GRILLE
	movement_cooldown = 1.5

	health = 20
	maxHealth = 20

	meat_type = /obj/item/reagent_containers/food/snacks/abominationmeat
	meat_amount = 1

	ai_holder_type = /datum/ai_holder/simple_animal/infestation/larva
	say_list_type = /datum/say_list/infestation_larva
	death_sounds = list(
		'sound/simple_mob/abominable_infestation/larva/death_1.ogg',
		'sound/simple_mob/abominable_infestation/larva/death_2.ogg',
		)

	transformation_types = list(
		/mob/living/simple_animal/hostile/infestation/broodling = 30 SECONDS,
		/mob/living/simple_animal/hostile/infestation/spitter = 45 SECONDS,
		/mob/living/simple_animal/hostile/infestation/eviscerator = 60 SECONDS,
		/mob/living/simple_animal/hostile/infestation/assembler = 90 SECONDS,
		/mob/living/simple_animal/hostile/infestation/rhino = 120 SECONDS,
		)

/datum/say_list/infestation_larva
	emote_hear = list("gurgles", "hisses", "attempts to make a sound")
	emote_see = list("wriggles around")

	emote_hear_sounds = list(
		'sound/simple_mob/abominable_infestation/larva/ambient_1.ogg',
		'sound/simple_mob/abominable_infestation/larva/ambient_2.ogg',
		'sound/simple_mob/abominable_infestation/larva/ambient_3.ogg',
		)
	emote_see_sounds = list(
		'sound/simple_mob/abominable_infestation/larva/ambient_1.ogg',
		'sound/simple_mob/abominable_infestation/larva/ambient_2.ogg',
		'sound/simple_mob/abominable_infestation/larva/ambient_3.ogg',
		)

/datum/ai_holder/simple_animal/infestation/larva
	hostile = FALSE
	retaliate = FALSE
	returns_home = FALSE
	can_flee = TRUE
	speak_chance = 4
	wander = TRUE
	base_wander_delay = 4

/mob/living/simple_animal/hostile/infestation/larva/Initialize()
	. = ..()
	transformation_time = world.time + rand(60 SECONDS, 90 SECONDS)

// Implanted subtype of larva transforms much faster
/mob/living/simple_animal/hostile/infestation/larva/implant/BecomeEgg()
	. = ..()
	transformation_time = world.time + rand(5 SECONDS, 10 SECONDS)

// Neutral faction and slightly different color
/mob/living/simple_animal/hostile/infestation/larva/friendly
	faction = "neutral"
	color = "#c87d44"
	transformation_types = list(
		/mob/living/simple_animal/hostile/infestation/broodling = 60 SECONDS,
		/mob/living/simple_animal/hostile/infestation/eviscerator = 90 SECONDS,
		/mob/living/simple_animal/hostile/infestation/assembler = 120 SECONDS,
		)

// Larva that will rush to humans and implant into them
/mob/living/simple_animal/hostile/infestation/larva/implanter
	icon_state = "larva_implanter"
	icon_living = "larva_implanter"
	ai_holder_type = /datum/ai_holder/simple_animal/infestation/larva/implanter

/datum/ai_holder/simple_animal/infestation/larva/implanter
	hostile = TRUE
	retaliate = TRUE
	can_flee = FALSE

/datum/ai_holder/simple_animal/infestation/larva/implanter/list_targets()
	var/list/humans = list()
	for(var/mob/living/carbon/human/H in view(vision_range, holder))
		humans += H

	return humans

/mob/living/simple_animal/hostile/infestation/larva/implanter/Initialize()
	. = ..()
	transformation_time = null // We only evolve after implanting ourselves

/mob/living/simple_animal/hostile/infestation/larva/implanter/attack_target(atom/A)
	if(!ishuman(A))
		return

	if(transformation_time != null) // Already implanted once
		return

	var/mob/living/carbon/human/H = A
	var/list/valid_organs = list()
	for(var/obj/item/organ/external/O in H.organs)
		if(istype(O, /obj/item/organ/external/stump))
			continue
		if(locate(/mob/living/simple_animal/hostile/infestation/larva) in O.implants)
			continue
		valid_organs += O

	if(!LAZYLEN(valid_organs))
		return

	visible_message(SPAN_DANGER("[src] bites through [H]'s clothes and skin and wriggles inside!"))
	playsound(src, 'sound/simple_mob/abominable_infestation/larva/implant.ogg', 50, TRUE)
	var/obj/item/organ/external/target_organ = pick(valid_organs)
	target_organ.owner.apply_damage(15, BRUTE, target_organ.organ_tag)
	forceMove(target_organ)
	target_organ.implants += src
	transformation_time = world.time + rand(120 SECONDS, 240 SECONDS)
	ai_holder.speak_chance = 0
