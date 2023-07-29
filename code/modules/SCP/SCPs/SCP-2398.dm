/datum/scp/scp_2398
	name = "SCP-2398"
	designation = "2398"
	classification = SAFE

/obj/item/weapon/twohanded/scp_2398
	name = "SCP-2398"
	desc = "A generic wooden bat. The letters 'K.O.' are branded into the wood, just above the handle."
	icon = 'icons/SCP/scp-2398.dmi'
	icon_state = null
	w_class = ITEM_SIZE_LARGE //until i find a better solution it will stay like this
	slot_flags = SLOT_BACK
	SCP = /datum/scp/scp_2398

/obj/item/weapon/twohanded/scp_2398/attack(mob/living/target,	mob/living/user)
	var/mob/living/carbon/human/T = target
	var/mob/living/carbon/human/U = user
	var/activehand = BP_L_ARM //determine which hand to burn (stolen from 113 code because bay code is messy)
	if(!U.hand)
		activehand = BP_R_ARM
	if(ishuman(user && target))
		to_chat(T, SPAN_USERDANGER("Someone begins swinging a bat at you!"))
		U.visible_message(SPAN_DANGER("[U] begins to swing [src] at [T]!"))
		if(do_after(U, 4 SECONDS, H))
			var/obj/item/organ/external/E = U.get_organ(activehand)
			E.fracture()
			explosion(T, 1, 1, 3, 3, 1)
			admin_attack_log(U, H, null, null, "[U] has attacked [T] with SCP-2398!")
			message_staff("[U] (ckey: [U.ckey]) has swung SCP-2398 at [T] ([H.ckey])!") //"im sure theres a proc to format this for admins already; go find it" no.
	else
		if(iscarbon(T))
			to_chat(T, SPAN_USERDANGER("Someone begins swinging a bat at you!"))
			G.visible_message(SPAN_DANGER("[G] begins to swing [src] at [T]!"))
			if(do_after(U, 4 SECONDS, H))
				var/obj/item/organ/external/E = U.get_organ(activehand)
				E.fracture()
				explosion(T, 1, 1, 3, 3, 1)
				admin_attack_log(U, T, null, null, "[U] has attacked [T] with SCP-2398!")
				message_staff("[U] (ckey: [U.ckey]) has swung SCP-2398 at [T] ([T.ckey])!")
				qdel(T) //perhaps a bad solution but i dont want to work with it
		return
