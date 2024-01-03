/* Using the HUD procs is simple. Call these procs in the life.dm of the intended mob.
Use the regular_hud_updates() proc before process_med_hud(mob) or process_sec_hud(mob) so
the HUD updates properly! */

// hud overlay image type, used for clearing client.images precisely
/image/hud_overlay
	appearance_flags = RESET_COLOR|RESET_TRANSFORM|KEEP_APART
	layer = ABOVE_HUMAN_LAYER
	plane = MOB_PLANE

//Medical HUD outputs. Called by the Life() proc of the mob using it, usually.
/proc/process_med_hud(mob/M, local_scanner, mob/Alt)
	if(!can_process_hud(M))
		return

	var/datum/arranged_hud_process/P = arrange_hud_process(M, Alt, GLOB.med_hud_users)
	for(var/mob/living/carbon/human/patient in P.Mob.in_view(P.Turf))

		if(!P.Mob.can_see(patient))
			continue

		if(local_scanner)
			P.Client.images += patient.hud_list[HEALTH_HUD]
			P.Client.images += patient.hud_list[STATUS_HUD]
		else
			if(hassensorlevel(patient, SUIT_SENSOR_VITAL))
				P.Client.images += patient.hud_list[HEALTH_HUD]
			if(hassensorlevel(patient, SUIT_SENSOR_BINARY))
				P.Client.images += patient.hud_list[LIFE_HUD]

//Blink HUD for 173.
/proc/process_blink_hud(mob/M, mob/Alt)
	if(!can_process_hud(M))
		return

	if(isscp173(M)) //Only 173 should have a blink HUD (Also this is neccesary for maintaing the blink HUD while caged)
		var/mob/living/scp173/S = M
		var/datum/arranged_hud_process/P = arrange_hud_process(M, Alt)
		for(var/mob/living/carbon/human/victim in dview(7, istype(S.loc, /obj/structure/scp173_cage) ? S.loc : S))
			if(victim.stat) //The unconscious cant blink, and therefore do not need to be added to the blink HUD
				continue
			P.Client.images += victim.hud_list[BLINK_HUD]

//Pestilence Hud for 049.
/proc/process_pestilence_hud(mob/M, mob/Alt)
	if(!can_process_hud(M))
		return

	if(isscp049(M))
		var/datum/arranged_hud_process/P = arrange_hud_process(M, Alt)
		for(var/mob/living/carbon/human/H in view(7, M))
			if(H.humanStageHandler.getStage("Pestilence"))
				P.Client.images += H.hud_list[PESTILENCE_HUD]

//Security HUDs. Pass a value for the second argument to enable implant viewing or other special features.
/proc/process_sec_hud(mob/M, advanced_mode, mob/Alt)
	if(!can_process_hud(M))
		return
	var/datum/arranged_hud_process/P = arrange_hud_process(M, Alt, GLOB.sec_hud_users)
	for(var/mob/living/carbon/human/perp in P.Mob.in_view(P.Turf))

		if(!P.Mob.can_see(perp))
			continue

		P.Client.images += perp.hud_list[ID_HUD]
		if(advanced_mode)
			P.Client.images += perp.hud_list[WANTED_HUD]
			P.Client.images += perp.hud_list[IMPTRACK_HUD]
			P.Client.images += perp.hud_list[IMPLOYAL_HUD]
			P.Client.images += perp.hud_list[IMPCHEM_HUD]

/proc/process_jani_hud(mob/M, mob/Alt)
	var/datum/arranged_hud_process/P = arrange_hud_process(M, Alt, GLOB.jani_hud_users)
	for (var/obj/effect/decal/cleanable/dirtyfloor in view(P.Mob))
		if(!P.Mob.can_see(dirtyfloor))
			continue
		P.Client.images += dirtyfloor.hud_overlay

// SCRAMBLE gear.
/proc/process_scramble_hud(mob/M, mob/Alt)
	if(!can_process_hud(M))
		return

	var/datum/arranged_hud_process/P = arrange_hud_process(M, Alt, GLOB.scramble_hud_users)
	// The only things that will have scramble hud, or so we assume
	// is SCP-096 (or, if admin shenanigans were happening, SCP-096s)
	for(var/mob/living/scp096/shylad in P.Mob.in_view(P.Turf))
		P.Client.images += new /image/hud_overlay('icons/SCP/hud_scramble.dmi', shylad, "scramble-alive")

/datum/arranged_hud_process
	var/client/Client
	var/mob/Mob
	var/turf/Turf

/proc/arrange_hud_process(mob/M, mob/Alt, list/hud_list)
	if(hud_list)
		hud_list |= M
	var/datum/arranged_hud_process/P = new
	P.Client = M.client
	P.Mob = Alt ? Alt : M
	P.Turf = get_turf(P.Mob)
	return P

/proc/can_process_hud(mob/M)
	if(!M)
		return 0
	if(!M.client)
		return 0
	if(M.stat != CONSCIOUS)
		return 0
	return 1

//Deletes the current HUD images so they can be refreshed with new ones.
/mob/proc/handle_hud_glasses() //Used in the life.dm of mobs that can use HUDs.
	if(client)
		for(var/image/hud_overlay/hud in client.images)
			client.images -= hud
	GLOB.med_hud_users -= src
	GLOB.sec_hud_users -= src
	GLOB.jani_hud_users -= src
	GLOB.scramble_hud_users -= src

/mob/proc/in_view(turf/T) //this is kind of stupid - dark
	return view(T)

/mob/observer/eye/in_view(turf/T)
	var/list/viewed = new
	for(var/mob/living/carbon/human/H in SSmobs.mob_list)
		if(get_dist(H, T) <= 7)
			viewed += H
	return viewed
