//handles anything that has memetic properties and needs to keep track of affected humans. Memetics are designed to work only on humans.
/datum/component/memetic
	///List of affected humans
	var/list/weakref/affected_mobs = list()
	///Memetic bitflags to determine what should be counted as affected
	var/memetic_flags
	///Proc to run on affected humans
	var/affected_proc

/datum/component/memetic/Initialize(flags, meme_proc)
	.=..()
	memetic_flags = flags
	affected_proc = meme_proc

/datum/component/memetic/Destroy(force, silent)
	. = ..()
	LAZYCLEARLIST(affected_mobs)

/datum/component/memetic/RegisterWithParent()
	RegisterSignal(parent, COMSIG_OBJECT_SOUND_HEARD, .proc/heard_memetic)
	RegisterSignal(parent, COMSIG_ATOM_EXAMINED, .proc/examined_memetic)
	RegisterSignal(parent, COMSIG_PHOTO_SHOWN_OF, .proc/saw_memetic_photo)

/datum/component/memetic/UnregisterFromParent()
	UnregisterSignal(parent, list(
		COMSIG_OBJECT_SOUND_HEARD,
		COMSIG_ATOM_EXAMINED,
		COMSIG_PHOTO_SHOWN_OF
	))

/datum/component/memetic/proc/check_viewers() //I dont like doing this but since theres no way for us to send a signal upon something being viewed its neccesary
	var/list/mviewers = viewers(world.view, parent)

	for(var/mob/living/carbon/human/H in mviewers)
		saw_memetic(H)

/datum/component/memetic/proc/activate_memetic_effects()
	if(!(memetic_flags & MPERSISTENT)) //if we arent a persistent memetic, then affected humans will be removed from effect after they no longer meet the reqs

		for(var/mob/living/carbon/human/H in affected_mobs)
			if((memetic_flags & MVISUAL) && H.can_see(parent, TRUE))
				continue
			if((memetic_flags & MAUDIBLE) && H.can_hear(parent))
				continue
			affected_mobs -= H

	for(var/mob/living/carbon/human/H in affected_mobs)
		if(H.stat == DEAD)
			affected_mobs -= H
			continue
		call(parent, affected_proc)(H)

/datum/component/memetic/proc/saw_memetic(datum/source)
	if((!ishuman(source)) || (source in affected_mobs))
		return
	var/mob/living/carbon/human/H = source
	if((memetic_flags & MVISUAL) && H.can_see(parent, TRUE))
		affected_mobs += H

/datum/component/memetic/proc/heard_memetic(datum/source, mob/hearer)
	SIGNAL_HANDLER
	if((!ishuman(hearer)) || (hearer in affected_mobs))
		return
	var/mob/living/carbon/human/H = hearer
	if((memetic_flags & MAUDIBLE) && H.can_hear(parent))
		affected_mobs += H

/datum/component/memetic/proc/examined_memetic(datum/source, mob/examinee)
	SIGNAL_HANDLER
	if((!ishuman(examinee)) || (examinee in affected_mobs))
		return
	var/mob/living/carbon/human/H = examinee
	if((memetic_flags & MINSPECT) && H.can_see(visual_memetic = TRUE)) //examine function already checks memetics system but we need to check for protection
		affected_mobs += examinee

/datum/component/memetic/proc/saw_memetic_photo(datum/source, obj/item/photo/photo_shown, mob/target)
	SIGNAL_HANDLER
	if((!ishuman(target)) || (target in affected_mobs))
		return
	var/mob/living/carbon/human/H = target
	if(!H.can_see(visual_memetic = TRUE))
		return
	if(memetic_flags & MSELF_PERPETRAITING)
		affected_mobs += target
