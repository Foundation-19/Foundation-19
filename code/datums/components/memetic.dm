//handles anything that has memetic properties and needs to keep track of affected humans. Memetics are designed to work only on humans.
/datum/component/memetic
	///List of affected humans
	var/list/mob/living/carbon/human/affected_mobs = list()
	///Memetic bitflags to determine what should be counted as affected
	var/memetic_flags
	///Proc to run on affected humans
	var/affected_proc
	///Parent/Memetic object
	var/atom/memetic_atom

/datum/component/memetic/Initialize(atom/parent_atom, flags, meme_proc)
	.=..()
	memetic_atom = parent_atom
	memetic_flags = flags
	affected_proc = meme_proc

/datum/component/memetic/Destroy(force, silent)
	. = ..()
	memetic_atom = null
	LAZYCLEARLIST(affected_mobs)

/datum/component/memetic/RegisterWithParent()
	RegisterSignal(parent, COMSIG_MEME_SAW, .proc/saw_memetic)
	RegisterSignal(parent, COMSIG_SOUND_PLAYED, .proc/heard_memetic)
	RegisterSignal(parent, COMSIG_MOB_EXAMINED, .proc/examined_memetic)
	RegisterSignal(parent, COMSIG_PHOTO_SHOWN, .proc/saw_memetic_photo)

/datum/component/memetic/UnregisterFromParent()
	UnregisterSignal(parent, list(
		COMSIG_MEME_SAW,
		COMSIG_SOUND_PLAYED,
		COMSIG_MOB_EXAMINED,
		COMSIG_PHOTO_SHOWN
	))

/datum/component/memetic/proc/check_viewers() //I dont like doing this but since theres no way for us to send a signal upon something being viewed its neccesary
	var/list/mviewers = viewers(world.view, memetic_atom)

	for(var/mob/living/carbon/human/H in mviewers)
		saw_memetic(H)

/datum/component/memetic/proc/activate_memetic_effects()
	if(!(memetic_flags & MPERSISTENT)) //if we arent a persistent memetic, then affected humans will be removed from effect after they no longer meet the reqs

		for(var/mob/living/carbon/human/H in affected_mobs)
			if((memetic_flags & MVISUAL) && H.can_see(memetic_atom, TRUE))
				continue
			if((memetic_flags & MAUDIBLE) && H.can_hear(memetic_atom))
				continue
			affected_mobs -= H

	for(var/mob/living/carbon/human/H in affected_mobs)
		if(H.stat == DEAD)
			affected_mobs -= H
			continue
		call(memetic_atom, affected_proc)(H)

/datum/component/memetic/proc/saw_memetic(datum/source)
	SIGNAL_HANDLER
	if((!ishuman(source)) || (source in affected_mobs))
		return
	var/mob/living/carbon/human/H = source
	if((memetic_flags & MVISUAL) && H.can_see(memetic_atom, TRUE))
		affected_mobs += H

/datum/component/memetic/proc/heard_memetic(datum/source, atom/sound_source)
	SIGNAL_HANDLER
	if((!ishuman(source)) || sound_source != memetic_atom || (source in affected_mobs))
		return
	var/mob/living/carbon/human/H = source
	if((memetic_flags & MAUDIBLE) && H.can_hear(memetic_atom))
		affected_mobs += H

/datum/component/memetic/proc/examined_memetic(datum/source, atom/target)
	SIGNAL_HANDLER
	if((!ishuman(source)) || target != memetic_atom || (source in affected_mobs))
		return
	var/mob/living/carbon/human/H = source
	if((memetic_flags & MINSPECT) && H.can_see(visual_memetic = TRUE)) //examine function already checks memetics system but we need to check for protection
		affected_mobs += source

/datum/component/memetic/proc/saw_memetic_photo(datum/source, obj/item/photo/photo_shown, mob/target)
	SIGNAL_HANDLER
	if((!ishuman(target)) || (target in affected_mobs))
		return
	if(!(memetic_atom in photo_shown.meta_data))
		return
	var/mob/living/carbon/human/H = target
	if(!H.can_see(visual_memetic = TRUE))
		return
	if(memetic_flags & MSELF_PERPETRAITING)
		affected_mobs += target
