// Cross-SCP interaction system — ported from daedalusdock scp_interactions.dm,
// adapted to Foundation-19:
//  - interactions keyed by F19 designation strings ("049", "035", ...)
//  - research gating via GLOB.scp_research_tracker (per-SCP tier levels)
//  - atoms resolved from GLOB.SCP_list (A.SCP.designation), prefix match for
//    instanced SCPs like 008 zombies ("008-3" matches "008")
//  - only pairs whose both SCPs exist on this map are registered
// Discovery: interactions start hidden; researchers unlock them by testing the
// involved SCPs (chance scales with each side's research tier). Discovered
// interactions tick on a proximity/probability/cooldown loop.

#define CROSS_INTERACT_TIER_1 1
#define CROSS_INTERACT_TIER_5 5

/datum/cross_scp_interaction
	var/interaction_id
	var/name
	var/description
	var/scp_id_1
	var/scp_id_2
	var/tier = 1
	var/research_required_scp1 = 3
	var/research_required_scp2 = 3
	var/probability = 2
	var/range_required = 15
	var/discovered = FALSE
	var/discovery_time
	var/discovered_by
	var/trigger_count = 0
	var/last_trigger_time = 0
	var/cooldown = 60 SECONDS

/datum/cross_scp_interaction/New(interaction_id, name, description, scp_id_1, scp_id_2, tier, req1, req2, prob, range_req, cooldown_time)
	src.interaction_id = interaction_id
	src.name = name
	src.description = description
	src.scp_id_1 = scp_id_1
	src.scp_id_2 = scp_id_2
	src.tier = tier
	src.research_required_scp1 = req1
	src.research_required_scp2 = req2
	src.probability = prob
	src.range_required = range_req
	src.cooldown = cooldown_time

SUBSYSTEM_DEF(scp_cross_interactions)
	name = "SCP Cross-Interactions"
	wait = 300
	flags = SS_BACKGROUND
	var/list/interactions = list()
	var/list/discovered_interactions = list()
	var/setup_complete = FALSE

/datum/controller/subsystem/scp_cross_interactions/Initialize()
	initialize_cross_interactions()
	setup_complete = TRUE
	log_game("SCP Cross-Interactions: Registered [interactions.len] interactions.")
	return ..()

/datum/controller/subsystem/scp_cross_interactions/fire()
	if(!setup_complete)
		return
	process_cross_interactions()

/datum/controller/subsystem/scp_cross_interactions/proc/initialize_cross_interactions()
	// --- 049 pairings ---
	register_interaction("049_detect_008", "Pestilence Resonance", "SCP-049 senses SCP-008-infected subjects nearby, recognizing them as 'partially cured' of the Pestilence.", "049", "008", 1, 2, 2, 2, 10, 60 SECONDS)
	register_interaction("049_sense_035_host", "Corrupted Flesh", "SCP-049 perceives SCP-035's host as uniquely pestilent, becoming agitated and focused on 'curing' them.", "049", "035", 2, 3, 3, 3, 8, 90 SECONDS)
	register_interaction("035_manipulate_049", "Silver Tongue", "SCP-035's psychological influence calms SCP-049, convincing the Doctor that it is already 'cured' of the Pestilence.", "035", "049", 2, 3, 3, 4, 6, 120 SECONDS)
	register_interaction("999_heal_049_victims", "Anti-Pestilence", "SCP-999's healing properties can partially reverse SCP-049's 'cure' effects on recent victims.", "999", "049", 4, 4, 4, 2, 5, 240 SECONDS)
	register_interaction("2343_benevolence_049", "Unwanted Grace", "SCP-2343's presence soothes SCP-049's compulsion to 'cure,' temporarily reducing its aggression toward humans.", "2343", "049", 2, 2, 3, 4, 8, 120 SECONDS)

	// --- 999 pairings ---
	register_interaction("999_calm_096", "Tickle Therapy", "SCP-999's presence has a measurable calming effect on SCP-096, reducing rage state duration.", "999", "096", 2, 3, 3, 4, 5, 120 SECONDS)
	register_interaction("999_counter_513", "Joyful Counter", "SCP-999's emotional aura counters SCP-513's stalking effect. Affected personnel feel the presence recede.", "999", "513", 2, 3, 3, 5, 7, 90 SECONDS)
	register_interaction("999_counter_035", "Emotional Shield", "SCP-999's presence creates a temporary resistance to SCP-035's psychological influence in nearby personnel.", "999", "035", 3, 4, 3, 3, 6, 120 SECONDS)

	// --- 106 pairings ---
	register_interaction("106_corrode_173_containment", "Corrosive Pressure", "SCP-106 corrodes SCP-173's containment walls when nearby, weakening structural integrity.", "106", "173", 1, 2, 2, 3, 10, 90 SECONDS)
	register_interaction("106_pocket_939_prey", "Dimensional Ambush", "SCP-106 pulls prey near SCP-939 into the pocket dimension. The combined trauma amplifies 939's mimicry.", "106", "939", 4, 4, 3, 2, 8, 240 SECONDS)
	register_interaction("457_ignite_106_residue", "Burning Trail", "SCP-457 ignites SCP-106's corrosive residue, creating toxic fumes that spread through corridors.", "457", "106", 2, 3, 2, 4, 8, 120 SECONDS)
	register_interaction("2020_phase_106", "Phasing Collision", "SCP-2020's phasing ability interferes with SCP-106's dimensional travel, creating spatial distortions.", "2020", "106", 3, 3, 3, 2, 8, 180 SECONDS)
	register_interaction("280_shadow_106", "Shadow Pocket", "SCP-280 retreats into SCP-106's pocket dimension through shadow, emerging at different locations as a shadow scout.", "280", "106", 3, 3, 3, 2, 8, 180 SECONDS)

	// --- 173 pairings ---
	register_interaction("017_shadow_173", "Shadow Sculpture", "SCP-017's shadow entity manifests near SCP-173 when unobserved, creating a secondary threat.", "017", "173", 3, 3, 3, 3, 8, 150 SECONDS)
	register_interaction("131_watch_173", "Eye Pod Guardian", "SCP-131's unblinking gaze provides additional observation coverage near SCP-173, preventing it from moving.", "131", "173", 2, 2, 2, 5, 4, 60 SECONDS)
	register_interaction("247_illusion_173", "Harmless Sculpture", "SCP-247's illusion makes SCP-173 appear as a harmless statue, causing observers to look away and enabling 173 to move.", "247", "173", 3, 3, 3, 3, 6, 150 SECONDS)
	register_interaction("2398_baseball_173", "Home Run", "SCP-2398's baseball bat can knock SCP-173 backward when struck, temporarily disrupting its movement.", "2398", "173", 1, 1, 2, 5, 2, 30 SECONDS)

	// --- 096/017 pairings ---
	register_interaction("017_shadow_096", "Blind Shadow", "SCP-017's shadow entity avoids SCP-096's face, instinctively retreating. 096 ignores 017 as it cannot perceive its face.", "017", "096", 2, 2, 3, 3, 10, 120 SECONDS)
	register_interaction("131_watch_096", "Tragic Vigil", "SCP-131 refuses to look at SCP-096, instinctively averting its gaze. 131 instead alerts nearby personnel.", "131", "096", 2, 2, 3, 3, 6, 90 SECONDS)
	register_interaction("247_illusion_096", "Invisible Face", "SCP-247's illusion prevents viewers from perceiving SCP-096's face, providing accidental protection.", "247", "096", 3, 3, 3, 2, 8, 180 SECONDS)

	// --- 035 pairings ---
	register_interaction("035_corrupt_939_voice", "Poisoned Whispers", "SCP-035's influence amplifies SCP-939's voice mimicry, making lures nearly irresistible.", "035", "939", 3, 4, 3, 2, 10, 180 SECONDS)
	register_interaction("939_mimic_035_voice", "Perfect Impersonation", "SCP-939 mimics SCP-035's host voice patterns with uncanny accuracy after proximity.", "939", "035", 3, 3, 3, 3, 10, 180 SECONDS)
	register_interaction("151_mirror_035", "Reflected Possession", "SCP-151's water reflections amplify SCP-035's telepathic range.", "151", "035", 3, 3, 3, 2, 6, 180 SECONDS)
	register_interaction("347_stealth_035", "Invisible Manipulator", "SCP-347's invisibility allows SCP-035 to spread its influence through an unseen agent.", "347", "035", 3, 3, 3, 2, 8, 180 SECONDS)
	register_interaction("066_eric_035", "Eric's Interference", "SCP-066 repeatedly says 'Eric' near SCP-035, disrupting its telepathic influence.", "066", "035", 2, 2, 3, 3, 5, 90 SECONDS)
	register_interaction("5000_suit_035", "Mind Shield", "SCP-5000's suit technology provides complete immunity to SCP-035's telepathic influence when worn.", "5000", "035", 4, 5, 4, 0, 2, 0)

	// --- 914 refinement pairs (item SCPs near the clockwork mechanism) ---
	register_interaction("914_refine_500", "Miracle Refinement", "SCP-914 on Fine setting applied to SCP-500 creates an enhanced variant with doubled efficacy.", "914", "500", 2, 3, 2, 0, 3, 0)
	register_interaction("914_refine_113", "Gender Refinement", "SCP-914 refines SCP-113 into a safer variant with reduced rejection risk.", "914", "113", 2, 3, 2, 0, 3, 0)
	register_interaction("914_refine_513", "Bell Refinement", "SCP-914 on Rough setting destroys SCP-513's memetic properties.", "914", "513", 3, 4, 3, 0, 3, 0)
	register_interaction("914_refine_427", "Locket Refinement", "SCP-914 on Fine setting creates a stabilized SCP-427 variant that heals without the corruption side effect.", "914", "427", 4, 5, 4, 0, 3, 0)

	// --- 500 cure pairs (pills used against effects) ---
	register_interaction("500_cure_008", "Universal Antidote", "An SCP-500 pill can cure SCP-008 infection entirely at any stage.", "500", "008", 2, 3, 2, 0, 2, 0)
	register_interaction("500_cure_049_touch", "Undoing the Cure", "An SCP-500 pill can reverse SCP-049's 'cure' on a recent victim.", "500", "049", 3, 4, 3, 0, 2, 0)
	register_interaction("500_cure_513_stalked", "Presence Banishment", "An SCP-500 pill can permanently end SCP-513's stalking effect on a victim.", "500", "513", 2, 3, 2, 0, 2, 0)
	register_interaction("500_cure_013", "Blue Lady Cure", "An SCP-500 pill cures SCP-013 addiction, freeing the subject from the Blue Lady's influence.", "500", "013", 2, 3, 2, 0, 2, 0)
	register_interaction("427_heal_008_infection", "Cursed Cure", "SCP-427 can halt SCP-008 infection progression temporarily, but accelerates 427's corruption effect.", "427", "008", 4, 5, 4, 0, 2, 0)

	// --- 216 / 263 / misc ---
	register_interaction("216_vault_500", "Emergency Cache", "SCP-216 occasionally dispenses SCP-500 pills when accessed by critically injured personnel.", "216", "500", 2, 2, 3, 0, 3, 0)
	register_interaction("263_quiz_012", "Game of Compulsion", "SCP-263's quiz questions reference SCP-012's composition. Correct answers grant temporary resistance to 012's compulsion.", "263", "012", 2, 2, 3, 0, 5, 0)
	register_interaction("013_bluelady_012", "Tragic Duet", "SCP-013's Blue Lady hallucination compels subjects to complete SCP-012's composition, creating a self-reinforcing compulsion loop.", "013", "012", 3, 3, 3, 2, 5, 180 SECONDS)
	register_interaction("151_mirror_895", "Corrupted Reflection", "SCP-151's reflections carry SCP-895's visual corruption, extending the hallucination effect to viewers.", "151", "895", 3, 3, 3, 2, 8, 150 SECONDS)
	register_interaction("457_feed_895_corpse", "Pyre of Shadows", "SCP-457 burns remains near SCP-895. The corrupted smoke extends 895's hallucination range.", "457", "895", 3, 3, 3, 2, 10, 180 SECONDS)
	register_interaction("2427_malfunction_914", "Refinement Glitch", "SCP-2427-3 causes SCP-914 to produce glitched outputs with mixed properties when both are active nearby.", "2427-3", "914", 3, 3, 2, 2, 5, 180 SECONDS)
	register_interaction("280_shadow_017", "Shadow Synergy", "SCP-280's shadow form merges with SCP-017's shadow entity when both are present.", "280", "017", 3, 3, 3, 3, 6, 180 SECONDS)
	register_interaction("343_god_999", "Divine Joy", "SCP-343 enhances SCP-999's healing aura in its presence.", "343", "999", 2, 2, 3, 4, 5, 120 SECONDS)
	register_interaction("527_trade_082", "Dragon's Feast", "SCP-527 provides SCP-082 with choice ingredients, earning 082's temporary cooperation.", "527", "082", 2, 2, 2, 4, 6, 120 SECONDS)
	register_interaction("529_half_cat_131", "Feline Alliance", "SCP-529 and SCP-131 form a protective pair, with 131's vigilance covering 529's vulnerable back half.", "529", "131", 1, 1, 1, 5, 4, 60 SECONDS)
	register_interaction("3349_liquid_008", "Toxic Cocktail", "SCP-3349's reagent interaction with SCP-008 creates an accelerated infection vector.", "3349", "008", 4, 4, 4, 2, 5, 300 SECONDS)

/datum/controller/subsystem/scp_cross_interactions/proc/register_interaction(id, name, desc, scp1, scp2, tier, req1, req2, prob, range_req, cooldown_time)
	var/datum/cross_scp_interaction/I = new(id, name, desc, scp1, scp2, tier, req1, req2, prob, range_req, cooldown_time)
	interactions[id] = I

// ---------------------------------------------------------------------------
// Atom resolution (F19: atoms hold .SCP datums keyed by designation)
// ---------------------------------------------------------------------------

/proc/find_scp_atom(designation)
	for(var/atom/A in GLOB.SCP_list)
		var/datum/scp/S = A.SCP
		if(!S || !S.designation)
			continue
		if(S.designation == designation)
			return A
		// Instanced SCPs (008 zombies "008-3") match their base designation.
		if(copytext(S.designation, 1, length(designation) + 2) == "[designation]-")
			return A
	return null

/proc/get_scp_research_level_cross(designation)
	var/datum/scp_research/research = GLOB.scp_research_tracker ? GLOB.scp_research_tracker.get_research(designation) : null
	return research ? research.research_level : 0

// ---------------------------------------------------------------------------
// Main loop
// ---------------------------------------------------------------------------

/datum/controller/subsystem/scp_cross_interactions/proc/process_cross_interactions()
	for(var/interaction_id in interactions)
		var/datum/cross_scp_interaction/I = interactions[interaction_id]
		if(!I.discovered)
			continue
		if(I.probability <= 0)
			continue
		if(world.time - I.last_trigger_time < I.cooldown)
			continue
		if(!prob(I.probability))
			continue
		var/atom/scp1 = find_scp_atom(I.scp_id_1)
		var/atom/scp2 = find_scp_atom(I.scp_id_2)
		if(!scp1 || !scp2)
			continue
		if(I.range_required > 0 && get_dist(scp1, scp2) > I.range_required)
			continue
		if(!check_research_requirement(I))
			continue
		execute_interaction(interaction_id, scp1, scp2)

/datum/controller/subsystem/scp_cross_interactions/proc/check_research_requirement(datum/cross_scp_interaction/I)
	var/level1 = get_scp_research_level_cross(I.scp_id_1)
	var/level2 = get_scp_research_level_cross(I.scp_id_2)
	return (level1 >= I.research_required_scp1 && level2 >= I.research_required_scp2)

// ---------------------------------------------------------------------------
// Discovery — called from research (test completion, scanner observation)
// ---------------------------------------------------------------------------

/datum/controller/subsystem/scp_cross_interactions/proc/try_discover_interaction(scp_designation, researcher_ckey)
	for(var/interaction_id in interactions)
		var/datum/cross_scp_interaction/I = interactions[interaction_id]
		if(I.discovered)
			continue
		var/level1 = get_scp_research_level_cross(I.scp_id_1)
		var/level2 = get_scp_research_level_cross(I.scp_id_2)
		var/discovery_chance = 0
		if(I.scp_id_1 == scp_designation && level1 >= I.research_required_scp1)
			discovery_chance = 10 + (level1 * 5)
		else if(I.scp_id_2 == scp_designation && level2 >= I.research_required_scp2)
			discovery_chance = 10 + (level2 * 5)
		if(discovery_chance > 0 && prob(discovery_chance))
			discover_interaction(interaction_id, researcher_ckey)

/datum/controller/subsystem/scp_cross_interactions/proc/discover_interaction(interaction_id, researcher_ckey)
	var/datum/cross_scp_interaction/I = interactions[interaction_id]
	if(!I || I.discovered)
		return
	I.discovered = TRUE
	I.discovery_time = world.time
	I.discovered_by = researcher_ckey
	discovered_interactions[interaction_id] = I
	log_game("SCP Cross-Interaction Discovered: [I.name] ([I.scp_id_1] x [I.scp_id_2]) by [researcher_ckey || "system"]")
	// Reward: push points into both involved SCPs' research + the site pool.
	for(var/side in list(I.scp_id_1, I.scp_id_2))
		var/datum/scp_research/research = GLOB.scp_research_tracker ? GLOB.scp_research_tracker.get_research(side) : null
		if(research)
			research.add_research_points(150, "cross_interaction_discovery")
	if(researcher_ckey)
		for(var/client/C in GLOB.clients)
			if(C?.mob?.ckey == researcher_ckey)
				to_chat(C, SPAN_BOLDNOTICE("RESEARCH DISCOVERY: Cross-anomaly interaction '[I.name]' identified between SCP-[I.scp_id_1] and SCP-[I.scp_id_2]!"))
				break
	log_and_message_staff("RESEARCH: [researcher_ckey ? "[researcher_ckey] discovered" : "The system auto-discovered"] cross-SCP interaction '[I.name]' (SCP-[I.scp_id_1] x SCP-[I.scp_id_2]).")

// ---------------------------------------------------------------------------
// Execution
// ---------------------------------------------------------------------------

/datum/controller/subsystem/scp_cross_interactions/proc/execute_interaction(interaction_id, atom/scp1, atom/scp2)
	var/datum/cross_scp_interaction/I = interactions[interaction_id]
	if(!I)
		return FALSE
	I.trigger_count++
	I.last_trigger_time = world.time
	var/result = execute_interaction_impl(interaction_id, scp1, scp2)
	if(result)
		hook_scp_cross_interaction(I.scp_id_1, I.scp_id_2, interaction_id, I.name)
	return result

/datum/controller/subsystem/scp_cross_interactions/proc/execute_interaction_impl(interaction_id, atom/scp1, atom/scp2)
	switch(interaction_id)
		if("049_detect_008")
			return interact_049_detect_008(scp1, scp2)
		if("049_sense_035_host")
			return interact_049_sense_035_host(scp1, scp2)
		if("035_manipulate_049")
			return interact_035_manipulate_049(scp1, scp2)
		if("999_heal_049_victims")
			return interact_999_heal_049_victims(scp1, scp2)
		if("2343_benevolence_049")
			return interact_2343_benevolence_049(scp1, scp2)
		if("999_calm_096")
			return interact_999_calm_096(scp1, scp2)
		if("999_counter_513")
			return interact_999_counter_513(scp1, scp2)
		if("999_counter_035")
			return interact_999_counter_035(scp1, scp2)
		if("106_corrode_173_containment")
			return interact_106_corrode_173_containment(scp1, scp2)
		if("106_pocket_939_prey")
			return interact_106_pocket_939_prey(scp1, scp2)
		if("457_ignite_106_residue")
			return interact_457_ignite_106_residue(scp1, scp2)
		if("2020_phase_106")
			return interact_2020_phase_106(scp1, scp2)
		if("280_shadow_106")
			return interact_280_shadow_106(scp1, scp2)
		if("017_shadow_173")
			return interact_017_shadow_173(scp1, scp2)
		if("131_watch_173")
			return interact_131_watch_173(scp1, scp2)
		if("247_illusion_173")
			return interact_247_illusion_173(scp1, scp2)
		if("2398_baseball_173")
			return interact_2398_baseball_173(scp1, scp2)
		if("017_shadow_096")
			return interact_017_shadow_096(scp1, scp2)
		if("131_watch_096")
			return interact_131_watch_096(scp1, scp2)
		if("247_illusion_096")
			return interact_247_illusion_096(scp1, scp2)
		if("035_corrupt_939_voice")
			return interact_035_corrupt_939_voice(scp1, scp2)
		if("939_mimic_035_voice")
			return interact_939_mimic_035_voice(scp1, scp2)
		if("151_mirror_035")
			return interact_151_mirror_035(scp1, scp2)
		if("347_stealth_035")
			return interact_347_stealth_035(scp1, scp2)
		if("066_eric_035")
			return interact_066_eric_035(scp1, scp2)
		if("914_refine_500")
			return interact_914_refine_500(scp1, scp2)
		if("914_refine_113")
			return interact_914_refine_113(scp1, scp2)
		if("914_refine_513")
			return interact_914_refine_513(scp1, scp2)
		if("914_refine_427")
			return interact_914_refine_427(scp1, scp2)
		if("216_vault_500")
			return interact_216_vault_500(scp1, scp2)
		if("263_quiz_012")
			return interact_263_quiz_012(scp1, scp2)
		if("013_bluelady_012")
			return interact_013_bluelady_012(scp1, scp2)
		if("151_mirror_895")
			return interact_151_mirror_895(scp1, scp2)
		if("457_feed_895_corpse")
			return interact_457_feed_895_corpse(scp1, scp2)
		if("2427_malfunction_914")
			return interact_2427_malfunction_914(scp1, scp2)
		if("280_shadow_017")
			return interact_280_shadow_017(scp1, scp2)
		if("343_god_999")
			return interact_343_god_999(scp1, scp2)
		if("527_trade_082")
			return interact_527_trade_082(scp1, scp2)
		if("529_half_cat_131")
			return interact_529_half_cat_131(scp1, scp2)
	return FALSE

// ---------------------------------------------------------------------------
// Persistence hook — feed the log/paperwork trail
// ---------------------------------------------------------------------------

/proc/hook_scp_cross_interaction(scp_id_1, scp_id_2, interaction_id, interaction_name)
	log_game("SCP Cross-Interaction: '[interaction_name]' ([interaction_id]) fired between SCP-[scp_id_1] and SCP-[scp_id_2].")
	// Persistence: record an interaction entry on both instances.
	if(SSscp_persistence && SSscp_persistence.manager)
		for(var/side in list(scp_id_1, scp_id_2))
			var/datum/scp_instance/instance = SSscp_persistence.manager.get_instance(side)
			if(instance)
				instance.add_interaction_record("SYSTEM", "Cross-SCP interaction: [interaction_name] with SCP-[side == scp_id_1 ? scp_id_2 : scp_id_1]")

#undef CROSS_INTERACT_TIER_1
#undef CROSS_INTERACT_TIER_5
