// Фокусировка взгляда на Alt + СКМ | => code/_onclick/click.dm

/mob/proc/AltMiddleClickOn(atom/A)
	face_direction(A)
	return

/mob/living/scp096/CtrlShiftClickOn(atom/A)
	stop_scream()
	return
// Моргания на кнопку V | => code/modules/keybindings/human.dm

/datum/keybinding/human/cause_blink
	hotkey_keys = list("V")
	name = "c_blink"
	full_name = "Cause blink"
	description = "Get blink!!"

/datum/keybinding/human/cause_blink/down(client/user)
	var/mob/living/carbon/human/H = user.mob
	H.cause_blink()
	return TRUE

/mob/living/scp096
	var/seedarkness = 1

/mob/living/scp096/verb/toggle_darkness()
	set name = "Toggle Darkness"
	set category = "IC"
	seedarkness = !(seedarkness)
	set_see_invisible(SEE_INVISIBLE_NOLIGHTING)
	to_chat(src, "You [(seedarkness?"now":"no longer")] see darkness.")
