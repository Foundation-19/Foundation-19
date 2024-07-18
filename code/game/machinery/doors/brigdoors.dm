#define CHARS_PER_LINE 5
#define FONT_SIZE "5pt"
#define FONT_COLOR "#09f"
#define FONT_STYLE "Small Fonts"

///////////////////////////////////////////////////////////////////////////////////////////////
// Brig Door control displays.
//  Description: This is a controls the timer for the brig doors, displays the timer on itself and
//               has a popup window when used, allowing to set the timer.
//  Code Notes: Combination of old brigdoor.dm code from rev4407 and the status_display.dm code
//  Date: 01/September/2010
//  Programmer: Veryinky
/////////////////////////////////////////////////////////////////////////////////////////////////
/obj/machinery/door_timer
	name = "Door Timer"
	icon = 'icons/obj/status_display.dmi'
	icon_state = "frame"
	desc = "A remote control for a door."
	req_access = list(ACCESS_SECURITY_LVL2)
	anchored = TRUE    		// can't pick it up
	density = FALSE       		// can walk through it.
	var/id = null     		// id of door it controls.
	var/timing = FALSE    		// boolean, true/1 timer is on, false/0 means it's not timing
	var/picture_state		// icon_state of alert picture, if not displaying text/numbers
	var/list/obj/machinery/door/window/brigdoor/doors = list() // list of weakrefs to nearby doors
	var/list/obj/machinery/flasher/flashers = list() // list of weakrefs to nearby flashers
	var/list/obj/structure/closet/secure_closet/brig/closets = list() // list of weakrefs to nearby closets

	// Time from activation_time before releasing.
	var/timer_duration  = 0
	// world.time at timer start.
	var/activation_time = 0
	// Can we currently use the flashers?
	var/can_flash = TRUE
	// Have we logged an over-limit timer at least once during this timer?
	var/have_logged = FALSE

	maptext_height = 26
	maptext_width = 32
	maptext_y = -1

/obj/machinery/door_timer/Initialize()
	..()
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/door_timer/LateInitialize()
	if(id)
		for(var/obj/machinery/door/window/brigdoor/M in urange(20, src))
			if (M.id == src.id)
				doors += weakref(M)

		for(var/obj/machinery/flasher/F in urange(20, src))
			if(F.id_tag == src.id)
				flashers += weakref(F)

		for(var/obj/structure/closet/secure_closet/brig/C in urange(20, src))
			if(C.id == src.id)
				closets += weakref(C)

	if(!id || (!length(doors) && !length(flashers) && !length(closets)))
		set_broken(TRUE)
	queue_icon_update()

//Main door timer loop, if it's timing and time is >0 reduce time by 1.
// if it's less than 0, open door, reset timer
// update the door_timer window and the icon
/obj/machinery/door_timer/Process()
	if(!timing) return PROCESS_KILL
	if(stat & (NOPOWER|BROKEN))	return PROCESS_KILL

	if(world.time - activation_time >= timer_duration)
		timer_end() // open doors, reset timer, clear status screen, broadcast to sec HUDs

	src.update_icon()


// open/closedoor checks if door_timer has power, if so it checks if the
// linked door is open/closed (by density) then opens it/closes it.

// Closes and locks doors, power check
/obj/machinery/door_timer/proc/timer_start()
	if(stat & (NOPOWER|BROKEN))	return 0


	activation_time = world.time
	timing = TRUE
	START_PROCESSING_MACHINE(src, MACHINERY_PROCESS_SELF)

	for(var/weakref/door_ref as anything in doors)
		var/obj/machinery/door/window/brigdoor/door = door_ref.resolve()
		if(!door)
			doors -= door_ref
			continue
		if(!door.density)
			continue
		INVOKE_ASYNC(door, TYPE_PROC_REF(/obj/machinery/door/window/brigdoor, close))

	for(var/weakref/closet_ref as anything in closets)
		var/obj/structure/closet/secure_closet/brig/closet = closet_ref.resolve()
		if(!closet)
			closets -= closet_ref
			continue
		if(closet.broken)
			continue
		if(closet.opened)
			continue
		closet.locked = TRUE
		closet.queue_icon_update()

	return 1


// Opens and unlocks doors, power check
/obj/machinery/door_timer/proc/timer_end()
	if(stat & (NOPOWER|BROKEN))	return 0

	//reset timing
	timing = FALSE
	activation_time = 0
	have_logged = FALSE
	broadcast_security_hud_message("The timer for [id] has expired.", src)
	STOP_PROCESSING_MACHINE(src, MACHINERY_PROCESS_SELF)

	for(var/weakref/door_ref as anything in doors)
		var/obj/machinery/door/window/brigdoor/door = door_ref.resolve()
		if(!door)
			doors -= door_ref
			continue
		if(!door.density)
			continue
		INVOKE_ASYNC(door, TYPE_PROC_REF(/obj/machinery/door/window/brigdoor, open))

	for(var/weakref/closet_ref as anything in closets)
		var/obj/structure/closet/secure_closet/brig/closet = closet_ref.resolve()
		if(!closet)
			closets -= closet_ref
			continue
		if(closet.broken)
			continue
		if(closet.opened)
			continue
		closet.locked = FALSE
		closet.queue_icon_update()

	return 1


// Check for time left from timer_duration
/obj/machinery/door_timer/proc/timeleft()
	return max(timer_duration - (world.time - activation_time), 0) / 10

/obj/machinery/door_timer/interface_interact(mob/user)
	ui_interact(user)
	return TRUE

/obj/machinery/door_timer/ui_interact(mob/user, ui_key = "main", datum/nanoui/ui = null, force_open = 1)
	var/list/data = list()

	var/timeval = timing ? timeleft() : timer_duration / 10
	data["timing"] = timing
	data["minutes"] = round(timeval/60)
	data["seconds"] = timeval % 60

	var/can_flash = TRUE
	for(var/weakref/flash_ref as anything in flashers)
		var/obj/machinery/flasher/flasher = flash_ref.resolve()
		if(!flasher)
			flashers -= flash_ref
			continue
		if(flasher.last_flash && (flasher.last_flash + 15 SECONDS) > world.time)
			can_flash = FALSE
			break
	src.can_flash = can_flash
	data["flash"] = can_flash

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "brig_timer.tmpl", name, 270, 150)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(1)

/obj/machinery/door_timer/CanUseTopic(user, state)
	if(!allowed(user))
		return STATUS_UPDATE
	return ..()

/obj/machinery/door_timer/OnTopic(mob/user, list/href_list, state)
	if (href_list["toggle"])
		if(timing)
			timer_end()
		else
			timer_start()
			if(timer_duration > 20 MINUTES)
				log_and_message_staff("has started a brig timer over 20 minutes in length!")
				have_logged = TRUE
		. =  TOPIC_REFRESH

	if (href_list["flash"])
		. =  TOPIC_REFRESH
		if(!can_flash)
			return

		for(var/weakref/flash_ref as anything in flashers)
			var/obj/machinery/flasher/flasher = flash_ref.resolve()
			if(!flasher)
				flashers -= flash_ref
				continue
			flasher.flash()

	if (href_list["adjust"])
		. = TOPIC_REFRESH
		if(timing)
			return
		timer_duration += text2num(href_list["adjust"])
		timer_duration = Clamp(timer_duration, 0, 30 MINUTES)

	update_icon()


//icon update function
// if NOPOWER, display blank
// if BROKEN, display blue screen of death icon AI uses
// if timing=true, run update display function
/obj/machinery/door_timer/on_update_icon()
	if(stat & (NOPOWER))
		icon_state = "frame"
		return
	if(stat & (BROKEN))
		set_picture("ai_bsod")
		return
	if(src.timing)
		var/disp1 = name
		var/timeleft = timeleft()
		var/disp2 = "[add_zero(num2text((timeleft / 60) % 60),2)]:[add_zero(num2text(timeleft % 60), 2)]"
		if(length(disp2) > CHARS_PER_LINE)
			disp2 = "Error"
		update_display(disp1, disp2)
	else
		if(maptext)
			maptext = ""
		update_display("Set","Time") // would be nice to have some default printed text
	return


// Adds an icon in case the screen is broken/off, stolen from status_display.dm
/obj/machinery/door_timer/proc/set_picture(state)
	picture_state = state
	cut_overlays()
	add_overlay(image('icons/obj/status_display.dmi', icon_state=picture_state))


//Checks to see if there's 1 line or 2, adds text-icons-numbers/letters over display
// Stolen from status_display
/obj/machinery/door_timer/proc/update_display(line1, line2)
	line1 = uppertext(line1)
	line2 = uppertext(line2)
	var/new_text = {"<div style="font-size:[FONT_SIZE];color:[FONT_COLOR];font:'[FONT_STYLE]';text-align:center;" valign="top">[line1]<br>[line2]</div>"}
	if(maptext != new_text)
		maptext = new_text


//Actual string input to icon display for loop, with 5 pixel x offsets for each letter.
//Stolen from status_display
/obj/machinery/door_timer/proc/texticon(tn, px = 0, py = 0)
	var/image/I = image('icons/obj/status_display.dmi', "blank")
	var/len = length(tn)

	for(var/d = 1 to len)
		var/char = copytext(tn, len-d+1, len-d+2)
		if(char == " ")
			continue
		var/image/ID = image('icons/obj/status_display.dmi', icon_state=char)
		ID.pixel_x = -(d-1)*5 + px
		ID.pixel_y = py
		I.add_overlay(ID)
	return I

#undef FONT_SIZE
#undef FONT_COLOR
#undef FONT_STYLE
#undef CHARS_PER_LINE
