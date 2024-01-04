/mob/living/simple_animal/hostile/scp939
	name = "SCP-939"
	desc = "A large quadrupedal predator with red skin, no visible eyes, ears, or nose, and a mouth lined with hundreds of long, sharp teeth. It mimics human speech to lure its prey."
	icon = 'icons/SCP/scp_939.dmi'
	icon_state = "crawling"
	icon_living = "crawling"
	icon_dead = "dead_dramatic"
	turns_per_move = 5
	response_help = "pets"
	response_disarm = "gently pushes aside"
	response_harm = "hits"
	maxHealth = 200
	health = 200
	harm_intent_damage = 18
	attacktext = "mauls"
	attack_sound = null
	sight = SEE_MOBS | SEE_OBJS | SEE_TURFS
	minbodytemp = 0
	maxbodytemp = 500
	faction = list("scp")
	var/amnestic_strength = 1 // The strength of the amnestic effect
	var/amnestic_cooldown = 300 // Cooldown in seconds before SCP-939 can use its amnestic effect again
	ai_holder_type = /datum/ai_holder/simple_animal/melee/meat
	natural_weapon = /obj/item/natural_weapon/bite/medium

/mob/living/simple_animal/hostile/scp939/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"flesh monster", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_EUCLID, //Obj Class
		"939", //Numerical Designation
		SCP_PLAYABLE|SCP_ROLEPLAY
	)
/mob/living/simple_animal/hostile/scp939/apply_melee_effects(atom/A)
	if(isliving(A))
		var/mob/living/L = A
		if(L.reagents)
			var/target_zone = pick(BP_CHEST,BP_CHEST,BP_CHEST,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_HEAD)
			if(L.can_inject(src, null, target_zone))
				inject_amnestic(L, target_zone)

// Does actual poison injection, after all checks passed.
/mob/living/simple_animal/hostile/scp939/proc/inject_amnestic(mob/living/L, target_zone)
	if(prob(amnestic_cooldown))
		to_chat(L, SPAN_WARNING("You feel a tiny prick."))
		L.reagents.add_reagent(/datum/reagent/medicine/amnestics/classa, 10)

var/regen_rate = 1 // Health points regenerated per tick
var/regen_cooldown = 10 // Cooldown in seconds between each regen tick

/mob/living/simple_animal/hostile/scp939/Life()
	if(health < maxHealth)
		health = min(health + regen_rate, maxHealth)
	..()
/mob/living/simple_animal/hostile/scp939/death()

	var/turf/T = get_turf(src)
	if(T)
		var/obj/effect/decal/cleanable/blood/gibs/G = new /obj/effect/decal/cleanable/blood/gibs(T)
		//G.flick("gibbed", G)
		G.update_icon()

	..()
