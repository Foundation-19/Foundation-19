#define SCP939_SCREEN_LOC_HELD   "EAST-8:16,SOUTH:5"
#define SCP939_SCREEN_LOC_HAT    "EAST-7:16,SOUTH:5"
#define SCP939_SCREEN_LOC_INTENT "EAST-2,SOUTH:5"
#define SCP939_SCREEN_LOC_HEALTH ui_alien_health

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
		"939", //Numerical Designation
		SCP_PLAYABLE|SCP_MEMETIC
	)

	SCP.min_time = 5 MINUTES
