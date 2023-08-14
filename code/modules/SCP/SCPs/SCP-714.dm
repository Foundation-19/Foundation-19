/obj/item/clothing/ring/scp714
	name = "jade ring"
	desc = "An strangely looking ring made out of jade."
	icon = 'icons/SCP/scp-714.dmi'
	icon_state = "scp-714"

/obj/item/clothing/ring/scp714/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"jade ring", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SAFE, //Obj Class
		"714", //Numerical Designation
		SCP_PLACEHOLDER
	)


