/decl/cultural_info/location
	desc_type = "Home System"
	category = TAG_HOMEWORLD
	var/distance = 0
	var/ruling_body = "\[Redacted]"
	var/capital

/decl/cultural_info/location/get_text_details()
	. = list()
	if(!isnull(capital))
		. += "<b>Site Director:</b> [capital]."
	if(!isnull(ruling_body))
		. += "<b>Location:</b> [ruling_body]."
	if(!isnull(distance))
		. += "<b>Distance from urban populace:</b> [distance]."
	. += ..()
