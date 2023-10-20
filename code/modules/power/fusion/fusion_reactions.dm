var/list/fusion_reactions

/decl/fusion_reaction
	var/p_react = "" // Primary reactant.
	var/s_react = "" // Secondary reactant.
	var/minimum_energy_level = 1
	var/energy_consumption = 0
	var/energy_production = 0
	var/radiation = 0
	var/instability = 0
	var/list/products = list()
	var/minimum_reaction_temperature = 100
	var/priority = 100

/decl/fusion_reaction/proc/handle_reaction_special(obj/effect/fusion_em_field/holder)
	return 0

/proc/get_fusion_reaction(p_react, s_react, m_energy)
	if(!fusion_reactions)
		fusion_reactions = list()
		for(var/rtype in typesof(/decl/fusion_reaction) - /decl/fusion_reaction)
			var/decl/fusion_reaction/cur_reaction = new rtype()
			if(!fusion_reactions[cur_reaction.p_react])
				fusion_reactions[cur_reaction.p_react] = list()
			fusion_reactions[cur_reaction.p_react][cur_reaction.s_react] = cur_reaction
			if(!fusion_reactions[cur_reaction.s_react])
				fusion_reactions[cur_reaction.s_react] = list()
			fusion_reactions[cur_reaction.s_react][cur_reaction.p_react] = cur_reaction

	if(list_find(fusion_reactions, p_react))
		var/list/secondary_reactions = fusion_reactions[p_react]
		if(list_find(secondary_reactions, s_react))
			return fusion_reactions[p_react][s_react]

// Material fuels
//  deuterium
//  tritium
//  phoron

// Gaseous/reagent fuels
// hydrogen
//  helium
//  lithium
//  boron

// Basic power production reactions.
// This is not necessarily realistic, but it makes a basic failure more spectacular.
/decl/fusion_reaction/hydrogen_hydrogen
	p_react = GAS_HYDROGEN
	s_react = GAS_HYDROGEN
	energy_consumption = 1
	energy_production = 2
	products = list(GAS_HELIUM = 1)
	priority = 10

/decl/fusion_reaction/deuterium_deuterium
	p_react = GAS_DEUTERIUM
	s_react = GAS_DEUTERIUM
	energy_consumption = 1
	energy_production = 2
	priority = 0

// Advanced production reactions (todo)
/decl/fusion_reaction/deuterium_helium
	p_react = GAS_DEUTERIUM
	s_react = GAS_HELIUM
	energy_consumption = 1
	energy_production = 5
	radiation = 2

/decl/fusion_reaction/deuterium_tritium
	p_react = GAS_DEUTERIUM
	s_react = GAS_TRITIUM
	energy_consumption = 1
	energy_production = 1
	products = list(GAS_HELIUM = 1)
	instability = 0.5
	radiation = 3

/decl/fusion_reaction/deuterium_lithium
	p_react = GAS_DEUTERIUM
	s_react = "lithium"
	energy_consumption = 2
	energy_production = 0
	radiation = 3
	products = list(GAS_TRITIUM= 1)
	instability = 1

// Unideal/material production reactions
/decl/fusion_reaction/oxygen_oxygen
	p_react = GAS_OXYGEN
	s_react = GAS_OXYGEN
	energy_consumption = 10
	energy_production = 0
	instability = 5
	radiation = 5
	products = list("silicon"= 1)

/decl/fusion_reaction/iron_iron
	p_react = "iron"
	s_react = "iron"
	products = list("silver" = 10, "gold" = 10, "platinum" = 10) // Not realistic but w/e
	energy_consumption = 10
	energy_production = 0
	instability = 2
	minimum_reaction_temperature = 10000

/decl/fusion_reaction/phoron_hydrogen
	p_react = GAS_HYDROGEN
	s_react = GAS_PHORON
	energy_consumption = 10
	energy_production = 0
	instability = 5
	products = list("mhydrogen" = 1)
	minimum_reaction_temperature = 8000

// High end reactions.
/decl/fusion_reaction/boron_hydrogen
	p_react = "boron"
	s_react = GAS_HYDROGEN
	minimum_energy_level = 15000
	energy_consumption = 3
	energy_production = 12
	radiation = 3
	instability = 2.5
