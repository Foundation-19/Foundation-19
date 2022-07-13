/obj/item/clothing/accessory/storage/bandolier/beanbag/Initialize()
	. = ..()
	INIT_SKIP_QDELETED
	if (container)
		for(var/i = 1 to abs(slots))
			new /obj/item/ammo_magazine/shotholder/beanbag (container)
