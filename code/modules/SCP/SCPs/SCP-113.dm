/obj/item/scp113
	name = "red piece of quartz"
	desc = "A red piece of quartz that gleams with unnatural smoothness."
	icon = 'icons/SCP/scp-113.dmi'

	icon_state = "scp113"
	force = 10.0
	throwforce = 10.0
	throw_range = 15
	throw_speed = 3

	var/list/victims = list()

/obj/item/scp113/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"red piece of quartz", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_SAFE, //Obj Class
		"113", //Numerical Designation
	)

//Mechanics

/obj/item/scp113/proc/effect(mob/living/carbon/human/user)
	if(loc != user)
		return

	user.humanStageHandler.adjustStage("113_effect", 1)

	switch(user.humanStageHandler.getStage("113_effect"))
		if(1)
			to_chat(user, SPAN_WARNING("The [src] begins to sear your hand, burning the skin on contact, and you feel yourself unable to drop it."))
			var/hand_used = user.hand ? BP_L_HAND : BP_R_HAND // determine hand to burn
			user.apply_damage(5, BURN, hand_used) //administer damage
			user.apply_damage(10, TOX, hand_used)
			canremove = 0
			addtimer(CALLBACK(src, PROC_REF(effect), user), 0.2 SECONDS)
		if(2)
			to_chat(user, SPAN_NOTICE("You feel a weird stinging sensation throughout your body."))
			if(prob(45))
				user.vomit()
			addtimer(CALLBACK(src, PROC_REF(effect), user), 20 SECONDS)
		if(3)
			to_chat(user, SPAN_WARNING("Bones begin to shift and grind inside of you, and every single one of your nerves seems like it's on fire."))
			user.visible_message(SPAN_NOTICE("\The [user] starts to scream and writhe in pain as their bone structure reforms."))
			addtimer(CALLBACK(src, PROC_REF(effect), user), 60 SECONDS)
		if(4)
			to_chat(user, SPAN_WARNING("The burning begins to fade, and you feel your hand relax it's grip on the [name]."))
			if(user.humanStageHandler.getStage("BlueLady"))
				if(user.gender == MALE)
					to_chat(user, SPAN_NOTICE("A vast sense of relief washes over you, as you feel your body reshape itself to be more like [SPAN_ITALIC("hers")]."))
				else
					to_chat(user, SPAN_WARNING("There's something you can't see, and it feels unbearably wrong. It's all wrong. You weren't ... she wasn't ... a man."))
			user.gender = (user.gender == MALE) ? FEMALE : MALE
			user.reset_hair()
			user.update_dna()
			user.update_body()
			canremove = 1
			user.humanStageHandler.adjustStage("113_conversions", 1)

//Overrides

/obj/item/scp113/pickup(mob/living/user)
	if(!ishuman(user))
		return ..()

	var/mob/living/carbon/human/H = user
	var/hand_covered = user.hand ? HAND_LEFT : HAND_RIGHT //determines which hand needs to be covered

	if(H.get_covered_body_parts() & hand_covered)
		return ..()

	if(H.humanStageHandler.getStage("113_conversions") >= 4)
		convertatom2type(H, /mob/living/simple_animal/hostile/meat/abomination)
		return

	if(H.humanStageHandler.getStage("113_conversions") >= 1)
		if(prob(5 * H.humanStageHandler.getStage("113_conversions")))
			H.gib()
			return
		if(prob(20 * H.humanStageHandler.getStage("113_conversions")))
			H.apply_damage(100, BRUTE, BP_GROIN)
			H.visible_message(SPAN_WARNING("[H]'s groin suddenly and violently explodes!"), SPAN_DANGER("You feel a horrible pain in your groin area!"))
			return

	H.humanStageHandler.setStage("113_effect", 0)
	effect(H)
