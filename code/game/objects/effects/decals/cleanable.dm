/obj/effect/decal/cleanable
	density = FALSE
	anchored = TRUE
	waterproof = FALSE
	var/persistent = FALSE
	var/generic_filth = FALSE
	var/age = 0
	var/list/random_icon_states
	var/image/hud_overlay/hud_overlay

	var/cleanable_scent
	var/scent_intensity = /decl/scent_intensity/normal
	var/scent_descriptor = SCENT_DESC_SMELL
	var/scent_range = 2

/obj/effect/decal/cleanable/Initialize()
	. = ..()
	if(isspace(loc))
		return INITIALIZE_HINT_QDEL
	hud_overlay = new /image/hud_overlay('icons/obj/hud_tile.dmi', src, "caution")
	hud_overlay.plane = EFFECTS_ABOVE_LIGHTING_PLANE
	set_cleanable_scent()

/obj/effect/decal/cleanable/Initialize(ml, _age)
	if(!isnull(_age))
		age = _age
	if(random_icon_states && length(src.random_icon_states) > 0)
		src.icon_state = pick(src.random_icon_states)
	. = ..()

/obj/effect/decal/cleanable/Destroy()
	. = ..()

/obj/effect/decal/cleanable/water_act(depth)
	..()
	qdel(src)

/obj/effect/decal/cleanable/clean(clean_forensics = TRUE)
	if(clean_forensics)
		qdel(src)
		return TRUE
	return ..()

/obj/effect/decal/cleanable/proc/set_cleanable_scent()
	if(cleanable_scent)
		set_extension(src, /datum/extension/scent/custom, cleanable_scent, scent_intensity, scent_descriptor, scent_range)
