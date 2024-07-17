/datum/codex_category/jobs/
	name = "Jobs"
	desc = "All the different jobs the Foundation has to offer."

/datum/codex_category/jobs/Initialize()
	for(var/thing in subtypesof(/datum/job))
		var/datum/job/job = SSjobs.get_by_path(thing)		// this is NOT a type, this is the actual job datum. this way we can check lists!

		var/list/j_info = list()

		if(isnull(job))	// sanity check
			continue

		j_info += "<p style='background-color: [job.selection_color]'><br><br><p>"	// ghetto way to add a colored bar

		j_info += "Roleplay difficulty: [job.roleplay_difficulty]"
		j_info += "Mechanical difficulty: [job.mechanical_difficulty]"
		j_info += "Guides: [jointext(job.codex_guides, ", ")]"
		j_info += "Duties: [job.duties]"

		j_info += ""	// 2 line breaks

		if(job.alt_titles)
			j_info += "Alternative titles include: [jointext(job.alt_titles, ", ")]."

		if(job.supervisors)
			j_info += "You directly answer to <b>[job.supervisors]</b>."

		if(job.department)
			j_info += "You are [job.head_position ? "in charge of" : "mainly part of"] [job.department]"

		// TODO: maybe some text for department flags as well?

		if(job.req_admin_notify)
			j_info += "This job is important for game progression. <b>If you have to disconnect, please notify the admins via adminhelp.</b>"

		j_info += "There [job.total_positions == 1 ? "is" : "are"] [job.total_positions] position[job.total_positions == 1 ? "" : "s"] for this job.[job.balance_limited ? " These slots are limited by the amount of D-class the site is handling." : ""]"

		var/list/skill_english = list()
		for(var/thing2 in job.min_skill)
			var/decl/hierarchy/skill/skill = thing2
			var/level = job.min_skill[skill]

			var/level_english
			switch(level)
				if(2)
					level_english = "basic"
				if(3)
					level_english = "trained"
				if(4)
					level_english = "experienced"
				if(5)
					level_english = "master"

			skill_english += "[initial(skill.name)] ([level_english])"

		j_info += "You get [job.skill_points] skill points, as well as the following skills: [jointext(skill_english, ", ")]"

		j_info += "Normally, this job grants you the following access: [jointext(job.access, ", ")]."
		j_info += "If the site has fewer staff than usual, you'll also have the following: [jointext(job.minimal_access, ", ")]."

		// TODO: add rank indicator. Not done since our ranks are fucking shit

		j_info += "" // 2 line breaks
		j_info += job.special_codex_text

		var/datum/codex_entry/entry = new(_display_name = "[initial(job.title)] (job)", _associated_strings = list(initial(job.title)), _entry_text = jointext(j_info, "<br>"))
		SScodex.add_entry_by_string(entry.display_name, entry)
		items += entry.display_name

	. = ..()
