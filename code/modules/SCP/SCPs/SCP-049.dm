/mob/living/carbon/human/scp049
	name = "plague doctor"
	desc = "A mysterious plague doctor."
	icon = 'icons/SCP/scp-049.dmi'

	status_flags = NO_ANTAG | SPECIES_FLAG_NO_EMBED | SPECIES_FLAG_NEED_DIRECT_ABSORB

	roundstart_traits = list(TRAIT_ADVANCED_TOOL_USER)

	handcuffs_breakout_modifier = 0.2

	//Config

	/// Emote cooldown
	var/emote_cooldown = 5 SECONDS
	/// Door force open cooldown
	var/door_cooldown = 10 SECONDS
	/// Base regen
	var/base_regen = 0.05
	/// How much our regen is multiplied by for each instance of 049-1. (be careful this is exponential)
	var/regen_multiply = 1.5
	/// Heal cooldown
	var/heal_cooldown = 2 SECONDS

	// Mechanical

	/// Amount of zombies we achieved so far
	var/cured_count = 0
	/// Amount of ticks left before bonus move speed dissipates. The higher it is - the higher is move speed
	var/anger_timer = 0
	/// How high can anger_timer go
	var/anger_timer_max = 40
	/// Last speech heard up close
	var/last_interaction_time = 0
	/// How much time should pass without interactions to be able to get up and leave
	var/patience_limit = 15 MINUTES
	/// The area we spawned in
	var/area/home_area = null

	/// Emote cooldown tracker
	var/emote_cooldown_track
	/// Door cooldown tracker
	var/door_cooldown_track
	/// Heal cooldown tracker
	var/heal_cooldown_track
	/// Cooldown for patience message
	var/patience_cooldown_track

/mob/living/carbon/human/scp049/Initialize(mapload, new_species = "SCP-049")
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"plague doctor", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_EUCLID, //Obj Class
		"049", //Numerical Designation
		SCP_PLAYABLE|SCP_ROLEPLAY
	)

	SCP.min_time = 10 MINUTES
	SCP.min_playercount = 25 //mostly a RP scp, cant escape as soon as they spawn in

	add_verb(src, list(
		/mob/living/carbon/human/scp049/verb/Greetings,
		/mob/living/carbon/human/scp049/verb/YetAnotherVictim,
		/mob/living/carbon/human/scp049/verb/YouAreNotDoctor,
		/mob/living/carbon/human/scp049/verb/SenseDiseaseInYou,
		/mob/living/carbon/human/scp049/verb/HereToCureYou,
	))

	InitSkills()
	add_language(LANGUAGE_ENGLISH)
	add_language(LANGUAGE_HUMAN_FRENCH)
	add_language(LANGUAGE_HUMAN_GERMAN)
	add_language(LANGUAGE_HUMAN_SPANISH)
	add_language(LANGUAGE_PLAGUESPEAK_GLOBAL)

	home_area = get_area(src)

/mob/living/carbon/human/scp049/proc/InitSkills()
	skillset.skill_list = list()
	for(var/decl/hierarchy/skill/S in GLOB.skills)
		skillset.skill_list[S.type] = SKILL_UNTRAINED
	skillset.skill_list[SKILL_COOKING] = SKILL_TRAINED
	skillset.skill_list[SKILL_HAULING] = SKILL_MASTER
	skillset.skill_list[SKILL_COMBAT] = SKILL_EXPERIENCED
	skillset.skill_list[SKILL_ANATOMY] = SKILL_MASTER
	skillset.skill_list[SKILL_CHEMISTRY] = SKILL_MASTER
	skillset.skill_list[SKILL_MEDICAL] = SKILL_MASTER
	skillset.skill_list[SKILL_SCIENCE] = SKILL_EXPERIENCED
	skillset.on_levels_change()
	if(!(MUTATION_XRAY in mutations))
		mutations.Add(MUTATION_XRAY)
		update_mutations()
		update_sight()

/mob/living/carbon/human/scp049/do_possession(mob/observer/ghost/possessor)
	if(!..())
		return
	priority_announcement.Announce("Motion sensors triggered in the containment chamber of SCP-049, on-site security personnel are to investigate the issue.", "Motion Sensors", 'sounds/AI/049.ogg')
	last_interaction_time = world.time + 5 MINUTES

//Mechanics

/mob/living/carbon/human/scp049/proc/AttackVoiceLine() //for when we're up to no good!
	var/voiceline = list('sounds/scp/voice/SCP049_1.ogg','sounds/scp/voice/SCP049_2.ogg','sounds/scp/voice/SCP049_3.ogg','sounds/scp/voice/SCP049_4.ogg','sounds/scp/voice/SCP049_5.ogg')
	playsound(src, pick(voiceline), 30)
	show_sound_effect(loc, src)

/mob/living/carbon/human/scp049/proc/OpenDoor(obj/machinery/door/A)
	if((world.time - door_cooldown_track) < door_cooldown)
		to_chat(src, SPAN_WARNING("You cant open another door just yet!"))
		return

	if(!istype(A))
		return

	if(!A.density)
		return

	if(!A.Adjacent(src))
		to_chat(src, SPAN_WARNING("\The [A] is too far away."))
		return

	var/open_time = 8 SECONDS - anger_timer * 2
	if(istype(A, /obj/machinery/door/blast))
		if(get_area(src) == home_area && world.time <= last_interaction_time + patience_limit && anger_timer < 5)
			to_chat(src, SPAN_WARNING("You don't feel like leaving just yet."))
			return
		open_time += 10 SECONDS

	if(istype(A, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/AR = A
		if(AR.locked)
			open_time += 3 SECONDS
		if(AR.welded)
			open_time += 3 SECONDS
		if(AR.secured_wires)
			open_time += 3 SECONDS

	if(istype(A, /obj/machinery/door/airlock/highsecurity))
		open_time += 6 SECONDS

	A.visible_message(SPAN_WARNING("\The [src] begins to pry open \the [A]!"))
	playsound(get_turf(A), 'sounds/machines/airlock_creaking.ogg', 35, 1)
	door_cooldown_track = world.time + open_time // To avoid sound spam

	if(!do_after(src, open_time, A))
		return

	if(istype(A, /obj/machinery/door/blast))
		var/obj/machinery/door/blast/DB = A
		DB.visible_message(SPAN_DANGER("\The [src] forcefully opens \the [DB]!"))
		DB.force_open()
		return

	if(istype(A, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/AR = A
		AR.unlock(TRUE) // No more bolting in the SCPs and calling it a day
		AR.welded = FALSE

	A.set_broken(TRUE)
	A.do_animate("spark")
	var/check = A.open(1)
	visible_message("\The [src] slices \the [A]'s controls[check ? ", ripping it open!" : ", breaking it!"]")

//Overrides

/mob/living/carbon/human/scp049/on_update_icon()
	if(lying || resting)
		var/matrix/M =  matrix()
		transform = M.Turn(90)
	else
		transform = null
	return

/mob/living/carbon/human/scp049/Life()
	. = ..()

	handle_regular_hud_updates()
	process_pestilence_hud(src)
	anger_timer = max(anger_timer - 1, 0)

	// Breach message
	if(world.time > patience_cooldown_track && world.time > last_interaction_time + patience_limit && get_area(src) == home_area)
		patience_cooldown_track = world.time + 5 MINUTES
		to_chat(src, SPAN_DANGER("They really abandoned you in here..? Seems like it's time to take a walk."))
		anger_timer = min(anger_timer + 15, anger_timer_max)

	//Regen (The more zombies we have the more we heal)
	if((world.time - heal_cooldown_track) < heal_cooldown || cured_count < 1)
		return

	var/heal_amount = -max((base_regen * (cured_count * regen_multiply)), base_regen)
	adjustBruteLoss(heal_amount)

/mob/living/carbon/human/scp049/UnarmedAttack(atom/target as obj|mob)
	if(!istype(target))
		return

	if(istype(target, /obj/machinery/door))
		setClickCooldown(CLICK_CD_ATTACK)
		OpenDoor(target)
		return

	if(!ishuman(target) || isscp049(target))
		return ..()

	var/mob/living/carbon/human/H = target

	if(isspecies(H, SPECIES_SCP049_1))
		return ..()

	if(!H.humanStageHandler.getStage("Pestilence"))
		to_chat(src, SPAN_DANGER("They are not infected with the Pestilence."))
		return

	if(H.SCP)
		to_chat(src, SPAN_WARNING("This thing... it isnt normal... you cannot cure it."))
		return

	setClickCooldown(CLICK_CD_ATTACK)

	switch(a_intent)
		if(I_HELP)
			to_chat(src, SPAN_NOTICE("You refrain from curing as your intent is set to help."))
			return ..()
		if(I_HURT)
			if(H.stat == DEAD)
				to_chat(src, SPAN_NOTICE("They are ready for your cure."))
			else if(can_touch_bare_skin(H))
				visible_message(SPAN_DANGER(SPAN_ITALIC("[src] reaches towards [H]!")))
				AttackVoiceLine()
				H.death(deathmessage = "suddenly becomes very still...", show_dead_message = "You have been killed by SCP-[SCP.designation]. Be patient as you may yet be cured...")
			else
				// Crowd control tool!
				if(anger_timer >= anger_timer_max * 0.75)
					visible_message(SPAN_DANGER(SPAN_ITALIC("[src] reaches towards [H], making them stumble!")))
					H.Weaken(10)
					return
				visible_message(SPAN_WARNING(SPAN_ITALIC("[src] reaches towards [H], but nothing happens...")))
				to_chat(src, SPAN_WARNING("\The target's [zone_sel.selecting] is covered. You must make contact with bare skin to kill!"))
			return
	return ..()

/mob/living/carbon/human/scp049/attack_hand(mob/living/carbon/human/M)
	if(isspecies(M, SPECIES_SCP049_1))
		to_chat(M, SPAN_DANGER(SPAN_BOLD("Do not attack your master!")))
		return

	if(M.a_intent != I_HELP && M != src)
		M.humanStageHandler.setStage("Pestilence", 1)
		anger_timer = min(anger_timer + 2, anger_timer_max)

	return ..()

/mob/living/carbon/human/scp049/bullet_act(obj/item/projectile/P, def_zone)
	if(!ishuman(P.firer))
		return

	if(isspecies(P.firer, SPECIES_SCP049_1))
		to_chat(P.firer, SPAN_DANGER(SPAN_BOLD("Do not attack your master!")))
		return

	if(P.damage && !P.nodamage && (P.firer != src))
		var/mob/living/carbon/human/H = P.firer
		H.humanStageHandler.setStage("Pestilence", 1)
		anger_timer = min(anger_timer + 2, anger_timer_max)

	return ..()

/mob/living/carbon/human/scp049/attackby(obj/item/W, mob/user)
	if(isspecies(user, SPECIES_SCP049_1))
		to_chat(user, SPAN_DANGER(SPAN_BOLD("Do not attack your master!")))
		return

	if((W.force > 0) && ishuman(user) && (user != src))
		var/mob/living/carbon/human/H = user
		H.humanStageHandler.setStage("Pestilence", 1)
		anger_timer = min(anger_timer + 2, anger_timer_max)

	return ..()

/mob/living/carbon/human/scp049/GetUnbuckleTime()
	return 15 SECONDS

/mob/living/carbon/human/scp049/examinate(atom/A)
	. = ..()
	if(!ishuman(A))
		return
	var/mob/living/carbon/human/H = A
	if(H.humanStageHandler.getStage("Pestilence"))
		var/pest_message = pick("They reek of the disease.", "They need to be cured.", "The disease is strong in them.", "You sense the pestilence in them.")
		to_chat(src, "[SPAN_DANGER(SPAN_BOLD(pest_message))]")

/mob/living/carbon/human/scp049/hear_say(message, verb = "says", datum/language/language = null, alt_name = "", italics = 0, mob/speaker = null, sound/speech_sound, sound_vol)
	. = ..()
	// Check if the speaker is not SCP-049 itself
	if(speaker == src)
		return
	// Update the last interaction time to the current time
	last_interaction_time = world.time

//Util Overrides

/mob/living/carbon/human/scp049/update_icons()
	return

/mob/living/carbon/human/scp049/get_pressure_weakness()
	return 0

/mob/living/carbon/human/scp049/handle_breath()
	return 1

/mob/living/carbon/human/scp049/movement_delay(decl/move_intent/using_intent = move_intent)
	return 3.0 - round(anger_timer * 0.03, 0.1)

// Override for footstep volume
/mob/living/carbon/human/scp049/handle_footsteps()
	if(!has_footsteps())
		return

	 //every other turf makes a sound
	if((step_count % 2) && MOVING_QUICKLY(src))
		return

	// don't need to step as often when you hop around
	if((step_count % 3) && !has_gravity(src))
		return

	if(istype(move_intent, /decl/move_intent/creep)) //We don't make sounds if we're tiptoeing
		return

	var/turf/T = get_turf(src)
	if(istype(T))
		var/footsound = T.get_footstep_sound(src)
		if(footsound)
			var/range = -(world.view - 2)
			var/volume = 70
			if(MOVING_DELIBERATELY(src))
				volume -= 45
				range -= 0.333
			playsound(T, footsound, volume, 1, range)
			play_special_footstep_sound(T, volume, range)

	show_sound_effect(T, src)

// Emotes

/mob/living/carbon/human/scp049/verb/Greetings()
	set category = "SCP-049"
	set name = "Greetings"

	if(!CanSpecialEmote())
		return

	playsound(src, 'sounds/scp/voice/SCP049_1.ogg', 30)
	show_sound_effect(loc, src)

/mob/living/carbon/human/scp049/verb/YetAnotherVictim()
	set category = "SCP-049"
	set name = "Yet another victim"

	if(!CanSpecialEmote())
		return

	playsound(src, 'sounds/scp/voice/SCP049_2.ogg', 30)
	show_sound_effect(loc, src)

/mob/living/carbon/human/scp049/verb/YouAreNotDoctor()
	set category = "SCP-049"
	set name = "You are not a doctor"

	if(!CanSpecialEmote())
		return

	playsound(src, 'sounds/scp/voice/SCP049_3.ogg', 30)
	show_sound_effect(loc, src)

/mob/living/carbon/human/scp049/verb/SenseDiseaseInYou()
	set category = "SCP-049"
	set name = "I sense the disease in you"

	if(!CanSpecialEmote())
		return

	playsound(src, 'sounds/scp/voice/SCP049_4.ogg', 30)
	show_sound_effect(loc, src)

/mob/living/carbon/human/scp049/verb/HereToCureYou()
	set category = "SCP-049"
	set name = "I'm here to cure you"

	if(!CanSpecialEmote())
		return

	playsound(src, 'sounds/scp/voice/SCP049_5.ogg', 30)
	show_sound_effect(loc, src)

/mob/living/carbon/human/scp049/proc/CanSpecialEmote()
	if((world.time - emote_cooldown_track) > emote_cooldown)
		emote_cooldown_track = world.time
		return TRUE
	return FALSE

// Cure procs

/mob/living/carbon/human/scp049/proc/PlagueDoctorCure(mob/living/carbon/human/target)
	if(!(target.species.name in GLOB.zombie_species) || !target.humanStageHandler.getStage("Pestilence"))
		return

	if(isspecies(target, SPECIES_DIONA) || isspecies(target, SPECIES_SCP049_1) || target.isSynthetic())
		return

	if(target.mind)
		if(target.mind.special_role == ANTAG_SCP049_1)
			return
		target.mind.special_role = ANTAG_SCP049_1

	var/turf/T = get_turf(target)
	new /obj/effect/decal/cleanable/blood(T)
	playsound(T, 'sounds/effects/splat.ogg', 20, 1)
	cured_count++

	target.SCP = new /datum/scp(
		target, // Ref to actual SCP atom
		"plague zombie", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_EUCLID, //Obj Class
		"049-[cured_count]", //Numerical Designation
		SCP_PLAYABLE
	)

	target.visible_message(SPAN_DANGER(SPAN_BOLD("The lifeless corpse of [target] begins to convulse violently!")))
	target.humanStageHandler.setStage("Pestilence", 0)

	target.adjust_jitter(30 SECONDS)
	target.adjustBruteLoss(100)

	addtimer(CALLBACK(src, PROC_REF(FinishPlagueDoctorCure), target), 15 SECONDS)

/mob/living/carbon/human/scp049/proc/FinishPlagueDoctorCure(mob/living/carbon/human/target)
	if(QDELETED(target))
		return

	if(isspecies(target, SPECIES_SCP049_1))
		return

	target.revive()
	target.ChangeToHusk()
	target.visible_message(\
		SPAN_DANGER("\The [target]'s skin decays before your very eyes!"), \
		SPAN_DANGER("You feel the last of your mind drift away... You must follow the one who cured you of your wretched disease."))
	log_admin("[key_name(target)] has transformed into an instance of 049-1!")

	target.Weaken(4)

	if(target.skillset && target.skillset.skill_list)
		target.skillset.skill_list = list()
		for(var/decl/hierarchy/skill/S in GLOB.skills) //Only want trained CQC and athletics
			skillset.skill_list[S.type] = SKILL_UNTRAINED
		target.skillset.skill_list[SKILL_HAULING] = SKILL_TRAINED
		target.skillset.skill_list[SKILL_COMBAT] = SKILL_TRAINED
		target.skillset.on_levels_change()

	target.species = all_species[SPECIES_SCP049_1]
	target.species.handle_post_spawn(target)

	playsound(get_turf(target), 'sounds/hallucinations/wail.ogg', 25, 1)
