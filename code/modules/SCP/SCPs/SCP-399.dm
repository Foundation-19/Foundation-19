/obj/item/clothing/ring/scp399
	name = "mysterious ring"
	desc = "A mysterious looking ring."
	icon = 'icons/SCP/scp-399.dmi'

	icon_state = "scp-399"

/obj/item/clothing/ring/scp399/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"mysterious ring", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SAFE, //Obj Class
		"399", //Numerical Designation
		SCP_PLACEHOLDER
	)

