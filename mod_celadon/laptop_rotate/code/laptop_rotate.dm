/obj/item/modular_computer
	var/icon_state_unpowered = null							// Icon state when the computer is turned off
	var/icon_state_menu = "mod_celadon/laptop_rotate/code/laptop_rotate.dmi/menu"							// Icon state overlay when the computer is turned on, but no program is loaded that would override the screen.
	var/icon_state_screensaver = "mod_celadon/laptop_rotate/code/laptop_rotate.dmi/standby"
	var/max_hardware_size = 0								// Maximal hardware size. Currently, tablets have 1, laptops 2 and consoles 3. Limits what hardware types can be installed.
	var/steel_sheet_cost = 5								// Amount of steel sheets refunded when disassembling an empty frame of this computer.
	var/light_strength = 0									// Intensity of light this computer emits. Comparable to numbers light fixtures use.
	var/list/idle_threads = list()

/obj/item/modular_computer/laptop
	anchored = TRUE
	name = "laptop computer"
	desc = "A portable computer."
	hardware_flag = PROGRAM_LAPTOP
	icon_state_unpowered = "laptop-open"
	icon = 'mod_celadon/laptop_rotate/code/laptop_rotate.dmi'
	icon_state = "laptop-open"
	icon_state_screensaver = "standby"
	base_idle_power_usage = 25
	base_active_power_usage = 200
	max_hardware_size = 2
	light_strength = 3
	max_damage = 200
	broken_damage = 100
	w_class = ITEM_SIZE_NORMAL
	var/icon_state_closed = "laptop-closed"
	interact_sounds = list(SFX_KEYBOARD, SFX_KEYSTROKE)
	interact_sound_volume = 20

/obj/item/modular_computer/laptop/AltClick(mob/living/carbon/user)
	// We need to be close to it to open it
	if((!in_range(src, user)) || user.stat || user.restrained())
		return
	// Prevents carrying of open laptops inhand.
	// While they work inhand, i feel it'd make tablets lose some of their high-mobility advantage they have over laptops now.
	if(!istype(loc, /turf/))
		to_chat(usr, "\The [src] has to be on a stable surface first!")
		return
	anchored = !anchored
	screen_on = anchored
	update_icon()

/obj/item/modular_computer/laptop/update_icon()
	if(anchored)
		..()
	else
		cut_overlays()
		set_light(0)		// No glow from closed laptops
		compile_overlays()
		icon_state = icon_state_closed

/obj/item/modular_computer/laptop/preset
	anchored = FALSE
	screen_on = FALSE

/obj/item/modular_computer/laptop/CtrlAltClick(mob/user)
	src.set_dir(turn(src.dir, -90))
