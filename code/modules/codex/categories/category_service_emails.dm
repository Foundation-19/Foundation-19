/datum/codex_category/service_emails/
	name = "Service Emails"
	desc = "Specialized E-mail addresses that have unique functionality."

/datum/codex_category/service_emails/Initialize()
	for(var/thing in subtypesof(/datum/computer_file/data/email_account/service))
		var/datum/computer_file/data/email_account/service/e_acc = thing

		var/datum/codex_entry/entry = new(_display_name = lowertext(trim("[initial(e_acc.login)] (service email)")), _entry_text = initial(e_acc.codex_info))
		entry.update_links()
		SScodex.add_entry_by_string(entry.display_name, entry)
		items += entry.display_name
