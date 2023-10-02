/mob/living/simple_animal/friendly/cat/fluff/scp529
	name = "mutilated cat"
	desc = "A friendly tabby cat that seems to be missing half of her body."
	icon = 'icons/SCP/scp-529.dmi'

	icon_state = "cat"
	item_state = "cat"
	icon_living = "cat"
	icon_dead = "cat_dead"

	turns_per_move = 5
	speak_emote = list("purrs", "meows", "chirps")

	response_help = "strokes"
	response_disarm = "gently pushes aside"
	response_harm = "kicks"

	minbodytemp = 223		//Below -50 Degrees Celsius
	maxbodytemp = 323	//Above 50 Degrees Celsius
	mob_size = MOB_SMALL
	gender = FEMALE
	see_invisible = SEE_INVISIBLE_NOLIGHTING
	see_in_dark = 7
	pass_flags = PASS_FLAG_TABLE
	density = FALSE

/mob/living/simple_animal/friendly/cat/fluff/scp529/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"mutilated cat", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_SAFE, //Obj Class
		"529" //Numerical Designation
	)
