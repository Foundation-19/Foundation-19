// Begin psi armour toggle.
/atom/movable/screen/psi/armour
	name = "Psi-Armour"
	icon_state = "psiarmour_off"

/atom/movable/screen/psi/armour/on_update_icon()
	..()
	if(invisibility == 0)
		icon_state = owner.psi.use_psi_armour ? "psiarmour_on" : "psiarmour_off"

/atom/movable/screen/psi/armour/Click()
	if(!owner.psi)
		return
	owner.psi.use_psi_armour = !owner.psi.use_psi_armour
	if(owner.psi.use_psi_armour)
		to_chat(owner, SPAN_NOTICE("You will now use your psionics to deflect or block incoming attacks."))
	else
		to_chat(owner, SPAN_NOTICE("You will no longer use your psionics to deflect or block incoming attacks."))
	update_icon()

// End psi armour toggle.

// Menu toggle.
/atom/movable/screen/psi/toggle_psi_menu
	name = "Show/Hide Psi UI"
	icon_state = "arrow_left"
	var/atom/movable/screen/psi/hub/controller

/atom/movable/screen/psi/toggle_psi_menu/New(mob/living/_owner, atom/movable/screen/psi/hub/_controller)
	controller = _controller
	..(_owner)

/atom/movable/screen/psi/toggle_psi_menu/Click()
	var/set_hidden = !hidden
	for(var/thing in controller.components)
		var/atom/movable/screen/psi/psi = thing
		psi.hidden = set_hidden
	controller.update_icon()

/atom/movable/screen/psi/toggle_psi_menu/on_update_icon()
	if(hidden)
		icon_state = "arrow_left"
	else
		icon_state = "arrow_right"
// End menu toggle.
