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

// Admin Announce

/datum/admins/proc/announce()
	set category = "Admin"
	set name = "Announce"
	set desc="Announce your desires to the world"
	if(!check_rights(0))	return

	var/message = input("Global message to send:", "Admin Announce", null, null) as message
	var/max_length = 1000
	if(message)
		if(length(message) >= max_length)
			var/overflow = ((length(message)+1) - max_length)
			to_chat(usr, SPAN_WARNING("Your message is too long by [overflow] character\s."))
			return
		message = copytext_char(message,1,max_length)
		message = replacetext(message, "\n", "<br>") // required since we're putting it in a <p> tag
		to_world("<span class=notice><b>[usr.key] Announces:</b><p style='text-indent: 50px'>[message]</p></span>")
		log_admin("Announce: [key_name(usr)] : [message]")
	SSstatistics.add_field_details("admin_verb","A") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/mob/living/scp096
	var/seedarkness = 1

/mob/living/scp096/verb/toggle_darkness()
	set name = "Toggle Darkness"
	set category = "IC"
	seedarkness = !(seedarkness)
	set_see_invisible(SEE_INVISIBLE_NOLIGHTING)
	to_chat(src, "You [(seedarkness?"now":"no longer")] see darkness.")
