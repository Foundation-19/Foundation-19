/datum/grab/normal/passive
	state_name = NORM_PASSIVE
	fancy_desc = "holding"

	upgrab_name = NORM_STRUGGLE

	shift = 8

	stop_move = 0
	reverse_facing = 0
	can_absorb = 0
	shield_assailant = 0
	point_blank_mult = 1.1
	same_tile = 0

	icon_state = "reinforce"

	break_chance_table = list(15, 60, 100)

/datum/grab/normal/passive/on_hit_disarm(obj/item/grab/normal/G)
	to_chat(G.assailant, SPAN_WARNING("Your grip isn't strong enough to pin."))
	return 0

/datum/grab/normal/passive/on_hit_grab(obj/item/grab/normal/G)
	to_chat(G.assailant, SPAN_WARNING("Your grip isn't strong enough to jointlock."))
	return 0

/datum/grab/normal/passive/on_hit_harm(obj/item/grab/normal/G)
	to_chat(G.assailant, SPAN_WARNING("Your grip isn't strong enough to dislocate."))
	return 0

/datum/grab/normal/passive/resolve_openhand_attack(obj/item/grab/G)
	return 0
