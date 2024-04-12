/datum/rite
	/// name of the religious rite
	var/name = "religious rite"
	/// Description of the religious rite
	var/desc = "immm gonna rooon"
	/// length it takes to complete the ritual
	var/ritual_length = (10 SECONDS) //total length it'll take
	/// list of invocations said (strings) throughout the rite
	var/list/ritual_invocations //strings that are by default said evenly throughout the rite
	/// message when you invoke
	var/invoke_msg
	var/favor_cost = 0
	/// does the altar auto-delete the rite
	var/auto_delete = TRUE

/datum/rite/New()
	. = ..()
	if(!GLOB?.sect)
		return
	LAZYADD(GLOB.sect.active_rites, src)

/datum/rite/Destroy()
	if(!GLOB?.sect)
		return
	LAZYREMOVE(GLOB.sect.active_rites, src)
	return ..()

/datum/rite/proc/can_afford(mob/living/user)
	if(GLOB.sect?.favor < favor_cost)
		to_chat(user, SPAN_WARNING("This rite requires more favor!"))
		return FALSE
	return TRUE

///Called to perform the invocation of the rite, with args being the performer and the altar where it's being performed. Maybe you want it to check for something else?
/datum/rite/proc/perform_rite(mob/living/user, atom/religious_tool)
	if(!can_afford(user))
		return FALSE
	to_chat(user, SPAN_NOTICE("You begin to perform the rite of [name]..."))
	if(!ritual_invocations)
		if(do_after(user, ritual_length))
			return TRUE
		return FALSE
	var/first_invoke = TRUE
	for(var/i in ritual_invocations)
		if(first_invoke) //instant invoke
			user.say(i)
			first_invoke = FALSE
			continue
		if(!length(ritual_invocations)) //we divide so we gotta protect
			return FALSE
		if(!do_after(user, ritual_length/length(ritual_invocations)))
			return FALSE
		user.say(i)
	if(!do_after(user, ritual_length/length(ritual_invocations))) //because we start at 0 and not the first fraction in invocations, we still have another fraction of ritual_length to complete
		return FALSE
	if(invoke_msg)
		user.say(invoke_msg)
	return TRUE


///Does the thing if the rite was successfully performed. return value denotes that the effect successfully (IE a harm rite does harm)
/datum/rite/proc/invoke_effect(mob/living/user, atom/religious_tool)
	SHOULD_CALL_PARENT(TRUE)
	GLOB.sect.on_riteuse(user,religious_tool)
	return TRUE
