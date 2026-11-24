#define FARMBOT_COLLECT 1
#define FARMBOT_WATER 2
#define FARMBOT_UPROOT 3
#define FARMBOT_NUTRIMENT 4

/mob/living/bot/farmbot
	name = "Farmbot"
	desc = "The botanist's best friend."
	icon = 'icons/mob/bot/farmbot.dmi'
	icon_state = "farmbot0"
	health = 50
	maxHealth = 50
	req_access = list(list(ACCESS_HYDROPONICS, ACCESS_ROBOTICS))

	var/action = "" // Used to update icon
	var/waters_trays = 1
	var/refills_water = 1
	var/uproots_weeds = 1
	var/replaces_nutriment = 0
	var/collects_produce = 0
	var/removes_dead = 0

	var/obj/structure/reagent_dispensers/watertank/tank

/mob/living/bot/farmbot/Initialize(mapload, newTank)
	. = ..()
	if(!newTank)
		tank = new /obj/structure/reagent_dispensers/watertank(src)
	else
		tank = newTank
	tank.forceMove(src)

/mob/living/bot/farmbot/premade
	name = "Old Ben"
	on = 0

/mob/living/bot/farmbot/GetInteractTitle()
	return "Automatic Hyrdoponic Assisting Unit v1.0"

/mob/living/bot/farmbot/get_status_data(mob/user)
	. = ..()
	.["info"] += list(list("label" = "Water tank", "value" = tank ? "[tank.reagents.total_volume]/[tank.reagents.maximum_volume]" : "error: not found"))
	return

/mob/living/bot/farmbot/get_panel_data(mob/user)
	. = list()
	.["toggles"] = list(
		list("action" = "water", "label" = "Water plants", "value" = waters_trays),
		list("action" = "refill", "label" = "Refill watertank", "value" = refills_water),
		list("action" = "weed", "label" = "Weed plants", "value" = uproots_weeds),
		list("action" = "replacenutri", "label" = "Replace fertilizer", "value" = replaces_nutriment),
		list("action" = "collect", "label" = "Collect produce", "value" = collects_produce),
		list("action" = "removedead", "label" = "Remove dead plants", "value" = removes_dead),
	)
	return

/mob/living/bot/farmbot/get_maintenance_data(mob/user)
	. = list()
	if(emagged < 2)
		.["toggles"] = list(
			list("action" = "emag", "label" = "Plant identifier", "value" = emagged, "value_text" = emagged ? "Scrambled (DANGER)" : "Normal"),
		)
	else
		.["info"] = list(
			list("label" = "Plant identifier status", "value" = "ERROROROROROR-----"),
		)
	return

/mob/living/bot/farmbot/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	if(CanAccessPanel(usr))
		switch(action)
			if("water")
				waters_trays = !waters_trays
				return TRUE
			if("refill")
				refills_water = !refills_water
				return TRUE
			if("weed")
				uproots_weeds = !uproots_weeds
				return TRUE
			if("replacenutri")
				replaces_nutriment = !replaces_nutriment
				return TRUE
			if("collect")
				collects_produce = !collects_produce
				return TRUE
			if("removedead")
				removes_dead = !removes_dead
				return TRUE
	if(CanAccessMaintenance(usr))
		switch(action)
			if("emag")
				if(emagged < 2)
					emagged = !emagged
				return TRUE
	return FALSE

/mob/living/bot/farmbot/emag_act(remaining_charges, mob/user)
	. = ..()
	if(!emagged)
		if(user)
			to_chat(user, SPAN_NOTICE("You short out [src]'s plant identifier circuits."))
			ignore_list |= user
		emagged = TRUE
		return 1

/mob/living/bot/farmbot/update_icons()
	if(on && action)
		icon_state = "farmbot_[action]"
	else
		icon_state = "farmbot[on]"

/mob/living/bot/farmbot/handleRegular()
	if(emagged && prob(1))
		flick("farmbot_broke", src)

/mob/living/bot/farmbot/handleAdjacentTarget()
	UnarmedAttack(target)

/mob/living/bot/farmbot/lookForTargets()
	if(emagged)
		for(var/mob/living/carbon/human/H in view(7, src))
			target = H
			return
	else
		for(var/obj/machinery/portable_atmospherics/hydroponics/tray in view(7, src))
			if(confirmTarget(tray))
				target = tray
				return
		if(!target && refills_water && tank && tank.reagents.total_volume < tank.reagents.maximum_volume)
			for(var/obj/structure/hygiene/sink/source in view(7, src))
				target = source
				return

/mob/living/bot/farmbot/calcTargetPath()
	target_path = get_path_to(src, target, max_target_dist, min_target_dist = 1, id = botcard)	// We need to land NEXT to the tray, because the tray itself is impassable
	if(!target_path)
		ignore_list |= target
		target = null
		target_path = list()
	return

/mob/living/bot/farmbot/stepToTarget() // Same reason
	var/turf/T = get_turf(target)
	if(!target_path.len || !T.Adjacent(target_path[target_path.len]))
		calcTargetPath()
	makeStep(target_path)
	return

/mob/living/bot/farmbot/UnarmedAttack(atom/A, proximity)
	if(!..())
		return
	if(busy)
		return

	if(istype(A, /obj/machinery/portable_atmospherics/hydroponics))
		var/obj/machinery/portable_atmospherics/hydroponics/T = A
		var/t = confirmTarget(T)
		switch(t)
			if(0)
				return
			if(FARMBOT_COLLECT)
				action = "water" // Needs a better one
				update_icons()
				visible_message(SPAN_NOTICE("[src] starts [T.dead? "removing the plant from" : "harvesting"] \the [A]."))
				busy = 1
				if(do_after(src, 3 SECONDS, A))
					visible_message(SPAN_NOTICE("[src] [T.dead? "removes the plant from" : "harvests"] \the [A]."))
					T.physical_attack_hand(src)
			if(FARMBOT_WATER)
				action = "water"
				update_icons()
				visible_message(SPAN_NOTICE("[src] starts watering \the [A]."))
				busy = 1
				if(do_after(src, 3 SECONDS, A))
					playsound(loc, 'sounds/effects/slosh.ogg', 25, 1)
					visible_message(SPAN_NOTICE("[src] waters \the [A]."))
					tank.reagents.trans_to(T, 100 - T.waterlevel)
			if(FARMBOT_UPROOT)
				action = "hoe"
				update_icons()
				visible_message(SPAN_NOTICE("[src] starts uprooting the weeds in \the [A]."))
				busy = 1
				if(do_after(src, 3 SECONDS, A))
					visible_message(SPAN_NOTICE("[src] uproots the weeds in \the [A]."))
					T.weedlevel = 0
			if(FARMBOT_NUTRIMENT)
				action = "fertile"
				update_icons()
				visible_message(SPAN_NOTICE("[src] starts fertilizing \the [A]."))
				busy = 1
				if(do_after(src, 3 SECONDS, A))
					visible_message(SPAN_NOTICE("[src] fertilizes \the [A]."))
					T.reagents.add_reagent(/datum/reagent/ammonia, 10)
		busy = 0
		action = ""
		update_icons()
		T.update_icon()
	else if(istype(A, /obj/structure/hygiene/sink))
		if(!tank || tank.reagents.total_volume >= tank.reagents.maximum_volume)
			return
		action = "water"
		update_icons()
		visible_message(SPAN_NOTICE("[src] starts refilling its tank from \the [A]."))
		busy = 1
		while(do_after(src, 1 SECOND, bonus_percentage = 100) && tank.reagents.total_volume < tank.reagents.maximum_volume)
			tank.reagents.add_reagent(/datum/reagent/water, 100)
			if(prob(5))
				playsound(loc, 'sounds/effects/slosh.ogg', 25, 1)
		busy = 0
		action = ""
		update_icons()
		visible_message(SPAN_NOTICE("[src] finishes refilling its tank."))
	else if(emagged && ishuman(A))
		var/action = pick("weed", "water")
		busy = 1
		spawn(50) // Some delay
			busy = 0
		switch(action)
			if("weed")
				flick("farmbot_hoe", src)
				do_attack_animation(A)
				if(prob(50))
					visible_message(SPAN_DANGER("[src] swings wildly at [A] with a minihoe, missing completely!"))
					return
				var/t = pick("slashed", "sliced", "cut", "clawed")
				A.attack_generic(src, 5, t)
			if("water")
				flick("farmbot_water", src)
				visible_message(SPAN_DANGER("[src] splashes [A] with water!"))
				tank.reagents.splash(A, 100)

/mob/living/bot/farmbot/explode()
	visible_message(SPAN_DANGER("[src] blows apart!"))
	var/turf/Tsec = get_turf(src)

	new /obj/item/material/minihoe(Tsec)
	new /obj/item/reagent_containers/glass/bucket(Tsec)
	new /obj/item/device/assembly/prox_sensor(Tsec)
	new /obj/item/device/scanner/plant(Tsec)

	if(tank)
		tank.forceMove(Tsec)

	if(prob(50))
		new /obj/item/robot_parts/l_arm(Tsec)

	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(3, 1, src)
	s.start()
	qdel(src)
	return

/mob/living/bot/farmbot/confirmTarget(atom/targ)
	if(!..())
		return 0

	if(emagged && ishuman(targ))
		if(targ in view(world.view, src))
			return 1
		return 0

	if(istype(targ, /obj/structure/hygiene/sink))
		if(!tank || tank.reagents.total_volume >= tank.reagents.maximum_volume)
			return 0
		return 1

	var/obj/machinery/portable_atmospherics/hydroponics/tray = targ
	if(!istype(tray))
		return 0

	if(tray.closed_system || !tray.seed)
		return 0

	if(tray.dead && removes_dead || tray.harvest && collects_produce)
		return FARMBOT_COLLECT

	else if(refills_water && tray.waterlevel < 40 && !tray.reagents.has_reagent(/datum/reagent/water))
		return FARMBOT_WATER

	else if(uproots_weeds && tray.weedlevel > 3)
		return FARMBOT_UPROOT

	else if(replaces_nutriment && tray.nutrilevel < 1 && tray.reagents.total_volume < 1)
		return FARMBOT_NUTRIMENT

	return 0
