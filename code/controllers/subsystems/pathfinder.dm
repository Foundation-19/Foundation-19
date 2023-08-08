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

/datum/controller/subsystem/pathfinder/Initialize()
	space_type_cache = typecacheof(/turf/space)
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

//This is a debug tool which can help you ensure that pathfiding is working correctly. To use, simply mark a turf you want to pathfind to, spawn the pathfinder at the start, and simply click on the pathfinder.

/obj/pathfinder
	name = "Pathfinder"
	desc = "This is for debugging pathfinding! If you dont understand what that means then you probably shouldent be touching this."
	icon = 'icons/obj/projector.dmi'
	icon_state = "projector1"

	var/list/path = list()
	var/image/path_overlay

/obj/pathfinder/New(loc, ...)
	. = ..()
	path_overlay = new('icons/misc/debug_group.dmi', "red")

/obj/pathfinder/Destroy()
	if(LAZYLEN(path))
		for(var/turf/T in path)
			T.cut_overlay(path_overlay)
	return ..()

/obj/pathfinder/attack_hand(mob/living/user)
	var/current = user.client.holder.marked_datum()
	if(!current)
		to_chat(user, SPAN_WARNING("You have no marked datum to pathfind to!"))
		return
	if(!isturf(current))
		to_chat(user, SPAN_WARNING("Your marked datum is not a turf!"))
		return
	start_pathfind(current)
	if(!LAZYLEN(path))
		to_chat(user, SPAN_NOTICE("No path found!"))
		return
	to_chat(user, SPAN_NOTICE("+----PATH----+"))
	var/index = 0
	for(var/item in path)
		to_chat(user, SPAN_NOTICE("| [index] - [item ? item : "null"]"))
		index++
	to_chat(user, SPAN_NOTICE("+--PATH-END--+"))

/obj/pathfinder/proc/start_pathfind(atom/target)
	var/turf/end_turf = get_turf(target)
	if(LAZYLEN(path))
		for(var/turf/T in path)
			T.cut_overlay(path_overlay)
		LAZYCLEARLIST(path)

	path = get_path_to(src, end_turf, 0)
	if(LAZYLEN(path))
		for(var/turf/T in path)
			T.add_overlay(path_overlay)
