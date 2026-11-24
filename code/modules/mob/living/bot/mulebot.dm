#define MULE_IDLE 0
#define MULE_MOVING 1
#define MULE_UNLOAD 2
#define MULE_LOST 3
#define MULE_CALC_MIN 4
#define MULE_CALC_MAX 10
#define MULE_PATH_DONE 11
// IF YOU CHANGE THOSE, UPDATE THEM IN pda.tmpl TOO

/mob/living/bot/mulebot
	name = "Mulebot"
	desc = "A Multiple Utility Load Effector bot."
	icon = 'icons/mob/bot/mulebot.dmi'
	icon_state = "mulebot0"
	layer = MOB_LAYER
	anchored = TRUE
	density = TRUE
	health = 150
	maxHealth = 150
	mob_bump_flag = HEAVY

	min_target_dist = 0
	max_target_dist = 250
	target_speed = 3
	max_frustration = 5
	botcard_access = list(ACCESS_MAINT_TUNNELS, ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_CARGO_BOT, ACCESS_QM, ACCESS_MINING, ACCESS_MINING_STATION)

	var/atom/movable/load

	var/paused = 1
	var/crates_only = 1
	var/auto_return = 1
	var/safety = 1

	var/targetName
	var/turf/home
	var/homeName

	var/global/amount = 0

/mob/living/bot/mulebot/Initialize()
	. = ..()

	var/turf/T = get_turf(loc)
	var/obj/machinery/navbeacon/N = locate() in T
	if(N)
		home = T
		homeName = N.location
	else
		homeName = "Unset"

	suffix = num2text(++amount)
	name = "Mulebot #[suffix]"

/mob/living/bot/mulebot/MouseDrop_T(atom/movable/C, mob/user)
	if(user.stat)
		return

	if(!istype(C) || C.anchored || get_dist(user, src) > 1 || get_dist(src, C) > 1 )
		return

	load(C)

/mob/living/bot/mulebot/GetInteractTitle()
	return "Multiple Utility Load Effector Mk. III"

/mob/living/bot/mulebot/get_status_data(mob/user)
	. = ..()
	.["info"] += list(list("label" = "ID", "value" = suffix))
	.["info"] += list(list("label" = "Current Load", "value" = load ? load.name : "none"))
	return

/mob/living/bot/mulebot/get_panel_data(mob/user)
	var/list/beaconlist = GetBeaconList()
	var/list/beacon_tags = list()
	for(var/tag in beaconlist)
		beacon_tags += tag

	. = list()
	.["info"] = list(
		list("label" = "Home", "value" = homeName ? homeName : "Unset"),
		list("label" = "Destination", "value" = targetName ? targetName : "None"),
	)
	.["buttons"] = list(
		list("action" = "stop", "label" = "Stop"),
		list("action" = "go", "label" = "Proceed"),
		list("action" = "home", "label" = "Return to home"),
	)
	if(load)
		.["buttons"] += list(list("action" = "unload", "label" = "Unload now"))
	.["toggles"] = list(
		list("action" = "autoret", "label" = "Auto return home", "value" = auto_return),
		list("action" = "cargotypes", "label" = "Allow non-standard cargo", "value" = !crates_only),
	)
	.["options"] = list()
	if(beacon_tags.len)
		.["options"] += list(list("action" = "set_destination", "label" = "Destination beacon", "param" = "dest", "values" = beacon_tags))
		.["options"] += list(list("action" = "set_home", "label" = "Home beacon", "param" = "dest", "values" = beacon_tags))
	return

/mob/living/bot/mulebot/get_maintenance_data(mob/user)
	. = list()
	.["toggles"] = list(
		list("action" = "safety", "label" = "Safety", "value" = safety, "value_text" = safety ? "On" : "Off - DANGER"),
	)
	return

/mob/living/bot/mulebot/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	if(CanAccessPanel(usr))
		var/list/beaconlist = GetBeaconList()
		switch(action)
			if("stop")
				obeyCommand("Stop")
				return TRUE
			if("go")
				obeyCommand("GoTD")
				return TRUE
			if("home")
				obeyCommand("Home")
				return TRUE
			if("set_destination")
				var/dest = params["dest"]
				if(dest && beaconlist[dest])
					resetTarget()
					target = get_turf(beaconlist[dest])
					targetName = dest
				return TRUE
			if("set_home")
				var/home_dest = params["dest"]
				if(home_dest && beaconlist[home_dest])
					home = get_turf(beaconlist[home_dest])
					homeName = home_dest
				return TRUE
			if("unload")
				unload()
				return TRUE
			if("autoret")
				auto_return = !auto_return
				return TRUE
			if("cargotypes")
				crates_only = !crates_only
				return TRUE
	if(CanAccessMaintenance(usr))
		switch(action)
			if("safety")
				safety = !safety
				return TRUE
	return FALSE

/mob/living/bot/mulebot/attackby(obj/item/O, mob/user)
	..()
	update_icons()

/mob/living/bot/mulebot/proc/obeyCommand(command)
	switch(command)
		if("Home")
			resetTarget()
			target = home
			targetName = "Home"
		if("SetD")
			var/new_dest
			var/list/beaconlist = GetBeaconList()
			if(beaconlist.len)
				new_dest = input("Select new destination tag", "Mulebot [suffix ? "([suffix])" : ""]") in null|beaconlist
			else
				alert("No destination beacons available.")
			if(new_dest)
				resetTarget()
				target = get_turf(beaconlist[new_dest])
				targetName = new_dest
		if("GoTD")
			paused = 0
		if("Stop")
			paused = 1

/mob/living/bot/mulebot/emag_act(remaining_charges, user)
	locked = !locked
	to_chat(user, SPAN_NOTICE("You [locked ? "lock" : "unlock"] the mulebot's controls."))
	flick("mulebot-emagged", src)
	playsound(loc, 'sounds/effects/sparks1.ogg', 100, 0)
	return 1

/mob/living/bot/mulebot/update_icons()
	if(open)
		icon_state = "mulebot-hatch"
		return
	if(target_path.len && !paused)
		icon_state = "mulebot1"
		return
	icon_state = "mulebot0"

/mob/living/bot/mulebot/handleRegular()
	if(!safety && prob(1))
		flick("mulebot-emagged", src)
	update_icons()

/mob/living/bot/mulebot/handleFrustrated()
	custom_emote(2, "makes a sighing buzz.")
	playsound(loc, 'sounds/machines/buzz-sigh.ogg', 50, 0)
	..()

/mob/living/bot/mulebot/handleAdjacentTarget()
	if(target == src.loc)
		custom_emote(2, "makes a chiming sound.")
		playsound(loc, 'sounds/machines/chime.ogg', 50, 0)
		UnarmedAttack(target)
		resetTarget()
		if(auto_return && home && (loc != home))
			target = home
			targetName = "Home"

/mob/living/bot/mulebot/confirmTarget()
	return 1

/mob/living/bot/mulebot/calcTargetPath()
	..()
	if(!target_path.len && target != home) // I presume that target is not null
		resetTarget()
		target = home
		targetName = "Home"

/mob/living/bot/mulebot/stepToTarget()
	if(paused)
		return
	..()

/mob/living/bot/mulebot/UnarmedAttack(turf/T)
	if(T == src.loc)
		unload(dir)

/mob/living/bot/mulebot/Bump(mob/living/carbon/human/M)
	if(!safety && istype(M))
		visible_message(SPAN_WARNING("[src] knocks over [M]!"))
		M.Stun(8)
		M.Weaken(5)
	..()

/mob/living/bot/mulebot/proc/runOver(mob/living/carbon/human/H)
	if(istype(H)) // No safety checks - WILL run over lying humans. Stop ERPing in the maint!
		visible_message(SPAN_WARNING("[src] drives over [H]!"))
		playsound(loc, 'sounds/effects/splat.ogg', 50, 1)

		var/damage = rand(5, 7)
		H.apply_damage(2 * damage, BRUTE, BP_HEAD)
		H.apply_damage(2 * damage, BRUTE, BP_CHEST)
		H.apply_damage(0.5 * damage, BRUTE, BP_L_LEG)
		H.apply_damage(0.5 * damage, BRUTE, BP_R_LEG)
		H.apply_damage(0.5 * damage, BRUTE, BP_L_ARM)
		H.apply_damage(0.5 * damage, BRUTE, BP_R_ARM)

		blood_splatter(src, H, 1)

/mob/living/bot/mulebot/relaymove(mob/user, direction)
	if(load == user)
		unload(direction)

/mob/living/bot/mulebot/explode()
	unload(pick(0, 1, 2, 4, 8))

	visible_message(SPAN_DANGER("[src] blows apart!"))

	var/turf/Tsec = get_turf(src)
	new /obj/item/device/assembly/prox_sensor(Tsec)
	new /obj/item/stack/material/rods(Tsec)
	new /obj/item/stack/material/rods(Tsec)
	new /obj/item/stack/cable_coil/cut(Tsec)

	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(3, 1, src)
	s.start()

	new /obj/effect/decal/cleanable/blood/oil(Tsec)
	..()

/mob/living/bot/mulebot/proc/GetBeaconList()
	var/list/beaconlist = list()
	for(var/obj/machinery/navbeacon/N in navbeacons)
		if(!N.codes["delivery"])
			continue
		beaconlist.Add(N.location)
		beaconlist[N.location] = N
	return beaconlist

/mob/living/bot/mulebot/proc/load(atom/movable/C)
	if(busy || load || get_dist(C, src) > 1 || !isturf(C.loc))
		return

	for(var/obj/structure/plasticflaps/P in src.loc)//Takes flaps into account
		if(!CanPass(C,P))
			return

	if(crates_only && !istype(C,/obj/structure/closet/crate))
		custom_emote(2, "makes a sighing buzz.")
		playsound(loc, 'sounds/machines/buzz-sigh.ogg', 50, 0)
		return

	var/obj/structure/closet/crate/crate = C
	if(istype(crate))
		crate.close()

	busy = 1

	C.forceMove(loc)
	sleep(2)
	if(C.loc != loc) //To prevent you from going onto more than one bot.
		return
	C.forceMove(src)
	load = C

	C.pixel_y += 9
	if(C.layer < layer)
		C.layer = layer + 0.1
	C.plane = plane
	add_overlay(C)

	if(ismob(C))
		var/mob/M = C
		if(M.client)
			M.client.perspective = EYE_PERSPECTIVE
			M.client.eye = src

	busy = 0

/mob/living/bot/mulebot/proc/unload(dirn = 0)
	if(!load || busy)
		return

	busy = 1
	cut_overlays()

	load.forceMove(loc)
	load.pixel_y -= 9
	load.reset_plane_and_layer()
	if(ismob(load))
		var/mob/M = load
		if(M.client)
			M.client.perspective = MOB_PERSPECTIVE
			M.client.eye = src

	if(dirn)
		step(load, dirn)

	load = null

	for(var/atom/movable/AM in src)
		if(AM == botcard || AM == access_scanner) continue

		AM.forceMove(loc)
		AM.reset_plane_and_layer()
		AM.pixel_y = initial(AM.pixel_y)
		if(ismob(AM))
			var/mob/M = AM
			if(M.client)
				M.client.perspective = MOB_PERSPECTIVE
				M.client.eye = src
	busy = 0
