/obj/item/clothing/mask/scp035
	name = "porcelain mask"
	desc = "A black and white porcelain mask. The white side seems to be leaking a dark, corrosive substance."
	icon = 'icons/SCP/scp-035.dmi'
	icon_state = "scp035"
	body_parts_covered = FACE
	w_class = ITEM_SIZE_NORMAL
	slot_flags = SLOT_MASK
	var/corrosion_damage_per_tick = 2
	var/mob/living/carbon/human/host_body
	var/compulsion_range = 7
	var/compulsion_prob = 5
	var/removal_resist_time = 8 SECONDS
	var/persuasion_prob = 12
	var/persuasion_range = 5
	var/mob/living/observer/scp035_controller/controller

/obj/item/clothing/mask/scp035/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src,
		"porcelain mask",
		SCP_KETER,
		"035",
		SCP_PLAYABLE|SCP_ROLEPLAY|SCP_MEMETIC
	)
	SCP.min_playercount = 15
	SCP.min_time = 20 MINUTES
	SCP.memeticFlags = MINSPECT
	SCP.memetic_proc = TYPE_PROC_REF(/obj/item/clothing/mask/scp035, compulsion_effect)
	SCP.compInit()
	START_PROCESSING(SSobj, src)

/obj/item/clothing/mask/scp035/Destroy()
	STOP_PROCESSING(SSobj, src)
	release_host()
	if(controller)
		controller.mask_ref = null
		controller.ghostize()
		qdel(controller)
		controller = null
	return ..()

/obj/item/clothing/mask/scp035/Process()
	if(host_body)
		if(host_body.wear_mask != src || host_body.stat == DEAD)
			release_host()
			return
		corrode_host(host_body)
		persuade_nearby(host_body)
	else
		if(prob(compulsion_prob))
			for(var/mob/living/carbon/human/H in viewers(compulsion_range, src))
				if(H.SCP)
					continue
				if(prob(15))
					to_chat(H, SPAN_ITALIC("You feel a strange urge to pick up the mask..."))
	if(controller)
		controller.forceMove(get_turf(host_body || src))

/obj/item/clothing/mask/scp035/proc/compulsion_effect(mob/living/carbon/human/H)
	if(!H || H.wear_mask == src)
		return
	to_chat(H, SPAN_ITALIC("Something about the mask draws your attention... You feel a desire to put it on."))

/obj/item/clothing/mask/scp035/proc/corrode_host(mob/living/carbon/human/H)
	if(!istype(H))
		return
	H.adjustCloneLoss(corrosion_damage_per_tick)
	H.adjustToxLoss(corrosion_damage_per_tick * 0.5)
	if(prob(5))
		var/msg = pick("Your skin burns where the mask touches your face...", "You feel the mask's corruption spreading through you...", "Dark liquid drips from beneath the mask...")
		to_chat(H, SPAN_WARNING(msg))
	if(H.getCloneLoss() >= H.maxHealth * 0.8)
		H.visible_message(SPAN_DANGER("[H]'s body finally gives way under the mask's corruption!"))
		if(controller)
			to_chat(controller, SPAN_DANGER("Your host's body has decayed beyond use. You are released."))
		release_host()
		H.dust()

/obj/item/clothing/mask/scp035/proc/persuade_nearby(mob/living/carbon/human/H)
	if(!prob(persuasion_prob))
		return
	for(var/mob/living/carbon/human/target in range(persuasion_range, H))
		if(target == H || target.SCP || target.stat)
			continue
		if(target.SCP && target.SCP.designation == "049")
			if(prob(20))
				to_chat(target, SPAN_ITALIC("A voice whispers in your mind... 'Doctor, we have much to discuss about the Pestilence...'"))
			continue
		if(prob(20))
			var/msg = pick("You feel compelled to trust [H]...", "Something about [H] seems very reasonable...", "You find yourself wanting to help [H]...")
			to_chat(target, SPAN_ITALIC(msg))

/obj/item/clothing/mask/scp035/equipped(mob/user, slot)
	. = ..()
	if(slot == slot_wear_mask && ishuman(user))
		possess(user)

/obj/item/clothing/mask/scp035/proc/possess(mob/living/carbon/human/H)
	if(!istype(H) || H.wear_mask != src)
		return
	if(host_body == H)
		return
	host_body = H
	H.visible_message(SPAN_DANGER("[H]'s posture shifts as they put on the mask, their eyes glazing over with an alien intelligence!"))
	to_chat(H, SPAN_DANGER("Another will surges through your mind, pushing you aside! You can only watch as the mask takes control..."))
	if(controller && controller.client)
		controller.client.eye = H
		controller.client.perspective = EYE_PERSPECTIVE
	if(SCP && SCP.research)
		SCP.research.set_containment_status(SCP_BREACHED)
	announce_possession(H)

/obj/item/clothing/mask/scp035/proc/release_host()
	if(!host_body)
		return
	var/mob/living/carbon/human/old_host = host_body
	host_body = null
	if(controller && controller.client)
		controller.client.eye = controller
		controller.client.perspective = MOB_PERSPECTIVE
	if(old_host)
		old_host.visible_message(SPAN_WARNING("[old_host] gasps as the mask's influence recedes!"))
		if(old_host.stat != DEAD)
			to_chat(old_host, SPAN_WARNING("Your mind is your own again... but the memories of what the mask did linger."))
	if(SCP && SCP.research && SCP.research.containment_status == SCP_BREACHED)
		SCP.research.set_containment_status(SCP_CONTAINED)

/obj/item/clothing/mask/scp035/proc/announce_possession(mob/living/carbon/human/H)
	var/area/A = get_area(H)
	priority_announcement.Announce(
		"ALERT: SCP-035 has found a new host. Last detected in [A ? A.name : "unknown location"]. All personnel are advised to avoid contact.",
		"SCP-035 Containment Breach",
		'sounds/effects/siren.ogg'
	)

/obj/item/clothing/mask/scp035/dropped(mob/user)
	. = ..()
	if(host_body)
		release_host()

/obj/item/clothing/mask/scp035/attack_hand(mob/user)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.wear_mask == src)
			to_chat(H, SPAN_DANGER("The mask resists being removed! You struggle against its grip..."))
			if(do_after(H, removal_resist_time, src))
				H.drop_from_inventory(src)
			return
	. = ..()

/obj/item/clothing/mask/scp035/do_possession(mob/observer/ghost/possessor)
	if(!(istype(possessor) && possessor.ckey))
		return 0

	if(controller && controller.ckey)
		to_chat(possessor, SPAN_WARNING("\The [src] already has a player."))
		return 0

	var/agreement = tgui_alert(possessor, "Warning! SCP-035 is a roleplay oriented SCP. You are expected to behave like SCP-035 would in lore - highly intelligent, manipulative, and persuasive. Failing to do so would result in ban from playing roleplay SCPs. Additionally, you need a host to interact with the physical world.", "Are you sure?", list("Yes","No"))
	if(!LAZYLEN(agreement) || (agreement == "No"))
		return 0

	if(controller && controller.ckey)
		to_chat(possessor, SPAN_WARNING("\The [src] already has a player."))
		return 0

	controller = new(get_turf(src))
	controller.mask_ref = src
	controller.ckey = possessor.ckey
	qdel(possessor)

	if(SCP)
		SCP.possessed = TRUE

	to_chat(controller, "<b>You are now SCP-035!</b>")
	to_chat(controller, SPAN_NOTICE("You are a sentient, highly intelligent mask. You need a living host to interact with the physical world. Your corrosive touch slowly destroys any host you wear. Use your persuasion and cunning to survive."))

	if(host_body && controller.client)
		controller.client.eye = host_body
		controller.client.perspective = EYE_PERSPECTIVE

	return 1

/mob/living/observer/scp035_controller
	name = "SCP-035 Controller"
	desc = "You shouldn't see this."
	invisibility = INVISIBILITY_ABSTRACT
	density = FALSE
	see_in_dark = 7
	see_invisible = SEE_INVISIBLE_LIVING
	var/obj/item/clothing/mask/scp035/mask_ref

/mob/living/observer/scp035_controller/Destroy()
	if(mask_ref)
		if(mask_ref.SCP)
			mask_ref.SCP.possessed = FALSE
		mask_ref.controller = null
		mask_ref = null
	return ..()

/mob/living/observer/scp035_controller/Life()
	. = ..()
	if(!mask_ref)
		ghostize()
		qdel(src)
		return
	if(mask_ref.host_body)
		if(mask_ref.host_body.wear_mask != mask_ref)
			mask_ref.release_host()
			return
		if(mask_ref.host_body.stat == DEAD)
			to_chat(src, SPAN_DANGER("Your host has died. You are released."))
			mask_ref.release_host()
			return
		if(client)
			client.eye = mask_ref.host_body
			client.perspective = EYE_PERSPECTIVE

/mob/living/observer/scp035_controller/say(message)
	if(!mask_ref || !mask_ref.host_body)
		to_chat(src, SPAN_WARNING("You need a host to speak."))
		return
	mask_ref.host_body.say(message)

/mob/living/observer/scp035_controller/custom_emote(var/type, var/message)
	if(!mask_ref || !mask_ref.host_body)
		return
	mask_ref.host_body.custom_emote(type, message)

/mob/living/observer/scp035_controller/relaymove(mob/user, direction)
	if(mask_ref && mask_ref.host_body)
		mask_ref.host_body.relaymove(user, direction)
