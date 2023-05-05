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
	var/obj/item/organ/external/L = H.get_organ(G.zone_sel.selecting)
	var/name = H.get_bodypart_name(target_zone)
	if(ishuman(user && target))
		if(target_zone == BP_CHEST) //that would be just too easy wouldnt it? (proceeds to not rule out the head)
			to_chat(G, SPAN_WARNING("You can't do that!"))
			return
		if(L)
			G.visible_message(SPAN_DANGER("[G] begins to swing [src] at [H]!"))
			to_chat(H, SPAN_USERDANGER("Someone begins swinging a sledgehammer at you!"))
			if(do_after(G, 4 SECONDS, H))
				L.droplimb(TRUE, DROPLIMB_BLUNT, FALSE, TRUE)
				H.emote("scream") //mfw it doesnt work...........
				new /obj/effect/decal/cleanable/blood/splatter/salsa(get_turf(H))
				to_chat(H, SPAN_DANGER("You feel a sharp pain at your [name]!"))
				playsound(src, pick(hitsounds), 30)
				admin_attack_log(G, H, null, null, "[G] has attacked [H] with SCP-3794!")
				message_staff("[G] (ckey: [G.ckey]) has swung SCP-2398 at [H] ([H.ckey])!")
