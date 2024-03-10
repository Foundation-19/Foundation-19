/obj/item/paper/talisman
	icon_state = "paper_talisman"
	var/imbue = null
	info = "<center><img src='talisman.png'></center><br/><br/>"
	language = LANGUAGE_CULT

/obj/item/paper/talisman/attack_self(mob/living/user)
	if(iscultist(user))
		to_chat(user, "Attack your target to use this talisman.")
	else
		to_chat(user, "You see strange symbols on the paper. Are they supposed to mean something?")

/obj/item/paper/talisman/attack(mob/living/M, mob/living/user)
	return

/obj/item/paper/talisman/stun/attack_self(mob/living/user)
	if(iscultist(user))
		to_chat(user, "This is a stun talisman. It can disable humans, temporarily.")
	..()

/obj/item/paper/talisman/stun/attack(mob/living/M, mob/living/user)
	if(!iscultist(user))
		return
	user.say("Dream Sign: Evil Sealing Talisman!", LANGUAGE_CULT) // this is hilarious but muh immersion!!
	var/obj/item/nullrod/nrod = locate() in M
	if(nrod)
		user.balloon_alert_to_viewers("invokes but unaffected!", "you invoke but they are unaffected!")
		return
	else
		user.balloon_alert_to_viewers("invokes talisman!", "you invoke stun talisman!")

	if(issilicon(M))
		M.Weaken(15)
		M.set_silence_if_lower(15 SECONDS)
	else if(iscarbon(M))
		var/mob/living/carbon/C = M
		C.set_silence_if_lower(15 SECONDS)
		C.Weaken(20)
		C.Stun(20)
	admin_attack_log(user, M, "Used a stun talisman.", "Was victim of a stun talisman.", "used a stun talisman on")
	user.unEquip(src)
	qdel(src)

/obj/item/paper/talisman/emp/attack_self(mob/living/user)
	if(iscultist(user))
		to_chat(user, "This is an EMP talisman, it can disable electronics.")
	..()

/obj/item/paper/talisman/emp/afterattack(atom/target, mob/user, proximity)
	if(!iscultist(user))
		return
	if(!proximity)
		return
	user.say("Ta'gh fara[pick("'","`")]qha fel d'amar det!")
	user.balloon_alert_to_viewers("invokes talisman!", "you invoke emp talisman!")
	target.emp_act(1)
	user.unEquip(src)
	qdel(src)

/obj/item/paper/talisman/blindness/attack_self(mob/living/user)
	. = ..()
	if(iscultist(user))
		to_chat(user, "This is a blindness talisman. It can blind a human.")
	..()

/obj/item/paper/talisman/blindness/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!iscultist(user))
		return
	var/obj/item/nullrod/nrod = locate() in M
	if(nrod)
		user.balloon_alert_to_viewers("invokes but unaffected!", "you invoke but they are unaffected!")
		return
	else
		user.balloon_alert_to_viewers("invokes talisman!", "you invoke blindness talisman!")

	if(iscarbon(M))
		var/mob/living/carbon/C = M
		to_chat(C, SPAN_WARNING("Your eyes burn horrifically!"))
		C.set_eye_blur_if_lower(30 SECONDS)
		C.set_temp_blindness_if_lower(30 SECONDS)

	admin_attack_log(user, M, "Used a blindness talisman.", "Was victim of a blindness talisman.", "used a blindness talisman on")
	qdel(src)
	user.unEquip(src)

/obj/item/paper/talisman/shackles/attack_self(mob/living/user)
	. = ..()
	if(iscultist(user))
		to_chat(user, "This is a shadow shackles talisman. It's able to form handcuffs around the wrists of a target.")
	..()

/obj/item/paper/talisman/shackles/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!iscultist(user))
		return
	var/obj/item/nullrod/nrod = locate() in M
	if(nrod)
		user.balloon_alert_to_viewers("invokes but unaffected!", "you invoke but they are unaffected!")
		return

	if(iscarbon(M))
		var/mob/living/carbon/C = M
		var/obj/item/handcuffs/shadowshackle/cuffs = new /obj/item/handcuffs/shadowshackle
		user.balloon_alert_to_viewers("begins invoking talisman!", "you begin invoking shadow shackles...")
		playsound(user.loc, cuffs.cuff_sound, 30, 1, -2)
		if(do_after(user, 2.5 SECONDS, C, bonus_percentage = 25))
			C.equip_to_slot(cuffs,slot_handcuffed)
			user.balloon_alert_to_viewers("invokes talisman!", "you invoke shadow shackles talisman!")
	admin_attack_log(user, M, "Used a shadow shackles talisman.", "Was victim of a shadow shackles talisman.", "used a shadow shackles talisman on")
	qdel(src)
	user.unEquip(src)
