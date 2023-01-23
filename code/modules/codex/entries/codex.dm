/datum/codex_entry/codex
	display_name = "The Codex"
	associated_strings = list("codex")
	lore_text = "The Codex is a widely-used encyclopedia maintained and distributed by the Foundation, for the Foundation. The intent of this document is to arm all staff with basic information of mundane and anomalous objects they might encounter. \
	<br><br> \
	Access to the Codex is transferred to all hired personnel via a memetically-spread and nomenclaturely-updated concept. \
	<br><br> \
	It has been brought to the attention of the Overseer Council that several individuals and groups have altered the documentation system for malicious use. Please report any potential misuse to Security."

/datum/codex_entry/codex/New()
	mechanics_text = "The Codex is both an IC and OOC resource. ICly, it is as described; an encyclopedia. You can use <b>Search-Codex <i>topic</i></b> to look something up, or you can click the links provided when examining some objects. \
	<br><br> \
	Any of the lore you find in the Codex, designated by <b><font color = '[CODEX_COLOR_LORE]'>green</font></b> text, can be freely referenced in-character. \
	<br><br> \
	OOC information on various mechanics and interactions is marked by <b><font color = '[CODEX_COLOR_MECHANICS]'>blue</font></b> text. \
	<br><br> \
	Information for antagonists will not be shown unless you are an antagonist, and is marked by <b><font color = '[CODEX_COLOR_ANTAG]'>red</font></b> text."
	..()

/datum/codex_entry/nexus
	display_name = "Nexus"
	associated_strings = list("nexus")
	mechanics_text = "The place to start with <span codexlink='codex'>The Codex</span><br>"

/datum/codex_entry/nexus/get_text(var/mob/presenting_to)
	var/list/dat = list(get_header(presenting_to))
	dat += "[mechanics_text]"
	dat += "<h3>Categories</h3>"
	var/list/categories = list()
	for(var/type in subtypesof(/datum/codex_category))
		var/datum/codex_category/C = type
		var/key = "[initial(C.name)] (category)"
		var/datum/codex_entry/entry = SScodex.get_codex_entry(key)
		if(entry)
			categories += "<li><span codexlink='[key]'>[initial(C.name)]</span> - [initial(C.desc)]"
	dat += jointext(categories, " ")
	return "<font color = '[CODEX_COLOR_MECHANICS]'>[jointext(dat, null)]</font>"

/client/proc/codex_topic(href, href_list)
	if(href_list["codex_search"]) //nano throwing errors
		search_codex()
		return TRUE

	if(href_list["codex_index"]) //nano throwing errors
		list_codex_entries()
		return TRUE
