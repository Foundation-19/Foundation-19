/datum/player_action/delimb
	action_tag = "mob_delimb"
	name = "Delimb"
	permissions_required = R_VAREDIT

/datum/player_action/delimb/act(var/client/user, var/mob/target, var/list/params)
	if(!params["limbs"] || !ishuman(target))
		return

	var/mob/living/carbon/human/H = target

	for(var/limb in params["limbs"])
		if(!limb)
			continue

		if(!H.has_organ(limb))
			continue

		var/obj/item/organ/external/L = H.get_organ(limb)
		L.droplimb()

	playsound(target, "bone_break", 45, TRUE)
	target.emote("scream")

	return TRUE

/datum/player_action/relimb
	action_tag = "mob_relimb"
	name = "Relimb"
	permissions_required = R_VAREDIT

/datum/player_action/relimb/act(var/client/user, var/mob/target, var/list/params)
	if(!params["limbs"] || !ishuman(target))
		return

	var/mob/living/carbon/human/H = target

	// These will always be last, because they get appended after.
	for(var/limb in params["limbs"])
		switch(limb)
			if("r_leg")
				params["limbs"] += "r_foot"
			if("l_leg")
				params["limbs"] += "l_foot"
			if("r_arm")
				params["limbs"] += "r_hand"
			if("l_arm")
				params["limbs"] += "l_hand"

	for(var/limb in params["limbs"])
		if(!limb)
			continue

		if(H.has_organ(limb))
			continue

		var/obj/item/organ/external/L = H.get_organ(limb)

		L.rejuvenate()

	to_chat(target, SPAN_NOTICE("You feel your limbs regrow back."))

	return TRUE

/datum/player_action/set_speed
	action_tag = "set_speed"
	name = "Set Speed"
	permissions_required = R_VAREDIT

/datum/player_action/set_speed/act(var/client/user, var/mob/target, var/list/params)
	if(isnull(params["speed"]))
		return

	target.move_speed = text2num(params["speed"])

	return TRUE

/datum/player_action/set_status_flags
	action_tag = "set_status_flags"
	name = "Set Status Flags"
	permissions_required = R_VAREDIT

/datum/player_action/set_status_flags/act(var/client/user, var/mob/target, var/list/params)
	if(isnull(params["status_flags"]))
		return

	target.status_flags = text2num(params["status_flags"])

	return TRUE
