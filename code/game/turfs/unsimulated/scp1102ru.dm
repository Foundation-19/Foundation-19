GLOBAL_LIST_EMPTY(scp1102_floors)

/turf/unsimulated/floor/scp1102
	name = "floor"
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_state = "techmaint"

/turf/unsimulated/floor/scp1102/New()
	..()
	START_PROCESSING(SSturf, src)
	GLOB.scp1102_floors += src

/turf/unsimulated/floor/scp1102/Destroy()
	STOP_PROCESSING(SSturf, src)
	GLOB.scp1102_floors -= src
	. = ..()
