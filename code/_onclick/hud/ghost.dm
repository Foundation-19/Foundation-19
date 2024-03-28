/mob/observer/ghost
	hud_type = /datum/hud/ghost

/datum/hud/ghost/FinalizeInstantiation()

	if(!isghost(mymob))
		return

	var/mob/observer/ghost/G = mymob

	var/atom/movable/screen/using
	adding = list()

	using = new /atom/movable/screen/ghost/orbit()
	using.screen_loc = ui_ghost_orbit
	adding += using

	using = new /atom/movable/screen/ghost/reenter_corpse()
	using.screen_loc = ui_ghost_reenter_corpse
	adding += using

	using = new /atom/movable/screen/ghost/teleport()
	using.screen_loc = ui_ghost_teleport
	adding += using

	using = new /atom/movable/screen/ghost/become_scp()
	using.screen_loc = ui_ghost_become_scp
	adding += using

	G.client.screen = list()
	G.client.screen += adding
