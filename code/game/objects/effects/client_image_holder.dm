/**
 * Simple effect that holds an image
 * to be shown to one or multiple clients only.
 *
 * Pass a list of mobs in initialize() that corresponds to all mobs that can see it.
 */
/obj/effect/client_image_holder
	invisibility = INVISIBILITY_OBSERVER
	anchored = TRUE

	/// A list of mobs which can see us.
	var/list/mob/who_sees_us
	/// The created image, what we look like.
	var/image/shown_image
	/// The icon file the image uses. If null, we have no image
	var/image_icon
	/// The icon state the image uses
	var/image_state
	/// The x pixel offset of the image
	var/image_pixel_x = 0
	/// The y pixel offset of the image
	var/image_pixel_y = 0
	/// Optional, the color of the image
	var/image_color
	/// The layer of the image
	var/image_layer = MOB_LAYER
	/// The plane of the image
	var/image_plane = MOB_PLANE

/obj/effect/client_image_holder/Initialize(mapload, list/mobs_which_see_us)
	. = ..()
	if(isnull(mobs_which_see_us))
		crash_with("Client image holder was created with no mobs to see it.")
		return INITIALIZE_HINT_QDEL

	shown_image = generate_image()

	if(!islist(mobs_which_see_us))
		mobs_which_see_us = list(mobs_which_see_us)

	RegisterSignal(src, COMSIG_MOVED, PROC_REF(regenerate_image))

	who_sees_us = list()
	for(var/mob/seer as anything in mobs_which_see_us)
		RegisterSignal(seer, COMSIG_MOB_LOGIN, PROC_REF(show_image_to))
		RegisterSignal(seer, COMSIG_PARENT_QDELETING, PROC_REF(remove_seer))
		// If we move for some reason, regenerate our image
		who_sees_us += seer
		show_image_to(seer)

/obj/effect/client_image_holder/Destroy(force)
	if(shown_image)
		for(var/mob/seer as anything in who_sees_us)
			remove_seer(seer)
		shown_image = null

	UnregisterSignal(src, COMSIG_MOVED)

	who_sees_us.Cut() // probably not needed but who knows
	return ..()

/// Signal proc to clean up references if people who see us are deleted.
/obj/effect/client_image_holder/proc/remove_seer(mob/source)
	SIGNAL_HANDLER

	UnregisterSignal(source, list(COMSIG_MOB_LOGIN, COMSIG_PARENT_QDELETING))
	hide_image_from(source)
	who_sees_us -= source

	// No reason to exist, anymore
	if(!QDELETED(src) && !length(who_sees_us))
		qdel(src)

/// Generates the image which we take on.
/obj/effect/client_image_holder/proc/generate_image()
	var/image/created = image(image_icon, src, image_state, image_layer, dir = src.dir)
	created.plane = image_plane
	created.pixel_x = image_pixel_x
	created.pixel_y = image_pixel_y
	if(image_color)
		created.color = image_color
	return created

/// Shows the image we generated to the passed mob
/obj/effect/client_image_holder/proc/show_image_to(mob/show_to)
	SIGNAL_HANDLER

	show_to.client?.images |= shown_image

/// Hides the image we generated from the passed mob
/obj/effect/client_image_holder/proc/hide_image_from(mob/hide_from)
	SIGNAL_HANDLER

	hide_from.client?.images -= shown_image

/// Simple helper for refreshing / showing the image to everyone in our list.
/obj/effect/client_image_holder/proc/regenerate_image()
	for(var/mob/seer as anything in who_sees_us)
		hide_image_from(seer)

	shown_image = generate_image()

	for(var/mob/seer as anything in who_sees_us)
		show_image_to(seer)

// Whenever we perform icon updates, regenerate our image
/obj/effect/client_image_holder/update_icon(updates = ALL)
	. = ..()
	regenerate_image()

/obj/effect/client_image_holder/singularity_pull()
	return

/obj/effect/client_image_holder/singularity_act()
	return
