/obj/item/organ/internal/augment/active/memory_inhibitor
	name = "class H amnestic implant"
	allowed_organs = list(BP_AUGMENT_HEAD)
	icon_state = "memory_inhibitor"
	desc = "An implant that allows one to have control over their memories, allowing you to set a timer and remove any memories developed within it. This is most popular with the SCP foundation."
	action_button_name = "Activate Class H Amnestic Implant"
	origin_tech = list(TECH_MATERIAL = 5, TECH_BIO = 5, TECH_ESOTERIC = 5)
	var/ready_to_erase = FALSE

/obj/item/organ/internal/augment/active/memory_inhibitor/attack_self(mob/living/M, removed)
	. = ..()

	if(!.)
		return FALSE

	if(!ready_to_erase)
		ready_to_erase = TRUE
		M.visible_message(SPAN_WARNING("[M]'s eyes grow dim."))
		to_chat(M, "<font size='5' color='red'>It feels like a haze falls in your head... You can remember everything just fine, but you'll forget what happens later on.</font>")
		ready_to_erase = TRUE
	else
		ready_to_erase = FALSE
		M.visible_message(SPAN_WARNING("[M]'s eyes regain their focus."))
		to_chat(M, "<font size='5' color='red'>Your mind feels a lot clearer, but... You can't recall the events since the last time you activated your memory inhibitor!</font>")

/obj/item/organ/internal/augment/active/memory_inhibitor/emp_act(mob/living/M, removed)
	if(owner)
		M.visible_message(SPAN_WARNING("[M] looks confused."))
		to_chat(M, "<font size='5' color='red'>You forgot everything that happened today!</font>")
	return TRUE

/obj/item/organ/internal/augment/active/memory_inhibitor/emp_act(severity)
	. = ..()

	if(prob(25))
		emp_act()
