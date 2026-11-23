/mob/living/simple_animal/hostile/scp247
	name = "cute kitty"
	desc = "A cute cat."
	icon = 'icons/scp/scp-247.dmi'

	icon_state = "scp-247"
	icon_living = "scp-247"
	icon_dead = "dead"

	maxHealth = 300
	health = 300

	response_help = "pets the"
	response_disarm = "gently pushes aside the"
	response_harm = "hits the"

	harm_intent_damage = 5

	ai_holder_type = /datum/ai_holder/simple_animal/melee/evasive/scp247
	say_list_type = /datum/say_list/cat

	natural_weapon = /obj/item/natural_weapon/bite/strong

	//config

	///minimium distance we have to be away in order to be able to fire on scp 247
	var/min_fire_distance = 3
	var/spawn_area

/mob/living/simple_animal/hostile/scp247/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src,
		"cute kitty",
		SCP_EUCLID,
		"247",
	)
	spawn_area = get_area(src)

/mob/living/simple_animal/hostile/scp247/Life()
	. = ..()
	if(spawn_area && SCP && SCP.research)
		var/area/current = get_area(src)
		if(current != spawn_area && SCP.research.containment_status != SCP_BREACHED)
			SCP.research.set_containment_status(SCP_BREACHED)
			for(var/mob/living/silicon/ai/AI in GLOB.living_mob_list_)
				to_chat(AI, SPAN_WARNING("<b>AI ALERT:</b> Unauthorized biological entity detected in [current ? current.name : "corridor"]. SCP-247 is outside its enclosure."))
		else if(current == spawn_area && SCP.research.containment_status == SCP_BREACHED)
			SCP.research.set_containment_status(SCP_CONTAINED)

// AI

/datum/ai_holder/simple_animal/melee/evasive/scp247
	returns_home = TRUE
	mauling = TRUE
	handle_corpse = TRUE
	home_low_priority = TRUE
	intelligence_level = AI_SMART
	use_astar = TRUE

/datum/ai_holder/simple_animal/melee/evasive/scp247/New()
	. = ..()
	home_turf = get_turf(holder)

// Overrides

/mob/living/simple_animal/hostile/scp247/bullet_act(obj/item/projectile/Proj) //This is a little bad but its the best way to keep this localized within 247
	if(Proj.damage && !Proj.nodamage && ishuman(Proj.firer) && (get_dist(Proj.firer, src) <= min_fire_distance))
		to_chat(Proj.firer, SPAN_WARNING(SPAN_BOLD("You cannot bear to fire at [src], and you miss intentionally!")))
		return PROJECTILE_FORCE_MISS
	else
		return ..()

/mob/living/simple_animal/hostile/scp247/attack_hand(mob/living/carbon/human/M)
	if(M.a_intent == I_HURT)
		to_chat(M, SPAN_WARNING(SPAN_BOLD("Why would you want to attack such a cute kitty?")))
		return
	else
		return ..()
