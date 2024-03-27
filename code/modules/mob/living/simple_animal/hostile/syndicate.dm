/mob/living/simple_animal/hostile/syndicate
	name = "\improper Syndicate operative"
	desc = "Death to the Company."
	icon_state = "syndicate"
	icon_living = "syndicate"
	icon_dead = "syndicate_dead"
	icon_gib = "syndicate_gib"
	turns_per_move = 5
	response_help = "pokes"
	response_disarm = "shoves"
	response_harm = "hits"
	movement_cooldown = 4
	maxHealth = 100
	health = 100
	harm_intent_damage = 5
	natural_weapon = /obj/item/natural_weapon/punch
	can_escape = TRUE
	a_intent = I_HURT
	var/corpse = /obj/effect/landmark/corpse/syndicate
	unsuitable_atmos_damage = 15
	environment_smash = 1
	faction = "syndicate"
	status_flags = CANPUSH

/mob/living/simple_animal/hostile/syndicate/death(gibbed, deathmessage, show_dead_message)
	..(gibbed, deathmessage, show_dead_message)
	if(corpse)
		new corpse (src.loc)
	qdel(src)
	return

///////////////Sword and shield////////////

/mob/living/simple_animal/hostile/syndicate/melee
	icon_state = "syndicatemelee"
	icon_living = "syndicatemelee"
	natural_weapon = /obj/item/melee/energy/sword/red/activated
	loot_list = list(
		/obj/item/melee/energy/sword/red/activated = 1,
		/obj/item/shield/energy = 1,
	)
	status_flags = 0

/mob/living/simple_animal/hostile/syndicate/melee/attackby(obj/item/O as obj, mob/user as mob)
	if(O.force)
		if(prob(80))
			var/damage = O.force
			if (O.damtype == PAIN)
				damage = 0
			health -= damage
			visible_message(SPAN_DANGER("\The [src] has been attacked with \the [O] by \the [user]."))
		else
			visible_message(SPAN_DANGER("\The [src] blocks the [O] with its shield!"))
		//user.do_attack_animation(src)
	else
		to_chat(usr, SPAN_WARNING("This weapon is ineffective, it does no damage."))
		visible_message(SPAN_WARNING("\The [user] gently taps \the [src] with \the [O]."))

/mob/living/simple_animal/hostile/syndicate/melee/bullet_act(obj/item/projectile/Proj)
	if(prob(35))
		visible_message(SPAN_DANGER("\The [src] blocks \the [Proj] with its shield!"))
		return PROJECTILE_FORCE_MISS
	return ..()


/mob/living/simple_animal/hostile/syndicate/melee/space
	min_gas = null
	max_gas = null
	minbodytemp = 0
	icon_state = "syndicatemeleespace"
	icon_living = "syndicatemeleespace"
	name = "Syndicate Commando"
	corpse = /obj/effect/landmark/corpse/syndicate

/mob/living/simple_animal/hostile/syndicate/ranged
	ranged = 1
	rapid = 1
	icon_state = "syndicateranged"
	icon_living = "syndicateranged"
	casingtype = /obj/item/ammo_casing/pistol
	projectilesound = 'sounds/weapons/gunshot/smg.ogg'
	projectiletype = /obj/item/projectile/bullet/pistol
	loot_list = list(
		/obj/item/gun/projectile/automatic/merc_smg = 1,
	)

/mob/living/simple_animal/hostile/syndicate/ranged/space
	icon_state = "syndicaterangedpsace"
	icon_living = "syndicaterangedpsace"
	name = "Syndicate Commando"
	min_gas = null
	max_gas = null
	minbodytemp = 0
	corpse = /obj/effect/landmark/corpse/syndicate/commando

/mob/living/simple_animal/hostile/viscerator
	name = "viscerator"
	desc = "A small, twin-bladed machine capable of inflicting very deadly lacerations."
	icon = 'icons/mob/simple_animal/critter.dmi'
	icon_state = "viscerator_attack"
	icon_living = "viscerator_attack"
	pass_flags = PASS_FLAG_TABLE
	health = 15
	maxHealth = 15
	natural_weapon = /obj/item/natural_weapon/rotating_blade
	faction = "syndicate"
	min_gas = null
	max_gas = null
	minbodytemp = 0

	meat_type =     null
	meat_amount =   0
	bone_material = null
	bone_amount =   0
	skin_material = null
	skin_amount =   0

/obj/item/natural_weapon/rotating_blade
	name = "rotating blades"
	attack_verb = list("sliced", "cut")
	hitsound = 'sounds/weapons/bladeslice.ogg'
	force = 15
	edge = 1
	sharp = 1

/mob/living/simple_animal/hostile/viscerator/death(gibbed, deathmessage, show_dead_message)
	..(null,"is smashed into pieces!", show_dead_message)
	qdel(src)

/mob/living/simple_animal/hostile/viscerator/hive
	faction = "hivebot"

// Chaos Insurgency

/mob/living/simple_animal/hostile/syndicate/chaos
	name = "Chaos Insurgency Trooper"
	desc = "A man in russian military gear, wielding an AK-47. You feel them observe you angrily. Death to The Foundation."
	icon_state = "citrooper"
	icon_living = "citrooper"
	maxHealth = 125
	health = 125
	faction = "syndicate"
	ranged = 1
	rapid = 0
	casingtype = /obj/item/ammo_casing/flechette
	projectilesound = 'sounds/weapons/gunshot/gunshot.ogg'
	projectiletype = /obj/item/projectile/bullet/flechette
	corpse = /obj/effect/landmark/corpse/chaos
	loot_list = list(
		/obj/item/gun/projectile/automatic/scp/ak47 = 1,
	)

/mob/living/simple_animal/hostile/syndicate/chaos/heavy
	name = "Chaos Insurgency Heavy Trooper"
	desc = "A man in heavy russian military gear, wielding an RPK-74. You feel them observe you angrily. Death to The Foundation."
	icon_state = "ciheavytrooper"
	icon_living = "ciheavytrooper"
	maxHealth = 175
	health = 175
	faction = "syndicate"
	ranged = 1
	rapid = 1
	casingtype = /obj/item/ammo_casing/flechette
	projectilesound = 'sounds/weapons/gunshot/gunshot.ogg'
	projectiletype = /obj/item/projectile/bullet/flechette
	corpse = /obj/effect/landmark/corpse/chaos/heavy
	loot_list = list(
		/obj/item/gun/projectile/automatic/scp/rpk = 1,
	)

/mob/living/simple_animal/hostile/syndicate/chaos/officer
	name = "Chaos Insurgency Team Leader"
	desc = "A man in russian military gear, alongside an officer cap, wielding an AK-47. You feel them observe you angrily. Death to The Foundation."
	icon_state = "cileader"
	icon_living = "cileader"
	maxHealth = 150
	health = 150
	faction = "syndicate"
	ranged = 1
	rapid = 1
	casingtype = /obj/item/ammo_casing/flechette
	projectilesound = 'sounds/weapons/gunshot/gunshot.ogg'
	projectiletype = /obj/item/projectile/bullet/flechette
	corpse = /obj/effect/landmark/corpse/chaos/officer
	loot_list = list(
		/obj/item/gun/projectile/automatic/scp/ak47 = 1,
	)
