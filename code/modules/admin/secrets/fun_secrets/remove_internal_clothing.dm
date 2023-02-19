/datum/admin_secret_item/fun_secret/remove_internal_clothing
	name = "Remove 'Internal' Clothing"

/datum/admin_secret_item/fun_secret/remove_internal_clothing/execute(mob/user)
	. = ..()
	if(!.)
		return

	for(var/obj/item/clothing/under/O in global.item_list)
		qdel(O)
