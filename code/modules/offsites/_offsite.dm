// This represents an entity (a group, location, person, etc) not physically represented on the map.

/datum/offsite
	/// Any faxes we have recieved from the site
	var/list/datum/fax_history/recieved_faxes = list()
	/// Any faxes we have sent to the site
	var/list/datum/fax_history/sent_faxes = list()

	/// Any messages we've recieved from the site
	var/list/recieved_messages = list()
