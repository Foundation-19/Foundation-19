/obj/effect/temp_visual/item_pickup_ghost
	duration = 0.2 SECONDS

/obj/effect/temp_visual/item_pickup_ghost/Initialize(mapload, set_dir, obj/item/picked_up)
	. =..()
	appearance = picked_up.appearance

/obj/effect/temp_visual/item_pickup_ghost/proc/animate_towards(atom/target)
	var/new_pixel_x = pixel_x + (target.x - src.x) * 32
	var/new_pixel_y = pixel_y + (target.y - src.y) * 32
	animate(src, pixel_x = new_pixel_x, pixel_y = new_pixel_y, transform = matrix()*0, time = duration)
