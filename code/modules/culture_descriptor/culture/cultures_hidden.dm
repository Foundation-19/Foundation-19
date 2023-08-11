/decl/cultural_info/culture/hidden
	description = "This is a hidden cultural detail. If you can see this, please report it on the tracker."
	hidden = TRUE
	hidden_from_codex = TRUE

/decl/cultural_info/culture/hidden/monkey
	name = CULTURE_MONKEY
	language = LANGUAGE_PRIMITIVE

/decl/cultural_info/culture/hidden/monkey/get_random_name()
	return "[lowertext(name)] ([rand(100,999)])"
