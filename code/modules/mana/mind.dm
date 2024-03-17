/datum/mind
	var/datum/mana/mana = /datum/mana

/datum/mind/New()
	. = ..()
	if(ispath(mana))
		mana = new mana()

/datum/mind/Destroy()
	QDEL_NULL(mana)
	. = ..()
