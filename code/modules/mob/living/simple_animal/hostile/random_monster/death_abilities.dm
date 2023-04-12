/* Abilities that are automatically performed on death of the mob */

/datum/random_ability/death
	name = "death ability"
	/// Will ability trigger if gibbed?
	var/can_use_on_gibs = FALSE

/datum/random_ability/death/explosion/CanUse(mob/living/user, gibbed)
	. = ..()
	if(!.)
		return FALSE
	if(can_use_on_gibs)
		return TRUE
	return !gibbed

/datum/random_ability/death/explosion
	name = "death explosion"
	added_name = "volatile alien"
	health_mod = -20 // Kamikaze!
	overlay_type = "explosive"
	/// Delay before the explosion
	var/explosion_delay = 15
	/// What sound is played on death, before explosion
	var/explosion_warning_sound = 'sound/effects/bubbles.ogg'
	var/explosion_devastation_range = -1
	var/explosion_heavy_range = 1
	var/explosion_light_range = 2
	var/explosion_flash_range = 0

/datum/random_ability/death/explosion/New()
	..()
	explosion_delay = rand(10, 30)
	if(prob(5)) // RARE
		explosion_delay += rand(5, 25)
	explosion_devastation_range = round(explosion_delay / 22)
	explosion_heavy_range = round(explosion_delay / 14)
	explosion_light_range = round(explosion_delay / 8)
	explosion_flash_range = rand(-1, explosion_light_range)
	health_mod *= 1 + (explosion_delay*0.1) // Bigger explosion makes you easier to kill

/datum/random_ability/death/explosion/perform(mob/living/user, atom/target)
	..()
	user.visible_message(SPAN_DANGER("\The [user] shivers violently, it's about to explode!"))
	var/turf/T = get_turf(user)
	playsound(T, explosion_warning_sound, (50 + explosion_delay), 1)
	var/obj/effect/temp_visual/decoy/D = new /obj/effect/temp_visual/decoy(user.loc, user.dir, user, explosion_delay + 2)
	animate(D, alpha = 0, color = "#ff0000", transform = matrix()*1.8, time = explosion_delay)
	addtimer(CALLBACK(src, .proc/do_explode, user, T), explosion_delay)

/datum/random_ability/death/explosion/proc/do_explode(mob/living/user, turf/T)
	if(!user || !T)
		return
	explosion(T, explosion_devastation_range, explosion_heavy_range, explosion_light_range, explosion_flash_range, 0)
	user.gib()

/datum/random_ability/death/mitosis
	name = "mitosis"
	added_name = "double alien" // Idk
	speed_mod = 1 // Slow
	overlay_type = "mitosis"
	/// How many mobs it will spawn
	var/mitosis_amount = 2
	/// What type of mob it spawns
	var/mob/living/mitosis_type = /mob/living/simple_animal/hostile/random_monster
	/// What sound plays on death
	var/mitosis_sound = 'sound/effects/attackblob.ogg'
	/// Minimal maxHealth requirement for mitosis to work
	var/mitosis_required_health = 25

/datum/random_ability/death/mitosis/New()
	..()
	if(prob(20))
		mitosis_amount = 3
	mitosis_required_health = pick(12,25,50)

/datum/random_ability/death/mitosis/perform(mob/living/user, atom/target)
	..()
	user.visible_message(SPAN_DANGER("\The [user] splits!"))
	var/turf/T = get_turf(user)
	var/turf/target_turf
	playsound(T, mitosis_sound, 100, 1)
	if(user.maxHealth > mitosis_required_health) // Fun ride is over
		for(var/i=1 to mitosis_amount)
			var/mob/living/mitosee = new mitosis_type(T)
			mitosee.maxHealth = user.maxHealth / 2 // To prevent infinite ride
			mitosee.transform = user.transform * 0.8
			target_turf = CircularRandomTurfAround(T, RAND_F(1, 2))
			mitosee.throw_at(target_turf, 2, 3)
	user.gib()

// This subtype will spawn mitosis monsters on death
/datum/random_ability/death/mitosis/repeat
	mitosis_type = /mob/living/simple_animal/hostile/random_monster/mitosis/repeat
