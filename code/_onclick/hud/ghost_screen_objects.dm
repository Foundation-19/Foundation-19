/obj/screen/ghost
	icon = 'icons/mob/screen_ghost.dmi'

/obj/screen/ghost/orbit
	name = "Orbit"
	icon_state = "orbit"

/obj/screen/ghost/orbit/Click()
	var/mob/observer/ghost/G = usr
	var/mob/fh = input(G, "Orbit", "Orbit a player") as null | anything in GLOB.player_list
	if(istype(fh))
		G.follow(fh)

/obj/screen/ghost/reenter_corpse
	name = "Reenter corpse"
	icon_state = "reenter_corpse"

/obj/screen/ghost/reenter_corpse/Click()
	var/mob/observer/ghost/G = usr
	if(G.can_reenter_corpse)
		G.reenter_corpse()
	else
		to_chat(G, SPAN_WARNING("You can't re-enter your corpse!"))

/obj/screen/ghost/teleport
	name = "Teleport"
	icon_state = "teleport"

/obj/screen/ghost/teleport/Click()
	var/mob/observer/ghost/G = usr
	var/A = input(G, "Teleport", "Teleport to an Area") as null | anything in area_repository.get_areas_by_z_level()
	if(A != "Cancel")
		G.dead_tele(A)
