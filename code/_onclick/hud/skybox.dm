var/global/const/SKYBOX_DIMENSION = 736 // Largest measurement for icon sides, used for offsets/scaling
/obj/skybox
	name = "skybox"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	anchored = TRUE
	simulated = FALSE
	screen_loc = "CENTER,CENTER"
	plane = SKYBOX_PLANE
	blend_mode = BLEND_MULTIPLY
	var/static/max_view_dim
	var/static/const/parallax_bleed_percent = 0.2 // 20% parallax offset when going from x=1 to x=max

/client
	var/obj/skybox/skybox

/client/proc/set_skybox_offsets(x_dim, y_dim)
	if(!skybox)
		update_skybox(TRUE)
		return
	var/scale_value = 1
	if(isnum(view))
		var/target_icon_size = (view * 2 + 1) * world.icon_size
		scale_value = skybox.parallax_bleed_percent + max((target_icon_size / SKYBOX_DIMENSION), 1)
		skybox.screen_loc = "CENTER:-[view * world.icon_size],CENTER:-[view * world.icon_size]"
	else
		var/target_icon_size = max(x_dim, y_dim) * world.icon_size
		scale_value = skybox.parallax_bleed_percent + max((target_icon_size / SKYBOX_DIMENSION), 1)
		skybox.screen_loc = "CENTER:-[round(SKYBOX_DIMENSION * scale_value / 2)],CENTER:-[round(SKYBOX_DIMENSION * scale_value / 2)]"

	skybox.transform = matrix(x_dim / 15, 0, 0, 0, y_dim / 15, 0)
	update_skybox()

/client/proc/update_skybox(rebuild)
	var/turf/T = get_turf(eye)
	if(!T)
		return

	if(!skybox)
		skybox = new()
		screen += skybox
		rebuild = TRUE

	if(rebuild)
		skybox.overlays.Cut()
		var/image/I = SSskybox.get_skybox(T.z)
		skybox.overlays += I
		screen |= skybox

		var/view_size = getviewsize(view)
		set_skybox_offsets(view_size[1], view_size[2])
		return

	if(skybox.parallax_bleed_percent > 0)
		var/matrix/M = matrix()
		var/view_size = getviewsize(view)
		var/x_translate = -((T.x/world.maxx)-0.5) * skybox.parallax_bleed_percent * SKYBOX_DIMENSION
		var/y_translate = -((T.y/world.maxy)-0.5) * skybox.parallax_bleed_percent * SKYBOX_DIMENSION
		M.Translate(x_translate, y_translate)
		M.Scale(view_size[1] / 15, view_size[2] / 15)
		skybox.transform = M

/mob/Login()
	..()
	client.update_skybox(TRUE)

/mob/Move()
	var/old_z = get_z(src)
	. = ..()
	if(. && client)
		client.update_skybox(old_z != get_z(src))

/mob/forceMove()
	var/old_z = get_z(src)
	. = ..()
	if(. && client)
		client.update_skybox(old_z != get_z(src))
