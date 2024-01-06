/* All reagents of '/datum/reagent/toxin' type */

/datum/chemical_reaction/potassium_chloride
	name = "Potassium Chloride"
	result = /datum/reagent/toxin/potassium_chloride
	required_reagents = list(/datum/reagent/sodiumchloride = 1, /datum/reagent/potassium = 1)
	minimum_temperature = 60 CELSIUS
	maximum_temperature = (60 CELSIUS) + 100
	result_amount = 2

/datum/chemical_reaction/potassium_chlorophoride
	name = "Potassium Chlorophoride"
	result = /datum/reagent/toxin/potassium_chlorophoride
	required_reagents = list(/datum/reagent/toxin/potassium_chloride = 1, /datum/reagent/toxin/phoron = 1, /datum/reagent/chloral_hydrate = 1)
	result_amount = 4

/datum/chemical_reaction/zombiepowder
	name = "Zombie Powder"
	result = /datum/reagent/toxin/zombie_powder
	required_reagents = list(/datum/reagent/toxin/carpotoxin = 5, /datum/reagent/soporific = 5, /datum/reagent/copper = 5)
	result_amount = 2
	minimum_temperature = 90 CELSIUS
	maximum_temperature = 99 CELSIUS
	mix_message = "The solution boils off to form a fine powder."

/datum/chemical_reaction/plantbgone
	name = "Plant-B-Gone"
	result = /datum/reagent/toxin/plant_b_gone
	required_reagents = list(/datum/reagent/toxin = 1, /datum/reagent/water = 4)
	result_amount = 5

/datum/chemical_reaction/hair_remover
	name = "Hair Remover"
	result = /datum/reagent/toxin/hair_remover
	required_reagents = list(/datum/reagent/radium = 1, /datum/reagent/potassium = 1, /datum/reagent/acid/hydrochloric = 1)
	result_amount = 3
	mix_message = "The solution thins out and emits an acrid smell."

/datum/chemical_reaction/methyl_bromide
	name = "Methyl Bromide"
	required_reagents = list(/datum/reagent/toxin/bromide = 1, /datum/reagent/ethanol = 1, /datum/reagent/hydrazine = 1)
	result_amount = 3
	result = /datum/reagent/toxin/methyl_bromide
	mix_message = "The solution begins to bubble, emitting a dark vapor."

/datum/chemical_reaction/oxyphoron
	name = "Oxyphoron"
	result = /datum/reagent/toxin/phoron/oxygen
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/toxin/phoron = 1)
	result_amount = 2
	mix_message = "The solution boils violently, shedding wisps of vapor."

/datum/chemical_reaction/formaldehyde
	result = /datum/reagent/toxin/formaldehyde
	required_reagents = list(/datum/reagent/ethanol = 1, /datum/reagent/water = 1, /datum/reagent/uranium = 1)
	result_amount = 3
	minimum_temperature = 70 CELSIUS
	maximum_temperature = (70 CELSIUS) + 100
