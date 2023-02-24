/datum/scp/scp_2398
	name = "SCP-2398"
	designation = "2398"
	classification = SAFE

/obj/item/weapon/twohanded/scp_2398
	name = "SCP-2398"
	desc = "A generic wooden bat, you see “K.O.” branded into the wood just above the handle."
	icon = 'icons/SCP/scp-2398.dmi'
	icon_state = null
	w_class = ITEM_SIZE_LARGE
	attack_verb = list("bwamed", "bonked")
	hitsound = 'sound/weapons/genhit3.ogg'
	slot_flags = SLOT_BACK
	var/uses = 0
	SCP = /datum/scp/scp_2398

/obj/item/weapon/twohanded/scp_2398/attack(mob/living/target,	mob/living/user)
	if(ishuman(user && target))
		var/mob/living/carbon/human/H = target
		var/mob/living/carbon/human/G = user
		H.gib()
		G.gib()
		explosion(src, 2, 1, 2, 2)
		return
