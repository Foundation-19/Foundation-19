/datum/spell/hand/slippery_surface
	name = "Slippery Surface"
	desc = "More of a practical joke than an actual spell."
	range = 5
	spell_flags = 0
	invocation_type = INVOKE_NONE
	show_message = " snaps their fingers."
	spell_delay = 50
	hud_state = "gen_ice"
	cast_sound = 'sounds/magic/summonitems_generic.ogg'

	spell_cost = 1
	mana_cost = 2
	mana_cost_per_cast = 5

/datum/spell/hand/slippery_surface/cast_hand(atom/a, mob/user)
	. = ..()
	if(!.)
		return

	for(var/turf/simulated/T in view(1,a))
		T.wet_floor(50)
		new /obj/effect/temp_visual/temporary(T,3, 'icons/effects/effects.dmi', "sonar_ping")
