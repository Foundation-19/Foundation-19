/*//////////////////////////////////////////////////////////////////////////////////////////////////////
	Syllable list compiled in this file based on work by Stefan Trost, available at the following URLs
						https://www.sttmedia.com/syllablefrequency-english
*///////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/language/english
	name = LANGUAGE_ENGLISH
	desc = "A common language spoken around the world with it roots coming down to England. It is so commonly spoken that it is a international language and the foundation's number one way of comunication."
	warning = "Automatically given if spawning with no languages."
	key = "j"
	shorthand = "Eng"
	partial_understanding = list(
		LANGUAGE_HUMAN_GERMAN = 25,
		LANGUAGE_HUMAN_CHINESE = 5,
		LANGUAGE_HUMAN_ARABIC = 5,
		LANGUAGE_HUMAN_INDIAN = 5,
		LANGUAGE_HUMAN_SPANISH = 15,
		LANGUAGE_HUMAN_JAPANESE = 5,
		LANGUAGE_HUMAN_RUSSIAN = 5,,
		LANGUAGE_HUMAN_FRENCH = 15,
		LANGUAGE_GUTTER = 35
	)
	syllables = list(
		"al", "an", "ar", "as", "at", "ea", "ed", "en", "er", "es", "ha", "he", "hi", "in", "is", "it", "le", "me",
		"nd", "ne", "ng", "nt", "on", "or", "ou", "re", "se", "st", "te", "th", "ti", "to", "ve", "wa",
		"all", "and", "are", "but", "ent", "era", "ere", "eve", "for", "had", "hat", "hen", "her", "hin", "his",
		"ing", "ion", "ith", "not", "ome", "oul", "our", "sho", "ted", "ter", "tha", "the", "thi", "tio", "uld",
		"ver", "was", "wit", "you",
	)
	colour = ""
	has_written_form = TRUE
