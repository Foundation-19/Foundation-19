/datum/status_effect/spasms
	id = "spasms"
	status_type = STATUS_EFFECT_MULTIPLE
	alert_type = null

/datum/status_effect/spasms/tick()
	if(owner.stat >= UNCONSCIOUS)
		return
	if(!prob(15))
		return
	switch(rand(1, 5))
		if(1)
			if(isturf(owner.loc))
				to_chat(owner, SPAN_WARNING("Your leg spasms!"))
				step(owner, pick(GLOB.cardinal))
		if(2)
			if(owner.incapacitated())
				return
			var/obj/item/held_item = owner.get_active_hand()
			if(!held_item)
				return
			to_chat(owner, SPAN_WARNING("Your fingers spasm!"))
			log_attack("[owner] used [held_item] due to a Muscle Spasm")
			held_item.attack_self(owner)
		if(3)
			owner.a_intent_change(I_HURT)

			var/range = 1
			if(istype(owner.get_active_hand(), /obj/item/gun)) //get targets to shoot at
				range = 7

			var/list/mob/living/targets = list()
			for(var/mob/living/nearby_mobs in oview(owner, range))
				targets += nearby_mobs
			if(LAZYLEN(targets))
				to_chat(owner, SPAN_WARNING("Your arm spasms!"))
				log_attack("[owner] attacked someone due to a Muscle Spasm") //the following attack will log itself
				owner.ClickOn(pick(targets))
			owner.a_intent_change(I_HELP)
		if(4)
			owner.a_intent_change(I_HURT)
			to_chat(owner, SPAN_WARNING("Your arm spasms!"))
			log_attack("[owner] attacked [owner.p_them()]self to a Muscle Spasm")
			owner.ClickOn(owner)
			owner.a_intent_change(I_HELP)
		if(5)
			if(owner.incapacitated())
				return
			var/obj/item/held_item = owner.get_active_hand()
			var/list/turf/targets = list()
			for(var/turf/nearby_turfs in oview(owner, 3))
				targets += nearby_turfs
			if(LAZYLEN(targets) && held_item)
				to_chat(owner, SPAN_WARNING("Your arm spasms!"))
				log_attack("[owner] threw [held_item] due to a Muscle Spasm")
				owner.throw_item(pick(targets))
