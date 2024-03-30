//handles anything that has memetic properties and needs to keep track of affected humans. Memetics are designed to work only on humans.
/datum/component/memetic
	///List of affected humans
	var/list/weakref/affected_mobs_weakref = list()
	///Memetic bitflags to determine what should be counted as affected
	var/memetic_flags
	///Proc to run on affected humans
	var/affected_proc
	///List of sounds that count as being memetic
	var/list/memetic_sounds

/datum/component/memetic/Initialize(flags, meme_proc, memeticSounds)
	. = ..()
	memetic_flags = flags
	affected_proc = meme_proc
	memetic_sounds = memeticSounds

/datum/component/memetic/Destroy(force, silent)
	. = ..()
	LAZYCLEARLIST(affected_mobs_weakref)

/datum/component/memetic/RegisterWithParent()
	RegisterSignal(parent, list(COMSIG_OBJECT_SOUND_HEARD, COMSIG_OBJECT_SOUND_HEARD_LOOPING), PROC_REF(heard_memetic))
	RegisterSignal(parent, COMSIG_ATOM_EXAMINED, PROC_REF(examined_memetic))
	RegisterSignal(parent, COMSIG_PHOTO_SHOWN_OF, PROC_REF(saw_memetic_photo))
	RegisterSignal(parent, COMSIG_ATOM_VIEW_RESET, PROC_REF(saw_through_camera))

/datum/component/memetic/UnregisterFromParent()
	UnregisterSignal(parent, list(
		COMSIG_OBJECT_SOUND_HEARD,
		COMSIG_ATOM_EXAMINED,
		COMSIG_PHOTO_SHOWN_OF,
		COMSIG_ATOM_VIEW_RESET,
		COMSIG_OBJECT_SOUND_HEARD_LOOPING
	))

/datum/component/memetic/proc/check_viewers() //I dont like doing this but since theres no way for us to send a signal upon something being viewed its neccesary
	var/list/mviewers = viewers(world.view, parent)

	for(var/mob/living/carbon/human/H in mviewers)
		saw_memetic(H)

/datum/component/memetic/proc/activate_memetic_effects()
	var/list/affected_mobs = resolveWeakrefList(affected_mobs_weakref)
	if(!(memetic_flags & MPERSISTENT)) //if we arent a persistent memetic, then affected humans will be removed from effect after they no longer meet the reqs
		for(var/mob/living/carbon/human/H in affected_mobs)
			if((memetic_flags & MVISUAL) && H.can_see(parent, TRUE))
				continue
			if((memetic_flags & MAUDIBLE) && H.can_hear(parent))
				continue
			affected_mobs_weakref -= weakref(H)

	for(var/mob/living/carbon/human/H in affected_mobs)
		if(H.stat == DEAD)
			affected_mobs_weakref -= weakref(H)
			continue
		call(parent, affected_proc)(H)

/datum/component/memetic/proc/saw_memetic(datum/source)
	var/list/mob/affected_mobs = resolveWeakrefList(affected_mobs_weakref)
	if((!ishuman(source)) || (source in affected_mobs))
		return
	var/mob/living/carbon/human/H = source
	if((memetic_flags & MVISUAL) && H.can_see(parent, TRUE))
		if(memetic_flags & MSYNCED)
			affected_mobs_weakref += weakref(H)
		else if(H.stat != DEAD)
			call(parent, affected_proc)(H)

/datum/component/memetic/proc/heard_memetic(datum/source, mob/hearer, sound)
	SIGNAL_HANDLER
	var/list/mob/affected_mobs = resolveWeakrefList(affected_mobs_weakref)
	if((!ishuman(hearer)) || (hearer in affected_mobs))
		return
	if(LAZYLEN(memetic_sounds) && !(sound in memetic_sounds))
		return
	var/mob/living/carbon/human/H = hearer
	if((memetic_flags & MAUDIBLE) && H.can_hear(parent))
		if(memetic_flags & MSYNCED)
			affected_mobs_weakref += weakref(H)
		else if(H.stat != DEAD)
			call(parent, affected_proc)(H)

/datum/component/memetic/proc/examined_memetic(datum/source, mob/examinee)
	SIGNAL_HANDLER
	var/list/mob/affected_mobs = resolveWeakrefList(affected_mobs_weakref)
	if((!ishuman(examinee)) || (examinee in affected_mobs))
		return
	var/mob/living/carbon/human/H = examinee
	if((memetic_flags & MINSPECT) && H.can_see(visual_memetic = TRUE)) //examine function already checks memetics system but we need to check for protection
		if(memetic_flags & MSYNCED)
			affected_mobs_weakref += weakref(H)
		else if(H.stat != DEAD)
			call(parent, affected_proc)(H)

/datum/component/memetic/proc/saw_memetic_photo(datum/source, obj/item/photo/photo_shown, mob/target)
	SIGNAL_HANDLER
	var/list/mob/affected_mobs = resolveWeakrefList(affected_mobs_weakref)
	if((!ishuman(target)) || (target in affected_mobs))
		return
	var/mob/living/carbon/human/H = target
	if(!H.can_see(visual_memetic = TRUE))
		return
	if(memetic_flags & MPHOTO)
		if(memetic_flags & MSYNCED)
			affected_mobs_weakref += weakref(H)
		else if(H.stat != DEAD)
			call(parent, affected_proc)(H)

/datum/component/memetic/proc/saw_through_camera(datum/source, mob/target, obj/machinery/camera/C)
	SIGNAL_HANDLER
	var/list/mob/affected_mobs = resolveWeakrefList(affected_mobs_weakref)
	if(!istype(C))
		return
	if((!ishuman(target)) || (target in affected_mobs))
		return
	var/mob/living/carbon/human/H = target
	if(!H.can_see(visual_memetic = TRUE))
		return
	if(memetic_flags & MCAMERA)
		if(memetic_flags & MSYNCED)
			affected_mobs_weakref += weakref(H)
		else if(H.stat != DEAD)
			call(parent, affected_proc)(H)
