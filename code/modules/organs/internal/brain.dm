/obj/item/organ/internal/brain
	name = "brain"
	desc = "A piece of juicy meat found in a person's head."
	organ_tag = BP_BRAIN
	parent_organ = BP_HEAD
	vital = 1
	icon_state = "brain2"
	force = 1.0
	w_class = ITEM_SIZE_SMALL
	throwforce = 1.0
	throw_speed = 3
	throw_range = 5
	origin_tech = list(TECH_BIO = 3)
	attack_verb = list("attacked", "slapped", "whacked")
	relative_size = 85
	damage_reduction = 0
	can_be_printed = FALSE

	var/can_use_mmi = TRUE
	var/mob/living/carbon/brain/brainmob = null
	var/healed_threshold = 1
	/// Basically, how many Process() calls we have until hardcrit if we run out of oxygen. Maximum value is equal to its starting value.
	var/oxygen_reserve = 6
	var/insanity = 0 // higher = bad

/obj/item/organ/internal/brain/robotize()
	replace_self_with(/obj/item/organ/internal/posibrain)

/obj/item/organ/internal/brain/mechassist()
	replace_self_with(/obj/item/organ/internal/mmi_holder)

/obj/item/organ/internal/brain/getToxLoss()
	return 0

/obj/item/organ/internal/brain/proc/replace_self_with(replace_path)
	var/mob/living/carbon/human/tmp_owner = owner
	qdel(src)
	if(tmp_owner)
		tmp_owner.internal_organs_by_name[organ_tag] = new replace_path(tmp_owner, 1)
		tmp_owner = null

/obj/item/organ/internal/brain/robotize()
	. = ..()
	icon_state = "brain-prosthetic"

/obj/item/organ/internal/brain/Initialize()
	.=..()
	if(species)
		set_max_damage(species.total_health)
	else
		set_max_damage(200)

	spawn(5)
		if(brainmob && brainmob.client)
			brainmob.client.screen.len = null //clear the hud

/obj/item/organ/internal/brain/Destroy()
	QDEL_NULL(brainmob)
	. = ..()

/obj/item/organ/internal/brain/proc/transfer_identity(mob/living/carbon/H)

	if(!brainmob)
		brainmob = new(src)
		brainmob.SetName(H.real_name)
		brainmob.real_name = H.real_name
		brainmob.dna = H.dna.Clone()
		brainmob.timeofhostdeath = H.timeofdeath

	if(H.mind)
		H.mind.transfer_to(brainmob)

	to_chat(brainmob, SPAN_NOTICE("You feel slightly disoriented. That's normal when you're just \a [initial(src.name)]."))
	callHook("debrain", list(brainmob))

/obj/item/organ/internal/brain/examine(mob/user)
	. = ..()
	if(brainmob && brainmob.client)//if thar be a brain inside... the brain.
		to_chat(user, "You can feel the small spark of life still left in this one.")
	else
		to_chat(user, "This one seems particularly lifeless. Perhaps it will regain some of its luster later..")

/obj/item/organ/internal/brain/removed(mob/living/user)
	if(!istype(owner))
		return ..()

	if(name == initial(name))
		name = "\the [owner.real_name]'s [initial(name)]"

	var/mob/living/simple_animal/borer/borer = owner.has_brain_worms()

	if(borer)
		borer.detatch() //Should remove borer if the brain is removed - RR

	transfer_identity(owner)

	..()

/obj/item/organ/internal/brain/replaced(mob/living/target)

	if(!..()) return 0

	if(target.key)
		target.ghostize()

	if(brainmob)
		if(brainmob.mind)
			brainmob.mind.transfer_to(target)
		else
			target.key = brainmob.key

	return 1

/obj/item/organ/internal/brain/can_recover()
	return ~status & ORGAN_DEAD

/obj/item/organ/internal/brain/proc/handle_severe_brain_damage()
	set waitfor = FALSE
	healed_threshold = 0
	to_chat(owner, "<span class = 'notice' font size='10'><B>Where am I...?</B></span>")
	sleep(5 SECONDS)
	if(!owner)
		return
	to_chat(owner, "<span class = 'notice' font size='10'><B>What's going on...?</B></span>")
	sleep(10 SECONDS)
	if(!owner)
		return
	to_chat(owner, "<span class = 'notice' font size='10'><B>What happened...?</B></span>")
	alert(owner, "You have taken massive brain damage! You will not be able to remember the events leading up to your injury.", "Brain Damaged")
	if(owner.psi)
		owner.psi.check_latency_trigger(40, "physical trauma")

/obj/item/organ/internal/brain/Process()
	if(owner)
		if(damage > max_damage / 2 && healed_threshold)
			handle_severe_brain_damage()

		if(damage < (max_damage / 4))
			healed_threshold = 1

		handle_disabilities()
		handle_damage_effects()
		handle_sanity_effects()

		// Brain damage from low oxygenation or lack of blood.
		if(owner.should_have_organ(BP_HEART))

			// No heart? You are going to have a very bad time. Not 100% lethal because heart transplants should be a thing.
			var/blood_volume = owner.get_blood_oxygenation()
			if(blood_volume < BLOOD_VOLUME_SURVIVE)
				if(!owner.chem_effects[CE_STABLE] || prob(60))
					oxygen_reserve = max(0, oxygen_reserve - 1)
			else
				oxygen_reserve = min(initial(oxygen_reserve), oxygen_reserve + 1)

			if(!oxygen_reserve) //(hardcrit)
				owner.Paralyse(3)

			// If we've got the proper chems, we can heal no matter what
			var/healing = owner.chem_effects[CE_BRAIN_REGEN] ? 1.6 : 0
			healing += ((damage > 40) && owner.chem_effects[CE_STABLE]) ? 0.5 : 0
			// At good oxygenation levels, we passively autoheal as well.
			if(blood_volume > (BLOOD_VOLUME_SAFE + 1))
				healing += 1.05 * log(12, (blood_volume - BLOOD_VOLUME_SAFE))

			var/incoming_damage = ((100 - (1.1 * blood_volume)) / 50) + (((blood_volume - 100) / 120) ** 2)
			if(owner.chem_effects[CE_STABLE])
				incoming_damage *= 0.5

			var/current_max_health = (max_damage + 75) - (3 * blood_volume)

			// Can't heal and take damage at the same time, so the smaller one is taken away from the larger
			if(healing && incoming_damage)
				if(healing > incoming_damage)
					healing -= incoming_damage
					incoming_damage = 0
				else
					incoming_damage -= healing
					healing = 0

			take_internal_damage(min(damage + incoming_damage, current_max_health - damage))

			// we can't heal if we're above max damage
			if(healing && damage && damage < max_damage)
				damage = max(damage - healing, 0)

			// Secondary effects of bloodloss
			switch(blood_volume)
				if(BLOOD_VOLUME_OKAY to BLOOD_VOLUME_SAFE)
					if(prob(1))
						to_chat(owner, SPAN_WARNING("You feel [pick("dizzy","woozy","faint")]..."))
				if(BLOOD_VOLUME_BAD to BLOOD_VOLUME_OKAY)
					owner.set_eye_blur_if_lower(2 SECONDS)
					if(prob(3))
						to_chat(owner, SPAN_WARNING("You feel very [pick("dizzy","woozy","faint")]..."))
				if(BLOOD_VOLUME_SURVIVE to BLOOD_VOLUME_BAD)
					owner.Weaken(2)
					owner.set_eye_blur_if_lower(4 SECONDS)
					if(prob(6))
						to_chat(owner, SPAN_WARNING("You feel extremely [pick("dizzy","woozy","faint")]..."))
				if(-(INFINITY) to BLOOD_VOLUME_SURVIVE) // Also see heart.dm, being below this point puts you into cardiac arrest.
					owner.Weaken(5)
					owner.set_eye_blur_if_lower(6 SECONDS)
	..()

/obj/item/organ/internal/brain/proc/take_sanity_damage(damage, silent)
	insanity = Clamp(damage, insanity + damage, BRAIN_MAX_INSANITY)

/obj/item/organ/internal/brain/proc/get_sanity_level()
	switch(insanity)
		if(-INFINITY to 0.4*BRAIN_MAX_INSANITY)
			return SL_SANE
		if(0.4*BRAIN_MAX_INSANITY to 0.7*BRAIN_MAX_INSANITY) // Stressed.
			return SL_STRESSED
		if(0.7*BRAIN_MAX_INSANITY to 0.9*BRAIN_MAX_INSANITY) // Starting to go insane.
			return SL_DISTRESSED
		if(0.9*BRAIN_MAX_INSANITY to INFINITY) // Schizophrenic med student.
			return SL_INSANE
	return SL_SANE // something went wrong.

/obj/item/organ/internal/brain/take_internal_damage(damage, silent)
	set waitfor = 0
	..()
	if(damage >= 10) //This probably won't be triggered by oxyloss or mercury. Probably.
		var/damage_secondary = damage * 0.20
		owner.flash_eyes()
		owner.adjust_eye_blur(damage_secondary SECONDS)
		owner.adjust_confusion(damage_secondary SECONDS)
		if(damage >= 25)
			owner.Weaken(round(damage_secondary / 2, 1))
		if(prob(30))
			addtimer(CALLBACK(src, PROC_REF(brain_damage_callback), damage), rand(6, 20) SECONDS, TIMER_UNIQUE)

/obj/item/organ/internal/brain/proc/brain_damage_callback(damage) //Confuse them as a somewhat uncommon aftershock. Side note: Only here so a spawn isn't used. Also, for the sake of a unique timer.
	if (!owner)
		return
	to_chat(owner, "<span class = 'notice' font size='10'><B>I can't remember which way is forward...</B></span>")
	owner.adjust_confusion(damage SECONDS)

/obj/item/organ/internal/brain/proc/handle_disabilities()
	if(owner.stat)
		return
	if((owner.disabilities & EPILEPSY) && prob(1))
		owner.seizure()
	else if((owner.disabilities & TOURETTES) && prob(10))
		owner.Stun(10)
		switch(rand(1, 3))
			if(1)
				owner.emote("twitch")
			if(2 to 3)
				owner.say("[prob(50) ? ";" : ""][pick("SHIT", "PISS", "FUCK", "CUNT", "COCKSUCKER", "MOTHERFUCKER", "TITS")]")
		owner.adjust_jitter(10 SECONDS)
	else if((owner.disabilities & NERVOUS) && prob(10))
		owner.set_stutter_if_lower(3 SECONDS)

/obj/item/organ/internal/brain/proc/handle_damage_effects()
	if(owner.stat)
		return
	if(damage > 0 && prob(1))
		owner.custom_pain("Your head feels numb and painful.",10)
	if(is_bruised() && prob(1) && !owner.has_status_effect(/datum/status_effect/eye_blur))
		to_chat(owner, SPAN_WARNING("It becomes hard to see for some reason."))
		owner.set_eye_blur_if_lower(10 SECONDS)
	if(damage >= 0.5*max_damage && prob(1) && owner.get_active_hand())
		to_chat(owner, SPAN_DANGER("Your hand won't respond properly, and you drop what you are holding!"))
		owner.unequip_item()
	if(damage >= 0.6*max_damage)
		owner.adjust_slurring(3 SECONDS)
	if(is_broken())
		if(!owner.lying)
			to_chat(owner, SPAN_DANGER("You black out!"))
		owner.Paralyse(10)

// Magic number;
// "designed" such that 120u of Citalopram are needed
// to go from full insanity to complete sanity.
// I forgot how I did the math for this, so trust me bro
#define CHEM_SANITY_MULTIPLIER (5/6)

/obj/item/organ/internal/brain/proc/handle_sanity_effects()
	if(owner.stat) // Dead => Don't change sanity
		return
	// reagent effect
	var/dmg_amt = owner.chem_effects[CE_SANITY] * REM * CHEM_SANITY_MULTIPLIER
	if(dmg_amt) // A sanity check. Get it?
		take_sanity_damage(-dmg_amt, TRUE)


	switch(get_sanity_level())
	 // if(SL_SANE) // you're sane, don't do anything
		if(SL_STRESSED) // Stressed.
			// to be implemented
		if(SL_DISTRESSED) // Starting to go insane.
			if(prob(1))
				owner.hallucination(insanity * 1.2, insanity)
		if(SL_INSANE) // Schizophrenic med student.
			if(prob(3))
				owner.hallucination(insanity * 2, insanity)

#undef CHEM_SANITY_MULTIPLIER

/obj/item/organ/internal/brain/surgical_fix(mob/user)
	var/blood_volume = owner.get_blood_oxygenation()
	if(blood_volume < BLOOD_VOLUME_SURVIVE)
		to_chat(user, SPAN_DANGER("Parts of [src] didn't survive the procedure due to lack of air supply!"))
		set_max_damage(Floor(max_damage - 0.25*damage))
	heal_damage(damage)

/obj/item/organ/internal/brain/get_scarring_level()
	. = (species.total_health - max_damage)/species.total_health

/obj/item/organ/internal/brain/get_mechanical_assisted_descriptor()
	return "machine-interface [name]"
