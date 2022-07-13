GLOBAL_LIST_EMPTY(scp035s)

/obj/item/clothing/mask/spc_035
	name = "SCP-035"
	icon = 'icons/SCP/scp-035.dmi'
	icon_state = "scp035_0"
	item_state = "scp035_0"
	var/weeping = FALSE
	var/tradegy = FALSE
	var/mob/living/carbon/brain/scp_035/client_holder

/mob/living/carbon/brain/scp_035
	name = "SCP-035"
	var/obj/item/clothing/mask/spc_035/mask

/datum/scp/scp_035
	name = "SCP-035"
	designation = "035"
	classification = KETER

/obj/item/clothing/mask/spc_035/Initialize()
	. = ..()
	client_holder = new()
	client_holder.mask = src
	contents += client_holder
	GLOB.scp035s += client_holder
	weepstart()

/obj/item/clothing/mask/spc_035/examine(mob/user)
	. = ..()
	var/message
	if(icon_state)
		message = "An ancient white porcelain comedy mask."
	else
		message = "An ancient white porcelain tradegy mask."
	if(weeping)
		message += " A viscious liquid is seeping out of its eyes and mouth."
	to_chat(user, message)

/obj/item/clothing/mask/spc_035/proc/weepstart()
	weeping = TRUE
	update_icon()
	addtimer(CALLBACK(src, .proc/weepstop), rand(5, 100) SECONDS)

/obj/item/clothing/mask/spc_035/proc/weepstop()
	weeping = FALSE
	update_icon()
	addtimer(CALLBACK(src, .proc/weepstart), rand(5, 100) SECONDS)

/obj/item/clothing/mask/spc_035/update_icon()
	. = ..()
	cut_overlays()
	icon_state = "scp035_[tradegy]"
	item_state = icon_state
	if(weeping)
		add_overlay("weeping")
		if(ishuman(loc))
			var/mob/living/carbon/human/H = loc
			H.update_inv_wear_mask()

/obj/item/clothing/mask/spc_035/AltClick(mob/user)
	. = ..()
	tradegy = !tradegy
	update_icon()
