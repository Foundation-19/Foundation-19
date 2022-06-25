/mob/observer/ghost
	hud_type = /datum/hud/ghost

/datum/hud/ghost/FinalizeInstantiation()

	if(!isghost(mymob))
		return

	var/mob/observer/ghost/G = mymob

	var/obj/screen/using
	adding = list()

	using = new /obj/screen/ghost/orbit()
	using.screen_loc = ui_ghost_orbit
	adding += using

	using = new /obj/screen/ghost/reenter_corpse()
	using.screen_loc = ui_ghost_reenter_corpse
	adding += using

	using = new /obj/screen/ghost/teleport()
	using.screen_loc = ui_ghost_teleport
	adding += using

	G.client.screen = list()
	G.client.screen += adding
