/decl/offsite_template/goc
	name = "GOC Template"
	uses_body = TRUE
	uses_header = FALSE
	uses_footer = FALSE

/decl/offsite_template/goc/generate_body(origin)
	var/text = @{"[table][row][cell][center][h1]United Nations Global Occult Coalition[/h1][/center][center][goclogo][/center][center][small]Survival. Concealment. Protection. Destruction. Education.
The Global Occult Coalition stands ready to defend humanity against all foes. Whether it likes it or not.[/center][/small][center][row][cell][center][h2]PSYCHE General Transmission[/h2][h3][time], [date][/h3][table]
[row][cell][center]To: [field] (serial: [field])[cell][center]From: [field], PSYCHE Command, North America Region[/table][/center][h2]Topic: [field][/h2][h3]Please be advised of the following critical updates:[/h3][field][hr][center][small]Confidentiality Notice: This fax transmission may contain confidential information intended only for the use of the recipient(s) named above. If you are not the intended recipient, you are hereby notified that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this fax in error, please notify the sender immediately and destroy any copies of this transmission.[/center][/small][/table]"}
	return convert(text)
