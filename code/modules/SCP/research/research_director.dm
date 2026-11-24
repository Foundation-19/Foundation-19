// Site research director — the hub of the SCP research overhaul.
// Owns the site tech tree + research point pool, research projects,
// research teams, safety protocols, and cross-round persistence.
// All SCP research point earnings flow into the pool (mirrored from
// /datum/scp_research.add_research_points), funding tech tree unlocks.

#define PROJECT_PROPOSED  "proposed"
#define PROJECT_ACTIVE    "active"
#define PROJECT_COMPLETED "completed"
#define PROJECT_REVOKED   "revoked"

GLOBAL_DATUM_INIT(scp_research_director, /datum/scp_research_director, new)

/datum/scp_research_director
	var/datum/scp_tech_tree/tech_tree
	var/site_research_points = 0
	var/total_points_earned = 0
	var/list/datum/scp_research_project/projects = list()
	var/list/datum/scp_research_team/teams = list()
	var/list/safety_protocols = list()
	var/list/achievements = list()
	var/list/research_log = list()

	// Safety model: extreme tests + revoked projects hurt; rating scales point gains.
	var/safety_rating = 100
	var/safety_violations = 0

	var/next_team_id = 1
	var/next_project_id = 1
	var/last_save = 0

/datum/scp_research_director/New()
	tech_tree = new
	tech_tree.initialize()
	load_persistent_data()
	initialize_safety_protocols()

// ---------------------------------------------------------------------------
// Point economy
// ---------------------------------------------------------------------------

// Called from /datum/scp_research/add_research_points — every point earned on
// any SCP also feeds the site pool and any active project targeting that SCP.
/datum/scp_research_director/proc/on_points_earned(datum/scp_research/research, amount, source)
	if(!research || amount <= 0)
		return
	total_points_earned += amount
	// Safety rating scales the site pool gains.
	var/rating_mult = 1
	if(safety_rating < 25)
		rating_mult = 0.5
	else if(safety_rating < 50)
		rating_mult = 0.75
	var/credited = round(amount * tech_tree.get_research_multiplier() * rating_mult, 1)
	site_research_points += credited
	// Credit projects targeting this SCP.
	for(var/datum/scp_research_project/project in projects)
		if(project.status != PROJECT_ACTIVE)
			continue
		if(project.scp_targets.len && !(research.designation in project.scp_targets))
			continue
		project.contributed_points += credited
		project.contribution_log += list(list("source" = source, "amount" = credited, "time" = station_time_timestamp()))
		if(project.contributed_points >= project.required_points)
			complete_project(project)
	add_research_log("POINTS", "SCP-[research.designation] gained [amount] points from [source] (site pool +[credited]).")

/datum/scp_research_director/proc/get_pool()
	return site_research_points

/datum/scp_research_director/proc/spend_points(amount)
	if(site_research_points < amount)
		return FALSE
	site_research_points -= amount
	return TRUE

// ---------------------------------------------------------------------------
// Tech tree actions
// ---------------------------------------------------------------------------

/datum/scp_research_director/proc/try_unlock_node(node_id, mob/user)
	var/datum/scp_tech_node/node = tech_tree.get_node(node_id)
	if(!node)
		return FALSE
	if(!tech_tree.can_unlock(node_id, site_research_points))
		if(node && !node.unlocked)
			for(var/prereq_id in node.prerequisites)
				var/datum/scp_tech_node/prereq = tech_tree.get_node(prereq_id)
				if(!prereq || !prereq.unlocked)
					to_chat(user, SPAN_WARNING("Prerequisite missing: [prereq.name]."))
					return FALSE
		if(node && site_research_points < node.research_cost)
			to_chat(user, SPAN_WARNING("Not enough site research points ([site_research_points]/[node.research_cost])."))
		return FALSE
	if(!spend_points(node.research_cost))
		return FALSE
	tech_tree.unlock_node(node_id, user ? user.ckey : "system")
	log_and_message_staff("RESEARCH: [key_name(user)] unlocked tech node [node.name] (tier [node.tier], [node.research_cost] pts).")
	add_research_log("TECH", "[node.name] unlocked by [user ? key_name(user) : "system"].")
	apply_node_bonuses(node)
	achievements += list(list("type" = "tech_unlock", "name" = node.name, "by" = user ? user.ckey : "system", "time" = station_time_timestamp()))
	save_persistent_data()
	return TRUE

/datum/scp_research_director/proc/apply_node_bonuses(datum/scp_tech_node/node)
	if(node.bonus_research_multiplier)
		add_research_log("BONUS", "Site research multiplier now [round((tech_tree.get_research_multiplier() - 1) * 100)]%.")
	if(node.bonus_sanity_resist)
		add_research_log("BONUS", "Site SCP-exposure sanity resistance now [round(tech_tree.get_sanity_resist() * 100)]%.")
	if(node.bonus_containment_floor)
		add_research_log("BONUS", "Containment zone integrity floor now [tech_tree.get_containment_floor()]%.")

// ---------------------------------------------------------------------------
// Research projects
// ---------------------------------------------------------------------------

/datum/scp_research_director/proc/create_project(title, description, list/scp_targets, required_points, mob/proposer)
	if(!title || !required_points)
		return null
	var/datum/scp_research_project/project = new
	project.id = next_project_id++
	project.title = title
	project.description = description
	project.scp_targets = scp_targets ? scp_targets.Copy() : list()
	project.required_points = required_points
	project.proposed_by = proposer ? key_name(proposer) : "system"
	project.status = PROJECT_PROPOSED
	projects += project
	add_research_log("PROJECT", "New project proposed: '[title]' by [project.proposed_by].")
	return project

/datum/scp_research_director/proc/approve_project(datum/scp_research_project/project, mob/approver)
	if(!project || project.status != PROJECT_PROPOSED)
		return FALSE
	project.status = PROJECT_ACTIVE
	project.approved_by = approver ? key_name(approver) : "system"
	project.approval_time = world.time
	add_research_log("PROJECT", "Project '[project.title]' approved by [project.approved_by].")
	return TRUE

/datum/scp_research_director/proc/revoke_project(datum/scp_research_project/project, mob/revoker)
	if(!project || (project.status != PROJECT_ACTIVE && project.status != PROJECT_PROPOSED))
		return FALSE
	project.status = PROJECT_REVOKED
	add_research_log("PROJECT", "Project '[project.title]' revoked by [revoker ? key_name(revoker) : "system"].")
	record_safety_violation("revoked_project")
	return TRUE

/datum/scp_research_director/proc/complete_project(datum/scp_research_project/project)
	project.status = PROJECT_COMPLETED
	project.completion_time = world.time
	// Completing a project pays out a breakthrough bonus to the site pool.
	var/bonus = round(project.required_points * 0.25)
	site_research_points += bonus
	total_points_earned += bonus
	achievements += list(list("type" = "project_complete", "name" = project.title, "by" = project.team_id ? "[project.team_id]" : "site staff", "time" = station_time_timestamp()))
	add_research_log("PROJECT", "Project '[project.title]' COMPLETED. Breakthrough bonus +[bonus] site points.")
	log_and_message_staff("RESEARCH: Project '[project.title]' completed. Breakthrough bonus +[bonus] points.")

// ---------------------------------------------------------------------------
// Research teams
// ---------------------------------------------------------------------------

/datum/scp_research_director/proc/create_team(team_name, mob/leader)
	var/datum/scp_research_team/team = new
	team.id = "RT-[next_team_id++]"
	team.name = team_name || "Research Team [team.id]"
	team.leader_ckey = leader ? leader.ckey : null
	if(leader)
		team.members += leader.ckey
	teams += team
	add_research_log("TEAM", "Team '[team.name]' formed by [leader ? key_name(leader) : "system"].")
	return team

/datum/scp_research_director/proc/request_team_join(datum/scp_research_team/team, mob/requester)
	if(!team || !requester)
		return FALSE
	if(requester.ckey in team.members)
		return FALSE
	if(!(requester.ckey in team.join_requests))
		team.join_requests += requester.ckey
		add_research_log("TEAM", "[key_name(requester)] requested to join [team.name].")
	return TRUE

/datum/scp_research_director/proc/approve_join(datum/scp_research_team/team, ckey, mob/approver)
	if(!team || !(ckey in team.join_requests))
		return FALSE
	if(team.leader_ckey && approver && approver.ckey != team.leader_ckey && !check_rights(R_ADMIN, 0, approver))
		to_chat(approver, SPAN_WARNING("Only the team leader can approve join requests."))
		return FALSE
	team.join_requests -= ckey
	team.members += ckey
	add_research_log("TEAM", "[ckey] joined [team.name].")
	return TRUE

/datum/scp_research_director/proc/deny_join(datum/scp_research_team/team, ckey)
	if(!team || !(ckey in team.join_requests))
		return FALSE
	team.join_requests -= ckey
	return TRUE

/datum/scp_research_director/proc/remove_member(datum/scp_research_team/team, ckey)
	if(!team || !(ckey in team.members))
		return FALSE
	team.members -= ckey
	if(team.leader_ckey == ckey)
		team.leader_ckey = team.members.len ? team.members[1] : null
	return TRUE

// ---------------------------------------------------------------------------
// Safety protocols
// ---------------------------------------------------------------------------

/datum/scp_research_director/proc/initialize_safety_protocols()
	safety_protocols = list(
		list("id" = "safety_standard", "name" = "Standard Decontamination", "violations" = 0),
		list("id" = "safety_supervision", "name" = "Test Supervision Requirement", "violations" = 0),
		list("id" = "safety_breach", "name" = "Breach Response Compliance", "violations" = 0),
	)

/datum/scp_research_director/proc/record_safety_violation(protocol_id)
	safety_violations++
	for(var/protocol in safety_protocols)
		if(protocol["id"] == protocol_id)
			protocol["violations"]++
			break
	update_safety_rating()
	add_research_log("SAFETY", "Safety violation recorded ([protocol_id]). Rating now [safety_rating].")

/datum/scp_research_director/proc/update_safety_rating()
	safety_rating = max(0, 100 - safety_violations * 5)

// Extreme-risk tests require sign-off and damage the safety rating.
/datum/scp_research_director/proc/on_extreme_test(designation)
	record_safety_violation("safety_supervision")
	add_research_log("SAFETY", "Extreme-risk test authorized on SCP-[designation].")

// ---------------------------------------------------------------------------
// Logging & data for UIs
// ---------------------------------------------------------------------------

/datum/scp_research_director/proc/add_research_log(tag, text)
	research_log += list(list("tag" = tag, "text" = text, "time" = station_time_timestamp()))
	if(research_log.len > 200)
		research_log.Cut(1, 2)

/datum/scp_research_director/proc/get_projects_data()
	var/list/out = list()
	for(var/datum/scp_research_project/project in projects)
		out += list(project.get_data())
	return out

/datum/scp_research_director/proc/get_teams_data()
	var/list/out = list()
	for(var/datum/scp_research_team/team in teams)
		out += list(team.get_data())
	return out

// ---------------------------------------------------------------------------
// Persistence — native DM file I/O (dodges the rustg file_write issue).
// Persists: tech tree unlocks, site pool, total earned, safety stats.
// ---------------------------------------------------------------------------

/datum/scp_research_director/proc/save_persistent_data()
	var/list/data = list(
		"site_research_points" = site_research_points,
		"total_points_earned" = total_points_earned,
		"safety_violations" = safety_violations,
		"tech_tree" = tech_tree.serialize(),
		"achievements_total" = achievements.len,
	)
	var/f = file("data/scp_research_director.json")
	f << json_encode(data)
	last_save = world.time

/datum/scp_research_director/proc/load_persistent_data()
	if(!fexists("data/scp_research_director.json"))
		return
	var/raw = file2text("data/scp_research_director.json")
	if(!raw)
		return
	var/list/data
	try
		data = json_decode(raw)
	catch
		return
	if(!data)
		return
	site_research_points = data["site_research_points"] || 0
	total_points_earned = data["total_points_earned"] || 0
	safety_violations = data["safety_violations"] || 0
	tech_tree.deserialize(data["tech_tree"])
	update_safety_rating()
	log_game("SCP Research Director: loaded [tech_tree.unlocked_nodes.len] unlocked tech nodes, [site_research_points] site points.")

// ---------------------------------------------------------------------------
// Project datum
// ---------------------------------------------------------------------------


/datum/scp_research_project
	var/id
	var/title
	var/description
	var/list/scp_targets = list()   // designations, empty = any SCP
	var/required_points = 200
	var/contributed_points = 0
	var/status = PROJECT_PROPOSED
	var/proposed_by
	var/approved_by
	var/approval_time
	var/completion_time
	var/team_id
	var/list/contribution_log = list()

/datum/scp_research_project/proc/get_data()
	return list(
		"id" = id,
		"title" = title,
		"description" = description,
		"scp_targets" = scp_targets,
		"required_points" = required_points,
		"contributed_points" = contributed_points,
		"status" = status,
		"proposed_by" = proposed_by,
		"approved_by" = approved_by,
		"team_id" = team_id,
	)


// ---------------------------------------------------------------------------
// Team datum
// ---------------------------------------------------------------------------

/datum/scp_research_team
	var/id
	var/name
	var/list/members = list()      // ckeys
	var/leader_ckey
	var/list/join_requests = list() // ckeys

/datum/scp_research_team/proc/get_data()
	return list(
		"id" = id,
		"name" = name,
		"members" = members,
		"leader" = leader_ckey,
		"join_requests" = join_requests,
	)
