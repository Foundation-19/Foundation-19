/datum/scp/scp_3794
	name = "SCP-3794"
	designation = "3794"
	classification = SAFE

/obj/effect/decal/cleanable/blood/splatter/salsa
	name = "salsa"
	desc = "It's salsa, nothing special. Really."
	cleanable_scent = "salsa"

/obj/item/weapon/twohanded/scp_3794
	name = "SCP-3794"
	desc = "A generic sledgehammer, you can see some red stuff at the face of the hammer."
	icon = 'icons/SCP/scp-3794.dmi'
	icon_state = null
	w_class = ITEM_SIZE_LARGE
	slot_flags = SLOT_BACK
	SCP = /datum/scp/scp_3794
	var/list/hitsounds = list(
		'sound/weapons/genhit1.ogg',
		'sound/weapons/genhit2.ogg',
		'sound/weapons/genhit3.ogg'
	)

/obj/item/weapon/twohanded/scp_3794/attack(mob/living/target,	mob/living/user,	target_zone)
	var/mob/living/carbon/human/H = target
	var/mob/living/carbon/human/G = user
	if(ishuman(user && target))
		to_chat(H, SPAN_USERDANGER("Someone begins swinging a sledgehammer at you!"))
		G.visible_message(SPAN_DANGER("[G] begins to swing [src] at [H]!"))
		if(target_zone == BP_CHEST) //that would be just too easy wouldnt it? (proceeds to not rule out the head)
			return
		if(do_after(G, 2 SECONDS, H))
			target_zone.qdel // doesnt work yet
			H.emote("scream")
			playsound(src, pick(hitsounds), 30)
			admin_attack_log(G, H, null, null, "[G] has attacked [H] with SCP-3794!")
			message_staff("[G] (ckey: [G.ckey]) has swung SCP-2398 at [H] ([H.ckey])!")
