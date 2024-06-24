var/const/GHOST_IMAGE_NONE = 0
var/const/GHOST_IMAGE_DARKNESS = 1
var/const/GHOST_IMAGE_SIGHTLESS = 2
var/const/GHOST_IMAGE_ALL = ~GHOST_IMAGE_NONE

/mob/observer
	density = FALSE
	alpha = 127
	plane = OBSERVER_PLANE
	invisibility = INVISIBILITY_OBSERVER
	see_invisible = SEE_INVISIBLE_OBSERVER
	sight = SEE_TURFS|SEE_MOBS|SEE_OBJS|SEE_SELF
	simulated = FALSE
	stat = DEAD
	status_flags = GODMODE
	var/ghost_image_flag = GHOST_IMAGE_DARKNESS
	var/image/ghost_image = null //this mobs ghost image, for deleting and stuff
	/// The target mob that the ghost is observing.
	var/mob/observe_target_mob = null
	/// The target client that the ghost is observing.
	var/client/observe_target_client = null
	var/ghost_orbit = GHOST_ORBIT_CIRCLE
	var/datum/orbit_menu/orbit_menu
/mob/observer/Initialize()
	.=..()
	ghost_image = image(src.icon,src)
	ghost_image.plane = plane
	ghost_image.layer = layer
	ghost_image.appearance = src
	ghost_image.appearance_flags = RESET_ALPHA
	if(ghost_image_flag & GHOST_IMAGE_DARKNESS)
		ghost_darkness_images |= ghost_image //so ghosts can see the eye when they disable darkness
	if(ghost_image_flag & GHOST_IMAGE_SIGHTLESS)
		ghost_sightless_images |= ghost_image //so ghosts can see the eye when they disable ghost sight
	SSghost_images.queue_global_image_update()

/mob/observer/Destroy()
	QDEL_NULL(orbit_menu)
	if (ghost_image)
		ghost_darkness_images -= ghost_image
		ghost_sightless_images -= ghost_image
		qdel(ghost_image)
		ghost_image = null
		SSghost_images.queue_global_image_update()
	. = ..()

/mob/observer/Login()
	mind?.active = TRUE
	..()

/mob/observer/check_airflow_movable()
	return FALSE

/mob/observer/CanPass()
	return TRUE

/mob/observer/dust()	//observers can't be vaporised.
	return

/mob/observer/gib()		//observers can't be gibbed.
	return

/mob/observer/can_see(atom/origin)	//Not blind either.
	if(origin)
		if(!(origin in view(src)))
			return FALSE
	return TRUE

/mob/observer/can_hear() 	//Nor deaf.
	return TRUE

/mob/observer/set_stat()
	stat = DEAD // They are also always dead

/mob/observer/touch_map_edge()
	if(z in GLOB.using_map.sealed_levels)
		return

	var/new_x = x
	var/new_y = y

	if(x <= TRANSITIONEDGE)
		new_x = TRANSITIONEDGE + 1
	else if (x >= (world.maxx - TRANSITIONEDGE + 1))
		new_x = world.maxx - TRANSITIONEDGE
	else if (y <= TRANSITIONEDGE)
		new_y = TRANSITIONEDGE + 1
	else if (y >= (world.maxy - TRANSITIONEDGE + 1))
		new_y = world.maxy - TRANSITIONEDGE

	var/turf/T = locate(new_x, new_y, z)
	if(T)
		forceMove(T)
		inertia_dir = 0
		throwing = null
		to_chat(src, SPAN_NOTICE("You cannot move further in this direction."))


///makes the ghost see the target hud and sets the eye at the target.
/mob/observer/proc/do_observe(atom/movable/target)
	if(!client || !target || !istype(target))
		return

	ManualFollow(target)
	reset_perspective()

	if(!iscarbon(target) || !client.prefs?.auto_observe)
		return
	var/mob/living/carbon/carbon_target = target
	if(!carbon_target.hud_used)
		return

	client.clear_screen()
	client.eye = carbon_target
	observe_target_mob = carbon_target

	carbon_target.auto_observed(src)

	RegisterSignal(src, COMSIG_MOVED, PROC_REF(observer_move_react))
	RegisterSignal(observe_target_mob, COMSIG_PARENT_QDELETING, PROC_REF(clean_observe_target))
	RegisterSignal(observe_target_mob, COMSIG_MOB_GHOSTIZE, PROC_REF(observe_target_ghosting))
	RegisterSignal(observe_target_mob, COMSIG_MOB_NEW_MIND, PROC_REF(observe_target_new_mind))
	RegisterSignal(observe_target_mob, COMSIG_MOB_LOGIN, PROC_REF(observe_target_login))

	if(observe_target_mob.client)
		observe_target_client = observe_target_mob.client
		RegisterSignal(observe_target_client, COMSIG_CLIENT_SCREEN_ADD, PROC_REF(observe_target_screen_add))
		RegisterSignal(observe_target_client, COMSIG_CLIENT_SCREEN_REMOVE, PROC_REF(observe_target_screen_remove))

/// When the observe target logs in our observer connect to the new client
/mob/observer/proc/observe_target_login(mob/living/new_character)
	SIGNAL_HANDLER

	if(observe_target_client != new_character.client)
		observe_target_client = new_character.client

	// Override the signal from any previous targets.
	RegisterSignal(observe_target_client, COMSIG_CLIENT_SCREEN_ADD, PROC_REF(observe_target_screen_add), TRUE)
	RegisterSignal(observe_target_client, COMSIG_CLIENT_SCREEN_REMOVE, PROC_REF(observe_target_screen_remove), TRUE)



/// When the observer target loses a screen, our observer loses it as well
/mob/observer/proc/observe_target_screen_remove(observe_target_mob_client, screen_remove)
	SIGNAL_HANDLER

	if(!client)
		return

	client.remove_from_screen(screen_remove)


/// When the observe target ghosts our observer disconnect from their screen updates
/mob/observer/proc/observe_target_ghosting(mob/observer_target_mob)
	SIGNAL_HANDLER

	if(observe_target_client) //Should never not have one if ghostizing but maaaybe?
		UnregisterSignal(observe_target_client, COMSIG_CLIENT_SCREEN_ADD)
		UnregisterSignal(observe_target_client, COMSIG_CLIENT_SCREEN_REMOVE)

/// Removes all signals and data related to the observe target and resets observer's HUD/eye
/mob/observer/proc/clean_observe_target()
	SIGNAL_HANDLER

	UnregisterSignal(observe_target_mob, COMSIG_PARENT_QDELETING)
	UnregisterSignal(observe_target_mob, COMSIG_MOB_GHOSTIZE)
	UnregisterSignal(observe_target_mob, COMSIG_MOB_NEW_MIND)
	UnregisterSignal(observe_target_mob, COMSIG_MOB_LOGIN)

	if(observe_target_client)
		UnregisterSignal(observe_target_client, COMSIG_CLIENT_SCREEN_ADD)
		UnregisterSignal(observe_target_client, COMSIG_CLIENT_SCREEN_REMOVE)

	if(observe_target_mob?.observers)
		observe_target_mob.observers -= src
		UNSETEMPTY(observe_target_mob.observers)

	observe_target_mob = null
	observe_target_client = null

	client.eye = src
	//hud_used.show_hud(hud_used.hud_version, src)
	UnregisterSignal(src, COMSIG_MOVED)

/// When the observer moves we disconnect from the observe target if we aren't on the same turf
/mob/observer/proc/observer_move_react()
	SIGNAL_HANDLER

	if(loc == get_turf(observe_target_mob))
		return
	clean_observe_target()

/// When the observer target gets a screen, our observer gets a screen minus some game screens we don't want the observer to touch
/mob/observer/proc/observe_target_screen_add(observe_target_mob_client, screen_add)
	SIGNAL_HANDLER

	var/static/list/excluded_types = typecacheof(list(
		/atom/movable/screen/fullscreen,
		/atom/movable/screen/click_catcher,
	))

	if(!client)
		return

	// `screen_add` can sometimes be a list, so it's safest to just handle everything as one.
	var/list/stuff_to_add = (islist(screen_add) ? screen_add : list(screen_add))

	for(var/item in stuff_to_add)
		// Ignore anything that's in `excluded_types`.
		if(is_type_in_typecache(item, excluded_types))
			continue

		client.add_to_screen(screen_add)

/// When the observe target gets a new mind our observer connects to the new client's screens
/mob/observer/proc/observe_target_new_mind(mob/living/new_character, client/new_client)
	SIGNAL_HANDLER

	if(observe_target_client != new_client)
		observe_target_client = new_client

	// Override the signal from any previous targets.
	RegisterSignal(observe_target_client, COMSIG_CLIENT_SCREEN_ADD, PROC_REF(observe_target_screen_add), TRUE)
	RegisterSignal(observe_target_client, COMSIG_CLIENT_SCREEN_REMOVE, PROC_REF(observe_target_screen_remove), TRUE)


// This is the ghost's follow verb with an argument
/mob/observer/proc/ManualFollow(atom/movable/target)
	if(!istype(target))
		return

	var/orbitsize = target.get_orbit_size()
	orbitsize -= (orbitsize / world.icon_size) * (world.icon_size * 0.25)

	var/rot_seg

	switch(ghost_orbit)
		if(GHOST_ORBIT_TRIANGLE)
			rot_seg = 3
		if(GHOST_ORBIT_SQUARE)
			rot_seg = 4
		if(GHOST_ORBIT_PENTAGON)
			rot_seg = 5
		if(GHOST_ORBIT_HEXAGON)
			rot_seg = 6
		else //Circular
			rot_seg = 36

	orbit(target, orbitsize, FALSE, 20, rot_seg)
