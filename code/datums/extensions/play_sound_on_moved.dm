/// This extension allows a movable atom to play a sound for each tile it is moved.
/datum/extension/play_sound_on_moved
	base_type = /datum/extension/play_sound_on_moved
	expected_type = /atom/movable
	flags = EXTENSION_FLAG_IMMEDIATE

	/// A reference to the atom affected by this extension.
	var/atom/movable/atom_holder
	/// If TRUE, the movement sound will always play. If FALSE, it will only play when dragged over hard surfaces (i.e. not space and carpets).
	var/always_play = FALSE
	/// A list of paths to sound files. When `atom_holder` is moved, one of these will play, picked at random.
	var/list/move_sounds = list(
		'sounds/effects/metalscrape1.ogg',
		'sounds/effects/metalscrape2.ogg',
		'sounds/effects/metalscrape3.ogg'
	)
	/// The volume of the sound to be played.
	var/move_volume = 75

/datum/extension/play_sound_on_moved/New(datum/holder, volume_override, sounds_override)
	..()
	atom_holder = holder
	if (volume_override)
		move_volume = volume_override
	if (sounds_override)
		move_sounds = sounds_override
	RegisterSignal(atom_holder, COMSIG_MOVED, PROC_REF(DoMoveSound))

/datum/extension/play_sound_on_moved/Destroy()
	UnregisterSignal(atom_holder, COMSIG_MOVED)
	..()

/// Plays a random sound from `move_sounds` at volume `move_volume`, centered at the turf of `atom_holder`.
/datum/extension/play_sound_on_moved/proc/DoMoveSound(atom/movable/inst, old_loc, new_loc)
	if(always_play || (has_gravity(inst) && !isspace(new_loc) && !istype(new_loc, /turf/simulated/floor/carpet)))
		playsound(inst, pick(move_sounds), move_volume, TRUE)
		show_sound_effect(inst.loc, inst)
