/datum/spell/invisibility
	name = "invisibility"
	desc = "A simple spell of invisibility, for when you really just can't afford a paper bag."
	feedback = "IV"
	spell_flags = 0
	charge_max = 100
	invocation = "Ror Rim Or!"
	invocation_type = INVOKE_SHOUT
	var/on = 0
	hud_state = "invisibility"

/datum/spell/invisibility/choose_targets(mob/user = usr)
	if(istype(holder, /mob/living/carbon/human))
		perform(user, holder)

/datum/spell/invisibility/cast(mob/living/carbon/human/H, mob/user)
	on = !on
	if(on)
		if(H.add_cloaking_source(src))
			playsound(get_turf(H), 'sound/effects/teleport.ogg', 90, 1)
			H.mutations |= MUTATION_CLUMSY
	else if(H.remove_cloaking_source(src))
		playsound(get_turf(H), 'sound/effects/stealthoff.ogg', 90, 1)
		H.mutations -= MUTATION_CLUMSY
