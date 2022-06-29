GLOBAL_LIST_EMPTY(scp012s)

/obj/item/paper/scp012
	name = "SCP-012"
	icon = 'icons/SCP/scp-012.dmi'
	desc = "An old paper of handwritten sheet music, titled \"On Mount Golgotha\". The writing is in a conspicuous blood red."
	w_class = ITEM_SIZE_NO_CONTAINER //Quick fix that may need more work in the future.
//	nothrow = TRUE
	SCP = /datum/scp/scp_012
	anchored = 1
	var/ticks = 0

/datum/scp/scp_012
	name = "SCP-012"
	designation = "012"
	classification = EUCLID

/obj/item/paper/scp012/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)
	GLOB.scp012s += src

/obj/item/paper/scp012/Destroy()
	STOP_PROCESSING(SSobj, src)
	GLOB.scp012s -= src
	return ..()

/obj/item/paper/scp012/Process()

	++ticks

	// find a victim in case the last one is gone
	var/mob/living/carbon/human/affecting = null
	for (var/mob/living/carbon/human/H in shuffle(view(2, src)))
		if (can_affect(H))
			affecting = H
			break

	// we're done here
	if (!affecting)
		return

	// make the victim come towards us
	if (!(affecting in view(1, src)))
		affecting.Move(get_step(affecting, get_dir(affecting, src)))

	// why is this such a horrible system
	var/datum/gender/T = gender_datums[affecting.get_gender()]

	// do fun stuff
	if (affecting in view(1, src))

		// once every 20 seconds
		if (!(ticks % 20))
			affecting.visible_message("<span class = \"danger\"><em>[affecting] rips into [T.his] own flesh and covers [T.his] hands in blood!</em></span>")
			affecting.emote("scream")
			affecting.adjustBruteLoss(25)
			affecting.drip(50)
		// once every 15 seconds
		else if (!(ticks % 15) && affecting.getBruteLoss())
			affecting.visible_message("<span class = \"warning\">[affecting] smears [T.his] blood on \"[name]\", writing musical notes...")
		// otherwise
		else if (prob(5))
			if (prob(50))
				affecting.visible_message("<span class = \"notice\">[affecting] looks at \"[name]\" and sighs dejectedly.</span>")
				playsound(affecting, "sound/voice/emotes/sigh_[T.key].ogg", 100)
			else
				affecting.visible_message("<span class = \"notice\">[affecting] looks at \"[name]\" and cries.</span>")
				playsound(affecting, "sound/voice/emotes/[T.key]_cry[pick(1,2)].ogg", 100)

/obj/item/paper/proc/can_affect(var/mob/living/carbon/human/H)
	return H.stat == CONSCIOUS && !(src in H.hidden_atoms) && !H.blinded && !istype(H.glasses, /obj/item/clothing/glasses/sunglasses)
