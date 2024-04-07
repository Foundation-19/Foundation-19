/obj/machinery/tele_projector
	name = "projector"
	desc = "This machine is capable of projecting a miniature wormhole leading directly to its provided target."
	icon = 'icons/obj/teleporter.dmi'
	icon_state = "station"
	density = TRUE
	anchored = TRUE
	idle_power_usage = 10
	active_power_usage = 2000

	var/obj/machinery/computer/teleporter/computer


/obj/machinery/tele_projector/Destroy()
	if (computer)
		computer.lost_projector()
	clear_computer()
	. = ..()


/obj/machinery/tele_projector/proc/clear_computer()
	if (!computer)
		return
	UnregisterSignal(computer, COMSIG_PARENT_QDELETING)
	computer = null


/obj/machinery/tele_projector/proc/lost_computer()
	clear_computer()
	queue_icon_update()


/obj/machinery/tele_projector/proc/set_computer(obj/machinery/computer/teleporter/_computer)
	if (computer == _computer)
		return
	clear_computer()
	computer = _computer
	RegisterSignal(computer, COMSIG_PARENT_QDELETING, TYPE_PROC_REF(/obj/machinery/tele_projector, lost_computer))


/obj/machinery/tele_projector/power_change()
	. = ..()
	if (!.)
		return
	queue_icon_update()


/obj/machinery/tele_projector/on_update_icon()
	cut_overlays()
	if (computer?.active)
		update_use_power(POWER_USE_ACTIVE)
		var/image/I = image(icon, src, "[initial(icon_state)]_active_overlay")
		I.plane = EFFECTS_ABOVE_LIGHTING_PLANE
		I.layer = ABOVE_LIGHTING_LAYER
		add_overlay(I)
	else
		update_use_power(POWER_USE_IDLE)
		if (operable())
			var/image/I = image(icon, src, "[initial(icon_state)]_idle_overlay")
			I.plane = EFFECTS_ABOVE_LIGHTING_PLANE
			I.layer = ABOVE_LIGHTING_LAYER
			add_overlay(I)
