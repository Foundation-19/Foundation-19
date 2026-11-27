/mob/living/simple_animal/hostile/scp939
	name = "red predator"
	desc = "An eyeless, limbless predator with red, translucent skin. Its mouth is filled with needle-like teeth."
	icon = 'icons/SCP/scp-939-zion.dmi'
	icon_state = "scp_939_1"
	icon_dead = "scp_939_1_down"
	status_flags = NO_ANTAG

	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 7
	movement_cooldown = 4

	maxHealth = 600
	health = 600

	natural_weapon = /obj/item/natural_weapon/bite/strong
	ai_holder_type = /datum/ai_holder/simple_animal/melee/scp939
	say_list_type = /datum/say_list/scp939

	can_bleed = TRUE

	var/spawn_area
	var/containment_alert_cooldown = 60 SECONDS
	var/last_containment_alert = 0
	var/list/learned_voices = list()
	var/mimic_cooldown = 10 SECONDS
	var/last_mimic_time = 0
	var/amnestic_cloud_range = 3
	var/amnestic_cloud_prob = 5

/mob/living/simple_animal/hostile/scp939/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src,
		"red predator",
		SCP_KETER,
		"939",
		SCP_PLAYABLE
	)
	SCP.min_playercount = 20
	SCP.min_time = 30 MINUTES
	spawn_area = get_area(src)

/mob/living/simple_animal/hostile/scp939/Life()
	. = ..()
	if(!.)
		return
	check_containment_status()
	amnestic_cloud()

/mob/living/simple_animal/hostile/scp939/proc/amnestic_cloud()
	if(!prob(amnestic_cloud_prob))
		return
	for(var/mob/living/carbon/human/H in range(amnestic_cloud_range, src))
		if(H.SCP)
			continue
		H.reagents.add_reagent(/datum/reagent/medicine/amnestics/classh, 0.1)
		if(prob(10))
			to_chat(H, SPAN_NOTICE("You feel momentarily disoriented..."))

/mob/living/simple_animal/hostile/scp939/proc/learn_voice(mob/living/carbon/human/H)
	if(!istype(H) || !H.mind)
		return
	var/voice_key = H.real_name
	if(learned_voices[voice_key])
		return
	learned_voices[voice_key] = H.voice_name || H.real_name
	if(SCP && SCP.research)
		SCP.research.add_research_points(5, "voice_learned")

/mob/living/simple_animal/hostile/scp939/proc/mimic_voice(mob/living/carbon/human/target)
	if(world.time < last_mimic_time + mimic_cooldown)
		return
	if(!length(learned_voices))
		return
	var/voice_name = pick(learned_voices)
	last_mimic_time = world.time
	var/mimic_message = input(src, "What should [voice_name] say?", "Voice Mimicry") as text|null
	if(!mimic_message || !client)
		return
	mimic_message = sanitize(mimic_message)
	for(var/mob/living/carbon/human/H in hearers(7, src))
		if(H == target)
			continue
		to_chat(H, "<b>[voice_name]</b> says, \"[mimic_message]\"")

/mob/living/simple_animal/hostile/scp939/UnarmedAttack(atom/A, bypass_checks)
	. = ..()
	if(ishuman(A))
		learn_voice(A)

/mob/living/simple_animal/hostile/scp939/death(gibbed, deathmessage = "collapses with a final, gurgling hiss", show_dead_message)
	if(SCP && SCP.research)
		SCP.research.set_containment_status(SCP_NEUTRALIZED_STATUS)
	return ..()

/mob/living/simple_animal/hostile/scp939/proc/check_containment_status()
	if(!SCP || !SCP.research)
		return
	var/area/current = get_area(src)
	var/in_containment = (current == spawn_area)
	if(in_containment && SCP.research.containment_status == SCP_BREACHED)
		SCP.research.set_containment_status(SCP_CONTAINED)
	else if(!in_containment && SCP.research.containment_status != SCP_BREACHED)
		SCP.research.set_containment_status(SCP_BREACHED)
		if(world.time > last_containment_alert + containment_alert_cooldown)
			last_containment_alert = world.time
			priority_announcement.Announce(
				"ALERT: SCP-939 has been detected outside its containment zone. All personnel are advised to remain silent and avoid the area.",
				"SCP-939 Containment Breach",
				'sounds/effects/siren.ogg'
			)

/mob/living/simple_animal/hostile/scp939/verb/mimic_say()
	set name = "Mimic Voice"
	set category = "SCP"
	if(!length(learned_voices))
		to_chat(src, SPAN_WARNING("You have not learned any voices yet. Kill a human to learn their voice."))
		return
	var/voice_name = input(src, "Which voice to mimic?", "Voice Mimicry") as null|anything in learned_voices
	if(!voice_name)
		return
	var/message = input(src, "What should [voice_name] say?", "Voice Mimicry") as text|null
	if(!message)
		return
	message = sanitize(message)
	last_mimic_time = world.time
	for(var/mob/living/carbon/human/H in hearers(7, src))
		to_chat(H, "<b>[voice_name]</b> says, \"[message]\"")

/datum/ai_holder/simple_animal/melee/scp939
	cooperative = TRUE
	speak_chance = 0
	mauling = TRUE
	destructive = TRUE
	returns_home = FALSE
	can_flee = FALSE
	respect_confusion = FALSE
	var/voice_mimic_cooldown = 30 SECONDS
	var/last_mimic_attempt = 0

/datum/ai_holder/simple_animal/melee/scp939/can_attack(atom/movable/the_target, vision_required = TRUE)
	if(the_target.SCP)
		return ATTACK_FAILED
	return ..()

/datum/ai_holder/simple_animal/melee/scp939/list_targets()
	. = ..()
	var/list/new_targets = list()
	for(var/mob/living/L in .)
		if(L.stat == DEAD)
			continue
		if(ishuman(L))
			var/mob/living/carbon/human/H = L
			if(!H.mind)
				continue
		new_targets += L
	return new_targets

/datum/say_list/scp939
	emote_hear = list("hisses","growls","clicks")
	emote_see = list("sniffs the air", "turns its head", "twitches")

/obj/item/natural_weapon/bite/strong
	name = "razor teeth"
	force = 35
	attack_verb = list("bites", "mauls", "tears into")
	sharp = TRUE
	edge = TRUE
