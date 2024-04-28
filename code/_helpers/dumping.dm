/proc/getDatumVarsDump(datum/D)
	. = ""
	var/list/variables = D.vars
	variables = sortList(variables)
	for(var/varname in variables)
		. += "\t [varname] = [getVariableValueAsText(D.vars[varname], varname)]\n"


/proc/getVariableValueAsText(value, varname)
	. = ""
	var/list/vars_dont_expand = list("overlays", "underlays", "vars")
	var/list/vars_no_assoc = list("verbs", "contents","screen","images")
	if(isnull(value))
		. = "null"
	else if(istext(value))
		. = "\"[value]\""
	else if(isicon(value))
		. = "[value]"
	else if(isfile(value))
		. = "'[value]'"
	else if(istype(value, /datum))
		var/datum/DA = value
		if("[DA]" == "[DA.type]" || !"[DA]")
			. = "\ref[DA] - [DA.type]"
		else
			. = "\ref[DA] - [DA] ([DA.type])"
	else if(istype(value, /client))
		var/client/C = value
		. = "\ref[C] - [C] ([C.type])"
	else if(islist(value))
		var/list/L = value
		. = "/list ([L.len])"
		if(!(varname in vars_dont_expand) && L.len > 0 && L.len < 100)
			for (var/index = 1 to L.len)
				. += "\n"
				var/entry = L[index]
				if(!isnum(entry) && !isnull(entry) && !(varname in vars_no_assoc) && L[entry] != null)
					. += "\t\t[index]: [getVariableValueAsText(entry)] -> [getVariableValueAsText(L[entry])]"
				else
					. += "\t\t[index]: [getVariableValueAsText(entry)]"
	else
		. = "[value]"

/datum/proc/dumpDatumIntoWorldLog()
	var/msg = "## DEBUG: [time2text(world.timeofday)]. [src]([src.type]) variables dump:\n"
	msg += getDatumVarsDump(src)
	log_world(msg)
