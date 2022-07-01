/obj/item/storage/pill_bottle/amnesticsa
	name = "bottle of pills"
	icon_state = "pill_canister_a"
	desc = "Class A Amnestics."

/obj/item/storage/pill_bottle/amnesticsa/New()
	..()
	new /obj/item/reagent_containers/pill/amnestics/classa( src )
	new /obj/item/reagent_containers/pill/amnestics/classa( src )
	new /obj/item/reagent_containers/pill/amnestics/classa( src )
	new /obj/item/reagent_containers/pill/amnestics/classa( src )
	new /obj/item/reagent_containers/pill/amnestics/classa( src )
	new /obj/item/reagent_containers/pill/amnestics/classa( src )
	new /obj/item/reagent_containers/pill/amnestics/classa( src )

/obj/item/storage/pill_bottle/amnesticsb
	name = "bottle of pills"
	icon_state = "pill_canister_b"
	desc = "Class B Amnestics."

/obj/item/storage/pill_bottle/amnesticsb/New()
	..()
	new /obj/item/reagent_containers/pill/amnestics/classb( src )
	new /obj/item/reagent_containers/pill/amnestics/classb( src )
	new /obj/item/reagent_containers/pill/amnestics/classb( src )
	new /obj/item/reagent_containers/pill/amnestics/classb( src )
	new /obj/item/reagent_containers/pill/amnestics/classb( src )
	new /obj/item/reagent_containers/pill/amnestics/classb( src )
	new /obj/item/reagent_containers/pill/amnestics/classb( src )

/obj/item/storage/pill_bottle/amnesticsc
	name = "bottle of pills"
	icon_state = "pill_canister_c"
	desc = "Class C Amnestics."

/obj/item/storage/pill_bottle/amnesticsc/New()
	..()
	new /obj/item/reagent_containers/pill/amnestics/classc( src )
	new /obj/item/reagent_containers/pill/amnestics/classc( src )
	new /obj/item/reagent_containers/pill/amnestics/classc( src )
	new /obj/item/reagent_containers/pill/amnestics/classc( src )
	new /obj/item/reagent_containers/pill/amnestics/classc( src )
	new /obj/item/reagent_containers/pill/amnestics/classc( src )
	new /obj/item/reagent_containers/pill/amnestics/classc( src )

/* PILLS Foundation 19*/

/obj/item/reagent_containers/pill/amnestics/classa
	name = "Amnestics_A (1u)"
	desc = "Removes all memory up until the last experiment."
	icon_state = "pill4"
/obj/item/reagent_containers/pill/amnestics/classa/New()
	..()
	reagents.add_reagent(/datum/reagent/amnestics/classa, 1)
	color = reagents.get_color()

/obj/item/reagent_containers/pill/amnestics/classb
	name = "Amnestics_B (1u)"
	desc = "Removes all memory up until the subject woke up."
	icon_state = "pill4"
/obj/item/reagent_containers/pill/amnestics/classb/New()
	..()
	reagents.add_reagent(/datum/reagent/amnestics/classb, 1)
	color = reagents.get_color()

/obj/item/reagent_containers/pill/amnestics/classc
	name = "Amnestics_C (1u)"
	desc = "Removes all memory up until the subject arrived at the foundation."
	icon_state = "pill4"
/obj/item/reagent_containers/pill/amnestics/classc/New()
	..()
	reagents.add_reagent(/datum/reagent/amnestics/classc, 1)
	color = reagents.get_color()

/obj/item/reagent_containers/pill/amnestics/classe
	name = "Amnestics_E (1u)"
	desc = "Removes all memories and personality, turning the subject into a blank slate to mold."
	icon_state = "pill4"
/obj/item/reagent_containers/pill/amnestics/classe/New()
	..()
	reagents.add_reagent(/datum/reagent/amnestics/classe, 1)
	color = reagents.get_color()

/* Reagents For Amnestics*/

/datum/reagent/amnestics
	name = "Amnestics"
	description = "Amnestics are applied to remove memories from a target, often to different degrees."
	taste_description = "something you forgot about already"
	reagent_state = LIQUID
	color = "#000000"


/datum/reagent/amnestics/classa
	name = "Class-A Amnestics"
	taste_description = "something you forgot about already"


/datum/reagent/amnestics/classa/on_mob_life(mob/living/M)
	to_chat(M, "<span class='notice'>You feel your memory drifting away...</span>")
	to_chat(M, "<span class='boldannounce'>You have lost all memory up until the point before the last experiment (if any) you were involved in began. You must roleplay accordingly.</span>")
	M.visible_message("<span class='warning'>[M] looks confused for a moment.</span>")
	playsound(src,'sound/misc/nymphchirp.ogg',3,3)
	holder.remove_reagent(/datum/reagent/amnestics/classa, volume)

/datum/reagent/amnestics/classb
	name = "Class-B Amnestics"
	color = "#00D9D9"
	taste_description = "something you forgot about already"

/datum/reagent/amnestics/classb/on_mob_life(mob/living/M)
	to_chat(M, "<span class='notice'>Your brain feels slightly emptier...</span>")
	to_chat(M, "<span class='boldannounce'>You have lost all memory up until the point when the round began and you woke up. You must roleplay accordingly.</span>")
	M.visible_message("<span class='warning'>[M] looks a little dumber.</span>")
	playsound(src,'sound/misc/nymphchirp.ogg',3,3)
	holder.remove_reagent(/datum/reagent/amnestics/classb, volume)

/datum/reagent/amnestics/classc
	name = "Class-C Amnestics"
	color = "#cd7f32"
	taste_description = "something you forgot about already"

/datum/reagent/amnestics/classc/on_mob_life(mob/living/M)
	to_chat(M, "<span class='notice'>Memories are ripped out of your head!</span>")
	to_chat(M, "<span class='boldannounce'>You have lost all memory up until the point when you arrived at the foundation, and have no idea how you got here. You must roleplay accordingly.</span>")
	M.visible_message("<span class='warning'>[M] looks like they've suddenly gotten lost.</span>")
	playsound(src,'sound/misc/nymphchirp.ogg',3,3)
	holder.remove_reagent(/datum/reagent/amnestics/classc, volume)

/datum/reagent/amnestics/classd
	name = "Class-D Amnestics"
	color = "#708238"
	taste_description = "something you forgot about already"

/datum/reagent/amnestics/classd/on_mob_life(mob/living/M)
	to_chat(M, "<span class='notice'>Memories are ripped out of your head!</span>")
	to_chat(M, "<span class='boldannounce'>You have lost all memory up until the point when you arrived at the foundation, and have no idea how you got here. You must roleplay accordingly.</span>")
	M.visible_message("<span class='warning'>[M] looks like they've suddenly gotten lost.</span>")
	playsound(src,'sound/misc/nymphchirp.ogg',3,3)
	holder.remove_reagent(/datum/reagent/amnestics/classd, volume)

/datum/reagent/amnestics/classe
	name = "Class-E Amnestics"
	color = "#fa8072"
	taste_description = "something you forgot about already"

/datum/reagent/amnestics/classe/on_mob_life(mob/living/M)
	to_chat(M, "<span class='notice'>Who... Am... I?</span>")
	to_chat(M, "<span class='boldannounce'>You have lost every memory you hold dear and every aspect of your identity has been torn away to be re-modelled like clay. You must roleplay accordingly.</span>")
	M.visible_message("<span class='warning'>[M] falls completely still for a moment, before raising their head with a cold, dull look in their eyes.</span>")
	playsound(src,'sound/misc/nymphchirp.ogg',3,3)
	holder.remove_reagent(/datum/reagent/amnestics/classe, volume)
