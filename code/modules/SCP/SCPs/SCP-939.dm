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

/obj/screen/intent/scp939/on_update_icon()
	if(intent == I_HURT || intent == I_GRAB)
		intent = I_HURT
		icon_state = "intent_bite"
	else
		intent = I_HELP
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
	if(ishuman(the_target) && (O.nutrition > O.hunting_threshold))
		var/mob/living/carbon/human/H = the_target
		if(H.stat != DEAD)
			if((world.time - H.l_move_time) <= 10 SECONDS) //If the mob hasn't been moved/moved in the last 10 seconds
				return TRUE //Valid target
	return FALSE



//939 reagents, weapons and mobcode\\

/datum/reagent/medicine/amnestics/amnC227
	name = "AMN-C227"
	description = "AMN-C227 is a substance regularly exhaled by SCP-939 in low doses. In large quantities, or in the case of being directly bitten or in close proximity, it has been known to lead to direct fatalities, due to its incapacitating abilities."
	taste_description = "sickly bitterness"
	color = "#8a006c"
	metabolism = 0.025
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
		M.drowsyness += 4
		to_chat(M, "<font size='5' color='red'>You can't help but wonder why you feel so endangered... Surely it's nothing.</font>")
	if(prob(2))
		if(M.dizziness <= 200)
			M.make_dizzy(7)
			to_chat(M, "<font size='6' color='red'>A bout of nausea comes over you. Where is your pack? Where are you...? And yet, shortly after - that brief fright disappears from your memory...</font>")

/obj/item/natural_weapon/scp939
	name = "sharp jaws"
	attack_verb = list("mauls", "tears", "bites")
	hitsound = 'sounds/simple_mob/abominable_infestation/aggregate/attack.ogg'
	damtype = BRUTE
	melee_accuracy_bonus = 200
	stun_prob = 0 // Only combat!
	edge = 1
	force = 19 //Lower damage

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

	maxHealth = 900
	health = 900
	var/nutrition = 500 //How it handles hunger
	var/nutrition_max = 650 //Maximum nutrition storage
	var/hunting_threshold = 300 //When 939 gets hungry enough that its AI will actively attack players
	var/effect_cooldown = 5 SECONDS //ditto
	var/effect_cooldown_counter //keeps track of 939 'breathing' cd

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
	SCP.memeticFlags = MVISUAL|MAUDIBLE|MSYNCED //Needs to be synced to not indefinitely add this.
	SCP.memetic_proc = TYPE_PROC_REF(/mob/living/simple_animal/hostile/scp939, memetic_effect) //re-used SCP-012 code, works for our purposes
	SCP.compInit() //if only I understood this code

/mob/living/simple_animal/hostile/scp939/Life() //call this here specifically so it only runs on alive instances
	. = ..()
	SCP.meme_comp.check_viewers()
	SCP.meme_comp.activate_memetic_effects() //Memetic effects are synced because of how we handle sound

/mob/living/simple_animal/hostile/scp939/proc/memetic_effect(mob/living/carbon/human/H)
	for(var/obj/item/clothing/C in list(H.wear_mask, H.head))
		if(C && (C.body_parts_covered & FACE) && (C.item_flags & ITEM_FLAG_THICKMATERIAL))
			return FALSE //You can't breathe in the amnestics gas if you're wearing a gasmask or hazmat, sorry bud.
	var/obj/item/organ/internal/stomach/stomach_organ = H.internal_organs_by_name[BP_STOMACH]
	if(!H || H.stat == DEAD) //the dead don't breathe
		return
	else if(((world.time - effect_cooldown_counter) > effect_cooldown) || abs((world.time - effect_cooldown_counter) - effect_cooldown) < 0.1 SECONDS) //Last part is so that this can run for all affected humans without worrying about cooldown
		if(prob(60))
			H.visible_message(SPAN_WARNING("[H] seems unfocused, [H.p_their()] eyes wandering towards \"[name]\", slavishly drooling..."))
			to_chat(H, SPAN_WARNING("What a delightful scent... Where is my pack, again?"))
			stomach_organ.ingested.add_reagent(/datum/reagent/medicine/amnestics/amnC227, 0.95) //Largest exposure per tick
		else if(prob(50))
			H.visible_message(SPAN_DANGER("[H] seems to resist something intangible, [H.p_their()] eyes widening briefly as [H.p_their()] nose twitches!"))
			H.emote("sniff") //avoids exposure
			to_chat(H, SPAN_WARNING("Your barely-protected nose picks up the scent of something sweet and alluring. You feel like a fly in honeyed water."))
		else if(prob(30))
			if(prob(50))
				H.visible_message(SPAN_NOTICE("[H] doesn't seem to what they're doing, they stare at \"[name]\" and blink, not having known it was there..."))
				playsound(H, "sounds/voice/emotes/sigh_[gender2text(H.gender)].ogg", 100)
				stomach_organ.ingested.add_reagent(/datum/reagent/medicine/amnestics/amnC227, 0.24)
			else
				H.visible_message(SPAN_NOTICE("[H] looks at the \"[name]\" and cries."))
				to_chat(H, SPAN_WARNING("You feel sad for reasons you can't quite remember."))
				playsound(H, "sounds/voice/emotes/[gender2text(H.gender)]_cry[pick(list("1","2"))].ogg", 100)
				stomach_organ.ingested.add_reagent(/datum/reagent/medicine/amnestics/amnC227, 0.34)
		effect_cooldown_counter = world.time
