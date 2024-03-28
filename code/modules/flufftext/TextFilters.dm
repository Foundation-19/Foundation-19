/*
RadioChat Filter.
args:
message - returns a distorted version of this
distortion_chance - the chance of a filter being applied to each character.
distortion_speed - multiplier for the chance increase.
distortion - starting distortion.
english_only - whether to use traditional english letters only (for use in NanoUI)
*/
/proc/RadioChat(mob/living/user, message, distortion_chance = 60, distortion_speed = 1, distortion = 1, english_only = 0)
	var/datum/language/language
	if(user)
		language = user.get_default_language()
	message = html_decode(message)
	var/new_message = ""
	var/input_size = length(message)
	var/lentext = 0
	if(input_size < 20) // Short messages get distorted too. Bit hacksy.
		distortion += (20-input_size)/2
	while(lentext <= input_size)
		var/newletter=copytext(message, lentext, lentext+1)
		if(!prob(distortion_chance))
			new_message += newletter
			lentext += 1
			continue
		if(newletter != " ")
			if(prob(0.08 * distortion)) // Major cutout
				newletter = "*zzzt*"
				lentext += rand(1, (length(message) - lentext)) // Skip some characters
				distortion += 1 * distortion_speed
			else if(prob(0.8 * distortion)) // Minor cut out
				if(prob(25))
					newletter = ".."
				else if(prob(25))
					newletter = " "
				else
					newletter = ""
				distortion += 0.25 * distortion_speed
			else if(prob(2 * distortion)) // Mishearing
				if(language && language.syllables && prob(50))
					newletter = pick(language.syllables)
				else
					newletter =	pick("a","e","i","o","u")
				distortion += 0.25 * distortion_speed
			else if(prob(1.5 * distortion)) // Mishearing
				if(language && prob(50))
					if(language.syllables)
						newletter = pick (language.syllables)
					else
						newletter = "*"
				else
					if(english_only)
						newletter += "*"
					else
						newletter = pick("ø", "Ð", "%", "æ", "µ")
				distortion += 0.5 * distortion_speed
			else if(prob(0.75 * distortion)) // Incomprehensible
				newletter = pick("<", ">", "!", "$", "%", "^", "&", "*", "~", "#")
				distortion += 0.75 * distortion_speed
			else if(prob(0.05 * distortion)) // Total cut out
				if(!english_only)
					newletter = "¦w¡¼b»%> -BZZT-"
				else
					newletter = "srgt%$hjc< -BZZT-"
				new_message += newletter
				break
			else if(prob(2.5 * distortion)) // Sound distortion. Still recognisable, mostly.
				switch(lowertext(newletter))
					if("s")
						newletter = "$"
					if("e")
						newletter = "£"
					if("w")
						newletter = "ø"
					if("y")
						newletter = "¡"
					if("x")
						newletter = "æ"
					if("u")
						newletter = "µ"
		else
			if(prob(0.2 * distortion))
				newletter = " *crackle* "
				distortion += 0.25 * distortion_speed
		if(prob(20))
			capitalize(newletter)
		new_message += newletter
		lentext += 1
	return new_message
