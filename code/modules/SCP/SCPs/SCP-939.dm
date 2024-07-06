//Defines
#define SCP939_SCREEN_LOC_HELD   "EAST-8:16,SOUTH:5"
#define SCP939_SCREEN_LOC_HAT    "EAST-7:16,SOUTH:5"
#define SCP939_SCREEN_LOC_INTENT "EAST-2,SOUTH:5"
#define SCP939_SCREEN_LOC_HEALTH ui_alien_health

//HUDCODE + AI code
/datum/hud/scp939

/obj/screen/intent/scp939
	icon = 'icons/mob/939hud.dmi'
	icon_state = "intent_help"
	screen_loc = SCP939_SCREEN_LOC_INTENT

/obj/screen/intent/scp939/on_update_icon(mob/user)
	if(user.a_intent == I_HURT || user.a_intent == I_GRAB)
		user.a_intent = I_HURT
		icon_state = "intent_bite"
	else
		user.a_intent = I_HELP
		icon_state = "intent_help"

/datum/hud/scp939/FinalizeInstantiation() //uses SCP939 hud as placeholders
	src.adding = list()
	src.other = list()

	action_intent = new /obj/screen/intent/scp939()
	adding += action_intent
	mymob.healths = new /obj/screen()
	mymob.healths.icon = 'icons/mob/939hud.dmi'
	mymob.healths.icon_state = "health0"
	mymob.healths.SetName("health")
	mymob.healths.screen_loc = SCP939_SCREEN_LOC_HEALTH

	mymob.client.screen = list(mymob.healths)
	mymob.client.screen += src.adding + src.other
	var/list/hud_elements = list()
	var/mob/living/H = mymob
	H.fov = new /obj/screen/fov/scp939()
	hud_elements |= H.fov

	H.fov_mask = new /obj/screen/fov_mask/scp939()
	hud_elements |= H.fov_mask
	mymob.client.screen += hud_elements

/datum/ai_holder/simple_animal/melee/scp939
	mauling = TRUE

/datum/ai_holder/simple_animal/melee/scp939/can_attack(atom/movable/the_target, vision_required = TRUE)
	if(!..())
		return FALSE
	var/mob/living/simple_animal/hostile/scp939/O = holder
	if(ismonkey(the_target))
		return TRUE //will always prioritise monkey
	if(ishuman(the_target) && (O.nutrition < O.hunting_threshold))
		var/mob/living/carbon/human/H = the_target
		if(H.stat != DEAD)
			if((world.time - H.l_move_time) <= 10 SECONDS && !istype(H.move_intent, /decl/move_intent/creep)  || (world.time - H.lastsound) <= 20 SECONDS && H.lastsound != null) //If the mob has moved near 939 instances without creeping, OR has made audible sounds.
				return TRUE //Valid target
	return FALSE

//939 reagents, weapons and mobcode\\

/datum/reagent/medicine/amnestics/amnC227
	name = "AMN-C227"
	description = "AMN-C227 is a substance regularly exhaled by SCP-939 in low doses. In large quantities, or in the case of being directly bitten or in close proximity, it has been known to lead to direct fatalities, due to its incapacitating abilities."
	taste_description = "sickly bitterness"
	color = "#8a006c"
	metabolism = 0.015
	overdose = 60 //WAY higher for 'exhaled' (memetic system) SCP-939 air
	value = 35
	addiction_types = list(/datum/addiction/amnestics = 0.1) // very rare

/datum/reagent/medicine/amnestics/amnC227/affect_blood(mob/living/carbon/M, removed)

	if((volume > 0.25) && !isamnesticized) //Upon initial check, inform about amnestic
		isamnesticized = TRUE
		M.visible_message(SPAN_WARNING("[M]'s eyes grow dim."))
		to_chat(M, "<font size='5' color='red'>It feels like a dim haze has come over your mind, you can't remember what you were doing five seconds ago - and you can't seem to form any new memories...</font>")
	if((volume <= 0.25) && isamnesticized) //Once the amnestic wears off, re-inform about memory regain
		isamnesticized = FALSE
		M.visible_message(SPAN_WARNING("[M]'s eyes regain their focus."))
		to_chat(M, "<font size='5' color='red'>Your mind feels a lot clearer, but... You can't recall the last [2 * round(M.chem_doses[type], 1) / metabolism] seconds.</font>")
	M.add_chemical_effect(CE_SEDATE, 0.11) //sedative logic stolen from chloral hydrate.
	if(prob(1))
		M.adjust_drowsiness(5 SECONDS)
		to_chat(M, "<font size='5' color='red'>You can't help but wonder why you feel so endangered... Surely it's nothing.</font>")
	if(prob(2))
		M.adjust_dizzy(7 SECONDS)
		to_chat(M, "<font size='6' color='red'>A bout of nausea comes over you. Where is your pack? Where are you...? And yet, shortly after - that brief fright disappears from your memory...</font>")

/obj/item/natural_weapon/scp939
	name = "sharp jaws"
	attack_verb = list("mauled", "torn", "bitten", "savagely crunched")
	hitsound = 'sounds/simple_mob/abominable_infestation/aggregate/attack.ogg'
	damtype = BRUTE
	melee_accuracy_bonus = 200
	stun_prob = 0 // Only combat!
	edge = 1
	force = 22 //Lower damage
	armor_penetration = 25

/obj/item/natural_weapon/scp939/apply_hit_effect(mob/living/target, mob/living/user, hit_zone)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(SpawnBiteEffect), target)) //Spawn bite effect, as it looks good.

/obj/item/natural_weapon/scp939/proc/SpawnBiteEffect(mob/living/target)
	if(QDELETED(target))
		return
	var/obj/effect/temp_visual/bite/B = new (get_turf(target))

	B.color = pick(COLOR_MAROON, COLOR_RED, COLOR_RED_GRAY)
	B.pixel_x = rand(-8, 8)
	B.pixel_y = rand(-8, 8)


/mob/living/simple_animal/hostile/scp939
	name = "large red dog"
	desc = "A huge, hulking dog-looking creature. It lacks eyes and seems to respond to sound..."
	icon = 'icons/SCP/scp-939.dmi'

	icon_state = "crawling"
	icon_dead = "dead_dramatic"
	icon_rest = "standing"
	icon_living = "crawling" //backup incase admins fuck something up
	alpha = 255
	default_pixel_x = -8
	default_pixel_y = -8

	maxHealth = 650 // Ditto for below
	health = 650 //Beefy, but not as tanky as other SCPs.
	var/regeneration_speed = 0.005 //controls how fast you restore health.
	var/starvation_damage = 0.005

	var/nutrition = 500 //How it handles hunger
	var/nutrition_max = 650 //Maximum nutrition storage
	var/hunting_threshold = 300 //When 939 gets hungry enough that its AI will actively attack players
	var/nutriloss = 0.12 //Slow by default. Ramps hard when injured.

	var/spawn_area
	var/door_cooldown

	var/message_cooldown = 25 SECONDS
	var/effect_cooldown_counter //keeps track of 939 'breathing' cd
	var/is_sleeping = FALSE
	hud_type = /datum/hud/scp939
	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 7
	usefov = 1

	universal_speak = 1	// 939 can understand all languages
	speak_emote = list("growls", "shouts", "screams", "says", "whispers")

	movement_cooldown = 2.9
	movement_sound = 'sounds/mecha/mechmove04.ogg'

	a_intent = "harm"
	can_be_buckled = TRUE
	natural_weapon = /obj/item/natural_weapon/scp939
	natural_armor = list(
		melee = ARMOR_MELEE_RESISTANT,
		bullet = ARMOR_BALLISTIC_PISTOL
		)

	ai_holder_type = /datum/ai_holder/simple_animal/melee/scp939 //janky but acceptable 939 AI
	melee_attack_delay = 0

/mob/living/simple_animal/hostile/scp939/Initialize()
	. = ..()
	add_language(LANGUAGE_ZOMBIE, 0) //Can understand their growls, can't speak
	add_language(LANGUAGE_ENGLISH, 1) //939 primarily hunts english-speaking individuals in Site-53
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"large red dog", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_KETER, //Obj Class
		"939-[rand(0,999)]", //randomises instance number
		SCP_PLAYABLE|SCP_MEMETIC
	)

	SCP.min_time = 25 MINUTES //These things become VERY dangerous when multiple of them spawn
	SCP.memeticFlags = MVISUAL|MAUDIBLE|MSYNCED //Needs to be synced to not indefinitely add this. Also uses VISUAL and AUDIBLE as if you're in range to see or hear 939, you're usually breathing the same air as it.
	SCP.memetic_proc = TYPE_PROC_REF(/mob/living/simple_animal/hostile/scp939, memetic_effect) //re-used SCP-012 code, works for our purposes
	SCP.compInit() //if only I understood this code
	spawn_area = get_area(src) //Used to track where SCP-939 is mapped in (or spawned)

//Incorporates lots of 2427-3 code, just because its good

/mob/living/simple_animal/hostile/scp939/Bump(atom/A)
	. = ..()
	if(a_intent != I_HELP)
		if(isliving(A) && canClick() && !A.SCP)
			UnarmedAttack(A)

/mob/living/simple_animal/hostile/scp939/attack_target(atom/A)
	return UnarmedAttack(A)

/mob/living/simple_animal/hostile/scp939/proc/AdjustNutrition(amount)
	nutrition = max(0, nutrition + amount)
	if(!is_sleeping && nutrition >= nutrition_max)
		FallAsleep()

/mob/living/simple_animal/hostile/scp939/proc/FallAsleep()
	if(is_sleeping)
		return
	visible_message(
		SPAN_NOTICE("[src] falls asleep."),
		SPAN_NOTICE("You fall asleep."))
	icon_state = "slep"
	is_sleeping = TRUE
	addtimer(CALLBACK(src, PROC_REF(WakeUp)), rand((2 MINUTES), (4 MINUTES)))

/mob/living/simple_animal/hostile/scp939/proc/WakeUp(attacked = FALSE)
	if(!is_sleeping)
		return
	revive() //Encouragement to not delay eating, only way for 939 to heal to full HP without constantly stopping to maul corpses.
	visible_message(
		SPAN_DANGER("[src] wakes up, shaking dust and blood from its form."),
		SPAN_NOTICE("You wake up."))
	sleep(2 SECONDS)
	is_sleeping = FALSE
	icon_state = "crawling"
	if(icon_state == "slep") // If somehow we died before WakeUp got called
		icon_state = null

/mob/living/simple_animal/hostile/scp939/SelfMove(direction)
	resting = FALSE //Yeh.
	if(is_sleeping)
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/scp939/IMove(turf/newloc, safety = TRUE)
	if(is_sleeping)
		return MOVEMENT_ON_COOLDOWN
	return ..()

/mob/living/simple_animal/hostile/scp939/get_status_tab_items()
	. = ..()
	if(stat == DEAD)
		. += "I am dead."
	else if(is_sleeping)
		. += "I am asleep."

	if(nutrition <= 50)
		. += "Hunger: I AM GOING TO STARVE TO DEATH!! ([round(nutrition)]/[nutrition_max])"
	else if(nutrition <= hunting_threshold)
		. += "Hunger: I NEED MEAT RIGHT NOW! HUNT AND KILL! ([round(nutrition)]/[nutrition_max])"
	else
		. += "Hunger: [round(nutrition)]/[nutrition_max]"

/mob/living/simple_animal/hostile/scp939/Life() //call this here specifically so it only runs on alive instances
	. = ..()
	if(!src.stat == DEAD)
		SCP.meme_comp.check_viewers()
		SCP.meme_comp.activate_memetic_effects() //Memetic effects are synced because of how we handle sound
	if(src.client) //Will entirely stop nutrition loss and regeneration if you refuse to comply and eat.
		if(istype(get_area(src), spawn_area)) // Hm yes, today I will ignore all the corpses and goats around me to breach
			for(var/mob/living/L in dview(7, src))
				if(istype(L, /mob/living/simple_animal/hostile/retaliate/goat))
					return FALSE
				if(istype(L, /mob/living/carbon/human/monkey))
					return FALSE
	if(nutrition >= 1 && src.client)
		if(health < maxHealth)
			var/regen_coeff = (-round(maxHealth * regeneration_speed))
			adjustBruteLoss(regen_coeff)
			AdjustNutrition(regen_coeff/2)
	if(nutrition <= 15) // Starvation.
		adjustBruteLoss(maxHealth * starvation_damage)
	if(nutrition >= 1)
		AdjustNutrition(-nutriloss)

/mob/living/simple_animal/hostile/scp939/proc/memetic_effect(mob/living/carbon/human/H)
	var/obj/item/organ/internal/stomach/stomach_organ = H.internal_organs_by_name[BP_STOMACH]
	var/randval = rand(1,4)
	if(!(H.head && (H.head.body_parts_covered & FACE) || H.wear_mask))
		if((world.time - H.humanStageHandler.getStage("939_message")) > message_cooldown)
			switch(randval)
				if(1)
					H.visible_message(SPAN_NOTICE("[H] looks at the [name] and cries."))
					stomach_organ.ingested.add_reagent(/datum/reagent/medicine/amnestics/amnC227, 0.67)
				if(2)
					H.visible_message(SPAN_WARNING("[H] seems unfocused, [H.p_their()] eyes wandering towards \"[name]\", slavishly drooling..."))
					stomach_organ.ingested.add_reagent(/datum/reagent/medicine/amnestics/amnC227, 1.7) //Largest exposure per tick
				if(3)
					H.visible_message(SPAN_DANGER("[H] seems to resist something intangible, [H.p_their()] eyes widening briefly as [H.p_their()] nose twitches!"))
					H.emote("sniff") //avoids exposure
					to_chat(H, SPAN_WARNING("Your barely-protected nose picks up the scent of something sweet and alluring. You feel like a fly in honeyed water."))
				if(4)
					H.visible_message(SPAN_NOTICE("[H] doesn't seem to what they're doing, they stare at \"[name]\" and blink, not having known it was there..."))
					playsound(H, "sounds/voice/emotes/sigh_[gender2text(H.gender)].ogg", 100)
					stomach_organ.ingested.add_reagent(/datum/reagent/medicine/amnestics/amnC227, 0.67)
			H.humanStageHandler.setStage("939_message", world.time)


/mob/living/simple_animal/hostile/scp939/UnarmedAttack(atom/A)
	if(is_sleeping)
		return
	if(istype(A, /obj/machinery/door))
		OpenDoor(A)
		return
	if(istype(A, /obj/machinery/power/apc))
		return // Fuck you RealB - Especially because I can see 939 doing this too.
	if(isliving(A))
		var/mob/living/L = A
		if(ishuman(L))
			var/mob/living/carbon/human/RIP = L
			var/obj/item/organ/internal/stomach/stomach_organ = RIP.internal_organs_by_name[BP_STOMACH]
			stomach_organ.ingested.add_reagent(/datum/reagent/medicine/amnestics/amnC227, 0.09) //Small exposure per bite.
		// Brute loss part is mainly for humans
		if((L.stat == DEAD) || (L.stat && ((L.health <= L.maxHealth * 0.25) || (L.getBruteLoss() >= L.maxHealth * 2))))
			var/nutr = L.mob_size
			if(istype(L, /mob/living/simple_animal/hostile/retaliate/goat)) // Makes it simpler if kept consistent with 2427-3
				nutr = round(nutrition_max * 0.5) //Almost full nutrition
			if(ismonkey(L))
				nutr = round(nutrition_max * 0.18) //Smaller than 2427-3
				visible_message(SPAN_DANGER("[src] mauls [L]!"))
				AdjustNutrition(nutr)
				L.gib()
			if(ishuman(L))
				if((world.time - L.lastsound) <= 50 SECONDS && L.lastsound != null) //OBJECTIVE: SURVIVE 50 SECONDS AFTER AGGROING 939
					nutr = round(nutrition_max * 0.23)
					L.adjustBruteLoss(350)
					L.lastsound = null //Null this (stops repeat-mauls from instantly gibbing crit people)
					visible_message(SPAN_DANGER("[src] mauls [L]!"))
					AdjustNutrition(nutr)
					return
				else
					visible_message(SPAN_DANGER("[src] looks confused at [L]!"))
					return
			playsound(src, 'sounds/scp/2427/consume.ogg', rand(15, 35), TRUE)
			visible_message(SPAN_DANGER("[src] mauls [L]!"))
			AdjustNutrition(nutr)
			L.gib()
			return
	return ..()


/mob/living/simple_animal/hostile/scp939/proc/OpenDoor(obj/machinery/door/A)
	if(door_cooldown > world.time)
		return

	if(!istype(A))
		return

	if(!A.density)
		return

	if(!A.Adjacent(src))
		to_chat(src, SPAN_WARNING("\The [A] is too far away."))
		return

	if(nutrition >= hunting_threshold && (get_area(A) == spawn_area))
		to_chat(src, SPAN_WARNING("You cannot open blast doors in your containment zone unless sufficiently hungry."))
		return

	var/open_time = istype(A, /obj/machinery/door/blast) ? 8 SECONDS : 3 SECONDS

	if(istype(A, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/AR = A
		if(AR.locked)
			open_time += 4 SECONDS
		if(AR.welded)
			open_time += 4 SECONDS
		if(AR.secured_wires)
			open_time += 5 SECONDS

	A.visible_message(SPAN_WARNING("\The [src] begins to pry open \the [A]!"))
	if(open_time > 0.5 SECONDS)
		playsound(get_turf(A), 'sounds/machines/airlock_creaking.ogg', 35, 1)
	door_cooldown = world.time + open_time // To avoid sound spam

	if(!do_after(src, open_time, A))
		return

	if(istype(A, /obj/machinery/door/blast))
		var/obj/machinery/door/blast/DB = A
		DB.visible_message(SPAN_DANGER("\The [src] tries to forcefully open \the [DB], damaging it with a shower of sparks!"))
		DB.health -= 250 // Do severe damage per use
		var/init_px = pixel_x
		var/shake_dir = pick(-1, 1)
		animate(DB, transform=turn(matrix(), 8*shake_dir), pixel_x=init_px + 2*shake_dir, time=1)
		animate(transform=null, pixel_x=init_px, time=6, easing=ELASTIC_EASING)
		if(DB.health <= 249) //Odd value to make Bdoors take longer to break
			DB.visible_message(SPAN_DANGER("\The [src] manages to rip open \the [DB]!"))
			DB.force_open()
		return

	if(istype(A, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/AR = A
		AR.unlock(TRUE) // No more bolting in the SCPs and calling it a day
		AR.welded = FALSE
	A.set_broken(TRUE)
	var/check = A.open(TRUE)
	visible_message("\The [src] slices \the [A]'s controls[check ? ", ripping it open!" : ", breaking it!"]")
