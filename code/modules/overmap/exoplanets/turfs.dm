/turf/simulated/floor/exoplanet
	name = "space land"
	icon = 'icons/turf/desert.dmi'
	icon_state = "desert"
	has_resources = 1
	footstep_type = /decl/footsteps/asteroid
	var/diggable = 1
	var/dirt_color = "#7c5e42"

/turf/simulated/floor/exoplanet/can_engrave()
	return FALSE

/turf/simulated/floor/exoplanet/New()
	if(GLOB.using_map.use_overmap)
		var/obj/effect/overmap/visitable/sector/exoplanet/E = map_sectors["[z]"]
		if(istype(E))
			if(E.atmosphere)
				initial_gas = E.atmosphere.gas.Copy()
				temperature = E.atmosphere.temperature
			else
				initial_gas = list()
				temperature = T0C
			//Must be done here, as light data is not fully carried over by ChangeTurf (but overlays are).
			set_light(E.lightlevel, 0.1, 2)
			if(E.planetary_area && istype(loc, world.area))
				ChangeArea(src, E.planetary_area)
	..()

/turf/simulated/floor/exoplanet/attackby(obj/item/C, mob/user)
	if(diggable && istype(C,/obj/item/shovel))
		visible_message(SPAN_NOTICE("\The [user] starts digging \the [src]"))
		if(do_after(user, 6 SECONDS, bonus_percentage = 25))
			to_chat(user,SPAN_NOTICE("You dig a deep pit."))
			new /obj/structure/pit(src)
			diggable = 0
		else
			to_chat(user,SPAN_NOTICE("You stop shoveling."))
	else if(istype(C, /obj/item/stack/tile))
		var/obj/item/stack/tile/T = C
		if(T.use(1))
			playsound(src, 'sound/items/Deconstruct.ogg', 80, 1)
			ChangeTurf(/turf/simulated/floor, FALSE, FALSE, TRUE)
	else if (isCrowbar(C) || isWelder(C) || istype(C, /obj/item/gun/energy/plasmacutter))
		return
	else
		..()

/turf/simulated/floor/exoplanet/ex_act(severity)
	switch(severity)
		if(1)
			ChangeTurf(get_base_turf_by_area(src))
		if(2)
			if(prob(40))
				ChangeTurf(get_base_turf_by_area(src))

/turf/simulated/floor/exoplanet/Initialize()
	. = ..()
	update_icon(1)

/turf/simulated/floor/exoplanet/on_update_icon(update_neighbors)
	cut_overlays()
	if(LAZYLEN(decals))
		add_overlay(decals)
	for(var/direction in GLOB.cardinal)
		var/turf/turf_to_check = get_step(src,direction)
		if(!istype(turf_to_check, type))
			var/image/rock_side = image(icon, "edge[pick(0,1,2)]", dir = turn(direction, 180))
			rock_side.plating_decal_layerise()
			switch(direction)
				if(NORTH)
					rock_side.pixel_y += world.icon_size
				if(SOUTH)
					rock_side.pixel_y -= world.icon_size
				if(EAST)
					rock_side.pixel_x += world.icon_size
				if(WEST)
					rock_side.pixel_x -= world.icon_size
			add_overlay(rock_side)
		else if(update_neighbors)
			turf_to_check.update_icon()

//WAter
/turf/simulated/floor/exoplanet/water/on_update_icon()
	return

/turf/simulated/floor/exoplanet/water/is_flooded(lying_mob, absolute)
	. = absolute ? ..() : lying_mob

/turf/simulated/floor/exoplanet/water/shallow
	name = "shallow water"
	icon = 'icons/misc/beach.dmi'
	icon_state = "seashallow"
	movement_delay = 2
	footstep_type = /decl/footsteps/water
	var/reagent_type = /datum/reagent/water

/turf/simulated/floor/exoplanet/water/shallow/attackby(obj/item/O, mob/living/user)
	var/obj/item/reagent_containers/RG = O
	if (reagent_type && istype(RG) && RG.is_open_container() && RG.reagents)
		RG.reagents.add_reagent(reagent_type, min(RG.volume - RG.reagents.total_volume, RG.amount_per_transfer_from_this))
		user.visible_message(SPAN_NOTICE("[user] fills \the [RG] from \the [src]."),SPAN_NOTICE("You fill \the [RG] from \the [src]."))
	else
		return ..()

/turf/simulated/floor/exoplanet/water/update_dirt()
	return	// Water doesn't become dirty

//Ice
/turf/simulated/floor/exoplanet/ice
	name = "ice"
	icon = 'icons/turf/snow.dmi'
	icon_state = "ice"

/turf/simulated/floor/exoplanet/ice/on_update_icon()
	return

//Snow
/turf/simulated/floor/exoplanet/snow
	name = "snow"
	icon = 'icons/turf/snow.dmi'
	icon_state = "snow"
	dirt_color = "#e3e7e8"
	footstep_type = /decl/footsteps/snow

/turf/simulated/floor/exoplanet/snow/Initialize()
	. = ..()
	icon_state = pick("snow[rand(1,12)]","snow0")

/turf/simulated/floor/exoplanet/snow/fire_act(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	melt()

/turf/simulated/floor/exoplanet/snow/melt()
	SetName("permafrost")
	icon_state = "permafrost"
	footstep_type = /decl/footsteps/asteroid

//Grass
/turf/simulated/floor/exoplanet/grass
	name = "grass"
	icon = 'icons/turf/jungle.dmi'
	icon_state = "greygrass"
	color = "#799c4b"
	footstep_type = /decl/footsteps/grass

/turf/simulated/floor/exoplanet/grass/Initialize()
	. = ..()
	if(GLOB.using_map.use_overmap)
		var/obj/effect/overmap/visitable/sector/exoplanet/E = map_sectors["[z]"]
		if(istype(E) && E.grass_color)
			color = E.grass_color
	if(!resources)
		resources = list()
	if(prob(70))
		resources[MATERIAL_GRAPHITE] = rand(3,5)
	if(prob(5))
		resources[MATERIAL_URANIUM] = rand(1,3)
	if(prob(2))
		resources[MATERIAL_DIAMOND] = 1

/turf/simulated/floor/exoplanet/grass/fire_act(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if((temperature > T0C + 200 && prob(5)) || temperature > T0C + 1000)
		melt()

/turf/simulated/floor/exoplanet/grass/melt()
	SetName("scorched ground")
	icon_state = "scorched"
	footstep_type = /decl/footsteps/asteroid
	color = null

//Sand
/turf/simulated/floor/exoplanet/desert
	name = "sand"
	desc = "It's coarse and gets everywhere."
	dirt_color = "#ae9e66"
	footstep_type = /decl/footsteps/sand

/turf/simulated/floor/exoplanet/desert/Initialize()
	. = ..()
	icon_state = "desert[rand(0,5)]"

/turf/simulated/floor/exoplanet/desert/fire_act(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if((temperature > T0C + 1700 && prob(5)) || temperature > T0C + 3000)
		melt()

/turf/simulated/floor/exoplanet/desert/melt()
	SetName("molten silica")
	desc = "A glassed patch of sand."
	icon_state = "sandglass"
	diggable = 0

//Concrete
/turf/simulated/floor/exoplanet/concrete
	name = "concrete"
	desc = "Stone-like artificial material."
	icon = 'icons/turf/flooring/misc.dmi'
	icon_state = "concrete"

/turf/simulated/floor/exoplanet/concrete/on_update_icon()
	cut_overlays()
	if(burnt)
		add_overlay(get_damage_overlay("burned[(x + y) % 3]", BLEND_MULTIPLY))
	if(broken)
		add_overlay(get_damage_overlay("broken[(x + y) % 5]", BLEND_MULTIPLY))

/turf/simulated/floor/exoplanet/concrete/melt()
	burnt = TRUE
	update_icon()

// Flesh
/turf/simulated/floor/exoplanet/flesh
	name = "flesh"
	icon = 'icons/turf/flooring/flesh.dmi'
	icon_state = "flesh0"
	color = "#94404e"
	footstep_type = /decl/footsteps/blank

/turf/simulated/floor/exoplanet/flesh/Initialize()
	. = ..()
	icon_state = "flesh[pick(0,1,2,3)]"

/turf/simulated/floor/exoplanet/flesh/fire_act(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if((temperature > T0C + 200 && prob(5)) || temperature > T0C + 1000)
		melt()

/turf/simulated/floor/exoplanet/flesh/melt()
	SetName("scorched flesh")
	footstep_type = /decl/footsteps/asteroid
	color = "#70353a"

//Special world edge turf

/turf/simulated/planet_edge
	name = "world's edge"
	desc = "Government didn't want you to see this!"
	density = TRUE
	blocks_air = TRUE
	dynamic_lighting = FALSE
	icon = null
	icon_state = null

/turf/simulated/planet_edge/Initialize()
	. = ..()
	var/obj/effect/overmap/visitable/sector/exoplanet/E = map_sectors["[z]"]
	if(!istype(E))
		return
	var/nx = x
	if (x <= TRANSITIONEDGE)
		nx = x + (E.maxx - 2*TRANSITIONEDGE) - 1
	else if (x >= (E.maxx - TRANSITIONEDGE))
		nx = x - (E.maxx  - 2*TRANSITIONEDGE) + 1

	var/ny = y
	if(y <= TRANSITIONEDGE)
		ny = y + (E.maxy - 2*TRANSITIONEDGE) - 1
	else if (y >= (E.maxy - TRANSITIONEDGE))
		ny = y - (E.maxy - 2*TRANSITIONEDGE) + 1

	var/turf/NT = locate(nx, ny, z)
	if(NT)
		vis_contents = list(NT)

	//Need to put a mouse-opaque overlay there to prevent people turning/shooting towards ACTUAL location of vis_content things
	var/obj/effect/overlay/O = new(src)
	O.mouse_opacity = MOUSE_OPACITY_OPAQUE
	O.name = "distant terrain"
	O.desc = "You need to come over there to take a better look."

/turf/simulated/planet_edge/Bumped(atom/movable/A)
	. = ..()
	var/obj/effect/overmap/visitable/sector/exoplanet/E = map_sectors["[z]"]
	if(!istype(E))
		return
	if(E.planetary_area && istype(loc, world.area))
		ChangeArea(src, E.planetary_area)
	var/new_x = A.x
	var/new_y = A.y
	if(x <= TRANSITIONEDGE)
		new_x = E.maxx - TRANSITIONEDGE - 1
	else if (x >= (E.maxx - TRANSITIONEDGE))
		new_x = TRANSITIONEDGE + 1
	else if (y <= TRANSITIONEDGE)
		new_y = E.maxy - TRANSITIONEDGE - 1
	else if (y >= (E.maxy - TRANSITIONEDGE))
		new_y = TRANSITIONEDGE + 1

	var/turf/T = locate(new_x, new_y, A.z)
	if(T && !T.density)
		A.forceMove(T)
		if(isliving(A))
			var/mob/living/L = A
			if(L.pulling)
				var/atom/movable/AM = L.pulling
				AM.forceMove(T)
