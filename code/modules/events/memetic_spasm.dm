/datum/event/memetic_spasm
	announceWhen = 0
	startWhen = 10
	endWhen = 40
	var/list/affected = list()	//list of people that have heard the noise and on what "level" of bad things they're on
	var/list/sound_tokens = list()	//associative list of radios and their looping sound tokens

/datum/event/memetic_spasm/announce()
	priority_announcement.Announce(
		"PRIORITY ALERT: MEMETIC SIGNAL TRAMISSION DETECTED: All personnel are advised to avoid \
		exposure to active audio transmission equipment including radio headsets and intercoms \
		for the duration of the memetic signal broadcast.",
		"[GLOB.using_map.station_name] Memetic Sensor Array",
		GLOB.using_map.command_report_sound
	)

/datum/event/memetic_spasm/start()
	for(var/obj/item/device/radio/radio in GLOB.listening_objects)
		if(radio.on && radio.listening)
			sound_tokens[radio] = GLOB.sound_player.PlayLoopingSound(radio, radio.sound_id, "sound/effects/memetic_spasm.ogg", 30, radio.canhear_range)

/datum/event/memetic_spasm/tick()
	var/list/victims = list()

	for(var/obj/item/device/radio/radio in GLOB.listening_objects)
		if(radio.on && radio.listening)
			for(var/mob/living/hearing in range(radio.canhear_range, radio.loc))
				if(hearing.stat == CONSCIOUS && hearing.can_hear(radio))
					victims |= hearing
					if(!(hearing in affected))
						affected[hearing] = 1
						to_chat(hearing, SPAN_DANGER("You hear an indescribable, brain-tearing sound!"))
					else
						if(prob(25))
							to_chat(hearing, SPAN_DANGER("You still hear the screeching! MAKE IT STOP!"))
			if(isnull(sound_tokens[radio]))
				sound_tokens[radio] = GLOB.sound_player.PlayLoopingSound(radio, radio.sound_id, "sound/effects/memetic_spasm.ogg", 30, radio.canhear_range)
		else
			if(!(isnull(sound_tokens[radio])))
				qdel(sound_tokens[radio])

	for(var/thing in victims)
		var/mob/living/victim = thing
		check_spasm(victim)

/datum/event/memetic_spasm/end()
	priority_announcement.Announce( \
		"PRIORITY ALERT: SIGNAL BROADCAST HAS CEASED. Personnel are cleared to resume use of non-hardened radio transmission equipment.", \
		"[GLOB.using_map.station_name] Memetic Sensor Array" \
	)

	for(var/obj/item/device/radio/radio in GLOB.listening_objects)
		if(!(isnull(sound_tokens[radio])))
			qdel(sound_tokens[radio])

/datum/event/memetic_spasm/proc/check_spasm(mob/living/victim)
	switch(affected[victim])
		if(1)
			victim.adjustSanityLoss(2)
			if(prob(15))
				affected[victim]++
		if(2)
			victim.adjustSanityLoss(4)
			victim.Weaken(2)
			if(prob(15))
				affected[victim]++
		if(3)
			victim.adjustSanityLoss(8)
			victim.adjustBrainLoss(1)
			if(prob(15))
				affected[victim]++
		if(4)
			victim.adjustSanityLoss(12)
			victim.adjustBrainLoss(3)
			victim.seizure()
			if(prob(15))
				affected[victim]++
		if(5)
			victim.adjustSanityLoss(15)
			victim.adjustBrainLoss(5)
		else
			to_chat(victim, SPAN_NOTICE("You're feeling pretty bugged out, maybe you should contact a coder."))
