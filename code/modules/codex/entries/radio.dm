/datum/codex_entry/radio
	display_name = "Radios"
	associated_paths = list()
	lore_text = "While there are many companies who produce handheld radios and headsets, the Foundation only issues internally-produced radios \
	to most of its staff. Not only does this protect against security threats, it also reduces the chance of equipment malfunction during containment breaches."
	mechanics_text = "Messages which begin with a ; are broadcast over the radio. \
	If a chat message begins with : or . and a specific letter, that message is broadcast along a specific departmental channel. \
	You can find which keys correspond to which department by examining a headset, or by using the following list:<br>"

/datum/codex_entry/radio/New(_display_name, list/_associated_paths, list/_associated_strings, _lore_text, _mechanics_text, _antag_text)
	associated_paths = typesof(/obj/item/device/radio)

	var/list/minimized_radio_keys = list()
	for(var/key in department_radio_keys)

		if(isnull(minimized_radio_keys[department_radio_keys[key]]))
			minimized_radio_keys[department_radio_keys[key]] = list()

		var/letter = lowertext(copytext(key,2,3))

		minimized_radio_keys[department_radio_keys[key]] |= letter

	for(var/dept in minimized_radio_keys)
		mechanics_text += "<br>[dept] : [english_list(minimized_radio_keys[dept])]"

	. = ..()
