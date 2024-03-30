/datum/spell/invisibility
	name = "invisibility"
	desc = "A simple spell of invisibility, for when you really just can't afford a paper bag."

	charge_max = 30 SECONDS
	cooldown_reduc = 8 SECONDS

	spell_flags = 0
	invocation = "Ror Rim Or!"
	invocation_type = INVOKE_SHOUT
	level_max = list(UPGRADE_TOTAL = 4, UPGRADE_SPEED = 2, UPGRADE_POWER = 4)

	hud_state = "invisibility"
	duration = 20 SECONDS

	spell_cost = 1
	mana_cost = 5

	var/on = FALSE

/datum/spell/invisibility/choose_targets(mob/user = usr)
	if(istype(holder, /mob/living/carbon/human))
		perform(user, holder)

/datum/spell/invisibility/cast(mob/living/carbon/human/H, mob/user)
	on = !on
	if(on)
		if(H.add_cloaking_source(src))
			playsound(get_turf(H), 'sounds/effects/teleport.ogg', 90, 1)
			H.mutations |= MUTATION_CLUMSY
			charge_counter = charge_max
			addtimer(CALLBACK(src, PROC_REF(ToggleOffTimed), H), duration * 0.9)
		return
	ToggleOff(H)

/datum/spell/invisibility/proc/ToggleOffTimed(mob/living/carbon/human/H)
	if(!on)
		return
	to_chat(H, SPAN_DANGER("You are about to turn visible again!"))
	addtimer(CALLBACK(src, PROC_REF(ToggleOff), H), duration * 0.1)

/datum/spell/invisibility/proc/ToggleOff(mob/living/carbon/human/H)
	if(H.remove_cloaking_source(src))
		playsound(get_turf(H), 'sounds/effects/stealthoff.ogg', 90, 1)
		H.mutations -= MUTATION_CLUMSY
		on = FALSE
		charge_counter = 0
		process()

/datum/spell/invisibility/ImproveSpellPower()
	if(!..())
		return FALSE

	duration += 10 SECONDS

	return "The [src] spell now lasts for a maximum of [round(duration / 10)] seconds."
