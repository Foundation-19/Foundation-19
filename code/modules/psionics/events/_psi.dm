/datum/event/psi
	startWhen = 30
	endWhen = 120

/datum/event/psi/announce()
	priority_announcement.Announce( \
		"A localized disruption within the neighboring noosphere has been detected. All psi-operant crewmembers \
		are advised to cease any sensitive activities and report to medical personnel in case of damage.", \
		"[GLOB.using_map.station_name] Memetic Sensor Array" \
		)

/datum/event/psi/end()
	priority_announcement.Announce( \
		"The noosphere disturbance has ended and baseline normality has been re-asserted.", \
		"[GLOB.using_map.station_name] Memetic Sensor Array" \
	)

/datum/event/psi/tick()
	for(var/thing in SSpsi.processing)
		apply_psi_effect(thing)

/datum/event/psi/proc/apply_psi_effect(datum/psi_complexus/psi)
	return
