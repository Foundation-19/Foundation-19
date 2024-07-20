/obj/item/device/megaphone
	name = "megaphone"
	desc = "A device used to project your voice. Loudly."
	icon_state = "megaphone"
	item_state = "radio"
	w_class = ITEM_SIZE_SMALL
	obj_flags = OBJ_FLAG_CONDUCTIBLE

	var/spamcheck = 0
	var/emagged = FALSE
	var/list/insultmsg = list("FUCK EVERYONE!", "I'M A TATER!", "ALL SECURITY TO SHOOT ME ON SIGHT!", "I HAVE A BOMB!", "CAPTAIN IS A COMDOM!", "FOR THE SYNDICATE!")

/obj/item/device/megaphone/equipped(mob/user, slot)
	. = ..()
	if(slot == slot_l_hand || slot == slot_r_hand)
		RegisterSignal(user, COMSIG_LIVING_TREAT_MESSAGE, PROC_REF(handle_speech))

/obj/item/device/megaphone/dropped(mob/user)
	. = ..()
	UnregisterSignal(user, COMSIG_LIVING_TREAT_MESSAGE)

/obj/item/device/megaphone/proc/handle_speech(mob/living/source, list/speech_args, datum/language/speaking)
	SIGNAL_HANDLER
	if(world.time < spamcheck)
		to_chat(source, SPAN_WARNING("\The [src] is recharging!"))
		return

	spamcheck = world.time + 5
	if(emagged)
		speech_args[SPEECH_ARG_MESSAGE] = "<b><font size=3>[capitalize(pick(insultmsg))]</b></font>"
	speech_args[SPEECH_ARG_MESSAGE] = "<b><font size=3>[capitalize(speech_args[SPEECH_ARG_MESSAGE])]</b></font>"

/obj/item/device/megaphone/emag_act(remaining_charges, mob/user)
	if(!emagged)
		to_chat(user, SPAN_WARNING("You overload \the [src]'s voice synthesizer."))
		emagged = TRUE
		return 1
