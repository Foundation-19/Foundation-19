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

	var/unformatedText = ""

/obj/item/paper/admin/New()
	..()
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
	interactions += "<A href='?src=\ref[src];clear=1'>Clear page</A> "
	interactions += "</center>"

/obj/item/paper/admin/proc/adminbrowse()
	updateinfolinks()
	updateDisplay()

/obj/item/paper/admin/proc/updateDisplay()
	show_browser(usr, "<HTML><HEAD><meta http-equiv='X-UA-Compatible' content='IE=edge' charset='UTF-8'/><TITLE>[name]</TITLE></HEAD><BODY>[info_links][stamps][interactions]</BODY></HTML>", "window=[name];can_close=0")

/obj/item/paper/admin/Topic(href, href_list)
	if(href_list["write"])
		var/id = href_list["write"]
		var/t = sanitize(tgui_input_text(usr, "Enter what you want to write:", "Write", id == "end" ? unformatedText : null, MAX_PAPER_MESSAGE_LEN), MAX_PAPER_MESSAGE_LEN, extra = 0)
		if(!t)
			return
	
		var/last_fields_value = fields

		unformatedText = t
		t = replacetext(t, "\n", "<BR>")
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
				updateinfolinks()
				close_browser(usr, "window=[name]")
				admindatum.faxCallback(src)
		return

	if(href_list["cancel"])
		close_browser(usr, "window=[name]")
		qdel(src)
		return

	if(href_list["clear"])
		clearpaper()
		updateDisplay()
		return

	if (href_list["changelanguage"])
		choose_language(usr, TRUE)
		updateDisplay()
		return

/obj/item/paper/admin/get_signature()
	return input(usr, "Enter the name you wish to sign the paper with (will prompt for multiple entries, in order of entry)", "Signature") as text|null
