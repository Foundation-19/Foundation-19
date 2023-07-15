/obj/item/organ/internal/eyes/unathi
	name = "reptilian eyes"
	desc = "Eyes belonging to a big lizard. They seem to be staring right at you no matter where you look from."
	icon = 'icons/mob/human_races/species/unathi/organs.dmi'
	eye_icon = 'icons/mob/human_races/species/unathi/eyes.dmi'

/obj/item/organ/internal/brain/unathi
	can_use_mmi = FALSE

/obj/item/organ/internal/heart/unathi
	name = "separated heart"
	desc = "A heart separated into two organs, each with their own chambers. Both are much larger than your fist."

/obj/item/organ/internal/heart/unathi/listen()
	. = ..()
	if(!pulse || (owner.status_flags & FAKEDEATH))
		return .
	return "\proper two [.]s"
