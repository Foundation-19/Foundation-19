GLOBAL_LIST_EMPTY(scp035s)

/datum/scp/scp_035
	name = "SCP-035"
	designation = "035"
	classification = KETER

/obj/item/clothing/mask/spc_035
	name = "SCP-035"
	icon = 'icons/SCP/scp-035.dmi'
	icon_state = "scp035_0"
	item_state = "scp035_0"
	randpixel = FALSE
	var/weeping = FALSE
	var/tradegy = FALSE
	var/mob/living/scp_035/brain_client
	var/bleed_colour = "#1f081b9f"
	//035_whispers_0.ogg Copyright 2013 Iwan Gabovitch, CC-BY3 license.
	var/list/whispering_sounds = list(	'sound/hallucinations/035_whispers_0.ogg',
										'sound/hallucinations/035_whispers_1.ogg',
										'sound/hallucinations/035_whispers_2.ogg',
										'sound/hallucinations/035_whispers_3.ogg',
										'sound/hallucinations/035_whispers_4.ogg')

/obj/item/clothing/mask/spc_035/Initialize()
	. = ..()
	brain_client = new()
	brain_client.mask = src
	contents += brain_client
	GLOB.scp035s += brain_client
	weepstart()
	whisper()

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

/obj/item/clothing/mask/spc_035/proc/whisper()
	addtimer(CALLBACK(src, .proc/whisper), 1 MINUTES)
	for(var/mob/living/carbon/human/H in viewers(src))
		if(prob(66)) //every minute 2/3 chance they hear whispering while observing the mask
			playsound(H.loc, pick(whispering_sounds), 50, 0, 10)

/obj/item/clothing/mask/spc_035/proc/weepstart()
	weeping = addtimer(CALLBACK(src, .proc/weepstop), rand(9.5, 304) SECONDS) //anywhere from 1 animation loop to 5 minutes
	output_substance()
	update_icon()

/obj/item/clothing/mask/spc_035/proc/weepstop()
	weeping = FALSE
	update_icon()
	addtimer(CALLBACK(src, .proc/weepstart), rand(9.5, 114) SECONDS) //only 2 min max downtime, it outputs alot
	if(prob(5))
		tradegy = !tradegy

/obj/item/clothing/mask/spc_035/proc/output_substance()
	if(!weeping)
		return
	if(prob(100)) //output under the mask 4/5 of the time
		//new /obj/effect/fluid/scp_035_substance(src.loc)
		var/obj/effect/decal/cleanable/blood/drip/scp035/drip = new(get_turf(src))
		drip.basecolor = bleed_colour
		drip.update_icon()
	else //find a wall to seep out of
		var/list/target_list = list()
		for(var/turf/T in view(5, src))
			if(T.density && T.opacity)
				target_list += T
		new /obj/effect/fluid/scp_035_substance(pick(target_list))
	addtimer(CALLBACK(src, .proc/output_substance), 10 SECONDS)

/obj/item/clothing/mask/spc_035/equipped(mob/user)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(H.wear_mask == src)
		/*
		H.movement_handlers.Cut()
		H.movement_handlers |= src.brain_client.movement_handlers
		//here we take control of the user and force their speech to only occur as whisper
		*/
		corrupt_host(H)

/obj/item/clothing/mask/spc_035/proc/corrupt_host(atom/user)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		message_admins("corrupting human")
	else
		message_admins("corrupting host")
		//put in code to handle corrupting statues/maniquines etc here

//BRAIN AND ABILITIES

/mob/living/scp_035
	name = "SCP-035"
	var/obj/item/clothing/mask/spc_035/mask

//THE CORROSIVE LIQUID
/datum/reagent/blood/spc_035_substance
	data = null
	name = "Water"
	description = "It is thick and viscous, its slowly degrading the container that contains it."
	reagent_state = LIQUID
	color = "#1f081b9f"
	alpha = 175
	scannable = 0
	metabolism = REM * 10
	taste_description = "death"

/datum/reagent/blood/spc_035_substance/get_data()
	return null

/obj/effect/decal/cleanable/blood/drip/scp035/
	mouse_opacity = 0

/obj/effect/decal/cleanable/blood/drip/scp035/merge_with_blood()
	return FALSE

/obj/effect/fluid/scp_035_substance
	name = ""
	icon = 'icons/effects/liquids.dmi'
	anchored = TRUE
	simulated = FALSE
	opacity = 0
	mouse_opacity = 0
	layer = FLY_LAYER
	alpha = 0
	color = "#1f081b9f"

	fluid_amount = 0
	start_loc
	equalizing_fluids = list()
	equalize_avg_depth = 0
	equalize_avg_temp = 0
	flow_amount = 0

	var/isWallDrippings

/obj/effect/fluid/scp_035_substance/Initialize()
	. = ..()
	create_reagents(20)
	reagents.add_reagent(/datum/reagent/blood/spc_035_substance, 10)
