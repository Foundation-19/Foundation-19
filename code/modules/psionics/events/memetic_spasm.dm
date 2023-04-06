/datum/event/memetic_spasm
	startWhen = 60
	endWhen = 90

/datum/event/memetic_spasm/announce()
	priority_announcement.Announce( \
		"PRIORITY ALERT: SIGMA-[rand(50,80)] MEMETIC SIGNAL LOCAL TRAMISSION DETECTED (97% MATCH, NONVARIANT) \
		(SIGNAL SOURCE TRIANGULATED ADJACENT LOCAL SITE): All personnel are advised to avoid \
		exposure to active audio transmission equipment including radio headsets and intercoms \
		for the duration of the memetic signal broadcast.", \
		"[GLOB.using_map.station_name] Memetic Sensor Array" \
		)

/datum/event/memetic_spasm/process()
	var/list/victims = list()

	for(var/obj/item/device/radio/radio in GLOB.listening_objects)
		if(radio.on)
			for(var/mob/living/victim in range(radio.canhear_range, radio.loc))
				if(isnull(victims[victim]) && victim.stat == CONSCIOUS && !victim.ear_deaf)
					victims[victim] = radio

	for(var/thing in victims)
		var/mob/living/victim = thing
		var/obj/item/device/radio/source = victims[victim]
		do_spasm(victim, source)

/datum/event/memetic_spasm/proc/do_spasm(mob/living/victim, obj/item/device/radio/source)
	set waitfor = 0

	if(iscarbon(victim) && !victim.isSynthetic())
		var/list/disabilities = list(NEARSIGHTED, EPILEPSY, TOURETTES, NERVOUS)
		for(var/disability in disabilities)
			if(victim.disabilities & disability)
				disabilities -= disability
		if(disabilities.len)
			victim.disabilities |= pick(disabilities)

	to_chat(victim, SPAN_DANGER("You hear an indescribable, brain-tearing sound, and you collapse in a seizure!"))
	victim.seizure()

/datum/event/memetic_spasm/end()
	priority_announcement.Announce( \
		"PRIORITY ALERT: SIGNAL BROADCAST HAS CEASED. Personnel are cleared to resume use of non-hardened radio transmission equipment.", \
		"[GLOB.using_map.station_name] Memetic Sensor Array" \
		)
