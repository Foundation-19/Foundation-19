/mob/living/Life()
	set invisibility = 0
	set background = BACKGROUND_ENABLED

	..()

	if (HasMovementHandler(/datum/movement_handler/mob/transformation/))
		return
	if (!loc)
		return

	if(machine && !CanMouseDrop(machine, src))
		machine = null

	//Handle temperature/pressure differences between body and environment
	var/datum/gas_mixture/environment = loc.return_air()
	if(environment)
		handle_environment(environment)

	// human/handle_regular_status_updates() needs a cleanup, as blindness should be handled in handle_disabilities()
	handle_regular_status_updates() // Status & health update, are we dead or alive etc.

	if(stat != DEAD)
		aura_check(AURA_TYPE_LIFE)

		if(!InStasis())
			//Mutations and radiation
			handle_mutations_and_radiation()

	if(!InStasis())
		handle_diseases()

	//Check if we're on fire
	handle_fire()

	update_pulling()

	for(var/obj/item/grab/G in src)
		G.Process()

	handle_actions()

	UpdateLyingBuckledAndVerbStatus()

	handle_regular_hud_updates()

	return 1

/mob/living/proc/handle_breathing()
	return

/mob/living/proc/handle_mutations_and_radiation()
	return

/mob/living/proc/handle_chemicals_in_body()
	return

/mob/living/proc/handle_random_events()
	return

/mob/living/proc/handle_environment(datum/gas_mixture/environment)
	return

/mob/living/proc/handle_diseases()
	return

/mob/living/proc/update_pulling()
	if(pulling)
		if(incapacitated())
			stop_pulling()

//This updates the health and status of the mob (conscious, unconscious, dead)
/mob/living/proc/handle_regular_status_updates()
	updatehealth()
	if(stat != DEAD)
		if(paralysis)
			set_stat(UNCONSCIOUS)
		else if (status_flags & FAKEDEATH)
			set_stat(UNCONSCIOUS)
		else
			set_stat(CONSCIOUS)
		return 1

/mob/living/proc/handle_statuses()
	handle_stunned()
	handle_weakened()
	handle_paralysed()

/mob/living/proc/handle_stunned()
	if(stunned)
		AdjustStunned(-1)
		if(!stunned)
			update_icons()
	return stunned

/mob/living/proc/handle_weakened()
	if(weakened)
		weakened = max(weakened-1,0)
		if(!weakened)
			update_icons()
	return weakened

/mob/living/proc/handle_paralysed()
	if(paralysis)
		AdjustParalysis(-1)
		if(!paralysis)
			update_icons()
	return paralysis

/mob/living/proc/handle_disabilities()
	handle_impaired_vision()
	handle_impaired_hearing()

/mob/living/proc/handle_impaired_vision()
	return

/mob/living/proc/handle_impaired_hearing()
	//Ears
	if(sdisabilities & DEAFENED)	//disabled-deaf, doesn't get better on its own
		setEarDamage(null, max(ear_deaf, 1))
	else if(ear_damage < 25)
		adjustEarDamage(-0.05, -1)	// having ear damage impairs the recovery of ear_deaf
	else if(ear_damage < 100)
		adjustEarDamage(-0.05, 0)	// deafness recovers slowly over time, unless ear_damage is over 100. TODO meds that heal ear_damage


//this handles hud updates. Calls update_vision() and handle_hud_icons()
/mob/living/proc/handle_regular_hud_updates()
	if(!client)	return 0

	handle_hud_icons()
	handle_vision()

	return 1

/mob/living/proc/handle_vision()
	update_sight()

	if(stat == DEAD)
		return

	set_fullscreen(stat == UNCONSCIOUS, "blackout", /atom/movable/screen/fullscreen/blackout)

	if(machine)
		var/viewflags = machine.check_eye(src)
		if(viewflags < 0)
			reset_view(null, 0)
		else if(viewflags)
			set_sight(viewflags)
	else if(eyeobj)
		if(eyeobj.owner != src)
			reset_view(null)
	else if(!client.adminobs)
		reset_view(null)

/mob/living/proc/update_sight()
	set_sight(0)
	set_see_in_dark(0)
	if(stat == DEAD || eyeobj)
		update_dead_sight()
	else
		update_living_sight()

	if(eyeobj)
		var/list/vision = eyeobj.get_accumulated_vision_handlers()
		set_sight(eyeobj.sight | vision[1])
		set_see_invisible(max(vision[2], eyeobj.see_invisible))
	else
		var/list/vision = get_accumulated_vision_handlers()
		set_sight(sight | vision[1])
		if(vision[2])
			set_see_invisible(vision[2])
		else
			set_see_invisible(see_invisible)

/mob/living/proc/update_living_sight()
	var/set_sight_flags = sight & ~(SEE_TURFS|SEE_MOBS|SEE_OBJS)
	if(stat & UNCONSCIOUS)
		set_sight_flags |= BLIND
	else
		set_sight_flags &= ~BLIND

	set_sight(set_sight_flags)
	set_see_in_dark(initial(see_in_dark))
	set_see_invisible(initial(see_invisible))

/mob/living/proc/update_dead_sight()
	set_sight(sight|SEE_TURFS|SEE_MOBS|SEE_OBJS)
	set_see_in_dark(8)
	set_see_invisible(SEE_INVISIBLE_LEVEL_TWO)

/mob/living/proc/handle_hud_icons()
	handle_hud_icons_health()
	handle_hud_glasses()

/mob/living/proc/handle_hud_icons_health()
	return
