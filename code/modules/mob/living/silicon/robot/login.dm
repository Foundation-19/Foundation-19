/mob/living/silicon/robot/Login()
	..()
	regenerate_icons()
	update_hud()

	show_laws(0)

	// Forces synths to select an icon relevant to their module
	if(!icon_selected)
		choose_icon()

	if(hands)
		hands.icon_state = istype(module) ? lowertext(module.display_name) : "nomod"