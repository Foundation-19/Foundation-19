/// Queues and manages JPS pathfinding steps
SUBSYSTEM_DEF(pathfinder)
	name = "Pathfinder"
	init_order = SS_INIT_PATHFINDER
	priority = SS_PRIORITY_PATHFINDER
	wait = 0.5
	/// List of pathfind datums we are currently trying to process
	var/list/datum/pathfind/active_pathing = list()
	/// List of pathfind datums being ACTIVELY processed. exists to make subsystem stats readable
	var/list/datum/pathfind/currentrun = list()
	var/static/space_type_cache

	/// List of turfs modified for the purpose of debug
	var/list/debugged_turfs = list()
	/// Overlay we use for debug path
	var/image/path_overlay

/datum/controller/subsystem/pathfinder/Initialize()
	space_type_cache = typecacheof(/turf/space)
	path_overlay = new('icons/misc/debug_group.dmi', "cyan")
	. = ..()

/datum/controller/subsystem/pathfinder/stat_entry(msg)
	msg = "P:[length(active_pathing)]"
	return ..()

// This is another one of those subsystems (hey lighting) in which one "Run" means fully processing a queue
// We'll use a copy for this just to be nice to people reading the mc panel
/datum/controller/subsystem/pathfinder/fire(resumed)
	if(!resumed)
		src.currentrun = active_pathing.Copy()

	// Dies of sonic speed from caching datum var reads
	var/list/currentrun = src.currentrun
	while(length(currentrun))
		var/datum/pathfind/path = currentrun[length(currentrun)]
		if(!path.search_step()) // Something's wrong
			path.early_exit()
			currentrun.len--
			continue
		if(MC_TICK_CHECK)
			return
		path.finished()
		// Next please
		currentrun.len--

/// Initiates a pathfind. Returns true if we're good, FALSE if something's failed
/datum/controller/subsystem/pathfinder/proc/pathfind(atom/movable/caller, atom/end, max_distance = 30, min_target_dist, id=null, simulated_only = TRUE, turf/exclude, skip_first=TRUE, diagonal_safety=TRUE, datum/callback/on_finish)
	var/datum/pathfind/path = new(caller, end, id, max_distance, min_target_dist, simulated_only, exclude, skip_first, diagonal_safety, on_finish)
	if(path.start())
		active_pathing += path
		return TRUE
	return FALSE

//This is a debug tool which can help you ensure that pathfinding is working correctly. To use, simply mark a turf you want to pathfind to, spawn the pathfinder at the start, and simply click on the pathfinder.

/client/proc/pathfind()
	set name = "Pathfind Debug"
	set category = "Debug"
	set desc = "Pathfind to a marked datum with visual debug."

	if (!check_rights(R_DEBUG, C = usr?.client))
		return

	var/current = holder.marked_datum()
	if(!current)
		to_chat(usr, SPAN_WARNING("You have no marked datum to pathfind to!"))
		return
	if(!isturf(current))
		to_chat(usr, SPAN_WARNING("Your marked datum is not a turf!"))
		return

	var/path = list()

	if(LAZYLEN(SSpathfinder.debugged_turfs))
		for(var/turf/T in SSpathfinder.debugged_turfs)
			T.cut_overlay(SSpathfinder.path_overlay)
		LAZYCLEARLIST(SSpathfinder.debugged_turfs)
	LAZYINITLIST(SSpathfinder.debugged_turfs)
	path = get_path_to(usr, current, 120)
	if(LAZYLEN(path))
		for(var/turf/T in path)
			LAZYADD(SSpathfinder.debugged_turfs, T)
			T.add_overlay(SSpathfinder.path_overlay)
	else
		to_chat(usr, SPAN_NOTICE("No path found!"))
		return

	to_chat(usr, SPAN_NOTICE("+----PATH----+"))
	var/index = 0
	for(var/item in path)
		to_chat(usr, SPAN_NOTICE("| [index] - [item ? item : "null"]"))
		index++
	to_chat(usr, SPAN_NOTICE("+--PATH-END--+"))
