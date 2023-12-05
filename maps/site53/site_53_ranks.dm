/datum/map/site53
	branch_types = list(
		/datum/mil_branch/civilian
	)

	spawn_branch_types = list(
		/datum/mil_branch/civilian
	)


/*
 *  Branches
 *  ========
 */

/datum/mil_branch/civilian
	name = "Foundation Personnel"

	rank_types = list(
		/datum/mil_rank/civ/classa,
		/datum/mil_rank/civ/classb,
		/datum/mil_rank/civ/classc,
		/datum/mil_rank/civ/classd,
		/datum/mil_rank/civ/classe
	)

	spawn_rank_types = list(
		/datum/mil_rank/civ/classa,
		/datum/mil_rank/civ/classb,
		/datum/mil_rank/civ/classc,
		/datum/mil_rank/civ/classd
	)

/*
 *  Ranks
 *  =====
 */

/datum/mil_rank/civ/classa
	name = "Class-A"

/datum/mil_rank/civ/classb
	name = "Class-B"

/datum/mil_rank/civ/classc
	name = "Class-C"

/datum/mil_rank/civ/classd
	name = "Class-D"

/datum/mil_rank/civ/classe
	name = "Class-E"
