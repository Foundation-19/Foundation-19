//Meant to handle stages of transitions or effects on mobs instead of humans having like 8 vars defined just for SCPs
/datum/stageHandler
	var/list/stages

/datum/stageHandler/New()
	. = ..()
	LAZYINITLIST(stages)

///Creates a new stage to track
/datum/stageHandler/proc/createStage(stageID)
	if(stages[stageID] == null)
		stages[stageID] = 0
		return 1
	return 0

///Returns value of a stage
/datum/stageHandler/proc/getStage(stageID)
	if(stages[stageID] == null)
		createStage(stageID)
	return stages[stageID]

///Adjusts a stage
/datum/stageHandler/proc/adjustStage(stageID, adjustment)
	if(!isnum(adjustment))
		return 0
	if(!stages[stageID])
		createStage(stageID)
	if(stages[stageID] + adjustment <= 0)
		stages[stageID] = 0
		return 1
	stages[stageID] += adjustment
	return 1

///Sets a stage
/datum/stageHandler/proc/setStage(stageID, setAmount)
	if(!isnum(setAmount))
		return 0
	if(!stages[stageID])
		createStage(stageID)
	if(setAmount < 0)
		stages[stageID] = 0
		return 1
	stages[stageID] = setAmount
	return 1
