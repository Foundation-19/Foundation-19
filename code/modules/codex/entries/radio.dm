/datum/codex_entry/radio
	display_name = "Radios"
	associated_paths = list()
	entry_text = "Messages which begin with a ; are broadcast over the radio. \
	If a chat message begins with : or . and a specific letter, that message is broadcast along a specific departmental channel. \
	You can find which keys correspond to which department by examining a headset, or by using the following list:<br>"

/datum/codex_entry/radio/New()
	associated_paths += typesof(/obj/item/device/radio)

	var/list/minimized_radio_keys = list()
	for(var/key in department_radio_keys)

		if(isnull(minimized_radio_keys[department_radio_keys[key]]))
			minimized_radio_keys[department_radio_keys[key]] = list()

		var/letter = lowertext(copytext(key,2,3))

		minimized_radio_keys[department_radio_keys[key]] |= letter

	for(var/dept in minimized_radio_keys)
		entry_text += "<br>[dept] : [english_list(minimized_radio_keys[dept])]"

	. = ..()
