/datum/grab/plague_doctor/aggressive
	state_name = GRAB_PLAGUE_DOCTOR_AGGRESSIVE
	fancy_desc = "holding"

	downgrab_name = GRAB_PLAGUE_DOCTOR_PASSIVE

	shift = 8
	grab_slowdown = 5

	stop_move = 1
	point_blank_mult = 2
	restrains = 1
	can_throw = 1

	icon_state = "reinforce1"

	break_chance_table = list(10, 15, 20, 25)

/datum/grab/plague_doctor/aggressive/on_hit_grab(obj/item/grab/normal/G)
	return AttemptCure(G)

/datum/grab/plague_doctor/aggressive/on_hit_harm(obj/item/grab/normal/G)
	return AttemptCure(G)

/datum/grab/plague_doctor/aggressive/upgrade(obj/item/grab/G)
	return AttemptCure(G)
