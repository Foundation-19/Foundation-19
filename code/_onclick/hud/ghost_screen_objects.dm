/obj/screen/ghost
	icon = 'icons/mob/screen_ghost.dmi'

/obj/screen/ghost/orbit
	name = "Orbit"
	icon_state = "orbit"

/obj/screen/ghost/orbit/Click()
	var/mob/observer/ghost/G = usr
	var/mob/fh = tgui_input_list(G, "Choose a player to orbit", "Orbit", GLOB.player_list)
	if(istype(fh))
		G.follow(fh)

/obj/screen/ghost/become_scp
	name = "Become an SCP"
	icon_state = "become_scp"

/obj/screen/ghost/become_scp/Click()
	var/mob/observer/ghost/G = usr
	var/choice = tgui_alert(G, "Safe or Keter/Euclid SCP?", "Become SCP", list("Safe", "Euclid/Keter", "Cancel"))
	if(choice == "Safe")
		G.become_safe()
	else if (choice == "Euclid/Keter")
		G.become_scp()

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
	var/A = tgui_input_list(G, "Teleport", "Teleport to an Area", area_repository.get_areas_by_z_level())
	if(A != "Cancel")
		G.dead_tele(A)
