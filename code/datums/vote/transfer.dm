#define CHOICE_TRANSFER "Initiate crew transfer"
#define CHOICE_EXTEND "Extend the round ([config.vote_autotransfer_interval / 600] minutes)"

/datum/vote/transfer
	name = "Transfer"
	override_question = "End the shift?"
	default_choices = list(CHOICE_TRANSFER)

/datum/vote/transfer/create_vote(mob/vote_creator)
	.=..()
	choices += CHOICE_EXTEND

/datum/vote/transfer/toggle_votable(mob/toggler)
	if(!toggler)
		CRASH("[type] wasn't passed a \"toggler\" mob to toggle_votable.")
	if(!check_rights(R_ADMIN, TRUE, toggler.client))
		return FALSE

	config.allow_vote_restart = !config.allow_vote_restart
	return TRUE

/datum/vote/transfer/is_config_enabled()
	return config.allow_vote_restart

/datum/vote/transfer/can_be_initiated(mob/by_who, forced)
	. = ..()
	if(!.)
		return FALSE
	if(!evacuation_controller || !evacuation_controller.should_call_autotransfer_vote())
		if(by_who)
			to_chat(by_who, SPAN_WARNING("Evacuation controller is not ready yet!"))
		return FALSE
	if(!forced && !config.allow_vote_restart)
		if(by_who)
			to_chat(by_who, SPAN_WARNING("Transfer voting is disabled."))
		return FALSE // Admins and autovotes bypass the config setting.
	if(check_rights(R_ADMIN|R_MOD, FALSE, by_who) || forced)
		return //Mods bypass further checks.
	var/decl/security_state/security_state = decls_repository.get_decl(GLOB.using_map.security_state)
	if(security_state.current_security_level_is_same_or_higher_than(security_state.high_security_level))
		if(by_who)
			to_chat(by_who, SPAN_WARNING("The current alert status is too high to call for a crew transfer!"))
		return FALSE
	if(GAME_STATE <= RUNLEVEL_SETUP)
		if(by_who)
			to_chat(by_who, SPAN_WARNING("The crew transfer button has been disabled!"))
		return FALSE

/datum/vote/transfer/get_vote_result(list/non_voters)
	if(!config.vote_no_default)
		choices[CHOICE_EXTEND] += length(non_voters)
	var/factor = 0.5
	switch(world.time / (1 MINUTE))
		if(0 to 60)
			factor = 0.5
		if(61 to 120)
			factor = 0.8
		if(121 to 240)
			factor = 1
		if(241 to 300)
			factor = 1.2
		else
			factor = 1.4
	choices[CHOICE_TRANSFER] = round(choices[CHOICE_TRANSFER] * factor)
	to_world(FONT_COLORED("purple","Transfer Vote Multiplier: [factor]"))

	return ..()

/datum/vote/transfer/finalize_vote(winning_option)
	switch(winning_option)
		if(CHOICE_TRANSFER)
			init_autotransfer()

#undef CHOICE_TRANSFER
#undef CHOICE_EXTEND
