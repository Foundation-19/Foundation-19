/datum/event/memetic_spasm
	startWhen = 30
	endWhen = 90
	var/list/affected = list()	//list of people that have heard the noise and on what "level" of bad things they're on

/datum/event/memetic_spasm/announce()
	priority_announcement.Announce( \
		"PRIORITY ALERT: SIGMA-[rand(50,80)] MEMETIC SIGNAL LOCAL TRAMISSION DETECTED (97% MATCH, NONVARIANT) \
		(SIGNAL SOURCE TRIANGULATED ADJACENT LOCAL SITE): All personnel are advised to avoid \
		exposure to active audio transmission equipment including radio headsets and intercoms \
		for the duration of the memetic signal broadcast.", \
		"[GLOB.using_map.station_name] Memetic Sensor Array" \
		)

/datum/event/memetic_spasm/end()
	priority_announcement.Announce( \
		"PRIORITY ALERT: SIGNAL BROADCAST HAS CEASED. Personnel are cleared to resume use of non-hardened radio transmission equipment.", \
		"[GLOB.using_map.station_name] Memetic Sensor Array" \
		)

/datum/event/memetic_spasm/process()
	var/list/victims = list()

	for(var/obj/item/device/radio/radio in GLOB.listening_objects)
		if(radio.on)
			for(var/mob/living/hearing in range(radio.canhear_range, radio.loc))
				if(hearing.stat == CONSCIOUS && hearing.can_hear(radio))
					victims |= hearing
					if(!(hearing in affected))
						affected[hearing] = 1
						to_chat(hearing, SPAN_DANGER("You hear an indescribable, brain-tearing sound!"))
					else
						if(prob(25))
							to_chat(hearing, SPAN_DANGER("You still hear the screeching! MAKE IT STOP!"))

	for(var/thing in victims)
		var/mob/living/victim = thing
		check_spasm(victim)

/datum/event/memetic_spasm/proc/check_spasm(mob/living/victim)
	set waitfor = 0

	switch(affected[victim])
		if(1)
			victim.adjustSanityLoss(2)
			if(prob(20))
				affected[victim]++
		if(2)
			victim.adjustSanityLoss(4)
			victim.Weaken(2)
			if(prob(20))
				affected[victim]++
		if(3)
			victim.adjustSanityLoss(8)
			victim.adjustBrainLoss(1)
			if(prob(20))
				affected[victim]++
		if(4)
			victim.adjustSanityLoss(12)
			victim.adjustBrainLoss(3)
			victim.seizure()
			if(prob(20))
				affected[victim]++
		if(5)
			victim.adjustSanityLoss(15)
			victim.adjustBrainLoss(5)

			if(iscarbon(victim) && !victim.isSynthetic())

				var/list/disabilities = list(NEARSIGHTED, EPILEPSY, TOURETTES, NERVOUS)
				for(var/disability in disabilities)
					if(victim.disabilities & disability)
						disabilities -= disability

				if(disabilities.len)
					victim.disabilities |= pick(disabilities)
		else
			to_chat(victim, SPAN_NOTICE("You're feeling pretty bugged out, maybe you should contact a coder."))
