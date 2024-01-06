/obj/effect/temp_visual/item_pickup_ghost
	duration = 0.2 SECONDS

// Ideally this would be set in Initialize, but since New can't directly accept named arguments it doesn't know exist, and the base version of Initialize has arguments of its own, this is the least headache-y way of doing it.
/obj/effect/temp_visual/item_pickup_ghost/proc/set_appearance_to(obj/item/picked_up)
	appearance = picked_up.appearance

/obj/effect/temp_visual/item_pickup_ghost/proc/animate_towards(atom/target)
	var/new_pixel_x = pixel_x + (target.x - src.x) * 32
	var/new_pixel_y = pixel_y + (target.y - src.y) * 32
	animate(src, pixel_x = new_pixel_x, pixel_y = new_pixel_y, transform = matrix()*0, time = duration)
