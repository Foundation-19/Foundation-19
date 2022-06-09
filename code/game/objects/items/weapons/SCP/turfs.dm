/turf/simulated/floor/tiled/monotile
	name = "floor"
	icon_state = "steel_monotile"
	initial_flooring = /decl/flooring/tiling/mono
/turf/simulated/floor/tiled/monotile/New()
	..()
	GLOB.simulated_turfs_scp106 += src
/turf/simulated/floor/tiled/monotile/Destroy()
	GLOB.simulated_turfs_scp106 -= src
	return ..()

/turf/simulated/floor/tiled/monotile/white
	name = "floor"
	icon_state = "monotile_light"
	initial_flooring = /decl/flooring/tiling/mono/white
