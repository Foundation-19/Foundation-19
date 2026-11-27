/atom/movable/screen/ghost
	icon = 'icons/hud/screen_ghost.dmi'

/atom/movable/screen/ghost/orbit
	name = "Orbit"
	icon_state = "orbit"

/atom/movable/screen/ghost/orbit/Click()
	var/mob/observer/ghost/G = usr
	if(!istype(G))
		return
	G.orbit_menu()

/atom/movable/screen/ghost/become_scp
	name = "Become an SCP"
	icon_state = "become_scp"

/atom/movable/screen/ghost/become_scp/Click()
	var/mob/observer/ghost/G = usr
	if(!istype(G))
		return
	if(!G.MayRespawn(TRUE, SCP_SPAWN_DELAY))
		return
	var/list/available = list()
	for(var/atom/PossibleSCP in GLOB.SCP_list)
		if(G.canBecomeSCP(PossibleSCP))
			available += PossibleSCP
	if(!LAZYLEN(available))
		to_chat(G, SPAN_WARNING("There are no SCPs avalible yet! Keep in mind that not all SCPs are avalible round start and more may become avalible as the round goes on!"))
		return
	G?.scp_select_menu()

/atom/movable/screen/ghost/reenter_corpse
	name = "Reenter corpse"
	icon_state = "reenter_corpse"

/atom/movable/screen/ghost/reenter_corpse/Click()
	var/mob/observer/ghost/G = usr
	// The button renders while observing (also for living mobs looking at
	// ghosts HUD edge cases) — only a real ghost with a corpse may use it.
	if(istype(G) && G.can_reenter_corpse)
		G.reenter_corpse()
	else
		to_chat(G, SPAN_WARNING("You can't re-enter your corpse!"))

/atom/movable/screen/ghost/teleport
	name = "Teleport"
	icon_state = "teleport"

/atom/movable/screen/ghost/teleport/Click()
	var/mob/observer/ghost/G = usr
	var/A = tgui_input_list(G, "Teleport", "Teleport to an Area", area_repository.get_areas_by_z_level())
	if(A != "Cancel")
		G.dead_tele(A)
