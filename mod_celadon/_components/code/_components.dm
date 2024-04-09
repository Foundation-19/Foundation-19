// Фокусировка взгляда на Alt + СКМ | => code/_onclick/click.dm

/mob/proc/AltMiddleClickOn(atom/A)
	face_direction(A)
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
