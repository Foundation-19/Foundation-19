/datum/antagonist/informant
	id = MODE_DCLASS
	antaghud_indicator = "hud_informant"
	whitelisted_jobs = list(/datum/job/classd)
	flags = ANTAG_RANDSPAWN | ANTAG_VOTABLE

/datum/antagonist/informant/create_objectives(datum/mind/informant_mind)
	if(!..())
		return

	var/datum/objective/survive/survive_objective = new
	survive_objective.owner = trader_mind
	trader_mind.objectives += survive_objective
