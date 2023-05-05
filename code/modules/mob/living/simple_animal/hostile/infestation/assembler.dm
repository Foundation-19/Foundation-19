/mob/living/simple_animal/hostile/infestation/assembler
	name = "assembler"
	desc = "A large monstrosity with many appendages that it uses to 'assemble' things."
	icon = 'icons/mob/simple_animal/abominable_infestation/48x48.dmi'
	icon_state = "assembler"
	icon_living = "assembler"
	icon_dead = "assembler_dead"
	mob_size = MOB_MEDIUM
	default_pixel_x = -8
	pixel_x = -8

	natural_weapon = /obj/item/natural_weapon/assembler

	health = 200
	maxHealth = 200

	movement_cooldown = 4

	meat_type = /obj/item/reagent_containers/food/snacks/abominationmeat
	meat_amount = 8
	skin_material = MATERIAL_SKIN_CHITIN
	skin_amount = 2
	bone_material = MATERIAL_BONE_CARTILAGE
	bone_amount = 2

	ai_holder_type = /datum/ai_holder/simple_animal/infestation/assembler
	//say_list_type = /datum/say_list/infestation_assembler
	death_sounds = list(
		'sound/simple_mob/abominable_infestation/eviscerator/death_1.ogg',
		'sound/simple_mob/abominable_infestation/eviscerator/death_2.ogg',
		)

	// Organs add 1; Non-human mobs add 5.
	var/nutrient_stored = 0
	/// Assoc list Type = Nutrient Required; This is responsible for forcing larva's evolution target type
	var/larva_types = list(
		/mob/living/simple_animal/hostile/infestation/broodling = 5,
		/mob/living/simple_animal/hostile/infestation/spitter = 8,
		/mob/living/simple_animal/hostile/infestation/eviscerator = 12,
		/mob/living/simple_animal/hostile/infestation/assembler = 16,
		/mob/living/simple_animal/hostile/infestation/rhino = 20,
		)
	/// Not actually the limit, but the point where it will forcefully spawn larva without waiting for time
	var/nutrient_max = 25
	/// World time by which we will spawn a larva if we have no target
	var/larva_time

/obj/item/natural_weapon/assembler
	name = "sharp tentacle"
	attack_verb = list("stabbed", "pierced")
	force = 20
	armor_penetration = 10
	hitsound = 'sound/weapons/rapidslice.ogg'
	sharp = TRUE
	edge = TRUE

/datum/ai_holder/simple_animal/infestation/assembler
	cooperative = FALSE
	mauling = TRUE
	handle_corpse = TRUE
	returns_home = FALSE
	home_low_priority = TRUE
	speak_chance = 1
	wander = TRUE
	base_wander_delay = 20

/datum/ai_holder/simple_animal/infestation/assembler/list_targets()
	. = ..()

	var/static/alternative_targets = typecacheof(list(/obj/item/organ))
	for(var/obj/item/organ/O in typecache_filter_list(range(vision_range, holder), alternative_targets))
		if(can_see(holder, O, vision_range) && !BP_IS_ROBOTIC(O))
			. += O

/datum/ai_holder/simple_animal/infestation/assembler/pick_target(list/targets)
	var/mobs_only = locate(/mob/living) in targets // If a mob is in the list of targets, then ignore objects.
	if(mobs_only)
		for(var/A in targets)
			if(!isliving(A))
				targets -= A

	return ..(targets)

/mob/living/simple_animal/hostile/infestation/assembler/Initialize()
	. = ..()
	larva_time = world.time + 10 SECONDS

/mob/living/simple_animal/hostile/infestation/assembler/Life()
	. = ..()
	if(!.)
		return
	if(nutrient_stored >= nutrient_max || world.time >= larva_time)
		AttemptLarva()
		return

/mob/living/simple_animal/hostile/infestation/assembler/attack_target(atom/A)
	return UnarmedAttack(A)

/mob/living/simple_animal/hostile/infestation/assembler/UnarmedAttack(atom/A)
	if(istype(A, /obj/item/organ))
		ConsumeOrgan(A)
		ai_holder.target = null
		return

	if(isliving(A))
		var/mob/living/L = A
		if(L.stat)
			ConsumeDead(L)
			return

	return ..()

/mob/living/simple_animal/hostile/infestation/assembler/proc/ConsumeOrgan(obj/item/organ/O)
	visible_message(SPAN_WARNING("[src] consumes \the [O]."))
	qdel(O)
	nutrient_stored += 1

/mob/living/simple_animal/hostile/infestation/assembler/proc/ConsumeDead(mob/living/L)
	if(ishuman(L))
		ConsumeHuman(L)
		return

	visible_message(SPAN_DANGER("[src] starts to consume \the [L]!"))
	playsound(src, 'sound/simple_mob/abominable_infestation/assembler/ambient_1.ogg', 50, TRUE)
	set_AI_busy(TRUE)

	if(!do_after(src, min(10, L.mob_size) SECONDS, L))
		set_AI_busy(FALSE)
		return FALSE

	set_AI_busy(FALSE)
	visible_message(SPAN_DANGER("[src] consumes \the [L]!"))
	nutrient_stored += min(10, L.mob_size)
	larva_time = world.time + 10 SECONDS
	L.gib()

/mob/living/simple_animal/hostile/infestation/assembler/proc/ConsumeHuman(mob/living/carbon/human/H)
	visible_message(SPAN_DANGER("[src] starts to tear [H] apart!"))
	playsound(src, 'sound/simple_mob/abominable_infestation/assembler/ambient_1.ogg', 50, TRUE)
	set_AI_busy(TRUE)

	if(!do_after(src, 3 SECONDS, H))
		set_AI_busy(FALSE)
		return FALSE

	if(QDELETED(H))
		set_AI_busy(FALSE)
		return FALSE

	var/list/potential_organs = list()
	for(var/obj/item/organ/external/O in H.organs)
		if(istype(O, /obj/item/organ/external/stump))
			continue
		if(O.organ_tag in (BP_LEGS_FEET | BP_ARMS_HANDS))
			potential_organs += O
			continue
		if(!LAZYLEN(potential_organs) && (O.organ_tag in list(BP_HEAD, BP_GROIN)))
			potential_organs += O
			continue

	if(!LAZYLEN(potential_organs)) // Most likely only chest left
		for(var/obj/item/organ/internal/I in H.internal_organs)
			I.removed()
			I.forceMove(get_turf(H))
			if(!QDELETED(I) && isturf(loc))
				I.throw_at(get_edge_target_turf(get_turf(H), pick(GLOB.alldirs)), rand(1,2), 5)
		H.gib()
		set_AI_busy(FALSE)
		return

	var/obj/item/organ/external/target_organ = pick(potential_organs)
	target_organ.droplimb(FALSE, DROPLIMB_EDGE, FALSE, FALSE)
	for(var/obj/item/organ/I in target_organ.internal_organs)
		I.removed()
		I.forceMove(get_turf(target_organ))
		if(!QDELETED(I) && isturf(loc))
			I.throw_at(get_edge_target_turf(target_organ, pick(GLOB.alldirs)), rand(1,2), 5)

	larva_time = world.time + 5 SECONDS
	set_AI_busy(FALSE)

/mob/living/simple_animal/hostile/infestation/assembler/proc/AttemptLarva(forced_type = null)
	if(ai_holder.target)
		return

	larva_time = world.time + 5 SECONDS
	var/target_type = forced_type
	if(isnull(target_type))
		for(var/thing_type in larva_types)
			if(nutrient_stored < larva_types[thing_type])
				break
			target_type = thing_type

	if(isnull(target_type))
		return

	var/mob/living/simple_animal/hostile/infestation/larva/L = new(get_turf(src))
	L.transformation_target_type = target_type
	L.transformation_time = world.time + 30 SECONDS // Assembled larvas hatch faster
	L.color = color
	L.faction = faction
	playsound(L, 'sound/simple_mob/abominable_infestation/larva/spawn.ogg', rand(35, 50), TRUE)
	visible_message(SPAN_WARNING("[src] assembles new [L]!"))
	nutrient_stored -= larva_types[target_type]
