/obj/structure/sign/double/barsign/scp_078

/obj/structure/sign/double/barsign/scp_078/examine(mob/user)
	. = ..()
	if(istype(chosen_sign, /datum/barsign/signoff))			// check if the current state is off
		to_chat(user, "You can barely make out the words 'Too Late to Die Young' on this unpowered neon sign. A small card reader is affixed to the electrical plug.")
	else
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			switch(H.scp078_status)
				if(0)
					to_chat(user, "The motto on the sign feels strange and invokes a deep sense of guilt.")
					spawn(300)
					to_chat(user, "You begin to think about how to forgive yourself, and make peace with the past.")
					H.scp078_status = 1
				if(1)
					to_chat(user, "The moments you regret the most come flooding back, all at once. Try as you might, you can't look away.")

/obj/structure/sign/double/barsign/scp_078/attackby(obj/item/I, mob/user)

	var/obj/item/card/id/card = I.GetIdCard()
	if(istype(card))
		if((ACCESS_SCIENCE_LVL1 in card.GetAccess()) || (ACCESS_BAR in card.GetAccess()))
			if(istype(chosen_sign, /datum/barsign/signoff))	// check if the current state is off
				set_sign(new /datum/barsign/toolate)
				to_chat(user, "<span class='notice'>You swipe your card, and the neon sign flickers to life.</span>")
			else
				set_sign(new /datum/barsign/signoff)
				to_chat(user, "<span class='notice'>You swipe your card to switch the neon sign off.</span>")
		else
			to_chat(user, "<span class='warning'>Access denied.</span>")
			return
	else
		return ..()
