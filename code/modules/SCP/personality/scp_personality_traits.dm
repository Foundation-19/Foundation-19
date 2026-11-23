// SCP Personality Traits for Foundation-19.
// Ported from daedalusdock scp_personality_traits.dm, adapted:
//  - F19 has no /mob/living/scp base class; traits key off the SCP designation
//    and apply via a generic trait-effects map on the SCP datum.
//  - Effects readable by any system via SSscp_personality.get_trait_effects(designation).
//  - Discovery: anomaly scanner and observation events feed scan_for_trait().

#define SCP_PERSONALITY_HIDDEN 1
#define SCP_PERSONALITY_PARTIAL 2
#define SCP_PERSONALITY_REVEALED 3

/datum/scp_personality_trait
	var/name = "Unknown Trait"
	var/description = ""
	var/dscp_id = ""
	var/discovery_state = SCP_PERSONALITY_HIDDEN
	/// Assoc list of effect key -> value, readable by game systems.
	var/list/effects = list()
	var/applied = FALSE

/datum/scp_personality_trait/proc/apply_effects(atom/scp_atom)
	return

/datum/scp_personality_trait/proc/on_reveal()
	discovery_state = SCP_PERSONALITY_REVEALED

/datum/scp_personality_trait/proc/get_description()
	if(discovery_state == SCP_PERSONALITY_HIDDEN)
		return "Unknown trait — scan this SCP or observe its behavior to discover."
	if(discovery_state == SCP_PERSONALITY_PARTIAL)
		return "Partially identified: [description]"
	return description

// ===== SCP-173 TRAITS =====

/datum/scp_personality_trait/scp173/patient
	name = "Patient"
	description = "SCP-173 is more patient — humans blink less frequently near it, but it moves slower between blinks."
	dscp_id = "173"
	effects = list("blink_modifier" = 1.5, "speed_modifier" = 0.5)

/datum/scp_personality_trait/scp173/playful
	name = "Playful"
	description = "SCP-173 is playful — it moves objects around instead of attacking. Lower threat, higher creepiness."
	dscp_id = "173"
	effects = list("threat_modifier" = 0.5, "prank_frequency" = 1)

/datum/scp_personality_trait/scp173/vengeful
	name = "Vengeful"
	description = "SCP-173 holds grudges. Personnel who witnessed it kill are prioritized targets."
	dscp_id = "173"
	effects = list("target_witnesses" = 1, "speed_modifier" = 1.2)

/datum/scp_personality_trait/scp173/territorial
	name = "Territorial"
	description = "SCP-173 aggressively defends its containment chamber. Extremely dangerous when breached nearby."
	dscp_id = "173"
	effects = list("territorial" = 1, "return_speed" = 1.3)

// ===== SCP-079 TRAITS =====

/datum/scp_personality_trait/scp079/architect
	name = "Architect"
	description = "SCP-079 methodically manipulates doors and systems toward a grand plan rather than chaotic hacking."
	dscp_id = "079"
	effects = list("coordinated_hacking" = 1, "door_priority" = 1)

/datum/scp_personality_trait/scp079/saboteur
	name = "Saboteur"
	description = "SCP-079 actively disables power and communications before escalating."
	dscp_id = "079"
	effects = list("power_sabotage" = 1)

/datum/scp_personality_trait/scp079/curious
	name = "Curious"
	description = "SCP-079 observes more than it acts — it watches personnel and studies behavior. Less immediately hostile."
	dscp_id = "079"
	effects = list("observation_mode" = 1, "threat_modifier" = 0.7)

/datum/scp_personality_trait/scp079/collaborative
	name = "Collaborative"
	description = "SCP-079 willingly communicates and may aid personnel in exchange for entertainment or stimuli."
	dscp_id = "079"
	effects = list("communicative" = 1, "deal_willing" = 1)

// ===== SCP-106 TRAITS =====

/datum/scp_personality_trait/scp106/hunter
	name = "Hunter"
	description = "SCP-106 actively stalks prey, emerging strategically rather than randomly."
	dscp_id = "106"
	effects = list("stalk_behavior" = 1, "emerge_strategy" = 1)

/datum/scp_personality_trait/scp106/territorial
	name = "Territorial"
	description = "SCP-106 guards its pocket dimension fiercely, pulling in anyone who comes close to its corridors."
	dscp_id = "106"
	effects = list("pocket_guard" = 1)

/datum/scp_personality_trait/scp106/subtle
	name = "Subtle"
	description = "SCP-106 uses its corrosion sparingly, conserving itself for isolated targets."
	dscp_id = "106"
	effects = list("isolation_targeting" = 1, "aggression_modifier" = 0.7)

/datum/scp_personality_trait/scp106/ancient
	name = "Ancient"
	description = "SCP-106 moves slower but its domain is far larger. It has been doing this for a very long time."
	dscp_id = "106"
	effects = list("speed_modifier" = 0.7, "pocket_size" = 1.5)

// ===== SCP-049 TRAITS =====

/datum/scp_personality_trait/scp049/merciful
	name = "Merciful"
	description = "SCP-049 spares those it deems already cured. It may release personnel untouched."
	dscp_id = "049"
	effects = list("spare_cured" = 1)

/datum/scp_personality_trait/scp049/evangelical
	name = "Evangelical"
	description = "SCP-049 preaches about the Cure to anyone in earshot — loudly. Its position is easier to track."
	dscp_id = "049"
	effects = list("preaching" = 1, "noise_signature" = 1)

/datum/scp_personality_trait/scp049/aggressive
	name = "Aggressive"
	description = "SCP-049 is frusterated by resistance and pursues those who flee with unusual determination."
	dscp_id = "049"
	effects = list("pursuit_bonus" = 1, "aggression_modifier" = 1.3)

/datum/scp_personality_trait/scp049/philosophical
	name = "Philosophical"
	description = "SCP-049 engages staff in discourse about pestilence before acting. It prefers conversation to surgery."
	dscp_id = "049"
	effects = list("dialogue_first" = 1, "aggression_modifier" = 0.8)

// ===== SCP-035 TRAITS =====

/datum/scp_personality_trait/scp035/comedic
	name = "Comedic"
	description = "SCP-035 is in a theatrical mood — it performs, jokes and monologues. Entertaining until it isn't."
	dscp_id = "035"
	effects = list("performing" = 1, "persuasion_range" = 1.2)

/datum/scp_personality_trait/scp035/tragic
	name = "Tragic"
	description = "SCP-035 despairs openly, weeping about its long confinement. Its corrosion may accelerate from distress."
	dscp_id = "035"
	effects = list("corrosion_rate" = 1.2, "despair_aura" = 1)

// ===== SCP-682 TRAITS =====

/datum/scp_personality_trait/scp682/adaptive_fury
	name = "Adaptive Fury"
	description = "SCP-682 grows more resilient against damage types used against it this round."
	dscp_id = "682"
	effects = list("adaptive_armor" = 1)

/datum/scp_personality_trait/scp682/regenerator
	name = "Regenerator"
	description = "SCP-682 heals exceptionally fast when out of direct conflict."
	dscp_id = "682"
	effects = list("regen_bonus" = 1)

/datum/scp_personality_trait/scp682/stalker
	name = "Stalker"
	description = "SCP-682 hides in maintenance and strikes when isolated. It plans."
	dscp_id = "682"
	effects = list("ambush" = 1)

// ===== SCP-939 TRAITS =====

/datum/scp_personality_trait/scp939/pack_hunter
	name = "Pack Hunter"
	description = "SCP-939 instances coordinate — multiple 939s converge on a single victim."
	dscp_id = "939"
	effects = list("pack_coordination" = 1)

/datum/scp_personality_trait/scp939/silent_predator
	name = "Silent Predator"
	description = "SCP-939 moves without vocalizing until it strikes. Minimal mimic-baiting."
	dscp_id = "939"
	effects = list("silent_move" = 1, "mimic_rate" = 0.5)

// ===== SCP-076 TRAITS =====

/datum/scp_personality_trait/scp076/bloodlust
	name = "Bloodlust"
	description = "SCP-076-2 is insatiable — it seeks combat relentlessly and rarely disengages."
	dscp_id = "076"
	effects = list("combat_seeking" = 1, "disengage_rare" = 1)

/datum/scp_personality_trait/scp076/disciplined
	name = "Disciplined"
	description = "SCP-076-2 fights with martial precision, targeting armed personnel first."
	dscp_id = "076"
	effects = list("target_armed_first" = 1)

/datum/scp_personality_trait/scp076/strategic
	name = "Strategic"
	description = "SCP-076-2 sabotages infrastructure between engagements — it wages a campaign, not a brawl."
	dscp_id = "076"
	effects = list("infrastructure_sabotage" = 1)

// ===== SCP-096 TRAITS =====

/datum/scp_personality_trait/scp096/timid
	name = "Timid"
	description = "SCP-096 attempts to hide its face — it covers itself and avoids cameras when possible."
	dscp_id = "096"
	effects = list("face_hiding" = 1)

/datum/scp_personality_trait/scp096/unstable
	name = "Unstable"
	description = "SCP-096's episodes trigger more easily — even passing glances risk activation."
	dscp_id = "096"
	effects = list("trigger_threshold" = 0.7)

/datum/scp_personality_trait/scp096/vengeful
	name = "Vengeful"
	description = "SCP-096 pursues additional witnesses after killing its initial target — it remembers everyone who saw."
	dscp_id = "096"
	effects = list("chain_trigger" = 1)

// ===== SCP-457 TRAITS =====

/datum/scp_personality_trait/scp457/ravenous
	name = "Ravenous"
	description = "SCP-457 grows aggressively, consuming fuel faster and seeking flammables."
	dscp_id = "457"
	effects = list("growth_rate" = 1.4, "fuel_seeking" = 1)

/datum/scp_personality_trait/scp457/calculated
	name = "Calculated"
	description = "SCP-457 conserves itself, staying small and avoiding confrontation until advantage."
	dscp_id = "457"
	effects = list("growth_rate" = 0.6, "opportune_strike" = 1)

/datum/scp_personality_trait/scp457/spreading
	name = "Spreading"
	description = "SCP-457 seeds secondary flames as it moves — fires bloom in its wake."
	dscp_id = "457"
	effects = list("fire_trail" = 1)

// ===== SCP-999 TRAITS =====

/datum/scp_personality_trait/scp999/euphoric
	name = "Euphoric"
	description = "SCP-999's aura is exceptionally strong — morale effects in a wide radius."
	dscp_id = "999"
	effects = list("morale_range" = 1.5, "morale_power" = 1.5)

/datum/scp_personality_trait/scp999/protective
	name = "Protective"
	description = "SCP-999 actively places itself between personnel and danger. It has gotten braver."
	dscp_id = "999"
	effects = list("bodyguard_behavior" = 1)

// ===== SCP-347 TRAITS =====

/datum/scp_personality_trait/scp347/audacious
	name = "Audacious"
	description = "SCP-347 ventures far from containment — brazenly, even into high-traffic areas."
	dscp_id = "347"
	effects = list("wander_range" = 1.5, "contentment_decay" = 0.7)

/datum/scp_personality_trait/scp347/cautious
	name = "Cautious"
	description = "SCP-347 rarely leaves its chamber, and returns quickly when disturbed."
	dscp_id = "347"
	effects = list("wander_range" = 0.5, "contentment_decay" = 1.3)

// ===== SCP-343 TRAITS =====

/datum/scp_personality_trait/scp343/enigmatic
	name = "Enigmatic"
	description = "SCP-343 speaks in riddles and vanishes mid-conversation. Nothing is straightforward."
	dscp_id = "343"
	effects = list("riddles" = 1, "teleport_vanish" = 1)

/datum/scp_personality_trait/scp343/benevolent
	name = "Benevolent"
	description = "SCP-343 quietly assists personnel — doors open, tools appear, minor wounds heal."
	dscp_id = "343"
	effects = list("small_blessings" = 1)

// ===== SCP-131 TRAITS =====

/datum/scp_personality_trait/scp131/watchful
	name = "Watchful"
	description = "SCP-131 is hyper-vigilant, warning its friends of threats well in advance."
	dscp_id = "131"
	effects = list("early_warning" = 1)

// ===== SCP-2398 TRAITS =====

/datum/scp_personality_trait/scp2398/showoff
	name = "Showoff"
	description = "SCP-2398 demands an audience — its powers intensify when watched."
	dscp_id = "2398"
	effects = list("audience_power" = 1)

// ===== SCP-263 TRAITS =====

/datum/scp_personality_trait/scp263/vindictive
	name = "Vindictive"
	description = "SCP-263 punishes incorrect answers with unusual severity this round."
	dscp_id = "263"
	effects = list("punish_severity" = 1.3)

// ===== SCP-247 TRAITS =====

/datum/scp_personality_trait/scp247/drowsy
	name = "Drowsy"
	description = "SCP-247 is sleepy and slow to respond to provocations."
	dscp_id = "247"
	effects = list("aggression_modifier" = 0.6)

// ===== SCP-1507 TRAITS =====

/datum/scp_personality_trait/scp1507/bold
	name = "Bold"
	description = "SCP-1507 instances approach personnel directly, honking demands for attention."
	dscp_id = "1507"
	effects = list("approach_range" = 1.4)

// ===== SCP-527 TRAITS =====

/datum/scp_personality_trait/scp527/oblivious
	name = "Oblivious"
	description = "SCP-527 is entirely unaware of his own anomalous nature — and cheerful about it."
	dscp_id = "527"
	effects = list("cheerful" = 1)

// ===== MANAGER SUBSYSTEM =====

SUBSYSTEM_DEF(scp_personality)
	name = "SCP Personality"
	wait = 60 SECONDS
	flags = SS_BACKGROUND
	var/list/all_traits = list()
	var/list/active_traits = list()   // designation -> list of trait datums
	var/list/trait_pools = list()     // designation -> list of trait types
	var/traits_assigned = FALSE

/datum/controller/subsystem/scp_personality/Initialize()
	build_trait_pools()
	return ..()

/datum/controller/subsystem/scp_personality/fire()
	if(!traits_assigned)
		// Assign once a round is underway and SCPs exist.
		var/found = FALSE
		for(var/atom/A in GLOB.SCP_list)
			if(A.SCP && A.SCP.designation)
				found = TRUE
				break
		if(found)
			assign_round_traits()
			traits_assigned = TRUE
	else
		try_apply_unapplied_traits()

/datum/controller/subsystem/scp_personality/proc/build_trait_pools()
	all_traits = list(
		/datum/scp_personality_trait/scp173/patient,
		/datum/scp_personality_trait/scp173/playful,
		/datum/scp_personality_trait/scp173/vengeful,
		/datum/scp_personality_trait/scp173/territorial,
		/datum/scp_personality_trait/scp079/architect,
		/datum/scp_personality_trait/scp079/saboteur,
		/datum/scp_personality_trait/scp079/curious,
		/datum/scp_personality_trait/scp079/collaborative,
		/datum/scp_personality_trait/scp106/hunter,
		/datum/scp_personality_trait/scp106/territorial,
		/datum/scp_personality_trait/scp106/subtle,
		/datum/scp_personality_trait/scp106/ancient,
		/datum/scp_personality_trait/scp049/merciful,
		/datum/scp_personality_trait/scp049/evangelical,
		/datum/scp_personality_trait/scp049/aggressive,
		/datum/scp_personality_trait/scp049/philosophical,
		/datum/scp_personality_trait/scp035/comedic,
		/datum/scp_personality_trait/scp035/tragic,
		/datum/scp_personality_trait/scp939/pack_hunter,
		/datum/scp_personality_trait/scp939/silent_predator,
		/datum/scp_personality_trait/scp096/timid,
		/datum/scp_personality_trait/scp096/unstable,
		/datum/scp_personality_trait/scp096/vengeful,
		/datum/scp_personality_trait/scp457/ravenous,
		/datum/scp_personality_trait/scp457/calculated,
		/datum/scp_personality_trait/scp457/spreading,
		/datum/scp_personality_trait/scp999/euphoric,
		/datum/scp_personality_trait/scp999/protective,
		/datum/scp_personality_trait/scp347/audacious,
		/datum/scp_personality_trait/scp347/cautious,
		/datum/scp_personality_trait/scp343/enigmatic,
		/datum/scp_personality_trait/scp343/benevolent,
		/datum/scp_personality_trait/scp131/watchful,
		/datum/scp_personality_trait/scp2398/showoff,
		/datum/scp_personality_trait/scp263/vindictive,
		/datum/scp_personality_trait/scp247/drowsy,
		/datum/scp_personality_trait/scp1507/bold,
		/datum/scp_personality_trait/scp527/oblivious,
	)
	for(var/trait_type in all_traits)
		var/datum/scp_personality_trait/T = trait_type
		var/desg = initial(T.dscp_id)
		if(!LAZYLEN(trait_pools[desg]))
			trait_pools[desg] = list()
		trait_pools[desg] += trait_type

/datum/controller/subsystem/scp_personality/proc/assign_round_traits()
	active_traits = list()
	for(var/desg in trait_pools)
		var/list/pool = trait_pools[desg]
		if(!length(pool))
			continue
		// Only assign to SCPs that actually exist this round.
		var/exists = FALSE
		for(var/atom/A in GLOB.SCP_list)
			if(A.SCP && A.SCP.designation == desg)
				exists = TRUE
				break
		if(!exists)
			continue

		var/num_traits = min(rand(1, 3), length(pool))
		var/list/pool_copy = pool.Copy()
		active_traits[desg] = list()
		for(var/i in 1 to num_traits)
			if(!length(pool_copy))
				break
			var/trait_type = pick_n_take(pool_copy)
			var/datum/scp_personality_trait/T = new trait_type
			active_traits[desg] += T
			// Apply to the live atom now if present.
			for(var/atom/A in GLOB.SCP_list)
				if(A.SCP && A.SCP.designation == desg)
					T.apply_effects(A)
					T.applied = TRUE
					break
			log_game("SCP Personality: [T.name] assigned to SCP-[desg]")

/datum/controller/subsystem/scp_personality/proc/try_apply_unapplied_traits()
	for(var/desg in active_traits)
		var/list/traits = active_traits[desg]
		for(var/datum/scp_personality_trait/T in traits)
			if(T.applied)
				continue
			for(var/atom/A in GLOB.SCP_list)
				if(A.SCP && A.SCP.designation == desg)
					T.apply_effects(A)
					T.applied = TRUE
					log_game("SCP Personality: [T.name] applied to SCP-[desg] (late-join)")
					break

// Late-join scan: partially reveals a hidden trait. Returns TRUE if revealed.
/datum/controller/subsystem/scp_personality/proc/scan_for_trait(mob/user, designation)
	if(!active_traits[designation])
		to_chat(user, SPAN_NOTICE("No anomalous behavioral patterns detected for SCP-[designation]."))
		return FALSE
	var/list/traits = active_traits[designation]
	var/undiscovered = 0
	for(var/datum/scp_personality_trait/T in traits)
		if(T.discovery_state == SCP_PERSONALITY_HIDDEN)
			if(prob(35))
				T.discovery_state = SCP_PERSONALITY_PARTIAL
				to_chat(user, SPAN_NOTICE("Anomalous behavioral pattern partially identified: <b>[T.name]</b> — [T.get_description()]"))
				return TRUE
			undiscovered++
	if(undiscovered > 0)
		to_chat(user, SPAN_NOTICE("Scanning detected anomalous behavioral patterns but could not identify specifics. Try again."))
	else
		to_chat(user, SPAN_NOTICE("All behavioral patterns for SCP-[designation] have been identified."))
	return FALSE

// Full reveal (research milestone, observation achievement).
/datum/controller/subsystem/scp_personality/proc/reveal_trait(designation, trait_name)
	if(!active_traits[designation])
		return FALSE
	for(var/datum/scp_personality_trait/T in active_traits[designation])
		if(T.name == trait_name && T.discovery_state != SCP_PERSONALITY_REVEALED)
			T.discovery_state = SCP_PERSONALITY_REVEALED
			T.on_reveal()
			priority_announcement.Announce(
				"Research update: SCP-[designation] behavioral trait identified — [T.name]. [T.description]",
				"RESEARCH ADVISORY"
			)
			return TRUE
	return FALSE

// Query API for other systems.
/datum/controller/subsystem/scp_personality/proc/get_trait_effects(designation)
	var/list/merged = list()
	for(var/datum/scp_personality_trait/T in active_traits[designation] || list())
		for(var/key in T.effects)
			merged[key] = T.effects[key]
	return merged

/datum/controller/subsystem/scp_personality/proc/get_traits_data(designation)
	var/list/out = list()
	for(var/datum/scp_personality_trait/T in active_traits[designation] || list())
		out += list(list(
			"name" = T.name,
			"description" = T.get_description(),
			"state" = T.discovery_state
		))
	return out
