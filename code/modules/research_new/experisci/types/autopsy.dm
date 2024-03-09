/datum/experiment/autopsy
	name = "Autopsy Experiment"
	description = "An experiment requiring a autopsy surgery to progress"
	exp_tag = "Autopsy"
	performance_hint = "Perform a autopsy surgery while connected to an operating computer."

/datum/experiment/autopsy/is_complete()
	return completed

/datum/experiment/autopsy/perform_experiment_actions(datum/component/experiment_handler/experiment_handler, mob/target)
	if (is_valid_autopsy(target))
		completed = TRUE
		return TRUE
	else
		return FALSE
