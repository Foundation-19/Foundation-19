/obj/item/scp513
	name = "rusty cowbell"
	desc = "An old cowbell, covered in immense amounts of rust."
	icon = 'icons/SCP/scp-513.dmi'

	icon_state = "mindfuckcowbell"

	//Config

	///Hallucination Cooldown
	var/hallucination_cooldown = 5 MINUTES

/obj/item/scp513/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"rusty cowbell", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_EUCLID, //Obj Class
		"513", //Numerical Designation
		SCP_MEMETIC
	)

	SCP.memeticFlags = MAUDIBLE|MPERSISTENT|MSYNCED
	SCP.memetic_proc = TYPE_PROC_REF(/obj/item/scp513, effect)
	SCP.memetic_sounds = list('sounds/scp/513/Bell1.ogg', 'sounds/scp/513/Bell2.ogg')
	SCP.compInit()

	START_PROCESSING(SSobj, src)


/obj/item/scp513/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

//Mechanics

/obj/item/scp513/proc/ring(mob/living/user)
	visible_message(SPAN_DANGER(SPAN_ITALIC("\The [src] rings, sending chills to your very bone.")))
	playsound(src, pick('sounds/scp/513/Bell1.ogg', 'sounds/scp/513/Bell2.ogg'), 50, TRUE)

/obj/item/scp513/proc/effect(mob/living/carbon/human/H)
	if(!H.humanStageHandler.getStage("513_victim"))
		H.humanStageHandler.setStage("513_victim", 1)
		return

	if((world.time - H.humanStageHandler.getStage("513_cooldown")) < hallucination_cooldown)
		return

	if(prob(60) || H.humanStageHandler.getStage("513_hallucinating")) //Add a little randomness to time between hallucinations/attacks, and avoids us spawning multiple instances of 513-1
		return

	H.humanStageHandler.setStage("513_hallucinating", 1)
	var/turf/spawn_turf = pick_turf_in_range(get_turf(H), world.view, list(GLOBAL_PROC_REF(isfloor)))
	var/mob/living/scp513_1/new_instance = new(spawn_turf)
	new_instance.activate(H)

	H.humanStageHandler.setStage("513_cooldown", world.time)

//Overrides

/obj/item/scp513/pickup(mob/living/user)
	. = ..()
	if(prob(15))
		to_chat(user, SPAN_DANGER("You accidentally ring \the [src]!"))
		ring(user)

/obj/item/scp513/attack_self(mob/living/carbon/human/user)
	if(!istype(user))
		return ..()
	if(user.humanStageHandler.getStage("513_victim"))
		to_chat(user, SPAN_WARNING("No no no I-I dont want to."))
		return
	ring(user)
	return ..()

/obj/item/scp513/Process()
	SCP.meme_comp.activate_memetic_effects()

// SCP 513-1

/mob/living/scp513_1
	name = "???"
	desc = "You arent sure what that is."
	icon = 'icons/SCP/scp-513-1.dmi'

	icon_state = "invisible"
	density = FALSE

	//Config

	///Our message cooldown
	var/message_cooldown = 45 SECONDS
	///Possible paranoia messages to pick from
	var/list/paranoia_messages = list(
		"You feel like you are being watched...",
		"Something is staring at you...",
		"You feel a set of eyes bore deep into your skull...",
		"There is something out there, just out of sight..."
	)
	///Max distance we can be from our victim before dissapearing (this is used in case we spawn in and are never seen by our victim)
	var/max_distance = 14
	///Minimium distance we can be from our victim before dissapearing (this is used to avoid our victim actually getting close to us)
	var/min_distance = 2
	///Our attack cooldown
	var/attack_cooldown = 5 SECONDS

	//Mechanics

	///Tracks message cooldown
	var/message_cooldown_track = 0
	///Our appearence handler
	var/decl/appearance_handler/hal_handle = new /decl/appearance_handler()
	///Our victim
	var/mob/living/carbon/human/victim
	///Have we been witnessed by our victim yet?
	var/was_seen = FALSE
	///Tracks attack cooldown
	var/attack_cooldown_track

/mob/living/scp513_1/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"???", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_EUCLID, //Obj Class
		"513-1" //Numerical Designation
	)

//Mechanics

/mob/living/scp513_1/proc/activate(mob/living/carbon/human/new_victim)
	var/image/hallucination = image('icons/SCP/scp-513-1.dmi', src, "visual")
	hal_handle.AddAltAppearance(src, hallucination, list(new_victim))
	victim = new_victim

/mob/living/scp513_1/proc/stop_hallucination()
	victim.humanStageHandler.setStage("513_hallucinating", 0)
	qdel_self()

//Overrides

/mob/living/scp513_1/Life()
	. = ..()
	if(!victim)
		return

	if(get_dist(src, victim) > max_distance)
		stop_hallucination()

	if(victim.stat == UNCONSCIOUS)
		if(get_dist(src, victim) > 1)
			step_towards(src, victim)
			return
		else
			UnarmedAttack(victim)
			return

	if(!was_seen)
		if(victim.can_see(src))
			was_seen = TRUE
		else
			if((world.time - message_cooldown_track) >= message_cooldown)
				to_chat(victim, SPAN_NOTICE(pick(paranoia_messages)))
				message_cooldown_track = world.time
			return

	step_away(src, victim)

	if(((victim.stat != UNCONSCIOUS) && !victim.can_see(src)) || (victim.stat == DEAD) || (get_dist(src, victim) <= min_distance))
		stop_hallucination()

/mob/living/scp513_1/UnarmedAttack(mob/living/carbon/human/H, proximity)
	if(!istype(H) || (victim != H) || ((world.time - attack_cooldown_track) < attack_cooldown))
		return

	to_chat(H, SPAN_DANGER("You are clawed at by [src]!"))
	sound_to(H, pick('sounds/weapons/alien_claw_flesh1.ogg', 'sounds/weapons/alien_claw_flesh2.ogg', 'sounds/weapons/alien_claw_flesh3.ogg'))

	H.apply_damage(15, BRUTE)

	attack_cooldown_track = world.time

/mob/living/scp513_1/Bump(atom/movable/AM, yes) //This makes it so we dont interact with the world since we are supposed to be more of a hallucination
	return
