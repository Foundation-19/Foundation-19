/datum/player_action/dna
	action_tag = "dna_switch"
	name = "DNA"
	permissions_required = R_SPAWN

/datum/player_action/dna/act(client/user, mob/living/carbon/target, list/params)
	if(!istype(target) || !target.dna || !params["block_to_toggle"])
		return

	var/block = text2num(params["block_to_toggle"])
	if(!block)
		return
	user.cmd_admin_toggle_block(target, block)
	return TRUE
