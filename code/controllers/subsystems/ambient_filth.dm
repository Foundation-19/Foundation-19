// Ambient filth build-up — the site slowly gets dirty during play so
// janitorial work matters. Ported from the Baystation12 persistent filth
// concept and extended: passive dirt accrual on walked floors plus rare
// trash/grime spawns in low-visibility areas. Everything created here
// flows through the existing persistent-filth save/load pipeline.
//
// Tuning (per ~2.5 min tick):
//  - each walked-over floor gains a small dirt bump (matching the
//    footstep economy of update_dirt, which adds 0.5 per entry)
//  - a handful of random hall/maintenance turfs gain grime decals
//  - a rare trash item appears in maintenance areas
// All spawn rates scale down with the live player count of janitors so a
// staffed janitor team can realistically keep up.

#define FILTH_TICK_INTERVAL (2.5 MINUTES)
#define FILTH_DIRT_BUMP 0.5
#define FILTH_MAX_PER_PASS 25

SUBSYSTEM_DEF(ambient_filth)
	name = "Ambient Filth"
	init_order = SS_INIT_MISC_LATE
	wait = FILTH_TICK_INTERVAL
	priority = SS_PRIORITY_TURF

	// Cached floor lists, rebuilt lazily when station maps change.
	var/list/hall_turfs
	var/list/maint_turfs
	var/last_rebuild = 0

/datum/controller/subsystem/ambient_filth/Initialize()
	. = ..()
	rebuild_turf_cache()

/datum/controller/subsystem/ambient_filth/Recover()
	last_rebuild = 0

// (Re)collect eligible turfs: station floors in persistent areas.
/datum/controller/subsystem/ambient_filth/proc/rebuild_turf_cache()
	set background = TRUE
	hall_turfs = list()
	maint_turfs = list()
	last_rebuild = world.time
	for(var/thing in GLOB.using_map.station_levels)
		var/z = thing
		for(var/turf/simulated/floor/T in block(locate(1, 1, z), locate(world.maxx, world.maxy, z)))
			var/area/A = get_area(T)
			if(!A || (A.area_flags & AREA_FLAG_IS_NOT_PERSISTENT))
				continue
			maint_turfs += T
			// Hallways: high traffic -> gradual visible dirt. F19 site53
			// area names end in "hallways"/"hallway"; maintenance is a
			// separate list member but also accrues foot dirt slowly.
			var/aname = lowertext(A.name)
			if(findtext(aname, "hallway") || istype(A, /area/site53/maintenance))
				hall_turfs += T

/datum/controller/subsystem/ambient_filth/fire(resumed = FALSE)
	// Lazily refresh the turf cache every ~10 minutes.
	if(world.time - last_rebuild > 10 MINUTES)
		rebuild_turf_cache()

	// Janitor pressure: more active janitors/cleanbots -> less filth gain.
	var/janitors = 0
	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(H.stat != DEAD && H.mind && H.mind.assigned_role == "Janitor")
			janitors++
	for(var/mob/living/bot/cleanbot/B in SSmobs.mob_list)
		if(B.on)
			janitors++
	// 0 janitors = full rate; each janitor shaves 25%, floor at 10%.
	var/rate_mult = max(0.1, 1 - janitors * 0.25)

	apply_dirt_buildup(rate_mult)
	spawn_grime(rate_mult)
	spawn_maintenance_trash(rate_mult)

// High-traffic floors accrue dirt from the crowd walking over them.
/datum/controller/subsystem/ambient_filth/proc/apply_dirt_buildup(rate_mult)
	if(!LAZYLEN(hall_turfs))
		return
	var/count = min(FILTH_MAX_PER_PASS, round(length(hall_turfs) * 0.05 * rate_mult) + 1)
	count = min(count, length(hall_turfs))
	for(var/i in 1 to count)
		var/turf/simulated/T = pick(hall_turfs)
		// Same bump economy as the per-footstep update_dirt() — a busy
		// hallway accrues as if a few people walked through.
		T.update_dirt()

// Random turfs sprout grime decals (persistent filth on round end).
/datum/controller/subsystem/ambient_filth/proc/spawn_grime(rate_mult)
	if(!LAZYLEN(maint_turfs))
		return
	var/count = min(10, round(3 * rate_mult) + rand(0, 1))
	count = min(count, length(maint_turfs))
	for(var/i in 1 to count)
		var/turf/simulated/T = pick(maint_turfs)
		if(T.density)
			continue
		if(locate(/obj/effect/decal/cleanable) in T)
			continue
		var/grime_type = pick(
			/obj/effect/decal/cleanable/filth,
			/obj/effect/decal/cleanable/filth,
			/obj/effect/decal/cleanable/dirt,
			/obj/effect/decal/cleanable/greenglow,
			/obj/effect/decal/cleanable/molten_item,
		)
		new grime_type(T)

// Maintenance areas occasionally grow a piece of forgotten trash.
/datum/controller/subsystem/ambient_filth/proc/spawn_maintenance_trash(rate_mult)
	if(!LAZYLEN(maint_turfs))
		return
	if(!prob(60 * rate_mult))
		return
	var/turf/simulated/T = pick(maint_turfs)
	if(T.density)
		return
	if((locate(/obj/item/trash) in T))
		return
	var/trash_type = pick(
		/obj/item/trash/candy,
		/obj/item/trash/cheesie,
		/obj/item/trash/chips,
		/obj/item/trash/popcorn,
		/obj/item/trash/semki,
		/obj/item/trash/croutons,
		/obj/item/trash/cubewrapper,
		/obj/item/trash/stick,
		/obj/item/trash/raisins,
	)
	new trash_type(T)

#undef FILTH_TICK_INTERVAL
#undef FILTH_DIRT_BUMP
#undef FILTH_MAX_PER_PASS
