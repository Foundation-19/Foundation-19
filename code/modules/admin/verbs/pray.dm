/mob/verb/pray(msg as text)
	set category = "IC"
	set name = "Pray"

	sanitize_and_communicate(/decl/communication_channel/pray, src, msg)
	SSstatistics.add_field_details("admin_verb","PR") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
