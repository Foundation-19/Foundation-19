/obj/structure/scp151
	name = "painting"
	desc = "A painting depicting a rising wave."
	icon = 'icons/obj/structures.dmi'

	icon_state = "great_wave"
	anchored = TRUE
	density = TRUE

	//Config

	///How much oxygen damage we do per tick
	var/oxy_damage = 1.5
	///Message cooldown
	var/message_cooldown = 15 SECONDS
	///How much water is ingested per tick
	var/water_ingest = 2

/obj/structure/scp151/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"painting", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_SAFE, //Obj Class
		"151", //Numerical Designation
		SCP_MEMETIC
	)

	SCP.memeticFlags = MVISUAL|MPERSISTENT|MSYNCED
	SCP.memetic_proc = TYPE_PROC_REF(/obj/structure/scp151, effect)
	SCP.compInit()

	START_PROCESSING(SSobj, src)

/obj/structure/scp151/Process()
	SCP.meme_comp.check_viewers()
	SCP.meme_comp.activate_memetic_effects()

// Mechanics

/obj/structure/scp151/proc/effect(mob/living/carbon/human/H)
	H.apply_damage(oxy_damage, OXY)

	var/obj/item/organ/internal/lungs/breathe_organ = H.internal_organs_by_name[H.species.breathing_organ]
	var/obj/item/organ/internal/stomach/stomach_organ = H.internal_organs_by_name[BP_STOMACH]

	stomach_organ.ingested.add_reagent(/datum/reagent/water, water_ingest)

	if((breathe_organ.get_oxygen_deprivation() > 10))
		if(stomach_organ.ingested.get_free_space() <= 5)
			H.vomit()
		else if(prob(breathe_organ.get_oxygen_deprivation() + 15))
			H.emote("cough")
	else if(prob(10) && ((world.time - H.humanStageHandler.getStage("151_message_cooldown")) > message_cooldown))
		to_chat(H, SPAN_NOTICE(pick("The taste of seawater permeates your mouth...", "Your lungs feel like they are filling with water...")))
		H.humanStageHandler.setStage("151_message_cooldown", world.time)

	if(prob(breathe_organ.get_oxygen_deprivation() + 30) && (breathe_organ.get_oxygen_deprivation() > 25) && ((world.time - H.humanStageHandler.getStage("151_message_cooldown")) > message_cooldown))
		to_chat(H, SPAN_WARNING(pick("Your lungs feel like they are filled with water!", "You try to breath but your lungs are filled with water!", "You cannot breath!")))
		H.humanStageHandler.setStage("151_message_cooldown", world.time)
