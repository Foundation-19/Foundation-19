/area/wizard_den_away
	icon = 'maps/away/wizard_den/wizard_den_areas.dmi'

/area/wizard_den_away/outdoors
	name = "\improper Wilderness"
	icon_state = "out"

/area/wizard_den_away/level_1
	name = "\improper Wizard Den Main Hall"
	icon_state = "one"
	requires_power = FALSE
	/// List with ckeys and cooldown for the area blurb
	var/list/area_blurb = list()

/area/wizard_den_away/level_1/Entered(atom/A)
	if(!istype(A, /mob/living))
		return

	var/mob/living/L = A
	if(!L.ckey || !L.client)
		return

	if(area_blurb[L.ckey] > world.time)
		return

	if(isnull(L.lastarea) || istype(L.lastarea, type))
		return

	show_blurb(L.client, 3 SECONDS, name)
	area_blurb[L.ckey] = world.time + 600 SECONDS
	return ..()

/area/wizard_den_away/level_2
	name = "\improper Wizard Den Basement"
	icon_state = "two"
	requires_power = FALSE

/area/wizard_den_away/level_3
	name = "\improper Wizard Den Catacombs"
	icon_state = "three"
	requires_power = FALSE
