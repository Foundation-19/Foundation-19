// Central event hooks that drive world reactions to SCP events.
// Ported from daedalusdock scp_integration_hooks.dm, adapted to F19:
//  - no TG security_level enum; uses F19 security state escalation
//  - no SSfacility_announcements; uses priority_announcement
//  - zone lighting via F19 area power helpers

var/list/scp_breach_cooldown = list()

/proc/hook_scp_breach(designation, atom/scp_atom)
	if(!designation)
		return FALSE

	if(scp_breach_cooldown[designation] && world.time < scp_breach_cooldown[designation])
		return FALSE

	// Don't double-fire if persistence already knows about this breach
	if(SSscp_persistence && SSscp_persistence.manager)
		var/datum/scp_instance/instance = SSscp_persistence.manager.get_instance(designation)
		if(instance && instance.containment_status == "breached")
			return FALSE

	scp_breach_cooldown[designation] = world.time + 5 MINUTES

	var/breach_zone = "unknown"
	if(scp_atom)
		var/area/A = get_area(scp_atom)
		breach_zone = A ? A.name : "unknown"

	log_game("SCP Breach: [designation] at [scp_atom ? get_area_name(scp_atom) : "unknown"]")

	// Persistence bookkeeping
	if(SSscp_persistence && SSscp_persistence.manager)
		var/datum/scp_instance/instance = SSscp_persistence.manager.get_instance(designation)
		if(!instance)
			instance = new /datum/scp_instance(designation, scp_atom)
			SSscp_persistence.manager.scp_instances[designation] = instance
		instance.containment_status = "breached"
		instance.containment_health = 0
		instance.last_breach = world.time
		instance.times_breached_total++
		instance.add_breach_record(breach_zone)
		SSscp_persistence.manager.active_breaches++
		SSscp_persistence.manager.global_containment_stability = max(0, SSscp_persistence.manager.global_containment_stability - 10)

	// Site-wide announcement — Safe-class escapes are non-events, log quietly.
	var/scp_class = null
	if(scp_atom && scp_atom.SCP)
		scp_class = scp_atom.SCP.classification
	if(scp_class != SCP_SAFE)
		priority_announcement.Announce(
			"Containment breach detected in [breach_zone]. SCP-[designation][scp_class == SCP_KETER ? " (Keter-class)" : ""] is no longer in its designated containment zone. All personnel are advised to exercise caution.",
			"SCP-[designation] Containment Breach Alert",
			'sounds/effects/siren.ogg'
		)
	else
		log_game("SCP Breach (Safe-class, no announcement): [designation] at [breach_zone]")

	// Codex: anyone nearby records the breach observation.
	if(scp_atom)
		for(var/mob/living/carbon/human/H in range(9, scp_atom))
			if(H.ckey)
				codex_on_breach(designation, H)

	// NOTE: security escalation is owned by SSscp_security (containment/security_integration.dm)
	// which reacts to the same COMSIG_CONTAINMENT_BREACH signal — no duplicate escalation here.

	return TRUE

/proc/hook_scp_recontained(designation, atom/scp_atom)
	if(!designation)
		return FALSE
	if(SSscp_persistence && SSscp_persistence.manager)
		var/datum/scp_instance/instance = SSscp_persistence.manager.get_instance(designation)
		if(instance)
			instance.mark_recontained()
			SSscp_persistence.manager.calculate_global_metrics()
			SSscp_persistence.manager.save_scp_data()
	log_game("SCP Recontained: [designation]")
	priority_announcement.Announce(
		"SCP-[designation] has been successfully returned to containment. Site personnel stand down to standard alert posture.",
		"SCP-[designation] Recontainment Confirmed"
	)
	return TRUE

/proc/hook_scp_interaction(designation, mob/actor, summary)
	if(!designation || !actor)
		return FALSE
	if(SSscp_persistence && SSscp_persistence.manager)
		var/datum/scp_instance/instance = SSscp_persistence.manager.get_instance(designation)
		if(instance)
			instance.add_interaction_record(actor.ckey || actor.name, summary)
	return TRUE

/proc/hook_scp_terminated(designation, atom/scp_atom)
	if(!designation)
		return FALSE
	if(SSscp_persistence && SSscp_persistence.manager)
		var/datum/scp_instance/instance = SSscp_persistence.manager.get_instance(designation)
		if(instance)
			instance.containment_status = "terminated"
			instance.current_state = "dead"
			SSscp_persistence.manager.calculate_global_metrics()
	log_game("SCP Terminated: [designation]")
	priority_announcement.Announce(
		"SCP-[designation] has been terminated. Site command has been notified for contingency review.",
		"SCP-[designation] Termination Report"
	)
	return TRUE
