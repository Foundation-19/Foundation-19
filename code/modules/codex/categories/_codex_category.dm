/datum/codex_category
	var/name = "Generic Category"
	var/desc = "Some description for a category's codex entry."
	/// If true, this category will not be shown at the codex main page. Useful for subcategories.
	var/hide_from_homepage = FALSE
	var/list/items = list()

//Children should call ..() at the end after filling the items list
/datum/codex_category/proc/Initialize()
	if(items.len)
		var/datum/codex_entry/entry = new(_display_name = "[name] (category)")
		entry.entry_text = desc + "<hr>"
		var/list/links = list()
		for(var/item in items)
			links += "<l>[item]</l>"
		entry.entry_text += jointext(links, "<br>")
		SScodex.add_entry_by_string(lowertext(entry.display_name), entry)

