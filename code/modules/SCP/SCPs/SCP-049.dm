#define NEXT_EMOTE_TIME 5 SECONDS
#define NEXT_PESTILLENCE_DIAG 5 MINUTES
#define NEXT_DEATH_TOUCH_AI 1 MINUTES

GLOBAL_LIST_EMPTY(scp049s)
GLOBAL_LIST_EMPTY(scp049_1s)

/mob/living/carbon/human/scp049
	desc = "A mysterious plague doctor."
	SCP = /datum/scp/scp_049
	icon = 'icons/SCP/scp-049.dmi'
	icon_state = null
	var/list/pestilence_images = list()
	icon_state = ""
	faction = "scp"
	var/contained = TRUE
	ai_holder_type = /datum/ai_holder/humanoid/scp049

	var/list/infected_players = list() // List of players infected with the pestillence
	var/emote_cooldown = 0 // How long before next emote
	var/pestillence_cooldown = 0 // How long until another person can be diagnosed with the disease through examining
	var/ai_death_touch_cooldown = 0 // Cooldown for AI to deathtouch
	var/curing = FALSE //we doing gods work or nah?
	var/chasing_sound = FALSE
	var/anger = 0
	var/angry = FALSE
	status_flags = NO_ANTAG

/datum/scp/scp_049
	name = "SCP-049"
	designation = "049"
	classification = EUCLID

/mob/living/carbon/human/scp049/update_icons()
	return

/mob/living/carbon/human/scp049/on_update_icon()
	if (lying || resting)
		var/matrix/M =  matrix()
		transform = M.Turn(90)
	else
		transform = null
	return
/mob/living/carbon/human/scp049/New(new_loc, new_species)
	new_species = "SCP-049"
	return  ..()

/mob/living/carbon/human/scp049/Initialize()
	. = ..()
	// fix names
	fully_replace_character_name("SCP-049")

	for(var/mob/living/carbon/human/player in GLOB.player_list)
		if(istype(player) && prob(1))
			infected_players += player

	GLOB.scp049s += src
	verbs += /mob/living/carbon/human/proc/door_049

	if(!zone_sel)
		zone_sel = new /obj/screen/zone_sel(null)

	// emotes
	verbs += list(
		/mob/living/carbon/human/scp049/proc/greetings,
		/mob/living/carbon/human/scp049/proc/yet_another_victim,
		/mob/living/carbon/human/scp049/proc/you_are_not_a_doctor,
		/mob/living/carbon/human/scp049/proc/I_sense_the_disease_in_you,
		/mob/living/carbon/human/scp049/proc/Im_here_to_cure_you
	)

/mob/living/carbon/human/scp049/Destroy()
	pestilence_images = null
	GLOB.scp049s -= src
	return ..()

/mob/living/carbon/human/scp049/examinate(var/mob/living/carbon/human/target)
	. = ..()
	if(prob(1) && !(target in infected_players) && is_valid_curing_target(target) && world.time >= pestillence_cooldown)
		to_chat(src, SPAN_NOTICE("Examining them closely. You sense that they are infected with the pestilence."))
		infected_players += target
		pestillence_cooldown = world.time + NEXT_PESTILLENCE_DIAG
	if(target in infected_players)
		to_chat(src, SPAN_DANGER("They are infected with the pestilence! I need to cure them."))
		see_disease()

/mob/living/carbon/human/scp049/proc/is_valid_curing_target(var/mob/living/carbon/human/target)
	if(target.SCP)
		return FALSE
	if(!istype(target, /mob/living/carbon/human))
		return FALSE

	return TRUE

/mob/living/carbon/human/scp049/Login()
	. = ..()
	if(client)
		//Start text

		if(!(MUTATION_XRAY in mutations))
			mutations.Add(MUTATION_XRAY)
			update_mutations()
			update_sight()

/mob/living/carbon/human/scp049/proc/see_disease()
	if (client)
		client.images -= pestilence_images
		for (var/image in pestilence_images)
			qdel(image)
		pestilence_images.Cut()
		for(var/mob/living/carbon/human/H in view(15, src))
			if(H in infected_players)
				pestilence_images += image('icons/SCP/scp-049.dmi', H, "pestilence", MOB_LAYER+0.01)
		client.images |= pestilence_images

/mob/living/carbon/human/scp049/get_pressure_weakness()
	return 0

/mob/living/carbon/human/scp049/handle_breath()
	return 1

/mob/living/carbon/human/scp049/movement_delay()
	return 3.0


/mob/living/carbon/human/scp049/bullet_act(var/obj/item/projectile/P, var/def_zone)
	if (getBruteLoss() + getFireLoss() + getToxLoss() + getCloneLoss() >= 200)
		return
	return ..(P, def_zone)

/mob/living/carbon/human/proc/door_049(obj/machinery/door/A in filter_list(oview(1), /obj/machinery/door))
	set name = "Pry Open Airlock"
	set category = "SCP-049"


	if (istype(A, /obj/machinery/door/airlock/highsecurity))
		to_chat(src, "<span class='warning'>\ You cannot open highsecurity doors.</span>")
		return

	if (istype(A, /obj/machinery/door/blast/regular))
		to_chat(src, "<span class='warning'>\ You cannot open blast doors.</span>")
		return

	if(!istype(A) || incapacitated())
		return

	if(!A.Adjacent(src))
		to_chat(src, "<span class='warning'>\The [A] is too far away.</span>")
		return

	if(!A.density)
		return

	src.visible_message("\The [src] begins to pry open \the [A]!")

	if(!do_after(src,120,A))
		return

	if(!A.density)
		return

	A.do_animate("spark")
	do_after(10)
	A.stat |= BROKEN
	var/check = A.open(1)
	src.visible_message("\The [src] slices \the [A]'s controls[check ? ", ripping it open!" : ", breaking it!"]")

// SCP-049 emotes
/mob/living/carbon/human/scp049/proc/greetings()
	set category = "SCP-049"
	set name = "Greetings"
	if (world.time >= emote_cooldown)
		playsound(src, 'sound/scp/voice/SCP049_1.ogg', 30)
		emote_cooldown = world.time + NEXT_EMOTE_TIME

/mob/living/carbon/human/scp049/proc/yet_another_victim()
	set category = "SCP-049"
	set name = "Yet another victim"
	if (world.time >= emote_cooldown)
		playsound(src, 'sound/scp/voice/SCP049_2.ogg', 30)
		emote_cooldown = world.time + NEXT_EMOTE_TIME

/mob/living/carbon/human/scp049/proc/you_are_not_a_doctor()
	set category = "SCP-049"
	set name = "You are not a doctor"
	if (world.time >= emote_cooldown)
		playsound(src, 'sound/scp/voice/SCP049_3.ogg', 30)

/mob/living/carbon/human/scp049/proc/I_sense_the_disease_in_you()
	set category = "SCP-049"
	set name = "I sense the disease in you"
	if (world.time >= emote_cooldown)
		playsound(src, 'sound/scp/voice/SCP049_4.ogg', 30)
		emote_cooldown = world.time + NEXT_EMOTE_TIME

/mob/living/carbon/human/scp049/proc/Im_here_to_cure_you()
	set category = "SCP-049"
	set name = "I'm here to cure you"
	if (world.time >= emote_cooldown)
		playsound(src, 'sound/scp/voice/SCP049_5.ogg', 30)
		emote_cooldown = world.time + NEXT_EMOTE_TIME

/mob/living/carbon/human/scp049/proc/conversion_act()
	var/mob/living/carbon/human/target
	var/diseased = FALSE
	var/obj/item/grab/G = src.get_active_hand()
	if(!G)
		to_chat(src, "<span class='warning'>We must take hold of a victim to cure their disease.</span>")
		return FALSE

	target = G.affecting

	if(isspecies(target, SPECIES_SCP049_1))
		to_chat(src, SPAN_WARNING("They are free from the pestillence. I have already cured them."))
		return FALSE

	if(!is_valid_curing_target(target))
		return FALSE

	if(target in infected_players)
		diseased = TRUE

	for(var/stage = 1, stage<=4, stage++)
		switch(stage)
			if(1)
				if(diseased)
					to_chat(src, "<span class='notice'>The disease has taken hold. We must work quickly...</span>")
				src.visible_message("<span class='danger'>[src] looms over [target]!</span>")
				target.adjustBruteLoss(25)
			if(2)
				to_chat(src, "<span class='notice'>You gather your tools.</span>")
				src.visible_message("<span class='warning'>[src] draws a rolled set of surgical equipment from their bag!</span>")
				Im_here_to_cure_you()
			if(3)
				to_chat(src, "<span class='notice'>You create your first incision.</span>")
				src.visible_message("<span class='danger'>[src] begins slicing open [target] with a scalpel!</span>")
				to_chat(target, "<span class='danger'>You feel a sharp stabbing pain as your life begins to wane.</span>")
				new /obj/effect/decal/cleanable/blood/splatter(get_turf(target), target.species.blood_color)
			if(4)
				if(diseased)
					to_chat(src, "<span class='notice'>You spend a great deal of time expertly curing this victim's disease.</span>")
				src.visible_message("<span class='danger'>[src] begins performing a horrifying procedure on [target]!</span>")

		if(!do_after(src, 15 SECONDS, target))
			if(diseased)
				to_chat(src, "<span class='warning'>Our curing of [target] has been interrupted!</span>")
			else
				to_chat(src, SPAN_WARNING("Our surgery on [target] has been interrupted."))
			return FALSE

	target.visible_message("<span class = 'danger'><big>The lifeless corpse of [target.name] begins to convulse violently!</big></span>")
	GLOB.scp049_1s += target
	target.undead()
	if(diseased)
		infected_players -= target
		to_chat(src, "<span class='notice'>You have cured [target].</span>")
	to_chat(target, "<span class='danger'>You feel the last of your mind drift away...</span>")
	return TRUE

/mob/living/carbon/human/scp049/proc/stop_heart(var/mob/living/carbon/human/target)
	if(!is_valid_curing_target(target))
		return FALSE

	var/obj/item/organ/internal/heart/heart = target.internal_organs_by_name[BP_HEART]
	if(heart.pulse != PULSE_NONE)
		var/targetted_bodypart = zone_sel.selecting
		if(targetted_bodypart == BP_EYES || targetted_bodypart == BP_MOUTH)
			to_chat(src, SPAN_WARNING("This targetted part is too small."))
			return FALSE
		visible_message(SPAN_DANGER("[src.name] presses against [target.name]'s [targetted_bodypart]."))
		if(target.get_covering_equipped_item_by_zone(targetted_bodypart))
			to_chat(src, SPAN_WARNING("Their [targetted_bodypart] is covered."))
			return FALSE
		heart.pulse = PULSE_NONE
		return TRUE
	else
		to_chat(usr, SPAN_WARNING("They are already dead."))
		return FALSE

/datum/ai_holder/humanoid/scp049
	use_astar = TRUE
	retaliate = TRUE
	hostile = TRUE
	wander = TRUE
	intelligence_level = AI_SMART

/datum/ai_holder/humanoid/scp049/give_target(new_target, urgent)
	. = ..()
	var/mob/living/carbon/human/scp049/user = holder
	if(new_target in user.infected_players)
		user.pointed(new_target)
		user.I_sense_the_disease_in_you()

/mob/living/carbon/human/scp049/IAttack(atom/A)
	if(!canClick())
		return FALSE
	var/mob/living/carbon/human/target = A
	setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
	zone_sel.selecting = pick(BP_CHEST, BP_HEAD)
	if(world.time >= ai_death_touch_cooldown)
		stop_heart(target)
		ai_death_touch_cooldown = world.time + NEXT_DEATH_TOUCH_AI
	else
		if(istype(get_active_hand(), /obj/item/grab))
			return FALSE
		a_intent = I_GRAB
		target.attack_hand(src)
		return TRUE

/datum/ai_holder/humanoid/scp049/pick_target(list/targets)
	var/mob/living/carbon/human/scp049/user = holder
	for(var/target in targets)
		if(!isliving(target) || !user.is_valid_curing_target(target) || !(target in user.infected_players))
			targets -= target
	return ..()

/datum/ai_holder/humanoid/scp049/post_melee_attack(atom/A)
	var/mob/living/carbon/human/scp049/user = holder
	if(istype(user.get_active_hand(), /obj/item/grab))
		if(do_after(holder, 6 SECONDS))
			user.conversion_act()
			user.drop_item() // Conversion finished. Drop grab.

#undef NEXT_EMOTE_TIME
#undef NEXT_PESTILLENCE_DIAG
#undef NEXT_DEATH_TOUCH_AI
