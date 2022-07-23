/datum
	var/tmp/gc_destroyed //Time when this object was destroyed.
	var/tmp/is_processing = FALSE
	/// Active timers with this datum as the target
	var/list/active_timers
	/// Components attached to this datum
	var/list/datum_components
	/// Status traits attached to this datum
	var/list/comp_lookup
	/// List of callbacks for signal procs
	var/list/list/datum/callback/signal_procs
	/// Datum level flags
	var/datum_flags = NONE

#ifdef TESTING
	var/tmp/running_find_references
	var/tmp/last_find_references = 0
#endif

// The following vars cannot be edited by anyone
/datum/VV_static()
	return UNLINT(..()) + list("gc_destroyed", "is_processing")

// Default implementation of clean-up code.
// This should be overridden to remove all references pointing to the object being destroyed.
// Return the appropriate QDEL_HINT; in most cases this is QDEL_HINT_QUEUE.
/datum/proc/Destroy(force=FALSE)
	SHOULD_CALL_PARENT(TRUE)
	SHOULD_NOT_SLEEP(TRUE)
	tag = null
	weakref = null // Clear this reference to ensure it's kept for as brief duration as possible.

	SSnano && SSnano.close_uis(src)

	var/list/timers = active_timers
	active_timers = null
	for(var/thing in timers)
		var/datum/timedevent/timer = thing
		if (timer.spent)
			continue
		qdel(timer)

	if(extensions)
		for(var/expansion_key in extensions)
			var/list/extension = extensions[expansion_key]
			if(islist(extension))
				extension.Cut()
			else
				qdel(extension)
		extensions = null

	GLOB.destroyed_event && GLOB.destroyed_event.raise_event(src)

	if (!isturf(src))	// Not great, but the 'correct' way to do it would add overhead for little benefit.
		cleanup_events(src)

	//BEGIN: ECS SHIT
	///Only override this if you know what you're doing. You do not know what you're doing
	///This is a threat
	var/list/dc = datum_components
	if(dc)
		var/all_components = dc[/datum/component]
		if(length(all_components))
			for(var/I in all_components)
				var/datum/component/C = I
				qdel(C, FALSE, TRUE)
		else
			var/datum/component/C = all_components
			qdel(C, FALSE, TRUE)
		dc.Cut()

	var/list/lookup = comp_lookup
	if(lookup)
		for(var/sig in lookup)
			var/list/comps = lookup[sig]
			if(length(comps))
				for(var/i in comps)
					var/datum/component/comp = i
					comp.UnregisterSignal(src, sig)
			else
				var/datum/component/comp = comps
				comp.UnregisterSignal(src, sig)
		comp_lookup = lookup = null

	for(var/target in signal_procs)
		UnregisterSignal(target, signal_procs[target])
	//END: ECS SHIT

	return QDEL_HINT_QUEUE

/datum/proc/Process()
	set waitfor = 0
	return PROCESS_KILL
