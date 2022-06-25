///Base class of station traits. These are used to influence rounds in one way or the other by influencing the levers of the station.
/datum/station_trait
	///Name of the trait
	var/name = "unnamed station trait"
	///The type of this trait. Used to classify how this trait influences the station
	var/trait_type = STATION_TRAIT_NEUTRAL
	///Whether or not this trait uses process()
	var/trait_processes = FALSE
	///Chance relative to other traits of its type to be picked
	var/weight = 10
	///Does this trait show in the centcom report?
	var/show_in_report = FALSE
	///What message to show in the centcom report?
	var/report_message
	///What traits are incompatible with this one?
	var/blacklist


/datum/station_trait/New()
	. = ..()
	SSticker.OnRoundstart(CALLBACK(src, .proc/on_round_start))
	if(trait_processes)
		START_PROCESSING(SSstation, src)

///Proc ran when round starts. Use this for roundstart effects.
/datum/station_trait/proc/on_round_start()
	return

///type of info the roundstart report has on this trait, if any.
/datum/station_trait/proc/get_report()
	return "[name] - [report_message]"
