//Adminpaper - it's like paper, but more adminny!
/obj/item/paper/admin
	name = "administrative paper"
	desc = "If you see this, something has gone horribly wrong."
	var/datum/admins/admindatum = null

	var/interactions = null
	var/origin = null
	var/datum/offsite/origin_offsite = null
	var/mob/sender = null
	/// List (`/obj/machinery/photocopier/faxmachine`). List of fax machines matching the paper's target department.
	var/list/destinations = list()
	/// String. The paper's target department.
	var/department = null

	/// Template (header/footer) in use for the adminpaper.
	var/decl/offsite_template/template = null
	/// Custom header text for use in template generation.
	var/header_custom_text = null
	/// Custom footer text for use in template generation.
	var/footer_custom_text = null
	/// Should the template header be used in the text?
	var/use_header = TRUE
	/// Should the template footer be used in the text?
	var/use_footer = TRUE

	var/header = ""
	var/footer = ""

	var/unformatedText = ""

/obj/item/paper/admin/New()
	..()
	changeTemplate(/decl/offsite_template/default)
	generateInteractions()

/obj/item/paper/admin/proc/generateInteractions()
	//clear first
	interactions = null

	//Snapshot is crazy and likes putting each topic hyperlink on a seperate line from any other tags so it's nice and clean.
	interactions += "<HR><center><font size= \"1\">The fax will transmit everything above this line</font><br>"
	interactions += "<A href='?src=\ref[src];confirm=1'>Send fax</A> "
	interactions += "<A href='?src=\ref[src];cancel=1'>Cancel fax</A> "
	interactions += "<BR>"
	interactions += "<A href='?src=\ref[src];changelanguage=1'>Change language ([language])</A> "
	interactions += "<A href='?src=\ref[src];changetemplate=1'>Change template</A> "
	interactions += "<A href='?src=\ref[src];toggleheader=1'>Toggle header</A> "
	interactions += "<A href='?src=\ref[src];togglefooter=1'>Toggle footer</A> "
	interactions += "<A href='?src=\ref[src];changeheader=1'>Change header</A> "
	interactions += "<A href='?src=\ref[src];changefooter=1'>Change footer</A> "
	interactions += "<A href='?src=\ref[src];codex=1'>Pencode guide</A> "
	interactions += "<A href='?src=\ref[src];clear=1'>Clear page</A> "
	interactions += "</center>"

/obj/item/paper/admin/proc/adminbrowse()
	updateinfolinks()
	updateDisplay()

/// Changes the adminpaper's template; accepts path or instance of template.
/obj/item/paper/admin/proc/changeTemplate(decl/offsite_template/T)
	if(ispath(T))
		T = SSoffsites.templates[T]
	if(!istype(T))
		return
	header_custom_text = T.default_custom_header
	footer_custom_text = T.default_custom_footer
	template = T
	updateTemplate()

/// Updates the adminpaper's cached header and footer based on the template.
/obj/item/paper/admin/proc/updateTemplate()
	header = use_header ? template.generate_header(origin, header_custom_text) : ""
	footer = use_footer ? template.generate_footer(origin, footer_custom_text) : ""

/obj/item/paper/admin/proc/updateDisplay()
	updateTemplate()
	show_browser(usr, "<HTML><HEAD><meta http-equiv='X-UA-Compatible' content='IE=edge' charset='UTF-8'/><TITLE>[name]</TITLE></HEAD><BODY>[header][info_links][stamps][footer][interactions]</BODY></HTML>", "window=[name];can_close=0")

/// Prompts for custom template header/footer text.
/obj/item/paper/admin/proc/promptTemplateCustom(text, mob/user = usr)
	var/output = tgui_input_text(user, "What custom text do you want in the [text]? Most likely accepts pencode. Cancel to not change, blank text to remove.", "Custom Text", header_custom_text, MAX_PAPER_MESSAGE_LEN, TRUE, TRUE)
	if(!isnull(output)) // important distinction, we want blank text to go through
		if(text == "header")
			header_custom_text = output
		else
			footer_custom_text = output

/obj/item/paper/admin/Topic(href, href_list)
	if(!check_rights(R_ADMIN|R_MOD))
		return

	if(href_list["write"])
		var/id = href_list["write"]
		var/t = tgui_input_text(usr, "Enter what you want to write:", "Write", id == "end" ? unformatedText : null, MAX_PAPER_MESSAGE_LEN, TRUE, FALSE, trim = FALSE)
		if(!t)
			return

		var/last_fields_value = fields

		unformatedText = t
		t = html_encode(t)
		t = parsepencode(t) // Encode everything from pencode to html

		if(fields > 50)//large amount of fields creates a heavy load on the server, see updateinfolinks() and addtofield()
			to_chat(usr, SPAN_WARNING("Too many fields. Sorry, you can't do this."))
			fields = last_fields_value
			return

		if(id!="end")
			addtofield(text2num(id), t) // He wants to edit a field, let him.
		else
			fields -= last_fields_value
			info = t // set the file to the new text
			updateinfolinks()

		updateDisplay()
		update_icon()
		return

	if(href_list["confirm"])
		switch(tgui_alert(usr, "Are you sure you want to send the fax as is?", "Confirm Sending", list("Yes", "No")))
			if("Yes")
				info = header + info + footer
				updateinfolinks()
				close_browser(usr, "window=[name]")
				admindatum.faxCallback(src)
		return

	if(href_list["cancel"])
		close_browser(usr, "window=[name]")
		qdel(src)
		return

	if(href_list["toggleheader"])
		use_header = !use_header
		updateDisplay()
		return

	if(href_list["togglefooter"])
		use_footer = !use_footer
		updateDisplay()
		return

	if(href_list["changeheader"])
		promptTemplateCustom("header")
		updateDisplay()
		return

	if(href_list["changefooter"])
		promptTemplateCustom("footer")
		updateDisplay()
		return

	if(href_list["changetemplate"])
		var/list/valid_templates = list()
		for(var/T in SSoffsites.templates_by_name)
			if(!is_abstract(SSoffsites.templates_by_name[T]))
				valid_templates += T

		var/newTemplate = tgui_input_list(usr, "What template do you want to use?", "Template", valid_templates, template ? template.name : null)
		if(newTemplate && SSoffsites.templates_by_name[newTemplate])
			changeTemplate(SSoffsites.templates_by_name[newTemplate])

		updateDisplay()
		return

	if(href_list["codex"])
		var/datum/codex_entry/entry = SScodex.get_codex_entry("pen")
		if(entry)
			SScodex.present_codex_entry(usr, entry)

	if(href_list["clear"])
		clearpaper()
		updateDisplay()
		return

	if (href_list["changelanguage"])
		choose_language(usr, TRUE)
		updateDisplay()
		return

/obj/item/paper/admin/get_signature()
	return tgui_input_text(usr, "Enter the name you wish to sign the paper with (will prompt for multiple entries, in order of entry)", "Signature")
