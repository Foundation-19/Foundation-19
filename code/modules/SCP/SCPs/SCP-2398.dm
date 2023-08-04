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

/obj/item/weapon/twohanded/scp_2398/attack(mob/living/target,	mob/living/carbon/human/user)
	var/mob/living/carbon/human/T = target
	var/activehand = user.hand ? BP_L_HAND : BP_R_HAND
	if(isSCP(target) || !istype(user) || !istype(target))
		return
	to_chat(T, SPAN_USERDANGER("Someone begins swinging a bat at you!"))
	U.visible_message(SPAN_DANGER("[U] begins to swing [src] at [T]!"))
	if(do_after(U, 4 SECONDS, T))
		var/obj/item/organ/external/E = U.get_organ(activehand)
		E.fracture()
		explosion(T, 1, 1, 3, 3, 1)
		admin_attack_log(U, T, null, null, "[U] has attacked [T] with SCP-2398!")
		message_staff("[U] (ckey: [U.ckey]) has swung SCP-2398 at [T] ([T.ckey])!") //"im sure theres a proc to format this for admins already; go find it" no.

