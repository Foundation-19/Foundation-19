// SCP Codex System for Foundation-19.
// Ported from daedalusdock scp_codex_system.dm, adapted:
//  - per-ckey unlock states persisted via SSscp_persistence's JSON file
//  - discovery hooks: first examine, tests, breaches (fed from research system)
//  - no TG persistent_progression XP; discovery is its own reward

#define CODEX_LOCKED 0
#define CODEX_BASIC 1
#define CODEX_DETAILED 2
#define CODEX_FULL 3

/datum/codex_entry
	var/id
	var/name = "Unknown"
	var/classification = "Unknown"
	var/description = "DATA NOT YET COLLECTED"
	var/lore = "ADDITIONAL DATA CLASSIFIED"
	var/containment_procedures = "CONTAINMENT PROTOCOLS UNKNOWN"
	var/threat_level = "UNKNOWN"

// ---------------------------------------------------------------------------

/datum/codex_manager
	var/list/datum/codex_entry/entries = list()
	// ckey -> entry_id -> unlock level
	var/list/player_codexes = list()

/datum/codex_manager/New()
	initialize_entries()

/datum/codex_manager/proc/initialize_entries()
	entries["173"] = new /datum/codex_entry/scp173
	entries["096"] = new /datum/codex_entry/scp096
	entries["106"] = new /datum/codex_entry/scp106
	entries["049"] = new /datum/codex_entry/scp049
	entries["999"] = new /datum/codex_entry/scp999
	entries["035"] = new /datum/codex_entry/scp035
	entries["457"] = new /datum/codex_entry/scp457
	entries["939"] = new /datum/codex_entry/scp939
	entries["914"] = new /datum/codex_entry/scp914
	entries["113"] = new /datum/codex_entry/scp113
	entries["500"] = new /datum/codex_entry/scp500
	entries["294"] = new /datum/codex_entry/scp294
	entries["012"] = new /datum/codex_entry/scp012
	entries["151"] = new /datum/codex_entry/scp151
	entries["216"] = new /datum/codex_entry/scp216
	entries["066"] = new /datum/codex_entry/scp066
	entries["082"] = new /datum/codex_entry/scp082
	entries["912"] = new /datum/codex_entry/scp912
	entries["343"] = new /datum/codex_entry/scp343
	entries["247"] = new /datum/codex_entry/scp247
	entries["131"] = new /datum/codex_entry/scp131
	entries["263"] = new /datum/codex_entry/scp263
	entries["347"] = new /datum/codex_entry/scp347
	entries["527"] = new /datum/codex_entry/scp527
	entries["513"] = new /datum/codex_entry/scp513
	entries["895"] = new /datum/codex_entry/scp895

// Global entry point — any system can report a discovery.
/proc/codex_discover(ckey, designation, level = CODEX_BASIC, source = "unknown", mob/discoverer = null)
	if(!SSscp_codex || !SSscp_codex.manager)
		return FALSE
	return SSscp_codex.manager.unlock_entry_for_player(ckey, designation, level, source, discoverer)

/datum/codex_manager/proc/get_player_codex(ckey)
	if(!(ckey in player_codexes))
		player_codexes[ckey] = list()
	return player_codexes[ckey]

/datum/codex_manager/proc/unlock_entry_for_player(ckey, designation, level = CODEX_BASIC, source = "unknown", mob/discoverer = null)
	if(!ckey || !entries[designation])
		return FALSE
	var/player_state = get_player_codex(ckey)[designation] || CODEX_LOCKED
	if(player_state >= level)
		return FALSE
	get_player_codex(ckey)[designation] = level
	log_game("Codex: Player [ckey] unlocked SCP-[designation] to level [level] via [source]")
	return TRUE

/datum/codex_manager/proc/get_player_progress(ckey)
	var/list/progress = list()
	var/unlocked = 0
	for(var/desg in entries)
		var/state = get_player_codex(ckey)[desg] || CODEX_LOCKED
		if(state > CODEX_LOCKED)
			unlocked++
	progress["unlocked"] = unlocked
	progress["total"] = entries.len
	return progress

/datum/codex_manager/proc/get_entry_display(ckey, designation)
	if(!entries[designation])
		return null
	var/datum/codex_entry/entry = entries[designation]
	var/state = get_player_codex(ckey)[designation] || CODEX_LOCKED
	var/list/data = list(
		"id" = entry.id,
		"name" = state >= CODEX_BASIC ? entry.name : "SCP-???",
		"classification" = state >= CODEX_BASIC ? entry.classification : "UNKNOWN",
		"threat_level" = state >= CODEX_BASIC ? entry.threat_level : "UNKNOWN",
		"unlock_state" = state,
		"description" = state >= CODEX_DETAILED ? entry.description : "DATA NOT YET COLLECTED",
		"containment_procedures" = state >= CODEX_FULL ? entry.containment_procedures : "CONTAINMENT PROTOCOLS CLASSIFIED",
		"lore" = state >= CODEX_FULL ? entry.lore : "ADDITIONAL DATA CLASSIFIED"
	)
	return data

/datum/codex_manager/proc/get_list_data(ckey)
	var/list/out = list()
	for(var/desg in entries)
		var/list/d = get_entry_display(ckey, desg)
		out += list(d)
	return out

// ---------------------------------------------------------------------------
// Codex entry content (Foundation-19 SCPs)

/datum/codex_entry/scp173
	id = "173"
	name = "SCP-173"
	classification = "Euclid"
	description = "A concrete sculpture that moves when unobserved. Extremely hostile when moving."
	containment_procedures = "Maintain direct line of sight at all times. Never enter containment alone. Blink in coordinated teams."
	threat_level = "High"
	lore = "Believed to be of anomalous origin. First contained in 1993. Responsible for multiple containment breaches."

/datum/codex_entry/scp096
	id = "096"
	name = "SCP-096"
	classification = "Euclid"
	description = "A tall humanoid that becomes violently enraged when its face is viewed."
	containment_procedures = "Keep face covered at all times. Do not allow visual contact with facial features."
	threat_level = "Extreme"
	lore = "Origin unknown. Capable of pursuit across any distance once triggered."

/datum/codex_entry/scp106
	id = "106"
	name = "SCP-106"
	classification = "Keter"
	description = "A corroded elderly humanoid that passes through matter and drags victims into a pocket dimension."
	containment_procedures = "Containment requires constant monitoring. Femur breaker protocol for recontainment."
	threat_level = "Keter"
	lore = "Its motives are unknown. Its domain defies conventional mapping."

/datum/codex_entry/scp049
	id = "049"
	name = "SCP-049"
	classification = "Euclid"
	description = "A plague doctor humanoid that seeks to 'cure' the Pestilence, converting victims into 049-2 instances."
	containment_procedures = "Standard humanoid containment. All interaction recorded. No surgical instruments permitted."
	threat_level = "Euclid"
	lore = "Cooperative in interviews. Obsessed with a disease only it can perceive."

/datum/codex_entry/scp999
	id = "999"
	name = "SCP-999"
	classification = "Safe"
	description = "A friendly orange slime that induces euphoria on contact. Zero hostile potential."
	containment_procedures = "Free play permitted. Feed twice daily. Do not expose to SCP-682."
	threat_level = "None"
	lore = "Site morale asset. Possibly the most beloved anomaly on-site."

/datum/codex_entry/scp035
	id = "035"
	name = "SCP-035"
	classification = "Keter"
	description = "A porcelain comedy mask that possesses any human who wears it, corroding the host over time."
	containment_procedures = "Sealed in a locked containment box. Two guards minimum at all times."
	threat_level = "Keter"
	lore = "Highly intelligent and persuasive. Has escaped multiple times through manipulation alone."

/datum/codex_entry/scp457
	id = "457"
	name = "SCP-457"
	classification = "Keter"
	description = "A sentient flame that grows by consuming fuel. Spreads if uncontained."
	containment_procedures = "Fuel-starved containment chamber. Absolute prohibition of flammables in the chamber."
	threat_level = "Keter"
	lore = "Reacts to fuel sources within line of sight. Grows exponentially when fed."

/datum/codex_entry/scp939
	id = "939"
	name = "SCP-939"
	classification = "Keter"
	description = "Eyeless pack predators that hunt by sound and mimic the voices of their victims."
	containment_procedures = "Sound-dampened chamber. Min-20 personnel for containment operations."
	threat_level = "Keter"
	lore = "Blind. Their lure is the voices of the dead."

/datum/codex_entry/scp914
	id = "914"
	name = "SCP-914"
	classification = "Safe"
	description = "A massive clockwork refinement machine with settings from Rough to Very Fine."
	containment_procedures = "Operation requires Level 3 science clearance. No living input permitted."
	threat_level = "None (indirect)"
	lore = "Output unpredictability is the primary hazard. Documented recipes remain incomplete."

/datum/codex_entry/scp113
	id = "113"
	name = "SCP-113"
	classification = "Safe"
	description = "A red quartz object that swaps the sex of whoever touches it with bare skin."
	containment_procedures = "Handle with insulated gloves only. Bare-hand contact triggers transmutation."
	threat_level = "Low"
	lore = "Repeated exposures carry compounding risk of fatal transformation."

/datum/codex_entry/scp500
	id = "500"
	name = "SCP-500"
	classification = "Safe"
	description = "A pill bottle containing pills that cure all known diseases and anomalous afflictions."
	containment_procedures = "Pills are irreplaceable. Dispensation requires dual Level 3 authorization."
	threat_level = "None"
	lore = "Finite supply. Every pill spent is a pill gone forever."

/datum/codex_entry/scp294
	id = "294"
	name = "SCP-294"
	classification = "Safe"
	description = "A coffee machine that dispenses any liquid requested by name."
	containment_procedures = "Level 2 access. Do not request unknown or dangerous substances."
	threat_level = "Low"
	lore = "Requests beyond liquids have... consequences."

/datum/codex_entry/scp012
	id = "012"
	name = "SCP-012"
	classification = "Euclid"
	description = "An incomplete musical composition written in blood that compels viewers to complete it with their own flesh."
	containment_procedures = "Sealed in a locked safe. Memetic handlers only."
	threat_level = "Euclid"
	lore = "Recovered from a dig site. The composition is mathematically impossible."

/datum/codex_entry/scp151
	id = "151"
	name = "SCP-151"
	classification = "Safe"
	description = "A painting that induces the sensation of drowning in those who view it."
	containment_procedures = "Keep covered. Uncover only for authorized viewing sessions."
	threat_level = "Low"
	lore = "The water in the painting is deeper than the frame."

/datum/codex_entry/scp216
	id = "216"
	name = "SCP-216"
	classification = "Safe"
	description = "A safe with a combination lock whose interior contains different objects per combination."
	containment_procedures = "Standard secure storage. Log all combinations used."
	threat_level = "Low"
	lore = "Dimensional interior mapping is an ongoing research priority."

/datum/codex_entry/scp066
	id = "066"
	name = "SCP-066"
	classification = "Euclid"
	description = "A mass of yarn that plays music and occasionally produces a deafening tone."
	containment_procedures = "Soundproof containment. Noise events are site-wide audio hazards."
	threat_level = "Euclid"
	lore = "It says 'Eric'. We do not know who Eric is."

/datum/codex_entry/scp082
	id = "082"
	name = "SCP-082"
	classification = "Euclid"
	description = "A friendly giant with an appetite for human flesh — cheerful until he's hungry."
	containment_procedures = "Apartment-suite containment with regular meals. Never let him go hungry."
	threat_level = "Euclid"
	lore = "Sociable and polite. Requests that you call him 'Fernand'."

/datum/codex_entry/scp912
	id = "912"
	name = "SCP-912"
	classification = "Safe"
	description = "A disembodied SWAT armor that enforces law enforcement protocols autonomously."
	containment_procedures = "Standard storage. Do not present it with perceived criminal activity."
	threat_level = "Low"
	lore = "It believes it is a police officer. It is extremely committed to this."

/datum/codex_entry/scp343
	id = "343"
	name = "SCP-343"
	classification = "Safe"
	description = "A elderly man claiming to be God. Reality-defying capabilities, appears uncontainable."
	containment_procedures = "Open containment. He stays because he wishes to. Be polite."
	threat_level = "Unknown"
	lore = "Walked through the containment wall. We no longer try."

/datum/codex_entry/scp247
	id = "247"
	name = "SCP-247"
	classification = "Euclid"
	description = "A Bengal tiger that appears to all human observers as an innocent house cat."
	containment_procedures = "Feeding via remote systems. Personnel are NOT to enter the enclosure."
	threat_level = "Euclid"
	lore = "Non-human observers (cameras) see the truth. Cameras do not un-see it for you."

/datum/codex_entry/scp131
	id = "131"
	name = "SCP-131"
	classification = "Safe"
	description = "Two friendly teardrop-shaped eye pods that bond with personnel and warn of danger."
	containment_procedures = "Free roaming permitted. They know where the eyes should be."
	threat_level = "None"
	lore = "They stare unblinking at SCP-173 when its friend is nearby. Somehow, this helps."

/datum/codex_entry/scp263
	id = "263"
	name = "SCP-263"
	classification = "Euclid"
	description = "A game show television that punishes incorrect answers."
	containment_procedures = "Research chamber only. Do not answer wrong."
	threat_level = "Euclid"
	lore = "The show must go on."

/datum/codex_entry/scp347
	id = "347"
	name = "SCP-347"
	classification = "Euclid"
	description = "An invisible woman. Contentment-based containment — social interaction keeps her home."
	containment_procedures = "Regular conversation visits. Low contentment leads to wandering."
	threat_level = "Low"
	lore = "Known as 'Claude Rains'. Thermal imaging partially reveals her."

/datum/codex_entry/scp527
	id = "527"
	name = "SCP-527"
	classification = "Safe"
	description = "Mr. Fish — an ordinary man with a fish head. Entirely cooperative."
	containment_procedures = "Standard humanoid apartment. He prefers the kitchen."
	threat_level = "None"
	lore = "He would like you to know that he is, in fact, Mr. Fish."

/datum/codex_entry/scp513
	id = "513"
	name = "SCP-513"
	classification = "Euclid"
	description = "A cowbell whose ringing summons a gaunt stalker that torments the hearer."
	containment_procedures = "Soundproof containment. Accidental ringing is a site-wide emergency."
	threat_level = "Euclid"
	lore = "Once you hear it, it is already behind you."

/datum/codex_entry/scp895
	id = "895"
	name = "SCP-895"
	classification = "Euclid"
	description = "An oak coffin that projects horrific imagery through camera feeds near it."
	containment_procedures = "No cameras in or near the containment room. Off-camera handling only."
	threat_level = "Euclid"
	lore = "The images worsen with exposure. Do not watch."

// ---------------------------------------------------------------------------
// Subsystem + persistence

SUBSYSTEM_DEF(scp_codex)
	name = "SCP Codex"
	flags = SS_NO_FIRE
	var/datum/codex_manager/manager

/datum/controller/subsystem/scp_codex/Initialize()
	manager = new
	load_codex()
	return ..()

/datum/controller/subsystem/scp_codex/proc/load_codex()
	var/filename = "data/scp_codex.json"
	if(!fexists(filename))
		return
	var/json_data = file2text(filename)
	if(!rustg_json_is_valid(json_data))
		return
	var/list/data = json_decode(json_data)
	if(data && data["player_codexes"])
		manager.player_codexes = data["player_codexes"]
	log_game("Codex: loaded [manager.player_codexes.len] player codex records")

/datum/controller/subsystem/scp_codex/proc/save_codex()
	var/list/data = list("player_codexes" = manager.player_codexes)
	var/result = rustg_file_write(json_encode(data), "data/scp_codex.json")
	if(result != "ok" && result != "true")
		log_game("Codex: save error [result]")

/datum/controller/subsystem/scp_codex/Shutdown()
	save_codex()
	return ..()

// Convenience hooks called from research systems.
/proc/codex_on_first_examine(mob/examinee, designation)
	if(!examinee?.ckey || !SSscp_codex?.manager)
		return
	SSscp_codex.manager.unlock_entry_for_player(examinee.ckey, designation, CODEX_BASIC, "visual observation", examinee)

/proc/codex_on_test(designation, mob/researcher, level = CODEX_DETAILED)
	if(!researcher?.ckey || !SSscp_codex?.manager)
		return
	SSscp_codex.manager.unlock_entry_for_player(researcher.ckey, designation, level, "controlled testing", researcher)

/proc/codex_on_breach(designation, mob/witness)
	if(!SSscp_codex?.manager)
		return
	if(witness?.ckey)
		SSscp_codex.manager.unlock_entry_for_player(witness.ckey, designation, CODEX_BASIC, "breach observation", witness)
