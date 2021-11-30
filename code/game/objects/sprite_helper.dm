/obj/sprite_helper
	icon = null 
	icon_state = ""
	layer = MOB_LAYER+0.1
	density = FALSE
	
/obj/sprite_helper/New()
	..()
	name = ""

/obj/sprite_helper/CanMoveOnto(atom/movable/mover, turf/target, height=1.5, direction = 0)
	return TRUE

// no need to sanity check vis_locs, because we couldn't click it in the first place if vis_locs.len was 0
/obj/sprite_helper/Click(location,control,params)
	var/atom/A = vis_locs[1]
	return A.Click(location, control, params)

/obj/sprite_helper/DblClick(location,control,params)
	var/atom/A = vis_locs[1]
	return A.DblClick(location, control, params)
		
// for tableclimbing
/obj/sprite_helper/MouseDrop(over)
	var/atom/A = vis_locs[1]
	return A.MouseDrop(over)
	
// other stuff 
/mob/living/carbon/human/set_dir(var/dir)
	. = ..(dir)
	for (var/obj/sprite_helper/SH in vis_contents)
		SH.dir = dir
