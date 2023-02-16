/mob/living/carbon/human
	var/zoomed = FALSE

/atom/CtrlRightClick(mob/living/carbon/human/user)
	if(!istype(user))
		return

	user.do_zoom(get_turf(src))

/mob/living/carbon/human/proc/do_zoom(turf/T)
	if(!zoomed)
		if(!isturf(src.loc))
			return
		if(stat)
			return

		var/turf/position = get_turf(src)
		var/delta_x = T.x - position.x
		var/delta_y = T.y - position.y

		if(abs(delta_x) > 7 || abs(delta_y) > 7)
			return
		if(delta_x == 0 && delta_y == 0)
			return

		face_atom(T)
		hide_cone()
		visible_message(SPAN_NOTICE("[src] peers into the distance."))
		animate(client, pixel_x = world.icon_size*delta_x, pixel_y = world.icon_size*delta_y, time = 2, easing = SINE_EASING)
		zoomed = TRUE
	else
		reset_zoom()

/mob/living/carbon/human/proc/reset_zoom()
	animate(client, pixel_x = 0, pixel_y = 0, time = 2, easing = SINE_EASING)
	show_cone()
	zoomed = FALSE
