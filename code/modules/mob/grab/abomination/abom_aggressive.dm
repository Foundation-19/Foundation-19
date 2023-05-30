/datum/grab/abomination/aggressive
	state_name = GRAB_ABOMINATION_AGGRESSIVE
	upgrab_name = GRAB_ABOMINATION_KILL

	shift = 12

	point_blank_mult = 1.5
	can_throw = 1
	stop_move = 1

	icon_state = "reinforce1"

	break_chance_table = list(5, 10, 25, 50, 75, 100)

/datum/grab/abomination/aggressive/process_effect(obj/item/grab/G)
	var/mob/living/carbon/human/target = G.affecting

	if(G.target_zone in list(BP_L_HAND, BP_R_HAND))
		target.drop_l_hand()
		target.drop_r_hand()

	// Keeps those who are on the ground down
	if(target.lying)
		target.Weaken(4)
