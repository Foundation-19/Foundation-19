// At minimum every mob has a hear_say proc.

/mob/proc/hear_say(message, verb = "says", datum/language/language = null, alt_name = "",italics = 0, mob/speaker = null, sound/speech_sound, sound_vol)
	if(!client)
		return

	if(speaker && !speaker.client && isghost(src) && get_preference_value(/datum/client_preference/ghost_ears) == GLOB.PREF_ALL_SPEECH && !(can_see(speaker)))
			//Does the speaker have a client?  It's either random stuff that observers won't care about (Experiment 97B says, 'EHEHEHEHEHEHEHE')
			//Or someone snoring.  So we make it where they won't hear it.
		return

	if(language && (language.flags & (NONVERBAL|SIGNLANG)))
		sound_vol = 0
		speech_sound = null

	//make sure the air can transmit speech - hearer's side
	var/turf/T = get_turf(src)
	if ((T) && (!(isghost(src)))) //Ghosts can hear even in vacuum.
		var/datum/gas_mixture/environment = T.return_air()
		var/pressure = (environment)? environment.return_pressure() : 0
		if(pressure < SOUND_MINIMUM_PRESSURE && get_dist(speaker, src) > 1)
			return

		if (pressure < ONE_ATMOSPHERE*0.4) //sound distortion pressure, to help clue people in that the air is thin, even if it isn't a vacuum yet
			italics = 1
			sound_vol *= 0.5 //muffle the sound a bit, so it's like we're actually talking through contact

	if(sleeping || stat == UNCONSCIOUS)
		hear_sleep(message)
		return

	//non-verbal languages are garbled if you can't see the speaker. Yes, this includes if they are inside a closet.
	if (language && (language.flags & NONVERBAL))
		if (!speaker || !can_see(speaker))
			message = stars(message)

	if(!(language && (language.flags & INNATE))) // skip understanding checks for INNATE languages
		if(!say_understands(speaker,language))
			if(!istype(speaker,/mob/living/simple_animal))
				if(language)
					message = language.scramble(message, languages)
				else
					message = stars(message)

	var/speaker_name = "Unknown"
	if(speaker)
		speaker_name = speaker.name

	if(ishuman(speaker))
		var/mob/living/carbon/human/H = speaker
		speaker_name = H.GetVoice()

	if(italics)
		message = "<i>[message]</i>"

	var/track = null
	if(isghost(src))
		if(speaker_name != speaker.real_name && speaker.real_name)
			speaker_name = "[speaker.real_name] ([speaker_name])"
		track = "([ghost_follow_link(speaker, src)]) "
		if(get_preference_value(/datum/client_preference/ghost_ears) == GLOB.PREF_ALL_SPEECH && (can_see(speaker)))
			message = "<b>[message]</b>"

	if(!can_hear(speaker) || get_sound_volume_multiplier() < 0.2)
		if(!language || !(language.flags & INNATE)) // INNATE is the flag for audible-emote-language, so we don't want to show an "x talks but you cannot hear them" message if it's set
			if(speaker == src)
				to_chat(src, SPAN_WARNING("You cannot hear yourself speak!"))
			else if(can_see(speaker))
				to_chat(src, "<span class='name'>[speaker_name]</span>[alt_name] talks but you cannot hear \him.")
	else
		if (language)
			var/nverb = verb
			if (say_understands(speaker, language))
				var/skip = FALSE
				if (isliving(src))
					var/mob/living/L = src
					skip = L.default_language == language
				if (!skip)
					switch(src.get_preference_value(/datum/client_preference/language_display))
						if(GLOB.PREF_FULL) // Full language name
							nverb = "[verb] in [language.name]"
						if(GLOB.PREF_SHORTHAND) //Shorthand codes
							nverb = "[verb] ([language.shorthand])"
						if(GLOB.PREF_OFF)//Regular output
							nverb = verb
			on_hear_say(SPAN_CLASS("game say","[track]<span class='name'>[speaker_name]</span>[alt_name] [language.format_message(message, nverb)]"))
		else
			on_hear_say(SPAN_CLASS("game say","[track]<span class='name'>[speaker_name]</span>[alt_name] [verb], <span class='message'><span class='body'>\"[message]\"</span></span>"))
		if (speech_sound && (get_dist(speaker, src) <= world.view && src.z == speaker.z))
			var/turf/source = speaker? get_turf(speaker) : get_turf(src)
			src.playsound_local(source, speech_sound, sound_vol, 1)

		return message

/mob/proc/on_hear_say(message)
	to_chat(src, message)

/mob/living/silicon/on_hear_say(message)
	var/time = say_timestamp()
	to_chat(src, "[time] [message]")

/mob/proc/hear_radio(message, verb="says", datum/language/language=null, part_a, part_b, part_c, mob/speaker = null, hard_to_hear = 0, vname ="")

	if(!client)
		return

	if(sleeping || stat==1) //If unconscious or sleeping
		hear_sleep(message)
		return

	var/track = null

	//non-verbal languages are garbled if you can't see the speaker. Yes, this includes if they are inside a closet.
	if (language && (language.flags & NONVERBAL))
		if (!speaker || !can_see(speaker))
			message = stars(message)

	if(!(language && (language.flags & INNATE))) // skip understanding checks for INNATE languages
		if(!say_understands(speaker,language))
			if(istype(speaker,/mob/living/simple_animal))
				var/mob/living/M = speaker
				var/datum/say_list/S = M.say_list
				if(S?.speak && S.speak.len)
					message = pick(S.speak)
				else
					return
			else
				if(language)
					message = language.scramble(message, languages)
				else
					message = stars(message)

		if(ishuman(src)) //Memetics checks for audio insulation, I.E if you're wearing mufflers you shouldent hear radios
			var/mob/living/carbon/human/H = src
			if(H.get_audio_insul() == A_INSL_PERFECT)
				hard_to_hear = 5
			else if(H.get_audio_insul() == A_INSL_IMPERFECT)
				hard_to_hear = 3

		if(hard_to_hear)
			if(hard_to_hear <= 5)
				message = stars(message)
			else // Used for compression
				message = RadioChat(null, message, 80, 1+(hard_to_hear/10))

	var/speaker_name = vname ? vname : speaker.name

	if(istype(speaker, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = speaker
		if(H.voice)
			speaker_name = H.voice

	if(hard_to_hear)
		speaker_name = "unknown"

	var/changed_voice

	if(istype(src, /mob/living/silicon/ai) && !hard_to_hear)
		var/jobname // the mob's "job"
		var/mob/living/carbon/human/impersonating //The crew member being impersonated, if any.

		if (ishuman(speaker))
			var/mob/living/carbon/human/H = speaker

			if(H.wear_mask && istype(H.wear_mask,/obj/item/clothing/mask/chameleon/voice))
				changed_voice = 1
				var/list/impersonated = new()
				var/mob/living/carbon/human/I = impersonated[speaker_name]

				if(!I)
					for(var/mob/living/carbon/human/M in SSmobs.mob_list)
						if(M.real_name == speaker_name)
							I = M
							impersonated[speaker_name] = I
							break

				// If I's display name is currently different from the voice name and using an agent ID then don't impersonate
				// as this would allow the AI to track I and realize the mismatch.
				if(I && !(I.name != speaker_name && I.wear_id && istype(I.wear_id,/obj/item/card/id/syndicate)))
					impersonating = I
					jobname = impersonating.get_assignment()
				else
					jobname = "Unknown"
			else
				jobname = H.get_assignment()

		else if (iscarbon(speaker)) // Nonhuman carbon mob
			jobname = "No id"
		else if (isAI(speaker))
			jobname = "AIC"
		else if (isrobot(speaker))
			jobname = "Robot"
		else if (istype(speaker, /mob/living/silicon/pai))
			jobname = "Personal AI"
		else
			jobname = "Unknown"

		if(changed_voice)
			if(impersonating)
				track = "<a href='byond://?src=\ref[src];trackname=[html_encode(speaker_name)];track=\ref[impersonating]'>[speaker_name] ([jobname])</a>"
			else
				track = "[speaker_name] ([jobname])"
		else
			track = "<a href='byond://?src=\ref[src];trackname=[html_encode(speaker_name)];track=\ref[speaker]'>[speaker_name] ([jobname])</a>"

	if(isghost(src))
		if(speaker) //speaker is null when the arrivals annoucement plays
			if(speaker_name != speaker.real_name && !isAI(speaker)) //Announce computer and various stuff that broadcasts doesn't use it's real name but AI's can't pretend to be other mobs.
				speaker_name = "[speaker.real_name] ([speaker_name])"
			track = "([ghost_follow_link(speaker, src)]) [speaker_name]"
		else
			track = "[speaker_name]"

	var/formatted
	if (language)
		var/nverb = verb
		if (say_understands(speaker, language))
			var/skip = FALSE
			if (isliving(src))
				var/mob/living/L = src
				skip = L.default_language == language
			if (!skip)
				switch(src.get_preference_value(/datum/client_preference/language_display))
					if (GLOB.PREF_FULL)
						nverb = "[verb] in [language.name]"
					if(GLOB.PREF_SHORTHAND)
						nverb = "[verb] ([language.shorthand])"
					if(GLOB.PREF_OFF)
						nverb = verb
		formatted = language.format_message_radio(message, nverb)
	else
		formatted = "[verb], <span class=\"body\">\"[message]\"</span>"
	if(can_hear(src))
		var/mob/living/carbon/human/H = src
		if(istype(H) && H.has_headset_in_ears() && prob(20))
			to_chat(src, SPAN_WARNING("You feel your headset vibrate but can hear nothing from it!"))
	else
		on_hear_radio(part_a, speaker_name, track, part_b, part_c, formatted)

/proc/say_timestamp()
	return SPAN_CLASS("say_quote","\[[station_time_timestamp("hh:mm")]\]")

/mob/proc/on_hear_radio(part_a, speaker_name, track, part_b, part_c, formatted)
	to_chat(src, "[part_a][speaker_name][part_b][formatted][part_c]")

/mob/observer/ghost/on_hear_radio(part_a, speaker_name, track, part_b, part_c, formatted)
	to_chat(src, "[part_a][track][part_b][formatted][part_c]")

/mob/living/silicon/on_hear_radio(part_a, speaker_name, track, part_b, part_c, formatted)
	var/time = say_timestamp()
	to_chat(src, "[time][part_a][speaker_name][part_b][formatted][part_c]")

/mob/living/silicon/ai/on_hear_radio(part_a, speaker_name, track, part_b, part_c, formatted)
	var/time = say_timestamp()
	to_chat(src, "[time][part_a][track][part_b][formatted][part_c]")

/mob/proc/hear_signlang(message, verb = "gestures", datum/language/language, mob/speaker = null)
	if(!client)
		return

	if(sleeping || stat == UNCONSCIOUS)
		return 0

	if(say_understands(speaker, language))
		var/nverb = null
		switch(src.get_preference_value(/datum/client_preference/language_display))
			if(GLOB.PREF_FULL) // Full language name
				nverb = "[verb] in [language.name]"
			if(GLOB.PREF_SHORTHAND) //Shorthand codes
				nverb = "[verb] ([language.shorthand])"
			if(GLOB.PREF_OFF)//Regular output
				nverb = verb
		message = "<B>[speaker]</B> [nverb], \"[message]\""
	else
		var/adverb
		var/length = length(message) * pick(0.8, 0.9, 1.0, 1.1, 1.2)	//Inserts a little fuzziness.
		switch(length)
			if(0 to 12) 	adverb = " briefly"
			if(12 to 30)	adverb = " a short message"
			if(30 to 48)	adverb = " a message"
			if(48 to 90)	adverb = " a lengthy message"
			else        	adverb = " a very lengthy message"
		message = "<B>[speaker]</B> [verb][adverb]."

	if(src.status_flags & PASSEMOTES)
		for(var/obj/item/holder/H in src.contents)
			H.show_message(message)
		for(var/mob/living/M in src.contents)
			M.show_message(message)
	src.show_message(message)

/mob/proc/hear_sleep(message)
	var/heard = ""
	if(prob(15))
		var/list/punctuation = list(",", "!", ".", ";", "?")
		var/list/messages = splittext(message, " ")
		var/R = rand(1, messages.len)
		var/heardword = messages[R]
		if(copytext(heardword,1, 1) in punctuation)
			heardword = copytext(heardword,2)
		if(copytext(heardword,-1) in punctuation)
			heardword = copytext(heardword,1,length(heardword))
		heard = "<span class = 'game_say'>...You hear something about...[heardword]</span>"

	else
		heard = "<span class = 'game_say'>...<i>You almost hear someone talking</i>...</span>"

	to_chat(src, heard)
