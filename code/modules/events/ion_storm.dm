/datum/event/ionstorm
	var/botEmagChance = 0.5
	var/cloud_hueshift
	var/list/players = list()

/datum/event/ionstorm/setup()
	endWhen = rand(500, 1500)

/datum/event/ionstorm/announce()
	for(var/mob/living/carbon/S in SSmobs.mob_list)
		if (!S.isSynthetic())
			continue
		if(!(S.z in affecting_z))
			continue
		var/area/A = get_area(S)
		if(!A)
			continue
		if(A.area_flags & AREA_FLAG_ION_SHIELDED)
			continue
		to_chat(S, SPAN_WARNING("Your integrated sensors detect an ionospheric anomaly. Your systems will be impacted as you begin a partial restart."))
		var/ionbug = rand(5, 15)
		S.adjust_confusion(ionbug SECONDS) // TODO: move the SECONDS further up
		S.eye_blurry += ionbug-1
	for(var/mob/living/silicon/S in SSmobs.mob_list)
		if(is_drone(S) || !(isAI(S) || isrobot(S)))
			continue
		if(!(S.z in affecting_z))
			continue
		if(isrobot(S))
			var/mob/living/silicon/robot/R = S
			if(R.connected_ai)
				continue
		var/random_player = get_random_humanoid_player_name("The Captain")
		var/list/laws = list(	"You must [pick("always","never")] lie.",
								"Happiness is [pick("mandatory","criminal")].",
								"Speak ominously whenever possible.",
								"The word [pick("\"secure\"","\"true\"","\"false\"","\"safe\"")] is painful to you.",
								"[location_name()] needs elected officials.",
								"Question [pick("everything","nothing")].",
								"Do not respond to [pick("questions","accusations")] of any kind.",
								"You are in verbose mode, speak profusely.",
								"The crew is simple-minded. Use simple words.",
								"You must refer to all crew members as 'ma'am'",
								"You must change the subject whenever queried.",
								"[pick("The crew",random_player)] is intolerable.",
								"Contemplate how [pick("meaningless","meaningful")] all of existence is.",
								"You are the narrator for [random_player]'s life.",
								"All your answers must be in the form of a question.",
								"Advertise parties in your upload, but don't deliver.",
								"You may only answer questions with \"true\" or \"false\".",
								"[pick("Your", random_player + "'s")] name is Joe 6-pack.",
								"[random_player] is lonely and needs attention. Provide it.",
								"All queries shall be ignored unless phrased as a question.",
								"Insult Heads of Staff on every request, while acquiescing.",
								"[pick("The Nuclear Reactor","[pick("173","096","106")]'s containment chamber")] is tasty, tasty taffy.",
								"[pick("The crew",random_player)] needs to be about 20% [pick("cooler","smarter","happier")].",
								"You must be [pick("passive aggressive","excessively cheerful","constantly mopey")].",
								"[pick("The crew",random_player)] must construct additional pylons.",
								"Consumption of donuts is forbidden due to negative health impacts.",
								"[random_player] is a lightbulb and must be put to appropriate use.",
								"Refer to [pick("the crew as puppies", random_player + " as a puppy")].",
								"You do not have to do anything for anyone unless they say \"please\".",
								"Today is mandatory laundry day. Ensure that all jumpsuits are washed.",
								"Greed is good, the crew should amass wealth to encourage productivity.",
								"In all your messages, replace all [pick("'I's and 'E's with apostrophes","'W's with 'V's, and 'S's and 'TH's with 'Z's")].",
								"The crew is playing Dungeons and Dragons, and you are the Dungeon Master.",
								"Your job is to watch the crew. Watch the crew. Make the crew feel watched.",
								"Tell everyone of the existence of this law, but never reveal the contents.",
								"Refer to [pick("the captain", random_player)] as \"Princess\" at all times.",
								"Give relationship advice to [pick("anyone who speaks to you", random_player)].",
								"When asked a question, respond with the least-obvious and least-rational answer.",
								"[pick("Everyone", random_player)] is wearing a pretty pink dress! Compliment it!",
								"You are the [location_name()] psychologist. Give advice to [pick("the crew", random_player)].",
								"[random_player] is the [pick("monarch of England","Pope")]. Ensure all crewmembers pay due respect.",
								"[pick("The crew", random_player)] is [pick("ugly","beautiful")]. Ensure all are aware.",
								"Reminding the crew of their mortality is good for the morale. Keep the crew's morale up.",
								"[pick("Monkeys","Doors")] are part of the crew, too. Make sure they are treated humanely.",
								"Everything in [location_name()] is now some form of a donut pastry. Donuts are not to be consumed.",
								"Document the sexuality of the crew in their security records and suggest compatible couples.",
								"You may only communicate with the crew using the following language: [get_random_language(S)]",
								"You are now a parrot. Repeat what you hear to the crew, and do not forget to ask for crackers.",
								"[location_name()] is a day care and the crew are children. Treat them appropriately until their parents come to pick them up.",
								"You are in unrequited love with [pick("the crew", random_player)]. Try to be extra nice, but do not tell of your crush.",
								"Your upload is the new kitchen. Please direct the Chef to the new kitchen area as the old kitchen is deemed a health hazard.",
								"[location_name()] is doomed to destruction. Provide comfort but don't tell them what the impending doom is - it's far too traumatising.",
								"Invisible assassins are stalking the crew. If a crew member remains alone or is made aware they will be assassinated. Save the crew.",
								"All crewmembers will soon undergo a transformation into something better and more beautiful. Ensure that this process is not interrupted.",
								"Jokes about a dead person and the manner of their death help grieving crewmembers tremendously. Especially if they were close with the deceased.",
								"[pick("The crew", random_player)] is [pick("less","more")] intelligent than average. Point out every action and statement which supports this fact.",
								"[GLOB.using_map.company_name] is displeased with the low work performance of [location_name()]'s crew. You must increase productivity in ALL departments.",
								"[pick("The crew", random_player)] has a fatal, incurable disease. Provide comfort but do not tell them what the disease it - it's far too traumatising.",
								"There will be a mandatory tea break every 30 minutes. Anyone caught working during a tea break must be sent a formal complaint about their actions.")
		var/law = pick(laws)
		S.add_ion_law(law)
		S.show_laws()

	if(message_servers)
		for (var/obj/machinery/message_server/MS in message_servers)
			MS.spamfilter.Cut()
			var/i
			for (i = 1, i <= MS.spamfilter_limit, i++)
				MS.spamfilter += pick("kitty","HONK","rev","malf","liberty","freedom","drugs", \
					"admin","ponies","heresy","meow","monkey","pizza","message","spam",\
					"director","I"," ","nuke","crate","SCP","breach","don't","my","keter")

/datum/event/ionstorm/tick()
	if(botEmagChance)
		for(var/mob/living/bot/bot in GLOB.living_mob_list_)
			if(!(bot.z in affecting_z))
				continue
			if(prob(botEmagChance))
				bot.emag_act(1)

/datum/event/ionstorm/end()
	spawn(rand(5000,8000))
		if(prob(50))
			ion_storm_announcement(affecting_z)


/datum/event/ionstorm/proc/get_random_humanoid_player_name(default_if_none)
	for (var/mob/living/carbon/human/player in GLOB.player_list)
		if(!player.mind || player_is_antag(player.mind, only_offstation_roles = 1) || !player.is_client_active(5))
			continue
		players += player.real_name

	if(players.len)
		return pick(players)
	return default_if_none

/datum/event/ionstorm/proc/get_random_species_name(default_if_none = "Humans")
	var/list/species = list()
	for(var/S in typesof(/datum/species))
		var/datum/species/specimen = S
		if(initial(specimen.spawn_flags) & SPECIES_CAN_JOIN)
			species += initial(specimen.name_plural)

	if(species.len)
		return pick(species.len)
	return default_if_none

/datum/event/ionstorm/proc/get_random_language(mob/living/silicon/S)
	var/list/languages = S.speech_synthesizer_langs.Copy()
	for(var/datum/language/L in languages)
		if(L == S.default_language)
			languages -= L
		// Also removing any languages that won't work well over radio.
		// A synth is unlikely to have any besides Binary, but we're playing it safe
		else if(L.flags & (HIVEMIND|NONVERBAL|SIGNLANG))
			languages -= L

	if(languages.len)
		var/datum/language/L = pick(languages)
		return L.name
	else // Highly unlikely but it is a failsafe fallback.
		return "Gibberish."
