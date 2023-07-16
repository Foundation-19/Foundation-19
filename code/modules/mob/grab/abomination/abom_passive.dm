/datum/grab/abomination/passive
	state_name = GRAB_ABOMINATION_PASSIVE
	fancy_desc = "holding"

	upgrab_name = GRAB_ABOMINATION_AGGRESSIVE

	shift = 8

	point_blank_mult = 1.1

	icon_state = "reinforce"

	break_chance_table = list(15, 30, 50, 75, 100)

/datum/grab/abomination/passive/on_hit_grab(obj/item/grab/normal/G)
	to_chat(G.assailant, SPAN_WARNING("Your grip isn't strong enough to crush."))
	return FALSE

/datum/grab/abomination/passive/on_hit_harm(obj/item/grab/normal/G)
	to_chat(G.assailant, SPAN_WARNING("Your grip isn't strong enough to devour."))
	return FALSE