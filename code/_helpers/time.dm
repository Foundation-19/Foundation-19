//Returns the world time in english
/proc/worldtime2text()
	return gameTimestamp("hh:mm:ss", world.time)

/proc/time_stamp(format = "hh:mm:ss", show_ds)
	var/time_string = time2text(world.timeofday, format)
	return show_ds ? "[time_string]:[world.timeofday % 10]" : time_string

/proc/minutes_to_readable(minutes)
	if (!isnum(minutes))
		minutes = text2num(minutes)

	if (minutes < 0)
		return "INFINITE"
	else if (isnull(minutes))
		return "BAD INPUT"

	var/hours = 0
	var/days = 0
	var/weeks = 0
	var/months = 0
	var/years = 0

	if (minutes >= 518400)
		years = round(minutes / 518400)
		minutes = minutes - (years * 518400)
	if (minutes >= 43200)
		months = round(minutes / 43200)
		minutes = minutes - (months * 43200)
	if (minutes >= 10080)
		weeks = round(minutes / 10080)
		minutes = minutes - (weeks * 10080)
	if (minutes >= 1440)
		days = round(minutes / 1440)
		minutes = minutes - (days * 1440)
	if (minutes >= 60)
		hours = round(minutes / 60)
		minutes = minutes - (hours * 60)

	var/result = list()
	if (years)
		result += "[years] year\s"
	if (months)
		result += "[months] month\s"
	if (weeks)
		result += "[weeks] week\s"
	if (days)
		result += "[days] day\s"
	if (hours)
		result += "[hours] hour\s"
	if (minutes)
		result += "[minutes] minute\s"

	return jointext(result, ", ")


/proc/get_game_time()
	var/global/time_offset = 0
	var/global/last_time = 0
	var/global/last_usage = 0

	var/wtime = world.time
	var/wusage = world.tick_usage * 0.01

	if(last_time < wtime && last_usage > 1)
		time_offset += last_usage - 1

	last_time = wtime
	last_usage = wusage

	return wtime + (time_offset + wusage) * world.tick_lag

/proc/gameTimestamp(format = "hh:mm:ss", wtime=null)
	if(!wtime)
		wtime = world.time
	return time2text(wtime - GLOB.timezoneOffset, format)

/proc/station_time(display_only = FALSE, wtime=world.time)
	return ((((wtime - SSticker.round_start_time) * SSticker.station_time_rate_multiplier) + SSticker.gametime_offset) % 864000) - (display_only? GLOB.timezoneOffset : 0)

/proc/station_time_timestamp(format = "hh:mm:ss", wtime)
	return time2text(station_time(TRUE, wtime), format)

GLOBAL_VAR_INIT(next_station_date_change, 1 DAY)
GLOBAL_VAR_INIT(timezoneOffset, 0)
GLOBAL_VAR(station_date)

/proc/stationdate2text()
	var/update_time = FALSE
	var/station_time = station_time()
	if(!(GLOB.station_date || station_time > 1 DAY))
		GLOB.next_station_date_change += 1 DAY
		update_time = TRUE
	if(update_time)
		var/extra_days = round(station_time / (1 DAY)) DAYS
		var/timeofday = world.timeofday + extra_days
		GLOB.station_date = "[GLOB.using_map.game_year]-[time2text(timeofday, "MM-DD")]"
	return GLOB.station_date

//Takes a value of time in deciseconds.
//Returns a text value of that number in hours, minutes, or seconds.
/proc/DisplayTimeText(time_value, round_seconds_to = 0.1)
	var/second = FLOOR(time_value * 0.1, round_seconds_to)
	if(!second)
		return "right now"
	if(second < 60)
		return "[second] second[(second != 1)? "s":""]"
	var/minute = FLOOR(second / 60, 1)
	second = FLOOR(MODULUS(second, 60), round_seconds_to)
	var/secondT
	if(second)
		secondT = " and [second] second[(second != 1)? "s":""]"
	if(minute < 60)
		return "[minute] minute[(minute != 1)? "s":""][secondT]"
	var/hour = FLOOR(minute / 60, 1)
	minute = MODULUS(minute, 60)
	var/minuteT
	if(minute)
		minuteT = " and [minute] minute[(minute != 1)? "s":""]"
	if(hour < 24)
		return "[hour] hour[(hour != 1)? "s":""][minuteT][secondT]"
	var/day = FLOOR(hour / 24, 1)
	hour = MODULUS(hour, 24)
	var/hourT
	if(hour)
		hourT = " and [hour] hour[(hour != 1)? "s":""]"
	return "[day] day[(day != 1)? "s":""][hourT][minuteT][secondT]"

/* Returns 1 if it is the selected month and day */
/proc/isDay(month, day)
	if(isnum(month) && isnum(day))
		var/MM = text2num(time2text(world.timeofday, "MM")) // get the current month
		var/DD = text2num(time2text(world.timeofday, "DD")) // get the current day
		if(month == MM && day == DD)
			return 1

GLOBAL_VAR_INIT(midnight_rollovers, 0)
GLOBAL_VAR_INIT(rollovercheck_last_timeofday, 0)
/proc/update_midnight_rollover()
	if (world.timeofday < GLOB.rollovercheck_last_timeofday) //TIME IS GOING BACKWARDS!
		return GLOB.midnight_rollovers++
	return GLOB.midnight_rollovers

//Increases delay as the server gets more overloaded,
//as sleeps aren't cheap and sleeping only to wake up and sleep again is wasteful
#define DELTA_CALC max(((max(world.tick_usage, world.cpu) / 100) * max(Master.sleep_delta,1)), 1)

/proc/stoplag()
	if (!Master || !(GAME_STATE & RUNLEVELS_DEFAULT))
		sleep(world.tick_lag)
		return 1
	. = 0
	var/i = 1
	do
		. += round(i*DELTA_CALC)
		sleep(i*world.tick_lag*DELTA_CALC)
		i *= 2
	while (world.tick_usage > min(TICK_LIMIT_TO_RUN, Master.current_ticklimit))

#undef DELTA_CALC

/proc/acquire_days_per_month()
	. = list(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
	if(isLeap(text2num(time2text(world.realtime, "YYYY"))))
		.[2] = 29

/proc/get_weekday_index()
	var/list/weekdays = list("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun")
	return list_find(weekdays, time2text(world.timeofday, "DDD"))

/proc/current_month_and_day()
	var/time_string = time2text(world.realtime, "MM-DD")
	var/time_list = splittext(time_string, "-")
	return list(text2num(time_list[1]), text2num(time_list[2]))
