/datum/admins/proc/create_panel_helper(template)
	var/final_html = replacetext(template, "/* ref src */", "\ref[src]")
	//final_html = replacetext(final_html,"/* hreftokenfield */","[HrefTokenFormField()]")
	return final_html

/datum/admins/proc/create_object(mob/user)
	var/static/create_object_html = null
	if (!create_object_html)
		var/objectjs = null
		objectjs = jointext(typesof(/obj), ";")
		create_object_html = file2text('html/create_object.html')
		create_object_html = replacetext(create_object_html, "null /* object types */", "\"[objectjs]\"")

	show_browser(user, create_panel_helper(create_object_html), "window=create_object;size=425x475")
