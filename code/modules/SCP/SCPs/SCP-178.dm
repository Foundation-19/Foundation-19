/obj/item/clothing/glasses/scp178
	name = "3D glasses"
	desc = "3D glasses, but these seem..different."
	icon = 'icons/SCP/scp-178.dmi'
	icon_state = "scp_178"
	item_state = "scp_178"
	body_parts_covered = 0

/obj/item/clothing/glasses/scp178/Initialize()
	. = ..()

	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"3D glasses", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		EUCLID, //Obj Class
		"178", //Numerical Designation
		SCP_PLACEHOLDER
	)
