/*//////////////////////////////////////////////////////////////////////////////////////////////////////
	Syllable list compiled in this file based on work by Stefan Trost, available at the following URL
						https://www.sttmedia.com/syllablefrequency-hindi
*///////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/language/human/indian
	name = LANGUAGE_HUMAN_INDIAN
	desc = "A pluricentric language, widely used as the lingua franca in Northern India and Pakistan.\
			 Also known as 'Hindi-Urdu', it can be seen as a 'unifying' or 'fusion language' derived from both."
	colour = "indian"
	key = "3"
	shorthand = "Hindi"
	space_chance = 30
	whisper_verb = "whispers"
	partial_understanding = list(
		LANGUAGE_HUMAN_GERMAN = 5,
		LANGUAGE_HUMAN_CHINESE = 5,
		LANGUAGE_HUMAN_ARABIC = 10,
		LANGUAGE_HUMAN_SELENIAN = 5,
		LANGUAGE_ENGLISH = 20
	)
	syllables = list(
		"ek", "aur", "ki", "ki", "ke", "de", "thaa", "ne", "me", "yaa", "se", "haa",
		"hai", "aar", "en", "ain", "y", "ke", "hai", "yaa", "en", "me", "aur", "se",
		"ki", "ne", "ek", "aar", "ain", "ki", "haa", "y", "thaa", "de", "usk", "use",
		"khaa", "kin", "kiy", "ky", "dei", "dekh", "nhi", "pne", "pr", "baar", "yon",
		"men", "iyaa", "main", "apn"
	)
	has_written_form = TRUE
