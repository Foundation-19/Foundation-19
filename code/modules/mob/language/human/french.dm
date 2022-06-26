/*//////////////////////////////////////////////////////////////////////////////////////////////////////
	Syllable list compiled in this file based on work by Stefan Trost, available at the following URLs
						https://www.sttmedia.com/syllablefrequency-french
*///////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/language/human/french
	name = LANGUAGE_HUMAN_FRENCH
	desc = "A descendant of gallo-romance, the latin spoken in northern gaul, influenced by different celtic languages.\
			Someone who speaks french is called a francophone."
	colour = "french"
	key = "8"
	shorthand = "Fr"
	partial_understanding = list(
		LANGUAGE_HUMAN_SPANISH = 30,
		LANGUAGE_ENGLISH = 20,
		LANGUAGE_HUMAN_GERMAN = 15,
	)
	syllables = list(
		"ai", "an", "ar", "au", "ce", "ch", "co", "de", "em", "en", "er", "es", "et", "eu", "ie", "il", "in", "is",
		"it", "la", "le", "ma", "me", "ne", "ns", "nt", "on", "ou", "pa", "qu", "ra", "re", "se", "te", "ti", "tr",
		"ue", "un", "ur", "us", "ve",
		"ain", "ais", "ait", "ans", "ant", "ati", "ava", "ave", "cha", "che", "com", "con", "dan", "des", "ell",
		"eme", "ent", "est", "éta", "eur", "eux", "fai", "ien", "ion", "ire", "les", "lle", "lus" ,"mai", "men",
		"mme", "nte", "omm", "ont", "our", "ous", "out", "ouv", "par", "pas", "plu", "pou", "que", "res", "son",
		"sur", "tai", "tio", "tou", "tre", "une", "ure", "ver", "vou",
	)
	has_written_form = TRUE
