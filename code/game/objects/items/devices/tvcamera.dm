/obj/item/device/camera/tvcamera
	name = "press camera drone"
	desc = "A Ward-Takahashi EyeBuddy livestreaming press camera drone. Weapon of choice for war correspondents and reality show cameramen. It does not appear to have any internal memory storage."
	icon_state = "camcorder"
	item_state = "camcorder"
	w_class = ITEM_SIZE_LARGE
	slot_flags = SLOT_BELT
	var/channel = "General News Feed"
	var/obj/machinery/camera/network/thunder/camera
	var/obj/item/device/radio/radio

/obj/item/device/camera/tvcamera/New()
	..()
	GLOB.listening_objects += src

/obj/item/device/camera/tvcamera/Destroy()
	GLOB.listening_objects -= src
	QDEL_NULL(camera)
	QDEL_NULL(radio)
	. = ..()

/obj/item/device/camera/tvcamera/Initialize()
	camera = new(src)
	camera.c_tag = channel
	camera.status = FALSE
	radio = new(src)
	radio.listening = FALSE
	radio.set_frequency(ENT_FREQ)
	radio.power_usage = 0
	. = ..()

/obj/item/device/camera/tvcamera/examine(mob/user)
	. = ..()
	to_chat(user, "Video feed is currently: [camera.status ? "Online" : "Offline"]")
	to_chat(user, "Audio feed is currently: [radio.broadcasting ? "Online" : "Offline"]")
	to_chat(user, "Photography setting is currently: [on ? "On" : "Off"]")

/obj/item/device/camera/tvcamera/attack_self(mob/user)
	add_fingerprint(user)
	tgui_interact(user)

/obj/item/device/camera/tvcamera/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "TVCamera", "EyeBuddy")
		ui.open()

/obj/item/device/camera/tvcamera/tgui_data(mob/user)
	var/list/data = list()
	data["on"] = on
	data["focus"] = size
	data["channel"] = channel ? channel : "unidentified broadcast"
	data["video"] = camera.status
	data["sound"] = radio.broadcasting
	data["frequency"] = format_frequency(radio.frequency)
	data["frequency_name"] = get_frequency_default_name(radio.frequency)
	return data

/obj/item/device/camera/tvcamera/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	switch(action)
		if("photo")
			on = !on
			return TRUE
		if("focus")
			change_size()
			return TRUE
		if("channel")
			var/nc = sanitize(input(usr, "Channel name", "Select new channel name", channel) as text|null)
			if(nc)
				channel = nc
				camera.c_tag = channel
				to_chat(usr, SPAN_NOTICE("New channel name: '[channel]' has been set."))
			return TRUE
		if("video")
			camera.set_status(!camera.status)
			if(camera.status)
				to_chat(usr,SPAN_NOTICE("Video streaming: Activated. Broadcasting on channel: '[channel]'"))
			else
				to_chat(usr,SPAN_NOTICE("Video streaming: Deactivated."))
			update_icon()
			return TRUE
		if("sound")
			radio.ToggleBroadcast()
			if(radio.broadcasting)
				to_chat(usr,SPAN_NOTICE("Audio streaming: Activated. Broadcasting on frequency: [format_frequency(radio.frequency)]."))
			else
				to_chat(usr,SPAN_NOTICE("Audio streaming: Deactivated."))
			return TRUE
	return FALSE

/obj/item/device/camera/tvcamera/on_update_icon()
	..()
	if(camera.status)
		icon_state = "camcorder_on"
		item_state = "camcorder_on"
	else
		icon_state = "camcorder"
		item_state = "camcorder"
	var/mob/living/carbon/human/H = loc
	if(istype(H))
		H.update_inv_r_hand(0)
		H.update_inv_l_hand()

/* Assembly by a roboticist */
/obj/item/robot_parts/head/attackby(obj/item/device/assembly/S, mob/user as mob)
	if ((!istype(S, /obj/item/device/assembly/infra)))
		..()
		return
	var/obj/item/TVAssembly/A = new(user)
	qdel(S)
	user.put_in_hands(A)
	to_chat(user, SPAN_NOTICE("You add the infrared sensor to the robot head."))
	qdel(src)

/* Using camcorder icon as I can't sprite.
Using robohead because of restricting to roboticist */
/obj/item/TVAssembly
	name = "TV Camera assembly"
	desc = "A robotic head with an infrared sensor inside."
	icon = 'icons/obj/robot_parts.dmi'
	icon_state = "head"
	item_state = "head"
	var/buildstep = 0
	w_class = ITEM_SIZE_LARGE

/obj/item/TVAssembly/attackby(obj/item/W, mob/user)
	switch(buildstep)
		if(0)
			if(istype(W, /obj/item/robot_parts/robot_component/camera))
				to_chat(user, SPAN_NOTICE("You add the camera module to [src]"))
				qdel(W)
				desc = "This TV camera assembly has a camera module."
				buildstep++
		if(1)
			if(istype(W, /obj/item/device/taperecorder))
				qdel(W)
				buildstep++
				to_chat(user, SPAN_NOTICE("You add the tape recorder to [src]"))
				desc = "This TV camera assembly has a camera and audio module."
				return
		if(2)
			if(isCoil(W))
				var/obj/item/stack/cable_coil/C = W
				if(!C.use(3))
					to_chat(user, SPAN_NOTICE("You need three cable coils to wire the devices."))
					..()
					return
				buildstep++
				to_chat(user, SPAN_NOTICE("You wire the assembly"))
				desc = "This TV camera assembly has wires sticking out."
				return
		if(3)
			if(isWirecutter(W))
				to_chat(user, SPAN_NOTICE(" You trim the wires."))
				buildstep++
				desc = "This TV camera assembly needs casing."
				return
		if(4)
			if(istype(W, /obj/item/stack/material/steel))
				var/obj/item/stack/material/steel/S = W
				if(S.use(1))
					buildstep++
					to_chat(user, SPAN_NOTICE("You encase the assembly."))
					var/turf/T = get_turf(src)
					new /obj/item/device/camera/tvcamera(T)
					qdel(src)
					return
	..()
