// Transformation to a mob type
/datum/disease/transformation
	name = "Transformation"
	max_stages = 5
	spread_text = "Acute"
	spread_flags = DISEASE_SPREAD_SPECIAL
	cure_text = "Nothing."
	agent = "Shenanigans"
	viable_mobtypes = list(/mob/living/carbon/human)
	severity = DISEASE_SEVERITY_BIOHAZARD
	stage_prob = 10
	disease_flags = CURABLE

	var/list/stage1 = list("You feel unremarkable.")
	var/list/stage2 = list("You feel boring.")
	var/list/stage3 = list("You feel utterly plain.")
	var/list/stage4 = list("You feel white bread.")
	var/list/stage5 = list("Oh the humanity!")
	var/list/new_form = list(/mob/living/carbon/human)

/datum/disease/transformation/Copy()
	var/datum/disease/transformation/D = ..()
	D.stage1 = stage1.Copy()
	D.stage2 = stage2.Copy()
	D.stage3 = stage3.Copy()
	D.stage4 = stage4.Copy()
	D.stage5 = stage5.Copy()
	D.new_form = D.new_form
	return D

/datum/disease/transformation/StageAct()
	. = ..()
	if(!.)
		return

	switch(stage)
		if(1)
			if(stage1 && prob(stage_prob))
				to_chat(affected_mob, pick(stage1))
		if(2)
			if(stage2 && prob(stage_prob))
				to_chat(affected_mob, pick(stage2))
		if(3)
			if(stage3 && prob(stage_prob * 2))
				to_chat(affected_mob, pick(stage3))
		if(4)
			if(stage4 && prob(stage_prob * 2))
				to_chat(affected_mob, pick(stage4))
		if(5)
			do_disease_transformation(affected_mob)


/datum/disease/transformation/proc/do_disease_transformation(mob/living/affected_mob)
	if(istype(affected_mob, /mob/living/carbon) && affected_mob.stat != DEAD)
		if(QDELETED(affected_mob))
			return
		if(stage5)
			to_chat(affected_mob, pick(stage5))
		for(var/obj/item/W in affected_mob.get_equipped_items(TRUE))
			affected_mob.drop_from_inventory(W, get_turf(affected_mob))
		affected_mob.drop_l_hand(get_turf(affected_mob))
		affected_mob.drop_r_hand(get_turf(affected_mob))
		var/new_type = pick(new_form)
		var/mob/living/new_mob = new new_type(affected_mob.loc)
		if(istype(new_mob))
			if(affected_mob.mind)
				affected_mob.mind.transfer_to(new_mob)
			else
				new_mob.key = affected_mob.key
		new_mob.name = affected_mob.real_name
		new_mob.real_name = new_mob.name
		qdel(affected_mob)

/* Subtypes */
// Infestation
/datum/disease/transformation/infestation
	name = "Befall"
	max_stages = 5
	spread_text = "Blood"
	spread_flags = DISEASE_SPREAD_BLOOD
	cure_text = "Grauel."
	cures = list(/datum/reagent/grauel)
	agent = "Unknown"
	stage_prob = 5

	stage1 = list("Something isn't right...")
	stage2 = list("Your skin is turning red.")
	stage3 = list("You feel your innards moving around.")
	stage4 = list("Your insides hurt!")
	stage5 = list("MY LIFE FOR THE HIVE!")
	new_form = list(
		/mob/living/simple_animal/hostile/infestation/broodling,
		/mob/living/simple_animal/hostile/infestation/eviscerator,
		/mob/living/simple_animal/hostile/infestation/assembler,
		)
