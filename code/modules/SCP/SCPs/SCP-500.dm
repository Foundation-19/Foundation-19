/obj/item/reagent_containers/pill/scp500
	name = "red pill"
	desc = "A strange red pill."
	icon_state = "pill9"

/obj/item/reagent_containers/pill/scp500/New()
	. = ..()
	SCP = new /datum/scp(
		src,
		"red pill",
		SCP_SAFE,
		"500"
	)

	reagents.add_reagent(/datum/reagent/scp500, 1)

/datum/reagent/scp500
	name = "SCP-500"
	description = "A strange liquid obtained from inside the pills of SCP-500. A universal panacea."
	taste_description = "vanilla"
	reagent_state = LIQUID
	color = "#f3eaf8"
	flags = AFFECTS_DEAD

	glass_name = "SCP-500"
	glass_desc = "A strange ethereal like liquid"

/datum/reagent/scp500/affect_blood(mob/living/carbon/M, alien, removed)
	if(M.chem_doses[type] >= 1)
		M.rejuvenate()
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			if(H.humanStageHandler.getStage("BlueLady"))
				H.cure_bluelady(3)
			if(H.humanStageHandler.getStage("513_victim"))
				H.cure_scp513()
			H.cure_scp151()
			var/datum/reagent/scp008/infection = H.reagents.get_reagent(/datum/reagent/scp008)
			if(infection)
				H.reagents.remove_reagent(/datum/reagent/scp008, infection.volume)
				H.visible_message(SPAN_NOTICE("[H]'s skin returns to a normal color as the infection recedes."))
			if(istype(H.species, /datum/species/scp049_1))
				var/orig_species = H.species.primitive_form || /datum/species/human
				H.set_species(orig_species)
				H.visible_message(SPAN_NOTICE("[H] returns to a normal appearance!"))
		remove_self(volume)

/obj/item/storage/pill_bottle/scp500
	name = "pill bottle (SCP-500)"
	desc = "This Pill Bottle has \'SCP-500\' written on its label. The label also notes, \'Storage of more than 10 instances of SCP-500 is limited to secure Sites only. Contact a RAISA official for more details.\'."
	max_storage_space = 10

	startswith = list(
		/obj/item/reagent_containers/pill/scp500 = 10
	)

	var/pills_remaining = 10

/obj/item/storage/pill_bottle/scp500/Initialize()
	. = ..()
	pills_remaining = contents.len

/obj/item/storage/pill_bottle/scp500/remove_from_storage(obj/item/W, atom/new_location, NoUpdate = 0)
	. = ..()
	pills_remaining = contents.len
	if(pills_remaining <= 3)
		for(var/mob/living/carbon/human/H in GLOB.human_mob_list)
			var/datum/job/job = SSjobs.get_by_title(H.job)
			if(job && (job.department_flag & (COM|MED|SCI)))
				to_chat(H, SPAN_WARNING("<b>Medical Alert:</b> SCP-500 supply critically low - [pills_remaining] pills remaining."))
