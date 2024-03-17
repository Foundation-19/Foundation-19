/obj/effect/magic_orb
	name = "orb of wonders"
	desc = "A radiating magic orb. What potential does it hold?"
	icon = 'icons/effects/magic_orb.dmi'
	icon_state = "orb"
	anchored = TRUE
	//particles = new /particles/magic_orb
	var/datum/sound_token/sound_token
	var/sound_id
	var/ambient_sound = 'sounds/magic/orb_ambience.ogg'

/obj/effect/magic_orb/Initialize()
	. = ..()
	if(!ambient_sound)
		return
	sound_id = "[type]_[sequential_id(/obj/effect/magic_orb)]"
	sound_token = GLOB.sound_player.PlayLoopingSound(src, sound_id, ambient_sound, 50, 14, 4)

/obj/effect/magic_orb/Destroy()
	QDEL_NULL(sound_token)
	sound_token = null
	return ..()

/obj/effect/magic_orb/attack_hand(mob/living/user)
	if(QDELETED(src)) // Should not be possible, but imagine
		return
	if(!CanUseOrb(user))
		return
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_ORB_PICKUP, src, user)
	playsound(src, 'sounds/magic/orb_pickup.ogg', 100, FALSE, 10, 3)
	var/obj/effect/temp_visual/decoy/D = new /obj/effect/temp_visual/decoy(loc, dir, src, 10)
	animate(D, alpha = 0, color = "#aaaaff", transform = matrix()*1.5, time = 10)
	OrbEffect(user)
	qdel(src)
	return

/obj/effect/magic_orb/proc/CanUseOrb(mob/living/user)
	return TRUE

/obj/effect/magic_orb/proc/OrbEffect(mob/living/user)
	return

/obj/effect/magic_orb/attackby(obj/item/thing, mob/user)
	return

// Grants the user some spell points
/obj/effect/magic_orb/spell_points
	name = "orb of knowledge"
	/// Amount of spell points granted to the user
	var/spell_points = 10

/obj/effect/magic_orb/spell_points/CanUseOrb(mob/living/user)
	if(!user.mind)
		return FALSE
	if(!user.mind.mana)
		return FALSE
	return ..()

/obj/effect/magic_orb/spell_points/OrbEffect(mob/living/user)
	user.mind.mana.spell_points += spell_points
	show_blurb(user.client, (5 SECONDS), "The knowledge sinks into your mind...", 10, typeout = FALSE)
	flash_color(user, COLOR_DIAMOND, 10)
	return

// Grants the user additional mana level and regeneration
/obj/effect/magic_orb/mana
	name = "orb of power"
	/// Amount of max mana level that is added
	var/mana_level = 20
	/// How much mana regeneration is added
	var/mana_regeneration = 0.5

/obj/effect/magic_orb/mana/CanUseOrb(mob/living/user)
	if(!user.mind)
		return FALSE
	if(!user.mind.mana)
		return FALSE
	return ..()

/obj/effect/magic_orb/mana/OrbEffect(mob/living/user)
	user.mind.mana.mana_level_max += mana_level
	user.mind.mana.mana_level = user.mind.mana.mana_level_max
	user.mind.mana.mana_recharge_speed += mana_regeneration
	show_blurb(user.client, (5 SECONDS), "The power invigorates your mind...", 10, typeout = FALSE)
	flash_color(user, COLOR_DIAMOND, 10)
	return
