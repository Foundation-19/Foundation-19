/client/proc/cmd_admin_say(msg as text)
	set name = "Asay" //Gave this shit a shorter name so you only have to time out "asay" rather than "admin say" to use it --NeoFite
	set category = "Staff Help"
	if(!check_rights(R_ADMIN|R_MOD))	return

	msg = sanitize(msg)
	if(!msg)	return

	log_admin("ADMIN: [key_name(src)] : [msg]")

	if(check_rights(R_ADMIN|R_MOD,0))
		for(var/client/C in GLOB.admins)
			if(check_rights(R_ADMIN|R_MOD,0,C))
				to_chat(C, SPAN_CLASS("admin_channel","" + create_text_tag("admin", "ADMIN:", C) + " <span class='name'>[key_name(usr, 1)]</span>([admin_jump_link(mob, src)]): <span class='message linkify'>[msg]</span>"))

	SSstatistics.add_field_details("admin_verb","M") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/cmd_mentor_say(msg as text)
	set name = "Msay"
	set desc = "Chat with other mentors."
	set category = "Staff Help"

	if(!check_rights(R_ADMIN|R_MOD|R_MENTOR))
		return

	msg = sanitize(msg)
	log_admin("MENTOR: [key_name(src)] : [msg]")

	if (!msg)
		return

	if(check_rights(R_ADMIN, 0))
		usr = SPAN_CLASS("admin","[usr]")
	for(var/client/C in GLOB.admins)
		to_chat(C, SPAN_CLASS("mentor_channel","" + create_text_tag("msay", "MSAY:", C) + " " + SPAN_BOLD(key_name_mentor(src)) + ": <span class='message'>[msg]</span>"))

	SSstatistics.add_field_details("admin_verb","MS") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
