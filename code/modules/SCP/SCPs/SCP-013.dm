/datum/scp/scp_013
	name = "SCP-013"
	designation = "013"
	classification = SAFE

/obj/item/storage/fancy/cigarettes/bluelady
	name = "pack of SCP-013s"
	desc = "A packet of six Blue Lady cigarettes. The SCP logo is stamped on the paper."
	icon_state = "BLpacket"
	startswith = list(/obj/item/clothing/mask/smokable/cigarette/bluelady = 6)

/obj/item/clothing/mask/smokable/cigarette/bluelady
	name = "'blue lady' cigarette"
	brand = "\improper Blue Lady"
	desc = "The words 'Blue Lady' are written on this deftly-rolled cigarette in blue ink."
	filling = list(/datum/reagent/tobacco/fine = 1)
	SCP = /datum/scp/scp_013

/obj/item/clothing/mask/smokable/cigarette/bluelady/Initialize()
	. = ..()

/obj/item/clothing/mask/smokable/cigarette/bluelady/light()
	. = ..()
	for(var/mob/living/carbon/human/affected in range(1, src))
		affected?.update_013_status()

