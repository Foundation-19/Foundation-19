GLOBAL_DATUM_INIT(gangsters, /datum/antagonist/gangster, new)

/datum/antagonist/gangster
	id = MODE_DCLASS
	antaghud_indicator = "hud_gangster"
	whitelisted_jobs = list(/datum/job/classd)
	flags = ANTAG_RANDSPAWN | ANTAG_VOTABLE

/datum/antagonist/gangster/create_objectives(datum/mind/gangster_mind)
	if(!..())
		return
