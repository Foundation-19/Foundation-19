/obj/item/projectile/bullet
	name = "bullet"
	icon_state = "bullet"
	fire_sound = 'sounds/weapons/gunshot/gunshot_strong.ogg'
	damage = 45
	damage_type = BRUTE
	damage_flags = DAM_BULLET | DAM_SHARP
	embed = TRUE
	penetration_modifier = 1.0
	var/mob_passthrough_check = 0

	muzzle_type = /obj/effect/projectile/muzzle/bullet
	miss_sounds = list('sounds/weapons/guns/miss1.ogg','sounds/weapons/guns/miss2.ogg','sounds/weapons/guns/miss3.ogg','sounds/weapons/guns/miss4.ogg')
	ricochet_sounds = list('sounds/weapons/guns/ricochet1.ogg', 'sounds/weapons/guns/ricochet2.ogg',
							'sounds/weapons/guns/ricochet3.ogg', 'sounds/weapons/guns/ricochet4.ogg')
	impact_sounds = list(BULLET_IMPACT_MEAT = SOUNDS_BULLET_MEAT, BULLET_IMPACT_METAL = SOUNDS_BULLET_METAL)

/obj/item/projectile/bullet/on_hit(atom/target, blocked = 0)
	if (..(target, blocked))
		var/mob/living/L = target
		shake_camera(L, 3, 2)

/obj/item/projectile/bullet/attack_mob(mob/living/target_mob, distance, miss_modifier)
	if(penetrating > 0 && damage > 20 && prob(damage))
		mob_passthrough_check = 1
	else
		mob_passthrough_check = 0
	. = ..()

	if(. == 1 && iscarbon(target_mob))
		damage *= 0.7 //squishy mobs absorb KE

/obj/item/projectile/bullet/can_embed()
	//prevent embedding if the projectile is passing through the mob
	if(mob_passthrough_check)
		return 0
	return ..()

/obj/item/projectile/bullet/check_penetrate(atom/A)
	if(QDELETED(A) || !A.density) return 1 //if whatever it was got destroyed when we hit it, then I guess we can just keep going

	if(ismob(A))
		if(!mob_passthrough_check)
			return 0
		return 1

	var/chance = damage
	if(has_extension(A, /datum/extension/penetration))
		var/datum/extension/penetration/P = get_extension(A, /datum/extension/penetration)
		chance = P.PenetrationProbability(chance, damage, damage_type)

	if(prob(chance))
		if(A.opacity)
			//display a message so that people on the other side aren't so confused
			A.visible_message(SPAN_WARNING("\The [src] pierces through \the [A]!"))
		return 1

	return 0

//For projectiles that actually represent clouds of projectiles
/obj/item/projectile/bullet/pellet
	name = "shrapnel" //'shrapnel' sounds more dangerous (i.e. cooler) than 'pellet'
	damage = DAM_BULLET_SHRAP
	//icon_state = "bullet" //TODO: would be nice to have it's own icon state
	var/pellets = 6			//number of pellets
	var/range_step = 2		//projectile will lose a fragment each time it travels this distance. Can be a non-integer.
	var/base_spread = 90	//lower means the pellets spread more across body parts. If zero then this is considered a shrapnel explosion instead of a shrapnel cone
	var/spread_step = 10	//higher means the pellets spread more across body parts with distance

/obj/item/projectile/bullet/pellet/Bumped()
	. = ..()
	bumped = 0 //can hit all mobs in a tile. pellets is decremented inside attack_mob so this should be fine.

/obj/item/projectile/bullet/pellet/proc/get_pellets(distance)
	var/pellet_loss = round((distance - 1)/range_step) //pellets lost due to distance
	return max(pellets - pellet_loss, 1)

/obj/item/projectile/bullet/pellet/attack_mob(mob/living/target_mob, distance, miss_modifier)
	if (pellets < 0) return 1

	var/total_pellets = get_pellets(distance)
	var/spread = max(base_spread - (spread_step*distance), 0)

	//shrapnel explosions miss prone mobs with a chance that increases with distance
	var/prone_chance = 0
	if(!base_spread)
		prone_chance = max(spread_step*(distance - 2), 0)

	var/hits = 0
	for (var/i in 1 to total_pellets)
		if(target_mob.lying && target_mob != original && prob(prone_chance))
			continue

		//pellet hits spread out across different zones, but 'aim at' the targeted zone with higher probability
		//whether the pellet actually hits the def_zone or a different zone should still be determined by the parent using get_zone_with_miss_chance().
		var/old_zone = def_zone
		def_zone = ran_zone(def_zone, spread)
		if (..()) hits++
		def_zone = old_zone //restore the original zone the projectile was aimed at

	pellets -= hits //each hit reduces the number of pellets left
	if (hits >= total_pellets || pellets <= 0)
		return 1
	return 0

/obj/item/projectile/bullet/pellet/get_structure_damage()
	var/distance = get_dist(loc, starting)
	return ..() * get_pellets(distance)

/obj/item/projectile/bullet/pellet/Move()
	. = ..()

	//If this is a shrapnel explosion, allow mobs that are prone to get hit, too
	if(. && !base_spread && isturf(loc))
		for(var/mob/living/M in loc)
			if(M.lying || !M.CanPass(src, loc, 0.5, 0)) //Bump if lying or if we would normally Bump.
				if(Bump(M)) //Bump will make sure we don't hit a mob multiple times
					return

/* short-casing projectiles, like the kind used in pistols or SMGs */

/obj/item/projectile/bullet/pistol
	fire_sound = 'sounds/weapons/gunshot/gunshot_9mm.ogg'
	damage = DAM_BULLET_9MM
	armor_penetration = 0
	distance_falloff = 3

/obj/item/projectile/bullet/pistol/holdout
	damage = DAM_BULLET_9MM
	penetration_modifier = 1.2
	distance_falloff = 4

/obj/item/projectile/bullet/pistol/strong
	fire_sound = 'sounds/weapons/gunshot/revolver.ogg'
	damage = DAM_BULLET_357
	penetration_modifier = 0.8
	distance_falloff = 2.5
	armor_penetration = 15

/obj/item/projectile/bullet/pistol/rubber //"rubber" bullets
	name = "rubber bullet"
	damage_flags = 0
	damage = DAM_BULLET_HEAVY_RUBBER
	agony = 30
	embed = FALSE

/obj/item/projectile/bullet/pistol/rubber/holdout
	agony = 20

// Revolvers
/obj/item/projectile/bullet/revolver
	fire_sound = 'sounds/weapons/gunshot/revolver.ogg'
	damage = DAM_BULLET_357
	distance_falloff = 3

/obj/item/projectile/bullet/revolver/rubber
	name = "rubber bullet"
	damage_flags = 0
	damage = DAM_BULLET_HEAVY_RUBBER
	agony = 40
	embed = FALSE

/obj/item/projectile/bullet/revolver/small
	fire_sound = 'sounds/weapons/gunshot/revolver_light.ogg'
	damage = DAM_BULLET_9MM
	penetration_modifier = 1.2
	distance_falloff = 4

/obj/item/projectile/bullet/revolver/medium
	damage = DAM_BULLET_357

/obj/item/projectile/bullet/revolver/heavy
	fire_sound = 'sounds/weapons/gunshot/revolver_heavy.ogg'
	damage = DAM_BULLET_454
	penetration_modifier = 0.8
	distance_falloff = 2.5
	armor_penetration = 15

//4mm. Tiny, very low damage, does not embed, but has very high penetration. Only to be used for the experimental SMG.
/obj/item/projectile/bullet/flechette
	fire_sound = 'sounds/weapons/gunshot/smg.ogg'
	damage = DAM_BULLET_4MM
	penetrating = 1
	armor_penetration = 70
	embed = FALSE
	distance_falloff = 2

// Higher damage, less AP
/obj/item/projectile/bullet/flechette/hp
	fire_sound = 'sounds/weapons/gunshot/smg_alt.ogg'
	damage = DAM_BULLET_4MMHP
	armor_penetration = 20

/obj/item/projectile/bullet/blank
	invisibility = 101
	damage = DAM_BULLET_RUBBER
	embed = FALSE

/* Practice */

/obj/item/projectile/bullet/pistol/practice
	damage = DAM_BULLET_HEAVY_RUBBER

/obj/item/projectile/bullet/pistol/ap
	damage = DAM_BULLET_10MM
	armor_penetration = 10

/obj/item/projectile/bullet/pistol/hp
	damage = DAM_BULLET_10MMHM
	armor_penetration = -10

/obj/item/projectile/bullet/rifle/military/practice
	damage = DAM_BULLET_HEAVY_RUBBER

/obj/item/projectile/bullet/shotgun/practice
	name = "practice"
	damage = DAM_BULLET_HEAVY_RUBBER

/obj/item/projectile/bullet/rifle/a762/practice
	damage = DAM_BULLET_HEAVY_RUBBER

/obj/item/projectile/bullet/pistol/cap
	name = "cap"
	invisibility = 101
	fire_sound = null
	damage_type = PAIN
	damage_flags = 0
	damage = 0
	nodamage = TRUE
	embed = FALSE

/obj/item/projectile/bullet/pistol/cap/Process()
	qdel(src)
	return PROCESS_KILL

/obj/item/projectile/bullet/rock //spess dust
	name = "micrometeor"
	icon_state = "rock"
	damage = 40
	armor_penetration = 25
	life_span = 255
	distance_falloff = 0

/obj/item/projectile/bullet/rock/New()
	icon_state = "rock[rand(1,3)]"
	pixel_x = rand(-10,10)
	pixel_y = rand(-10,10)
	..()

// Rocket launcher
/obj/item/projectile/bullet/rocket
	name = "missile"
	icon_state = "missile"
	fire_sound = 'sounds/weapons/gunshot/launcher.ogg'
	var/exp_devastation = -1
	var/exp_heavy_impact = 2
	var/exp_light_impact = 4

/obj/item/projectile/bullet/rocket/on_hit(atom/target, blocked = 0)
	var/turf/T = get_turf(target)
	if(T)
		explosion(T, exp_devastation, exp_heavy_impact, exp_light_impact)
	..()

/obj/item/projectile/bullet/rocket/heavy
	exp_devastation = 2
	exp_heavy_impact = 5
	exp_light_impact = 8

//////////////////////////Bullets////////////////

/obj/item/projectile/bullet/pistol
	fire_sound = 'sounds/weapons/gunshot/gunshot_9mm.ogg'
	damage = DAM_BULLET_9MM //9mm, .38, etc
	armor_penetration = 0
	distance_falloff = 3

/obj/item/projectile/bullet/pistol/holdout
	damage = DAM_BULLET_9MM
	penetration_modifier = 1
	distance_falloff = 4

/obj/item/projectile/bullet/pistol/rubber
	name = "rubber bullet"
	damage = DAM_BULLET_RUBBER //Pistol rubber
	agony = 30
	embed = FALSE
	sharp = FALSE
	armor_penetration = 0
	damage_flags = 0

/obj/item/projectile/bullet/pistol/rubber/holdout
	agony = 20

/obj/item/projectile/bullet/pistol/medium
	damage = DAM_BULLET_45 //.45
	armor_penetration = 0

/obj/item/projectile/bullet/pistol/medium/ap
	damage = DAM_BULLET_45 //.45
	armor_penetration = 10

/obj/item/projectile/bullet/pistol/medium/revolver
	fire_sound = 'sounds/weapons/gunshot/gunshot_strong.ogg'
	damage = DAM_BULLET_44 //.44 magnum
	armor_penetration = 0

/obj/item/projectile/bullet/pistol/strong //matebas
	fire_sound = 'sounds/weapons/gunshot/gunshot_strong.ogg'
	damage = DAM_BULLET_44 //snowflake bullet
	armor_penetration = 0
	penetration_modifier = 0.8
	distance_falloff = 2.5

/obj/item/projectile/bullet/pistol/vstrong //tacrevolver
	fire_sound = 'sounds/weapons/gunshot/gunshot_strong.ogg'
	damage = DAM_BULLET_500SW //.500 S&W Magnum
	armor_penetration = 0

/obj/item/projectile/bullet/pistol/strong/revolver //revolvers
	damage = DAM_BULLET_127X50 //Revolvers get snowflake bullets, to keep them relevant
	armor_penetration = 0

// P90 SMG
/obj/item/projectile/bullet/a57
	fire_sound = 'sounds/weapons/gunshot/p90.ogg'
	damage = DAM_BULLET_10MM
	armor_penetration = 10
	distance_falloff = 3

/obj/item/projectile/bullet/a57/rubber
	damage = DAM_BULLET_RUBBER
	armor_penetration = 0
	agony = 10 // This thing has 50 bullets and full auto, come on
	embed = 0
	sharp = 0

/obj/item/projectile/bullet/a57/hollowpoint
	damage = DAM_BULLET_10MMHM //10mm hollowpoint
	armor_penetration = 0
	embed = 1

/obj/item/projectile/bullet/a57/ap
	damage = DAM_BULLET_10MM
	armor_penetration = 20

/obj/item/projectile/bullet/a57/silver
	damage = DAM_BULLET_10MMSILVER
	armor_penetration = 10

/* shotgun projectiles */

/obj/item/projectile/bullet/shotgun
	name = "slug"
	fire_sound = 'sounds/weapons/gunshot/shotgun.ogg'
	damage = DAM_BULLET_12G_SLUG
	armor_penetration = 5

/obj/item/projectile/bullet/shotgun/beanbag		//because beanbags are not bullets
	name = "beanbag"
	damage = DAM_BULLET_HEAVY_RUBBER
	agony = 70
	embed = FALSE
	sharp = FALSE
	armor_penetration = 0
	distance_falloff = 3


//Should do about 80 damage at 1 tile distance (adjacent), and 50 damage at 3 tiles distance.
//Overall less damage than slugs in exchange for more damage at very close range and more embedding
/obj/item/projectile/bullet/pellet/shotgun
	name = "shrapnel"
	fire_sound = 'sounds/weapons/gunshot/shotgun.ogg'
	damage = DAM_BULLET_12G_PELLET
	pellets = 9
	range_step = 1
	spread_step = 10

/obj/item/projectile/bullet/pellet/shotgun/rubbershot
	name = "rubbershot"
	damage = DAM_BULLET_RUBBER
	pellets = 8
	range_step = 1
	spread_step = 10
	agony = 25
	embed = 0
	sharp = 0

/* "Rifle" rounds */

/obj/item/projectile/bullet/rifle
	fire_sound = 'sounds/weapons/gunshot/gunshot3.ogg'
	damage = DAM_BULLET_5MMR
	armor_penetration = 25
	penetration_modifier = 1.5
	penetrating = 1
	distance_falloff = 1.5

/obj/item/projectile/bullet/rifle/a556
	fire_sound = 'sounds/weapons/gunshot/gunshot3.ogg'
	damage = DAM_BULLET_A556X45
	armor_penetration = 10

/obj/item/projectile/bullet/rifle/a762
	fire_sound = 'sounds/weapons/gunshot/gunshot2.ogg'
	damage = DAM_BULLET_A762X39
	armor_penetration = 5

/obj/item/projectile/bullet/rifle/a762x54
	fire_sound = 'sounds/weapons/gunshot/gunshot2.ogg'
	damage = DAM_BULLET_A762X54
	armor_penetration = 15

/obj/item/projectile/bullet/rifle/a762nato
	fire_sound = 'sounds/weapons/gunshot/gunshot2.ogg'
	damage = DAM_BULLET_A762X51
	armor_penetration = 15

/obj/item/projectile/bullet/rifle/a145
	fire_sound = 'sounds/weapons/gunshot/sniper.ogg'
	damage = DAM_BULLET_145
	stun = 3
	weaken = 3
	penetrating = 5
	armor_penetration = 100
	hitscan = 1 //so the PTR isn't useless as a sniper weapon
	penetration_modifier = 1.25

/obj/item/projectile/bullet/rifle/a145/apds
	damage = DAM_BULLET_145_APDS
	penetrating = 6
	armor_penetration = 120
	penetration_modifier = 1.5

/obj/item/projectile/bullet/blank
	invisibility = 101
	damage = DAM_BULLET_RUBBER
	embed = 0

/* "Rifle" rounds */

/obj/item/projectile/bullet/rifle/military
	fire_sound = 'sounds/weapons/gunshot/gunshot2.ogg'
	damage = DAM_BULLET_7MMR
	armor_penetration = 35
	penetration_modifier = 1

/obj/item/projectile/bullet/rifle/t12
	fire_sound = SFX_GUN_T12
	damage = DAM_BULLET_10X24 // If you buff the damage I will murder you, it is meant to have high AP low damage
	armor_penetration = 85

/obj/item/projectile/bullet/rifle/m16
	fire_sound = 'sounds/weapons/gunshot/m16.ogg'
	damage = DAM_BULLET_A556X45NPC

/obj/item/projectile/bullet/rifle/shell
	fire_sound = 'sounds/weapons/gunshot/sniper.ogg'
	damage = DAM_BULLET_15MMR
	stun = 3
	weaken = 3
	penetrating = 3
	armor_penetration = 70
	penetration_modifier = 1.2
	distance_falloff = 0.5

/obj/item/projectile/bullet/rifle/shell/apds
	damage = DAM_BULLET_15MMR_APDS
	penetrating = 5
	armor_penetration = 80
	penetration_modifier = 1.5

/* Practice */
