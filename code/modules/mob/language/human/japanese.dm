/datum/language/human/japanese
	name = LANGUAGE_HUMAN_JAPANESE
	desc = "'Standard Nihongo Japanese', mostly just known as Japanese, is the official language of Japan.\
			 It is based on the Kanto dialect of Japan and is the language of some english speakers."
	colour = "japanese"
	key = "6"
	shorthand = "Jap"
	space_chance = 25
	whisper_verb = "whispers"
	partial_understanding = list(
		LANGUAGE_HUMAN_GERMAN = 5,
		LANGUAGE_HUMAN_ARABIC = 5,
		LANGUAGE_HUMAN_CHINESE = 35,
		LANGUAGE_HUMAN_INDIAN = 5,
		LANGUAGE_HUMAN_SELENIAN = 10,
		LANGUAGE_ENGLISH = 5
	)
	syllables = list(
		"da", "do", "de", "ra", "ri", "ro", "re", "tsu", "me", "mi", "ma", "ka", "ki", "ko",
		"ke", "shi", "sho", "sha", "sa", "se", "su", "si", "ou", "na", "no", "ni", "ne", "te", "ta",
		 "to", "ti", "wa", "wo", "wi", "we", "ho", "ga", "ge", "go", "gi"
	)
	has_written_form = TRUE