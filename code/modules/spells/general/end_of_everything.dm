/datum/spell/end_of_everything
	name = "End of Everything"
	desc = "Forbidden art of summoning darkest energies from within the veil of magic itself. You are a part of \"everything\", so it might be a bad idea to do it..."
	invocation_type = INVOKE_SHOUT
	invocation = "Arcesso!"
	spell_flags = NEEDSCLOTHES
	charge_max = 2 MINUTES

	level_max = list(UPGRADE_TOTAL = 0, UPGRADE_SPEED = 0, UPGRADE_POWER = 0)
	cast_sound = 'sounds/magic/churchbell.ogg'
	hud_state = "wiz_endall"

	categories = list(SPELL_CATEGORY_FORBIDDEN)
	spell_book_visible = FALSE

	spell_cost = 100
	mana_cost = 200

	var/list/active_effects = list()

/datum/spell/end_of_everything/Destroy()
	ClearEffects()
	return ..()

/datum/spell/end_of_everything/choose_targets(mob/user = usr)
	perform(user, list(holder))

/datum/spell/end_of_everything/cast(list/targets, mob/user)
	ClearEffects()
	if(!do_after(user, 10 SECONDS))
		to_chat(user, SPAN_NOTICE("You cancel the ritual!"))
		ClearEffects()
		return
	if(!CastCheck(user))
		to_chat(user, SPAN_NOTICE("You cancel the ritual!"))
		ClearEffects()
		return

	var/turf/T = get_turf(user)

	user.say("Interitus!")
	active_effects += new /obj/effect/effect/warp(T)

	if(!do_after(user, 10 SECONDS))
		to_chat(user, SPAN_NOTICE("You cancel the ritual!"))
		ClearEffects()
		return
	if(!CastCheck(user))
		to_chat(user, SPAN_NOTICE("You cancel the ritual!"))
		ClearEffects()
		return

	user.say("Annihilatio!")

	if(!do_after(user, 10 SECONDS))
		to_chat(user, SPAN_NOTICE("You cancel the ritual!"))
		ClearEffects()
		return
	if(!CastCheck(user))
		to_chat(user, SPAN_NOTICE("You cancel the ritual!"))
		ClearEffects()
		return

	user.say("Mors et aegritudo!")

	if(!do_after(user, 10 SECONDS))
		to_chat(user, SPAN_NOTICE("You cancel the ritual!"))
		ClearEffects()
		return
	if(!CastCheck(user))
		to_chat(user, SPAN_NOTICE("You cancel the ritual!"))
		ClearEffects()
		return

	user.say("Cruel gods, end it all!!")
	to_chat(user, SPAN_WARNING("You feel like you should run..."))
	log_and_message_admins("finished casting [src] spell!", user)
	ClearEffects()

	new /obj/effect/end_of_everything(get_turf(user))

/datum/spell/end_of_everything/proc/CastCheck(mob/user)
	if(!user || QDELETED(user))
		return FALSE
	if(user.stat)
		return FALSE
	return TRUE

/datum/spell/end_of_everything/proc/ClearEffects()
	for(var/datum/D in active_effects)
		qdel(D)
	active_effects = list()

// Essentially a delayed all-consuming terror
/obj/effect/end_of_everything
	icon = 'icons/effects/160x160.dmi'
	icon_state = "end_of_everything"
	pixel_x = -64
	pixel_y = -64

/obj/effect/end_of_everything/Initialize()
	. = ..()
	filters += filter(type = "outline", size = 3, color = "#ff000024", flags = OUTLINE_SHARP)
	var/matrix/M = transform
	transform *= 0.1 // Starts small
	animate(src, transform = M, alpha = 175, time = 24 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(Annihilation)), 25 SECONDS)

/obj/effect/end_of_everything/proc/Annihilation()
	for(var/mob/M in GLOB.player_list)
		if(isnewplayer(M))
			continue
		if(!(M.z in GetConnectedZlevels(z)))
			continue
		M.playsound_local(get_turf(M), 'sounds/magic/end_of_everything.ogg', 150, FALSE)
		to_chat(M, SPAN_USERDANGER("Something terrible has happened..."))
		M.flash_eyes(FLASH_PROTECTION_MAJOR * 2)

	// HAHAHAHAHA
	for(var/atom/A in range(32, src))
		if(A == src)
			continue
		if(isobserver(A))
			continue
		if(prob(15))
			continue
		if(prob(33))
			if(istype(A, /mob/living))
				var/mob/living/L = A
				if(prob(50))
					L.dust()
				else
					L.gib()
				continue
			qdel(A)
			continue
		A.ex_act(rand(1, 2))

	var/matrix/M = transform * 3
	animate(src, transform = M, alpha = 0, time = 4 SECONDS)
	QDEL_IN(src, (5 SECONDS))
