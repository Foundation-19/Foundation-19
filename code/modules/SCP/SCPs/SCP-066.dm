/datum/scp/scp_066
	name = "SCP-066"
	designation = "066"
	classification = EUCLID


/mob/living/simple_animal/cat/scp_066
	name = "SCP-066"
	desc = "An amorphous red mass of braided yarn and ribbon."
	SCP = /datum/scp/scp_066
	var/next_emote = -1
	var/global/mob/living/carbon/list/victims = list()
	icon = 'icons/SCP/scp-066.dmi'
	icon_state = "066"
	icon_living = "066"
	icon_dead = "dead"
	response_help = "strokes"
	response_disarm = "gently pushes aside"
	response_harm = "kicks"
	maxHealth = 1500
	health = 1500
	see_in_dark = 3


/mob/living/simple_animal/cat/scp_066/New()

	..()
	add_language(/datum/language/english)


		// emotes
	verbs += list(
		/mob/living/simple_animal/cat/scp_066/proc/Eric,
		/mob/living/simple_animal/cat/scp_066/proc/EarRape,
		/mob/living/simple_animal/cat/scp_066/proc/Noise
	)

	// SCP-066 emotes
/* /mob/living/simple_animal/cat/scp_066/proc/Eric()
	set category = "SCP-066"
	set name = "Eric?"
	if (world.time >= next_emote)
		var/random = rand(1,5)
		if (random == 1)
			playsound(src, 'sound/scp/066/066-eric1.ogg', 30)
			next_emote = world.time + 10
		if (random == 2)
			playsound(src, 'sound/scp/066/066-eric2.ogg', 30)
			next_emote = world.time + 10
		if (random == 3)
			playsound(src, 'sound/scp/066/066-eric3.ogg', 30)
			next_emote = world.time + 10
		if (random == 4)
			playsound(src, 'sound/scp/066/066-eric4.ogg', 30)
			next_emote = world.time + 10
		if (random == 5)
			playsound(src, 'sound/scp/066/066-eric5.ogg', 30)
			next_emote = world.time + 10 */

		// SCP-066 emotes
/mob/living/simple_animal/cat/scp_066/proc/Eric()
	set category = "SCP-066"
	set name = "Eric?"

	if (world.time >= next_emote)
		for(var/mob/living/carbon/human/M in hear(7, get_turf(src)))
			if(M.is_deaf())
//				M << pick('sound/scp/066/066-eric5.ogg', 'sound/scp/066/066-eric4.ogg', 'sound/scp/066/066-eric3.ogg', 'sound/scp/066/066-eric2.ogg', 'sound/scp/066/066-5-rape.ogg', 5, )
				next_emote = world.time + 30

/mob/living/simple_animal/cat/scp_066/proc/Noise()
	set category = "SCP-066"
	set name = "Noise"
	if (world.time >= next_emote)
		for(var/mob/living/carbon/human/M in hear(7, get_turf(src)))
			if(M.is_deaf())
//				M << pick('sound/scp/066/066-ali.ogg', 'sound/scp/066/066-eric5.ogg', 'sound/scp/066/066-eric4.ogg', 'sound/scp/066/066-eric3.ogg', 'sound/scp/066/066-eric2.ogg', 'sound/scp/066/066-5-rape.ogg')
				next_emote = world.time + 100

/mob/living/simple_animal/cat/scp_066/proc/EarRape()
	set category = "SCP-066"
	set name = "EarRape"
//	playsound(src, 'sound/scp/066/066-ali.ogg', 30)
	if (world.time >= next_emote)
		for(var/mob/living/carbon/human/M in hear(7, get_turf(src)))
			if(M.is_deaf() || istype(M.l_ear, /obj/item/clothing/ears/earmuffs) || istype(M.r_ear, /obj/item/clothing/ears/earmuffs))
				continue
			to_chat(M, "<span class='danger'><i>\The [src] rings, sending chills to your very bone.</i></span>")
//			M << pick('sound/scp/066/066-1-rape.ogg', 'sound/scp/066/066-2-rape.ogg', 'sound/scp/066/066-3-rape.ogg', 'sound/scp/066/066-4-rape.ogg', 'sound/scp/066/066-5-rape.ogg', 'sound/scp/066/066-ericrape.ogg')
			next_emote = world.time + 600
			M.Stun(2)
			M.confused += 5
			M.ear_damage += rand(0, 5)
			M.ear_deaf = max(M.ear_deaf,15)
//			if(istype(M.l_ear, /obj/item/clothing/ears/earmuffs) || istype(M.r_ear, /obj/item/clothing/ears/earmuffs))
//				M << pick('sound/scp/066/066-1-rapeE.ogg', 'sound/scp/066/066-2-rapeE.ogg', 'sound/scp/066/066-3-rapeE.ogg', 'sound/scp/066/066-4-rapeE.ogg', 'sound/scp/066/066-5-rapeE.ogg', 'sound/scp/066/066-ericrapeE.ogg')
