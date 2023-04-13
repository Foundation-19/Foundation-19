#define PROGRESSBAR_HEIGHT 6
#define PROGRESSBAR_ANIMATION_TIME 5

/datum/progressbar
	var/max_progress
	var/listindex

/datum/progressbar/proc/update(progress)


/datum/progressbar/private
	var/last_progress = 0
	var/mob/actor
	var/image/bar
	var/client/client
	var/visible
	var/shown

/datum/progressbar/private/New(mob/actor, max_progress, atom/actee)
	actee = actee || actor
	if (!istype(actee))
		EXCEPTION("Invalid progressbar/private instance")
	src.actor = actor
	src.max_progress = max_progress
	client = actor.client
	visible = actor.get_preference_value(/datum/client_preference/show_progress_bar) == GLOB.PREF_SHOW
	if (!visible)
		return
	bar = image('icons/effects/progressbar.dmi', actee, "prog_bar_0", HUD_ABOVE_ITEM_LAYER)
	bar.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA
	bar.plane = HUD_PLANE

	LAZYINITLIST(actor.progressbars)
	LAZYINITLIST(actor.progressbars[bar.loc])
	var/list/bars = actor.progressbars[bar.loc]
	bars.Add(src)
	listindex = bars.len
	bar.pixel_y = 0
	bar.alpha = 0
	animate(bar, pixel_y = 32 + (PROGRESSBAR_HEIGHT * (listindex - 1)), alpha = 255, time = PROGRESSBAR_ANIMATION_TIME, easing = SINE_EASING)

/datum/progressbar/private/update(progress)
	if (!visible || !actor || !actor.client)
		shown = FALSE
		return
	if (actor.client != client)
		client.images.Remove(bar)
		shown = FALSE
	client = actor.client
	progress = clamp(progress, 0, max_progress)
	last_progress = progress
	bar.icon_state = "prog_bar_[round(progress * 100 / max_progress, 5)]"
	if (!shown)
		client.images.Add(bar)
		shown = TRUE

/datum/progressbar/private/proc/shiftDown()
	--listindex
	bar.pixel_y = 32 + (PROGRESSBAR_HEIGHT * (listindex - 1))
	var/dist_to_travel = 32 + (PROGRESSBAR_HEIGHT * (listindex - 1)) - PROGRESSBAR_HEIGHT
	animate(bar, pixel_y = dist_to_travel, time = PROGRESSBAR_ANIMATION_TIME, easing = SINE_EASING)

/datum/progressbar/private/Destroy()
	for(var/I in actor.progressbars[bar.loc])
		var/datum/progressbar/private/P = I
		if(P != src && P.listindex > listindex)
			P.shiftDown()

	var/list/bars = actor.progressbars[bar.loc]
	bars.Remove(src)
	if(!bars.len)
		LAZYREMOVE(actor.progressbars, bar.loc)

	animate(bar, alpha = 0, time = PROGRESSBAR_ANIMATION_TIME)
	addtimer(CALLBACK(src, .proc/remove_from_client), PROGRESSBAR_ANIMATION_TIME, TIMER_CLIENT_TIME)
	QDEL_IN(bar, PROGRESSBAR_ANIMATION_TIME * 2) //for garbage collection safety
	. = ..()

/datum/progressbar/private/proc/remove_from_client()
	if(client)
		client.images.Remove(bar)
		client = null

/datum/progressbar/public
	var/atom/movable/actor
	var/atom/movable/actee
	var/atom/movable/bar

/datum/progressbar/public/Destroy()
	if (actor && bar)
		actor.vis_contents -= bar
	qdel(bar)
	. = ..()

/datum/progressbar/public/New(atom/movable/actor, max_progress, atom/movable/actee)
	actee = actee || actor
	if (!istype(actee))
		EXCEPTION("Invalid progressbar/public instance")
	src.actor = actor
	src.max_progress = max_progress
	src.actee = actee
	bar = new()
	bar.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	bar.icon = 'icons/effects/progressbar.dmi'
	bar.icon_state = "prog_bar_0"
	bar.pixel_x = (actee.x - actor.x) * WORLD_ICON_SIZE
	bar.pixel_y = (actee.y - actor.y) * WORLD_ICON_SIZE + WORLD_ICON_SIZE
	bar.layer = ABOVE_HUMAN_LAYER
	actor.vis_contents += bar

/datum/progressbar/public/update(progress)
	if (!actor || !actee)
		return
	progress = clamp(progress, 0, max_progress)
	bar.icon_state = "prog_bar_[round(progress * 100 / max_progress, 5)]"
	bar.pixel_x = (actee.x - actor.x) * WORLD_ICON_SIZE
	bar.pixel_y = (actee.y - actor.y) * WORLD_ICON_SIZE + WORLD_ICON_SIZE

#undef PROGRESSBAR_ANIMATION_TIME
#undef PROGRESSBAR_HEIGHT
