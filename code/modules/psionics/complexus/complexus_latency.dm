/datum/psi_complexus/proc/check_latency_trigger(trigger_strength = 0, source, redactive = FALSE)

	if(!LAZYLEN(latencies) || (world.time < next_latency_trigger))
		return FALSE

	if(!prob(trigger_strength))
		next_latency_trigger = world.time + rand(10, 30)
		return FALSE

	var/faculty = pick(latencies)
	var/new_rank = rand(2,4)
	owner.set_psi_rank(faculty, new_rank)
	var/decl/psionic_faculty/faculty_decl = SSpsi.get_faculty(faculty)
	to_chat(owner, SPAN_DANGER("You scream internally as your [faculty_decl.name] faculty is forced into operancy by [source]!"))
	next_latency_trigger = world.time + 30 * new_rank
	if(!redactive)
		owner.adjustBrainLoss(rand(trigger_strength*0.3, trigger_strength*0.6))
	return TRUE
