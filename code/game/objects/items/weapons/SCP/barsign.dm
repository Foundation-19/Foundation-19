/obj/structure/sign/double/barsign
	desc = "A jumbo-sized LED sign. This one seems to be showing its age."
	icon = 'icons/obj/barsigns.dmi'
	icon_state = "empty"
	appearance_flags = 0
	anchored = TRUE
//	var/cult = 0
	var/toolate = 0
	var/toolate_on = 0

/obj/structure/sign/double/barsign/scp_078
	name = "SCP-078"
	desc = "If your ID has science access, you may swipe it on this sign to alter its display."
	icon = 'icons/obj/barsigns.dmi'
	icon_state = "Off"
	appearance_flags = 0
	anchored = TRUE
	toolate = 1
	toolate_on = 0

/obj/structure/sign/double/barsign/examine(mob/user)
	. = ..()
	switch(icon_state)
		if("Off")
			if(toolate == 1)
				to_chat(user, "You can barely make out the words 'Too Late To Die Young' on this unpowered neon sign. A small card reader is affixed to the electrical plug.")
			else
				to_chat(user, "It appears to be switched off.")
		if("narsiebistro")
			to_chat(user, "It shows a picture of a large black and red being. Spooky!")
		if("toolate")
			to_chat(user, "The moments you regret the most come flooding back, all at once. Try as you might, you can't look away.")
			spawn(300)
				to_chat(user, "You begin to think about how to forgive yourself, and make peace with the past.")
				if(ishuman(user))
					var/mob/living/carbon/human/H = user
					if(H.dies_young == 0)
						H.dies_young = 1
		if("on", "empty")
			to_chat(user, "The lights are on, but there's no picture.")
		else
			to_chat(user, "It says '[icon_state]'")

/obj/structure/sign/double/barsign/New()
	..()
	if(!toolate)
		icon_state = pick(get_valid_states())

/obj/structure/sign/double/barsign/attackby(obj/item/I, mob/user)
	if(cult)
		return ..()

	var/obj/item/card/id/card = I.GetIdCard()
	if(istype(card))

		if(toolate == 1)
			if(access_sciencelvl1 in card.GetAccess())
				if(toolate_on)
					toolate_on = 0
					icon_state = "Off"
					to_chat(user, "<span class='notice'>You swipe your card to switch the neon sign off.</span>")
				else
					toolate_on = 1
					icon_state = "toolate"
					to_chat(user, "<span class='notice'>You swipe your card, and the neon sign flickers to life.</span>")
			else
				to_chat(user, "<span class='warning'>The power supply flashes a red light - access denied.</span>")
			return
		else
			if(access_dclasskitchen in card.GetAccess())
				var/sign_type = input(user, "What would you like to change the barsign to?") as null|anything in get_valid_states(0)
				if(!sign_type)
					return
				icon_state = sign_type
				to_chat(user, "<span class='notice'>You change the barsign.</span>")
			else
				to_chat(user, "<span class='warning'>Access denied.</span>")
			return

	return ..()
