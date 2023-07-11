// These objects are from Tegu Station's away site Ascent Caulship.

/obj/item/ascent_egg
	name = "crystalline egg"
	desc = "A lumpy, gooey egg with a thin crystalline exterior."
	icon = 'icons/obj/ascent.dmi'
	icon_state = "egg_single"

/obj/item/ascent_egg/anchored
	icon_state = "egg0"
	anchored = TRUE

/obj/item/ascent_egg/immovable/Initialize()
	. = ..()
	icon_state = pick("egg0", "egg1", "egg2")

/obj/item/ascent_egg/empty
	name = "crystalline eggshell"
	desc = "A lumpy, gooey egg with a thin crystalline exterior. This one is broken and empty."
	icon_state = "egg_broken"
	anchored = TRUE

/mob/living/simple_animal/hostile/retaliate/alate_nymph
	name = "alate nymph"
	desc = "A small, skittering, juvenile kharmaan alate, likely fresh from the egg."
	icon = 'icons/mob/simple_animal/ascent.dmi'
	icon_state = "larva"
	icon_living = "larva"
	icon_dead = "larva_dead"
	holder_type = /obj/item/holder
	destroy_surroundings = FALSE
	health = 50
	maxHealth = 50
	movement_cooldown = 2
	density = FALSE
	min_gas = list(GAS_METHYL_BROMIDE = 5)
	mob_size = MOB_MINISCULE
	can_escape = TRUE
	pass_flags = PASS_FLAG_TABLE
	natural_weapon = /obj/item/natural_weapon/bite
	faction = "kharmaani"
	ai_holder_type = /datum/ai_holder/simple_animal/retaliate/alate_nymph
	var/global/list/friendly_species = list(SPECIES_MANTID_ALATE, SPECIES_MANTID_GYNE, SPECIES_MONARCH_QUEEN, SPECIES_MONARCH_WORKER)
	/// If TRUE - any ghost can click on it to play as it
	var/possessable = FALSE

/datum/ai_holder/simple_animal/retaliate/alate_nymph/list_targets()
	. = list()
	var/mob/living/simple_animal/hostile/retaliate/alate_nymph/A = holder
	for(var/mob/living/M in hearers(src, vision_range))
		if(M.faction == A.faction)
			continue
		if(istype(M,/mob/living/carbon/human))
			var/mob/living/carbon/human/H = M
			if(H.species.get_bodytype() in A.friendly_species)
				continue
		. += M

/mob/living/simple_animal/hostile/retaliate/alate_nymph/Initialize()
	. = ..()
	add_language(LANGUAGE_MANTID_NONVOCAL)
	add_language(LANGUAGE_MANTID_VOCAL)

/mob/living/simple_animal/hostile/retaliate/alate_nymph/attack_ghost(mob/observer/ghost/user)
	. = ..()
	if(ckey || !possessable)
		return
	if(alert(user, "Do you wish to play as [src]?",, "Yes", "No") != "Yes")
		return
	if(ckey) // Someone was faster
		to_chat(user, SPAN_WARNING("Someone is already in control of [src]!"))
		return
	if(!possessable) // Admin changed their mind, maybe?
		to_chat(user, SPAN_WARNING("Admins forbid anyone to play as [src] while you were thinking!"))
		return
	PossessByGhost(user)

/mob/living/simple_animal/hostile/retaliate/alate_nymph/get_scooped(mob/living/carbon/grabber)
	if(!(grabber.species.get_bodytype() in friendly_species))
		to_chat(grabber, SPAN_WARNING("\The [src] wriggles out of your hands before you can pick it up!"))
		return
	else
		return ..()

/mob/living/simple_animal/hostile/retaliate/alate_nymph/proc/PossessByGhost(mob/observer/ghost/user)
	ckey = user.ckey
	qdel(user)
