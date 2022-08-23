#define CHOICE_RESTART "Restart Round"
#define CHOICE_CONTINUE "Continue Playing"

/datum/vote/restart
	name = "Restart"
	default_choices = list(
		CHOICE_RESTART,
		CHOICE_CONTINUE,
	)

/datum/vote/restart/toggle_votable(mob/toggler)
	if(!toggler)
		CRASH("[type] wasn't passed a \"toggler\" mob to toggle_votable.")
	if(!check_rights(R_ADMIN, TRUE, toggler.client))
		return FALSE

	config.allow_vote_restart = !config.allow_vote_restart
	return TRUE

/datum/vote/restart/is_config_enabled()
	return config.allow_vote_restart

/datum/vote/restart/can_be_initiated(mob/by_who, forced)
	. = ..()
	if(!.)
		return FALSE

	if(!forced && !config.allow_vote_restart)
		if(by_who)
			to_chat(by_who, SPAN_WARNING("Restart voting is disabled."))
		return FALSE

	return TRUE

/datum/vote/restart/get_vote_result(list/non_voters)
	if(!config.vote_no_default)
		// Default no votes will add non-voters to "Continue Playing"
		choices[CHOICE_CONTINUE] += length(non_voters)

	return ..()

/datum/vote/restart/finalize_vote(winning_option)
	if(winning_option == CHOICE_CONTINUE)
		return

	if(winning_option == CHOICE_RESTART)
		to_chat(world, SPAN_BOLD(FONT_LARGE("Restart vote successful")))
		world.Reboot("Restart vote successful")
		return

	CRASH("[type] wasn't passed a valid winning choice. (Got: [winning_option || "null"])")

#undef CHOICE_RESTART
#undef CHOICE_CONTINUE
