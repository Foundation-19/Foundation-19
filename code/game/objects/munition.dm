/obj/structure/ship_munition
	name = "munitions"
	icon = 'icons/obj/munitions.dmi'
	w_class = ITEM_SIZE_GARGANTUAN
	density = TRUE

/obj/structure/ship_munition/Initialize()
	. = ..()
	set_extension(src, /datum/extension/play_sound_on_moved)

/obj/structure/ship_munition/md_slug
	name = "mass driver slug"
	icon_state = "slug"

/obj/structure/ship_munition/ap_slug
	name = "armor piercing mass driver slug"
	icon_state = "ap"
