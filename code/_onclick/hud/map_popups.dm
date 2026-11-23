/atom/movable/screen/map_view
	layer = DEFAULT_PLANE
	plane = DEFAULT_PLANE

/atom/movable/screen/background
	name = "background"
	icon = 'icons/mob/screen1.dmi'
	icon_state = ""
	layer = DEFAULT_PLANE
	plane = DEFAULT_PLANE

/client/var/list/screen_maps = list()

/client/proc/register_map_obj(atom/movable/screen/screen_obj)
	if(!screen_obj.assigned_map)
		CRASH("Can't register [screen_obj] without 'assigned_map' property.")
	if(!screen_maps[screen_obj.assigned_map])
		screen_maps[screen_obj.assigned_map] = list()
	var/list/screen_map = screen_maps[screen_obj.assigned_map]
	screen_map |= screen_obj
	screen |= screen_obj

/client/proc/clear_map(map_name)
	if(!map_name || !screen_maps[map_name])
		return FALSE
	for(var/atom/movable/screen/screen_obj in screen_maps[map_name])
		screen_maps[map_name] -= screen_obj
		screen -= screen_obj
		if(screen_obj.del_on_map_removal)
			qdel(screen_obj)
	screen_maps -= map_name

/client/proc/clear_all_maps()
	for(var/map_name in screen_maps)
		clear_map(map_name)
