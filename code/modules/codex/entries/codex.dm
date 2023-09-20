/datum/codex_entry/codex
	display_name = "The Codex"
	associated_strings = list("codex")

/datum/codex_entry/codex/New()
	entry_text = "The Codex is an OOC resource - think of it like an in-game wikipedia.<br>\
	You can use <b>Search-Codex <i>topic</i></b> to look something up, or you can click the links provided when examining some objects.<br>"
	..()

/datum/codex_entry/nexus
	display_name = "Nexus"
	associated_strings = list("nexus")
	entry_text = "The place to start with <span codexlink='codex'>The Codex</span><br>"

/datum/codex_entry/nexus/get_text(mob/presenting_to)
	var/list/dat = list(get_header(presenting_to))
	dat += "[entry_text]"
	dat += "<h3>Categories</h3>"
	var/list/categories = list()
	for(var/type in subtypesof(/datum/codex_category))
		var/datum/codex_category/C = type
		var/key = "[initial(C.name)] (category)"
		var/datum/codex_entry/entry = SScodex.get_codex_entry(key)
		if(entry)
			categories += "<li><span codexlink='[key]'>[initial(C.name)]</span> - [initial(C.desc)]"
	dat += jointext(categories, " ")
	return jointext(dat, null)

/client/proc/codex_topic(href, href_list)
	if(href_list["codex_search"]) //nano throwing errors
		search_codex()
		return TRUE
