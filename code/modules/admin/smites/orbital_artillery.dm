#define BSA_CHANCE_TO_BREAK_TILE_TO_PLATING 80
#define BSA_MAX_DAMAGE 99
#define BSA_PARALYZE_TIME (40 SECONDS)
#define BSA_STUTTER_TIME (40 SECONDS)

/// Fires orbital artillery at the target
/datum/smite/orbital_artillery
	name = "Orbital Artillery"

/datum/smite/orbital_artillery/effect(client/user, mob/living/target)
	. = ..()

	explosion(target.loc)

	var/turf/simulated/floor/target_turf = get_turf(target)
	if(istype(target_turf))
		if(prob(BSA_CHANCE_TO_BREAK_TILE_TO_PLATING))
			target_turf.break_tile_to_plating()
		else
			target_turf.break_tile()

	if(target.health <= 1)
		target.gib()
	else
		target.adjustBruteLoss(min(BSA_MAX_DAMAGE, (target.health - 1)))
		target.Stun(20)
		target.Weaken(20)
		target.adjust_stutter(BSA_STUTTER_TIME)

#undef BSA_CHANCE_TO_BREAK_TILE_TO_PLATING
#undef BSA_MAX_DAMAGE
#undef BSA_PARALYZE_TIME
#undef BSA_STUTTER_TIME
