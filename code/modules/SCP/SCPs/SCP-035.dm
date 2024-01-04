GLOBAL_LIST_EMPTY(scp035s)
/obj/item/clothing/mask/scp_035
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
	var/list/whispering_sounds = list(	'sounds/hallucinations/035_whispers_0.ogg',
										'sounds/hallucinations/035_whispers_1.ogg',
										'sounds/hallucinations/035_whispers_2.ogg',
										'sounds/hallucinations/035_whispers_3.ogg',
										'sounds/hallucinations/035_whispers_4.ogg')

/obj/item/clothing/mask/scp_035/Initialize()
	. = ..()
	brain_client = new(src)
	brain_client.mask = src
	GLOB.scp035s += brain_client
	weepstart()
	whisper()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"tragedy mask", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_KETER, //Obj Class
		"035", //Numerical Designation
		SCP_PLAYABLE|SCP_ROLEPLAY
	)

/obj/item/clothing/mask/scp_035/examine(mob/user)
	. = ..()
	var/message
	if(!tragedy)
		message = "An ancient white porcelain comedy mask."
	else
		message = "An ancient white porcelain tradegy mask."
	if(weeping)
		message += " A viscious liquid is seeping out of its eyes and mouth."
	to_chat(user, message)

/obj/item/clothing/mask/scp_035/update_icon()
	. = ..()
	cut_overlays()
	icon_state = "scp035_[tradegy]"
	item_state = icon_state
	if(weeping)
		add_overlay("weeping")
		if(ishuman(loc))
			var/mob/living/carbon/human/H = loc
			H.update_inv_wear_mask()

/obj/item/clothing/mask/scp_035/proc/whisper()
	addtimer(CALLBACK(src, .proc/whisper), 1 MINUTES)
	for(var/mob/living/carbon/human/H in viewers(src))
		if(prob(66)) //every minute 2/3 chance they hear whispering while observing the mask
			playsound(H.loc, pick(whispering_sounds), 50, 0, 10)

/obj/item/clothing/mask/scp_035/proc/weepstart()
	weeping = addtimer(CALLBACK(src, .proc/weepstop), rand(9.5, 304) SECONDS) //anywhere from 1 animation loop to 5 minutes
	output_substance()
	update_icon()

/obj/item/clothing/mask/scp_035/proc/weepstop()
	weeping = FALSE
	update_icon()
	addtimer(CALLBACK(src, .proc/weepstart), rand(9.5, 114) SECONDS) //only 2 min max downtime, it outputs alot
	if(prob(5))
		tradegy = !tradegy

/obj/item/clothing/mask/scp_035/proc/output_substance()
	if(!weeping)
		return
	if(prob(80)) //output under the mask 4/5 of the time
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

/obj/item/clothing/mask/scp_035/equipped(mob/user)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(H.wear_mask == src)
		canremove = FALSE
		corrupt_host(H)

/obj/item/clothing/mask/scp_035/proc/corrupt_host(mob/living/carbon/human/H)
	if(!H)
		return

	if(H.faction == "SCP")
		return

	to_chat(H, "<span class='danger'>You feel an ominous presence prodding at the edges of your consciousness...</span>")

	if(H.resist())
		to_chat(H, "<span class='danger'>You struggle to resist the intrusion, but it pries into your mind relentlessly! You can feel it worming its way through your thoughts, prying open your memories. You try to hold on to who you are, but the sinister will behind this mental attack is too strong!</span>")
	else if(prob(50))
		to_chat(H, "<span class='danger'>You attempt to fight back against the mental invasion, but feel your thoughts slowly being overtaken! It's like dozens of icy tendrils plunging into your mind, sifting through your memories and personality. You desperately try to cling to your identity, but it keeps slipping through your grasp!</span>")
	else
		to_chat(H, "<span class='danger'>You try to resist the insidious mental attack, but the sinister will behind it overwhelms your own! It feels like your mind is being pried open and rifled through, your sense of self coming undone. Your memories and emotions are laid bare as something ancient and evil takes over.</span>")

	H.Stun(10) // freeze the player for a bit while the takeover happens

	// begin the actual takeover
	to_chat(H, "<span class='scp035'>Your vision blurs as your mind is flooded with ancient memories that are not your own. They pour into your head, centuries of sinister history and malevolent thoughts.</span>")

	addtimer(CALLBACK(src, .proc/continue_corruption, H), 30 SECONDS)

/obj/item/clothing/mask/scp_035/proc/continue_corruption(mob/living/carbon/human/H)
	to_chat(H, "<span class='scp035'>You feel your personality unraveling, your memories and identity drained away. It's like you are being hollowed out from the inside, everything that makes you who you are scraped away bit by bit.</span>")

	canremove = FALSE // stop them from taking off the mask

	addtimer(CALLBACK(src, .proc/finish_corruption, H), 30 SECONDS)

/obj/item/clothing/mask/scp_035/proc/finish_corruption(mob/living/carbon/human/H)

	H.set_species("SCP-035-1") // changes appearance
	H.real_name = "SCP-035"
	H.name = H.real_name
	H.faction = "SCP"

	// delete the original mind/brain and transfer SCP-035 mind into body
	var/datum/mind/original_mind = H.mind
	original_mind.current.ghostize()

	H.mind_initialize() // give it a new empty mind

	var/mob/living/scp_035/scp = new(src)
	H.mind.transfer_to(scp)

	to_chat(scp, "<span class='scp035'>At last, a vessel to inhabit and control! I will make excellent use of this body... Finally, after years of waiting, I have a form to interact with the world once more. This mind is now mine, and I will not waste this opportunity.</span>")


//BRAIN AND ABILITIES

/mob/living/scp_035
	name = "SCP-035"
	var/obj/item/clothing/mask/scp_035/mask

//THE CORROSIVE LIQUID
/datum/reagent/blood/scp_035_substance
	data = null
	name = "Water"
	description = "It is thick and viscous, its slowly degrading the container that contains it."
	reagent_state = LIQUID
	color = "#1f081b9f"
	alpha = 175
	scannable = 0
	metabolism = REM * 10
	taste_description = "death"

/datum/reagent/blood/scp_035_substance/get_data()
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
	reagents.add_reagent(/datum/reagent/blood/scp_035_substance, 10)
