/atom/proc/get_codex_value()
	return src

/atom/proc/get_specific_codex_entry()
	if(SScodex.entries_by_path[type])
		return SScodex.entries_by_path[type]

	var/lore = get_lore_info()
	var/mechanics = get_mechanics_info()
	var/antag = get_antag_info()
	if(!lore && !mechanics && !antag)
		return FALSE

	var/datum/codex_entry/entry = new(name, list(type), _lore_text = lore, _mechanics_text = mechanics, _antag_text = antag)
	return entry

/atom/proc/get_mechanics_info()
	return

/atom/proc/get_antag_info()
	return

/atom/proc/get_lore_info()
	return

/atom/var/codex_link_suppressed = 0	// if the codex link shouldn't show up (e.g. chameleon gear, fake plushie bombs)

/atom/examine(mob/user, distance, infix = "", suffix = "")
	. = ..()
	var/datum/codex_entry/entry = SScodex.get_codex_entry(get_codex_value())
	if(entry && (entry.lore_text || entry.mechanics_text || entry.antag_text) && (!(src.codex_link_suppressed) || isghost(user)))
		to_chat(user, SPAN_NOTICE("The codex has <b><a href='?src=\ref[SScodex];show_examined_info=\ref[src];show_to=\ref[user]'>relevant information</a></b> available."))
