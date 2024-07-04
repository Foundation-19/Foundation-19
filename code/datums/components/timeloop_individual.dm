/**
 * A component to reset the parent to its previous state after some time passes
 */
/datum/component/timeloop_individual

	///message sent when timeloop_individual rewinds
	var/rewind_message = "You remember a time not so long ago..."
	///message sent when timeloop_individual is out of rewinds
	var/no_rewinds_message = "But the memory falls out of your reach."

	/// An effect created where the parent was on when this components was applied, they get moved back here after the duration
	var/obj/effect/time_loop/spawned_effect
	/// Determined by the type of the parent so different behaviours can happen per type
	var/rewind_type
	/// How many rewinds will happen before the effect ends
	var/rewinds_remaining
	/// How long to wait between each rewind
	var/rewind_interval

	/// The starting value of brute loss at the beginning of the effect
	var/brute_loss = 0
	/// The starting value of fire loss at the beginning of the effect
	var/fire_loss = 0
	/// The starting value of toxin loss at the beginning of the effect
	var/tox_loss = 0
	/// The starting value of oxygen loss at the beginning of the effect
	var/oxy_loss = 0
	/// The starting value of brain loss at the beginning of the effect
	var/brain_loss = 0
	/// The starting value of clone loss at the beginning of the effect
	var/clone_loss = 0
	/// The starting value of stamina at the beginning of the effect
	var/stamina = 0
	/// The starting value of health at the beginning of the effect
	/// This only applies to objects
	var/obj_health

/datum/component/timeloop_individual/Initialize(rewinds = 1, interval = 10 SECONDS)
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE

	var/atom/A = parent

	spawned_effect = new(get_turf(parent), A.dir, parent)
	rewinds_remaining = rewinds
	rewind_interval = interval

	if(isliving(parent))
		var/mob/living/L = parent
		brute_loss = L.getBruteLoss()
		fire_loss = L.getFireLoss()
		tox_loss = L.getToxLoss()
		oxy_loss = L.getOxyLoss()
		brain_loss = L.getBrainLoss()
		clone_loss = L.getCloneLoss()
		stamina = L.get_stamina()

		rewind_type = PROC_REF(rewind_living)

	else if(isobj(parent))
		var/obj/O = parent
		obj_health = O.get_current_health()
		rewind_type = PROC_REF(rewind_obj)

	addtimer(CALLBACK(src, rewind_type), rewind_interval)

/datum/component/timeloop_individual/Destroy()
	QDEL_NULL(spawned_effect)
	return ..()

/datum/component/timeloop_individual/proc/rewind()
	to_chat(parent, SPAN_NOTICE(rewind_message))

	var/atom/movable/master = parent

	// we play a sound both at the ORIGIN and at the DESTINATION
	playsound(get_turf(master), 'sounds/effects/phasein.ogg', 50)

	if(spawned_effect)
		master.forceMove(get_turf(spawned_effect))
		playsound(master, 'sounds/effects/phasein.ogg', 50)

	rewinds_remaining --
	if(rewinds_remaining)
		addtimer(CALLBACK(src, rewind_type), rewind_interval)
	else
		to_chat(parent, SPAN_NOTICE(no_rewinds_message))
		qdel(src)

/datum/component/timeloop_individual/proc/rewind_living()
	var/mob/living/master = parent
	master.setBruteLoss(brute_loss)
	master.setFireLoss(fire_loss)
	master.setToxLoss(tox_loss)
	master.setOxyLoss(oxy_loss)
	master.setBrainLoss(brain_loss)
	master.setCloneLoss(clone_loss)
	master.set_stamina(stamina)
	rewind()

/datum/component/timeloop_individual/proc/rewind_obj()
	var/obj/master = parent
	master.set_health(obj_health)
	rewind()
