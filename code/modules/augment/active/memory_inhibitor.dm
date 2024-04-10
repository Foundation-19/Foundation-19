/obj/item/organ/internal/augment/active/memory_inhibitor
	name = "class H amnestic implant"
	allowed_organs = list(BP_AUGMENT_HEAD)
	icon_state = "memory_inhibitor"
	desc = "An implant that allows one to have control over their memories, allowing you to set a timer and remove any memories developed within it. This is most popular with the SCP foundation."
	action_button_name = "Activate Class H Amnestic Implant"
	origin_tech = list(TECH_MATERIAL = 5, TECH_BIO = 5, TECH_ESOTERIC = 5)
	var/ready_to_erase = FALSE

/obj/item/organ/internal/augment/active/memory_inhibitor/activate()
	if(!can_activate())
		return

	if(!ready_to_erase)
		ready_to_erase = TRUE
		owner.visible_message(SPAN_WARNING("[owner]'s eyes grow dim."))
		to_chat(owner, "<font size='5' color='red'>It feels like a haze falls in your head... You can remember everything just fine, but you'll forget what happens later on.</font>")
		ready_to_erase = TRUE
	else
		ready_to_erase = FALSE
		owner.visible_message(SPAN_WARNING("[owner]'s eyes regain their focus."))
		to_chat(owner, "<font size='5' color='red'>Your mind feels a lot clearer, but... You can't recall the events since the last time you activated your memory inhibitor!</font>")

/obj/item/organ/internal/augment/active/memory_inhibitor/emp_act(severity)
	. = ..()
	if(severity)
		owner.visible_message(SPAN_WARNING("[owner] looks confused"))
		to_chat(owner, "<font size='5' color='red'>You forgot everything that happened today!</font>")


