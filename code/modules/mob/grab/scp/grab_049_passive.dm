/datum/grab/plague_doctor/passive
	state_name = GRAB_PLAGUE_DOCTOR_PASSIVE
	fancy_desc = "holding"

	upgrab_name = GRAB_PLAGUE_DOCTOR_AGGRESSIVE

	shift = 4
	grab_slowdown = 3

	point_blank_mult = 1.1

	icon_state = "reinforce"

	break_chance_table = list(20, 40, 60, 80, 100)

/datum/grab/plague_doctor/passive/on_hit_grab(obj/item/grab/normal/G)
	to_chat(G.assailant, SPAN_WARNING("Your grip isn't strong enough to cure them."))
	return FALSE

/datum/grab/plague_doctor/passive/on_hit_harm(obj/item/grab/normal/G)
	to_chat(G.assailant, SPAN_WARNING("Your grip isn't strong enough to devour."))
	return FALSE
