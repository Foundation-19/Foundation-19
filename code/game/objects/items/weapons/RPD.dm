GLOBAL_LIST_INIT(rpd_pipe_selection, list(
	new /datum/pipe/pipe_dispenser/simple() = list(
		new /datum/pipe/pipe_dispenser/simple/straight(),
		new /datum/pipe/pipe_dispenser/simple/bent(),
		new /datum/pipe/pipe_dispenser/simple/manifold(),
		new /datum/pipe/pipe_dispenser/simple/manifold4w(),
		new /datum/pipe/pipe_dispenser/simple/cap()),
	new /datum/pipe/pipe_dispenser/supply() = list(
		new /datum/pipe/pipe_dispenser/supply/straight(),
		new /datum/pipe/pipe_dispenser/supply/bent(),
		new /datum/pipe/pipe_dispenser/supply/manifold(),
		new /datum/pipe/pipe_dispenser/supply/manifold4w(),
		new /datum/pipe/pipe_dispenser/supply/cap()),
	new /datum/pipe/pipe_dispenser/scrubber() = list(
		new /datum/pipe/pipe_dispenser/scrubber/straight(),
		new /datum/pipe/pipe_dispenser/scrubber/bent(),
		new /datum/pipe/pipe_dispenser/scrubber/manifold(),
		new /datum/pipe/pipe_dispenser/scrubber/manifold4w(),
		new /datum/pipe/pipe_dispenser/scrubber/cap()),
	))

GLOBAL_LIST_INIT(rpd_pipe_selection_skilled, list(
	new /datum/pipe/pipe_dispenser/simple() = list(
		new /datum/pipe/pipe_dispenser/simple/straight(),
		new /datum/pipe/pipe_dispenser/simple/bent(),
		new /datum/pipe/pipe_dispenser/simple/manifold(),
		new /datum/pipe/pipe_dispenser/simple/manifold4w(),
		new /datum/pipe/pipe_dispenser/simple/cap(),
		new /datum/pipe/pipe_dispenser/simple/up(),
		new /datum/pipe/pipe_dispenser/simple/down()
		),
	new /datum/pipe/pipe_dispenser/supply() = list(
		new /datum/pipe/pipe_dispenser/supply/straight(),
		new /datum/pipe/pipe_dispenser/supply/bent(),
		new /datum/pipe/pipe_dispenser/supply/manifold(),
		new /datum/pipe/pipe_dispenser/supply/manifold4w(),
		new /datum/pipe/pipe_dispenser/supply/cap(),
		new /datum/pipe/pipe_dispenser/supply/up(),
		new /datum/pipe/pipe_dispenser/supply/down()
		),
	new /datum/pipe/pipe_dispenser/scrubber() = list(
		new /datum/pipe/pipe_dispenser/scrubber/straight(),
		new /datum/pipe/pipe_dispenser/scrubber/bent(),
		new /datum/pipe/pipe_dispenser/scrubber/manifold(),
		new /datum/pipe/pipe_dispenser/scrubber/manifold4w(),
		new /datum/pipe/pipe_dispenser/scrubber/cap(),
		new /datum/pipe/pipe_dispenser/scrubber/up(),
		new /datum/pipe/pipe_dispenser/scrubber/down()
		),
	new /datum/pipe/pipe_dispenser/fuel() = list(
		new /datum/pipe/pipe_dispenser/fuel/straight(),
		new /datum/pipe/pipe_dispenser/fuel/bent(),
		new /datum/pipe/pipe_dispenser/fuel/manifold(),
		new /datum/pipe/pipe_dispenser/fuel/manifold4w(),
		new /datum/pipe/pipe_dispenser/fuel/cap(),
		new /datum/pipe/pipe_dispenser/fuel/up(),
		new /datum/pipe/pipe_dispenser/fuel/down()
		),
	new /datum/pipe/pipe_dispenser/device() = list(
		new /datum/pipe/pipe_dispenser/device/universaladapter(),
		new /datum/pipe/pipe_dispenser/device/gaspump(),
		new /datum/pipe/pipe_dispenser/device/manualvalve()
		)
	))

/obj/item/rpd
	name = "rapid piping device"
	desc = "Portable, complex and deceptively heavy, it's the cousin of the RCD, use to dispense piping on the move."
	icon = 'icons/obj/tools.dmi'//Needs proper icon
	icon_state = "rpd"
	force = 12
	throwforce = 15
	throw_speed = 1
	throw_range = 3
	w_class = ITEM_SIZE_NORMAL
	origin_tech = list(TECH_ENGINEERING = 5, TECH_MATERIAL = 4)

	var/datum/effect/effect/system/spark_spread/spark_system
	var/datum/pipe/P
	var/pipe_color = "white"

/obj/item/rpd/Initialize()
	. = ..()
	spark_system = new /datum/effect/effect/system/spark_spread
	spark_system.set_up(5, 0, src)
	spark_system.attach(src)
	var/list/L = GLOB.rpd_pipe_selection[GLOB.rpd_pipe_selection[1]]
	P = L[1]
	//if there's no pipe selected randomize it

/obj/item/rpd/Destroy()
	QDEL_NULL(spark_system)
	return ..()

/obj/item/rpd/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "RPD", src.name)
		ui.open()

/obj/item/rpd/tgui_data(mob/user)
	var/list/data = list()
	var/list/pipe_categories = user.skill_check(SKILL_ATMOS, SKILL_EXPERIENCED) ? GLOB.rpd_pipe_selection_skilled : GLOB.rpd_pipe_selection
	var/list/categories = list()
	for(var/category in pipe_categories)
		var/datum/pipe/cat = category
		var/list/pipe_list = list()
		for(var/datum/pipe/pipe in pipe_categories[category])
			pipe_list += list(list(
				"name" = pipe.name,
				"ref" = REF(pipe),
				"selected" = (P.type == pipe.type)))
		categories += list(list(
			"name" = initial(cat.category),
			"pipes" = pipe_list))
	data["categories"] = categories
	data["pipe_color"] = pipe_color
	var/list/colors = list()
	for(var/color in pipe_colors)
		colors += color
	data["colors"] = colors
	return data

/obj/item/rpd/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	switch(action)
		if("set_buildtype")
			var/datum/pipe/new_pipe = locate(params["pipe"])
			if(!istype(new_pipe))
				return TRUE
			P = new_pipe
			playsound(src.loc, 'sounds/machines/click.ogg', 50, 1)
			SStgui.update_uis(src)
			if(prob(10)) src.spark_system.start()
			return TRUE
		if("set_color")
			var/choice = params["color"]
			if(!(choice in pipe_colors))
				return TRUE
			pipe_color = choice
			SStgui.update_uis(src)
			return TRUE
	return FALSE

/obj/item/rpd/afterattack(atom/A, mob/user, proximity)
	if(!proximity) return
	if(istype(A, /obj/item/pipe))
		recycle(A,user)
	else
		if(user.skill_fail_prob(SKILL_ATMOS, 80, SKILL_TRAINED))
			var/C = pick(GLOB.rpd_pipe_selection)
			P = pick(GLOB.rpd_pipe_selection[C])
			user.visible_message(SPAN_WARNING("[user] cluelessly fumbles with \the [src]."))
		var/turf/T = get_turf(A)
		if(!T.Adjacent(src.loc)) return		//checks so it can't pipe through window and such

		playsound(get_turf(user), 'sounds/machines/click.ogg', 50, 1)
		if(T.is_wall())	//pipe through walls!
			if(!do_after(user, 4 SECONDS, T, bonus_percentage = 25))
				return
			playsound(get_turf(user), 'sounds/items/Deconstruct.ogg', 50, 1)

		P.Build(P, T, pipe_colors[pipe_color])
		if(prob(20)) src.spark_system.start()

/obj/item/rpd/examine(mob/user, distance)
	. = ..()
	if(distance <= 1)
		if(user.skill_check(SKILL_ATMOS,SKILL_BASIC))
			to_chat(user, "<span class='notice'>Current selection reads:</span> [P]")
		else
			to_chat(user, SPAN_WARNING("The readout is flashing some atmospheric jargon, you can't understand."))

/obj/item/rpd/attack_self(mob/user)
	tgui_interact(user)
	add_fingerprint(user)

/obj/item/rpd/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/pipe))
		if(!user.unEquip(W))
			return
		recycle(W,user)
		return
	..()

/obj/item/rpd/proc/recycle(obj/item/W,mob/user)
	if(!user.skill_check(SKILL_ATMOS,SKILL_BASIC))
		user.visible_message("[user] struggles with \the [src], as they futilely jam \the [W] against it")
		return
	playsound(src.loc, 'sounds/effects/pop.ogg', 50, 1)
	qdel(W)
