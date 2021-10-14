/client/proc/dooc(msg as text)
	set category = "Donator"
	set name = "DOOC"
	set desc = "Donator OOC"

	sanitize_and_communicate(/decl/communication_channel/dooc, src, msg)