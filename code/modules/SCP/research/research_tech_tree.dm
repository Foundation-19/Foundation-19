// Site-wide SCP technology tree — ported from daedalusdock research_tech_tree.dm.
// Nodes are unlocked by the site research pool (fed by all SCP research point
// earnings) and grant real mechanical bonuses:
//  - research multiplier (point gains site-wide)
//  - sanity resistance (SCP exposure severity reduction)
//  - containment integrity floor (zone integrity minimum)
//  - research catalog unlocks (items fabricable at the research console)

#define TECH_TIER_1 1
#define TECH_TIER_5 5

#define TECH_CATEGORY_CONTAINMENT "Containment"
#define TECH_CATEGORY_MEDICAL "Medical"
#define TECH_CATEGORY_ENGINEERING "Engineering"
#define TECH_CATEGORY_COGNITIVE "Cognitive"
#define TECH_CATEGORY_ANALYTICAL "Analytical"

/datum/scp_tech_node
	var/node_id
	var/name
	var/description
	var/category = TECH_CATEGORY_CONTAINMENT
	var/tier = TECH_TIER_1
	var/research_cost = 100
	var/list/prerequisites = list()
	var/unlocked = FALSE
	var/unlocked_by
	var/unlock_time
	// Mechanical bonuses applied on unlock (cumulative site-wide):
	var/bonus_research_multiplier = 0      // +fraction of point gains
	var/bonus_sanity_resist = 0            // +fraction reduction of SCP exposure severity
	var/bonus_containment_floor = 0        // +minimum zone integrity
	var/list/unlock_catalog = list()       // research catalog item types added

/datum/scp_tech_node/New(node_id, node_name, node_desc, node_category, node_tier, cost, list/prereqs)
	src.node_id = node_id
	name = node_name
	description = node_desc
	category = node_category
	tier = node_tier
	research_cost = cost
	if(prereqs)
		prerequisites = prereqs

/datum/scp_tech_tree
	var/list/datum/scp_tech_node/nodes = list()
	var/list/unlocked_nodes = list()
	var/total_spent = 0

/datum/scp_tech_tree/proc/initialize()
	register_tech_nodes()

/datum/scp_tech_tree/proc/register_tech_nodes()
	var/list/tech_defs = list(
		list("basic_containment", "Basic Containment Protocols", "Standard containment procedures for Safe-class objects.", TECH_CATEGORY_CONTAINMENT, 1, 50, null, list("floor" = 5)),
		list("basic_analysis", "Basic SCP Analysis", "Preliminary anomaly analysis methodology.", TECH_CATEGORY_ANALYTICAL, 1, 50, null, list("research" = 0.10)),
		list("basic_medical", "Anomalous Medicine", "Treatment protocols for anomalous exposure.", TECH_CATEGORY_MEDICAL, 1, 50, null, list("catalog" = list(/obj/item/reagent_containers/hypospray/autoinjector = "Anomalous Exposure Autoinjector"))),
		list("pathogen_identification", "Pathogen Identification", "Rapid identification and classification of Foundation pathogens.", TECH_CATEGORY_MEDICAL, 1, 75, null, list("catalog" = list(/obj/item/reagent_containers/glass/bottle = "Diagnostic Reagent Sample"))),
		list("improved_containment", "Improved Containment", "Enhanced containment for Euclid-class objects.", TECH_CATEGORY_CONTAINMENT, 2, 200, list("basic_containment"), list("floor" = 5)),
		list("advanced_analysis", "Advanced Anomaly Analysis", "Deep anomaly profiling and classification.", TECH_CATEGORY_ANALYTICAL, 2, 200, list("basic_analysis"), list("research" = 0.10)),
		list("cognitive_shielding", "Cognitive Hazard Shielding", "Basic memetic and cognitive hazard protection.", TECH_CATEGORY_COGNITIVE, 2, 200, list("basic_analysis"), list("sanity" = 0.10)),
		list("anomalous_surgery", "Anomalous Surgery", "Surgical techniques for anomalous conditions.", TECH_CATEGORY_MEDICAL, 2, 200, list("basic_medical"), list("catalog" = list(/obj/item/reagent_containers/glass/bottle/inaprovaline = "Surgical Stabilizer Solution"))),
		list("bsl3_protocols", "BSL-3 Containment Protocols", "High-containment laboratory procedures for dangerous pathogens.", TECH_CATEGORY_MEDICAL, 2, 250, list("pathogen_identification"), list("catalog" = list(/obj/item/reagent_containers/spray/sterilizine = "BSL-3 Sterilant Spray"))),
		list("anomalous_virology", "Anomalous Virology", "Study of SCP-derived and reality-altering pathogens.", TECH_CATEGORY_MEDICAL, 2, 250, list("pathogen_identification", "basic_analysis"), list("catalog" = list(/obj/item/reagent_containers/pill/antitox = "Broad-Spectrum Antiviral"))),
		list("containment_reinforcement", "Containment Reinforcement", "Reinforced containment for Keter-class objects.", TECH_CATEGORY_CONTAINMENT, 3, 500, list("improved_containment"), list("floor" = 10)),
		list("amnestics_production", "Amnestics Production", "On-site amnestics manufacturing capability.", TECH_CATEGORY_MEDICAL, 3, 500, list("anomalous_surgery", "cognitive_shielding"), list("catalog" = list(/obj/item/reagent_containers/pill/methylphenidate = "Class-A Amnestic Regimen"))),
		list("pattern_recognition", "Anomaly Pattern Recognition", "Predictive modeling for SCP behavior.", TECH_CATEGORY_ANALYTICAL, 3, 500, list("advanced_analysis"), list("research" = 0.15)),
		list("memetic_countermeasures", "Memetic Countermeasures", "Advanced counter-memetic equipment.", TECH_CATEGORY_COGNITIVE, 3, 500, list("cognitive_shielding"), list("sanity" = 0.10, "catalog" = list(/obj/item/device/scp_memetic_scrubber = "Memetic Scrubber (Restock)"))),
		list("containment_engineering", "Containment Engineering", "Purpose-built containment systems.", TECH_CATEGORY_ENGINEERING, 3, 500, list("improved_containment"), list("floor" = 5)),
		list("bsl4_containment", "BSL-4 Maximum Containment", "Full biocontainment with double-door decon and isolated HVAC.", TECH_CATEGORY_MEDICAL, 3, 600, list("bsl3_protocols", "anomalous_virology"), list("catalog" = list(/obj/item/clothing/suit/bio_suit = "BSL-4 Biohazard Suit"))),
		list("anomalous_cure_development", "Anomalous Cure Synthesis", "Targeted countermeasure development for anomalous pathogens.", TECH_CATEGORY_MEDICAL, 3, 600, list("anomalous_virology", "anomalous_surgery"), list("catalog" = list(/obj/item/reagent_containers/glass/bottle/antitoxin = "Anomalous Exposure Cure Batch"))),
		list("keter_protocols", "Keter-Class Protocols", "Maximum security containment procedures.", TECH_CATEGORY_CONTAINMENT, 4, 1500, list("containment_reinforcement"), list("floor" = 10)),
		list("reality_anchor_theory", "Reality Anchor Theory", "Theoretical framework for reality stabilization.", TECH_CATEGORY_ENGINEERING, 4, 1500, list("containment_engineering"), list("sanity" = 0.10)),
		list("telekill_alloy", "Telekill Alloy Research", "Psychic shielding alloy development.", TECH_CATEGORY_COGNITIVE, 4, 1500, list("memetic_countermeasures"), list("sanity" = 0.05, "catalog" = list(/obj/item/clothing/ears/scp_acoustic_dampener = "Telekill-Lined Dampener (Restock)"))),
		list("scp_weaponization", "SCP Weaponization", "Offensive application of anomalous properties.", TECH_CATEGORY_CONTAINMENT, 4, 1500, list("keter_protocols"), list("catalog" = list(/obj/item/scp_photonic_grenade = "Photonic Grenade (Restock)"))),
		list("bioweapon_countermeasures", "Anomalous Bioweapon Countermeasures", "Large-scale countermeasures for weaponized anomalous pathogens.", TECH_CATEGORY_MEDICAL, 4, 1500, list("bsl4_containment", "anomalous_cure_development"), list("catalog" = list(/obj/item/storage/box/masks = "Early-Response Respirator Kit"))),
		list("apollyon_protocols", "Apollyon Containment Theory", "Theoretical XK-class prevention strategies.", TECH_CATEGORY_CONTAINMENT, 5, 5000, list("keter_protocols", "reality_anchor_theory"), list("floor" = 15)),
		list("project_overwatch", "Project Overwatch", "Global anomaly monitoring network.", TECH_CATEGORY_ANALYTICAL, 5, 5000, list("pattern_recognition", "reality_anchor_theory"), list("research" = 0.15)),
		list("xk_biodefense", "XK-Class Biodefense Protocol", "Ultimate biodefense against existential anomalous pathogen threats.", TECH_CATEGORY_MEDICAL, 5, 5000, list("bioweapon_countermeasures", "apollyon_protocols"), list("sanity" = 0.05, "catalog" = list(/obj/item/storage/box/autoinjectors = "XK-Class Exposure Response Kit"))),
	)

	for(var/list/def in tech_defs)
		var/datum/scp_tech_node/node = new(def[1], def[2], def[3], def[4], def[5], def[6], (length(def) > 6 ? def[7] : null))
		if(length(def) > 7)
			var/list/bonus = def[8]
			node.bonus_research_multiplier = bonus["research"] || 0
			node.bonus_sanity_resist = bonus["sanity"] || 0
			node.bonus_containment_floor = bonus["floor"] || 0
			node.unlock_catalog = bonus["catalog"] || list()
		nodes[node.node_id] = node

/datum/scp_tech_tree/proc/get_node(node_id)
	return nodes[node_id]

/datum/scp_tech_tree/proc/can_unlock(node_id, available_points)
	var/datum/scp_tech_node/node = nodes[node_id]
	if(!node || node.unlocked)
		return FALSE
	if(available_points < node.research_cost)
		return FALSE
	for(var/prereq_id in node.prerequisites)
		var/datum/scp_tech_node/prereq = nodes[prereq_id]
		if(!prereq || !prereq.unlocked)
			return FALSE
	return TRUE

/datum/scp_tech_tree/proc/unlock_node(node_id, researcher_ckey)
	var/datum/scp_tech_node/node = nodes[node_id]
	if(!node || node.unlocked)
		return FALSE
	node.unlocked = TRUE
	node.unlocked_by = researcher_ckey
	node.unlock_time = world.time
	unlocked_nodes[node_id] = node
	total_spent += node.research_cost
	return TRUE

// Aggregated site bonuses.
/datum/scp_tech_tree/proc/get_research_multiplier()
	. = 1.0
	for(var/node_id in unlocked_nodes)
		var/datum/scp_tech_node/node = unlocked_nodes[node_id]
		. += node.bonus_research_multiplier
	return min(., 1.5)

/datum/scp_tech_tree/proc/get_sanity_resist()
	. = 0
	for(var/node_id in unlocked_nodes)
		var/datum/scp_tech_node/node = unlocked_nodes[node_id]
		. += node.bonus_sanity_resist
	return min(., 0.35)

/datum/scp_tech_tree/proc/get_containment_floor()
	. = 0
	for(var/node_id in unlocked_nodes)
		var/datum/scp_tech_node/node = unlocked_nodes[node_id]
		. += node.bonus_containment_floor
	return min(., 50)

/datum/scp_tech_tree/proc/get_catalog_items()
	. = list()
	for(var/node_id in unlocked_nodes)
		var/datum/scp_tech_node/node = unlocked_nodes[node_id]
		for(var/typepath in node.unlock_catalog)
			if(!(typepath in .))
				.[typepath] = node.unlock_catalog[typepath]
	return .

/datum/scp_tech_tree/proc/get_all_nodes_data()
	var/list/result = list()
	for(var/node_id in nodes)
		var/datum/scp_tech_node/node = nodes[node_id]
		result += list(list(
			"id" = node.node_id,
			"name" = node.name,
			"description" = node.description,
			"category" = node.category,
			"tier" = node.tier,
			"cost" = node.research_cost,
			"prerequisites" = node.prerequisites,
			"unlocked" = node.unlocked,
			"unlocked_by" = node.unlocked_by,
		))
	return result

/datum/scp_tech_tree/proc/serialize()
	var/list/unlocked = list()
	for(var/node_id in unlocked_nodes)
		var/datum/scp_tech_node/node = unlocked_nodes[node_id]
		unlocked += list(list("id" = node_id, "by" = node.unlocked_by, "time" = node.unlock_time))
	return list("unlocked" = unlocked, "total_spent" = total_spent)

/datum/scp_tech_tree/proc/deserialize(list/data)
	if(!data)
		return
	for(var/entry in (data["unlocked"] || list()))
		var/node_id = entry["id"]
		var/datum/scp_tech_node/node = nodes[node_id]
		if(node && !node.unlocked)
			node.unlocked = TRUE
			node.unlocked_by = entry["by"]
			node.unlock_time = entry["time"]
			unlocked_nodes[node_id] = node
	total_spent = data["total_spent"] || 0

#undef TECH_TIER_1
#undef TECH_TIER_5
