/decl/offsite_template/default
	name = "Default Template"
	default_custom_header = "\[scplogo\]"
	takes_custom_footer = TRUE

/decl/offsite_template/default/generate_header(origin, custom)
	var/originhash = md5("[origin]")
	var/challengehash = copytext(md5("[game_id]"), 1, 10) // Changes every round.
	var/text = "\[center\][custom]\[br\]"
	text += "\[b\][origin] Radio Uplink Signed Message\[/b\]\[br\]"
	text += "\[small\]Encryption key: [originhash]\[br\]"
	text += "Challenge: [challengehash]\[br\]\[/small\]\[/center\]\[hr\]"
	return convert(text)

/decl/offsite_template/default/generate_footer(origin, custom)
	var/text = "\[hr\]\[small\]"
	text += "This transmission is intended only for the addressee and may contain confidential information. Any unauthorized disclosure is strictly prohibited. \[br\]\[br\]"
	text += "If this transmission is recieved in error, please notify both the sender and the office of [custom ? custom : origin] Internal Affairs immediately so that corrective action may be taken. "
	text += "Failure to comply is a breach of regulation and may be prosecuted to the fullest extent of the law, where applicable."
	text += "\[/small\]"
	return convert(text)
