/datum/scp/scp_2398
	name = "SCP-2398"
	designation = "2398"
	classification = SAFE

/obj/item/weapon/twohanded/scp_2398
	name = "SCP-2398"
	desc = "A generic wooden bat, you see 'K.O.' branded into the wood just above the handle."
	icon = 'icons/SCP/scp-2398.dmi'
	icon_state = null
	w_class = ITEM_SIZE_LARGE
	slot_flags = SLOT_BACK
	SCP = /datum/scp/scp_2398

/obj/item/weapon/twohanded/scp_2398/attack(mob/living/target,	mob/living/user)
	var/mob/living/carbon/human/H = target
	var/mob/living/carbon/human/G = user
	if(ishuman(user && target))
		to_chat(H, SPAN_USERDANGER("Someone begins swinging a bat at you!"))
		G.visible_message(SPAN_DANGER("[G] begins to swing [src] at [H]!"))
		if(do_after(G, 4 SECONDS, H))
			explosion(H, 1, 1, 3, 3, 1)
			message_admins("[G] (ckey: [G.ckey]) has swung SCP-2398 at [H] ([H.ckey])!")
	else
		if(iscarbon(G))
			to_chat(H, SPAN_USERDANGER("Someone begins swinging a bat at you!"))
			G.visible_message(SPAN_DANGER("[G] begins to swing [src] at [H]!"))
			if(do_after(G, 4 SECONDS, H))
				explosion(H, 1, 1, 3, 3, 1)
				message_admins("[G] (ckey: [G.ckey]) has swung SCP-2398 at [H] ([H.ckey])!")
				qdel(H)
		return
