/datum/chemical_reaction
	var/name = null
	var/result = null
	var/list/required_reagents = list()
	var/list/catalysts = list()
	var/list/inhibitors = list()
	var/result_amount = 0
	var/hidden_from_codex
	var/maximum_temperature = INFINITY
	var/minimum_temperature = 0
	var/thermal_product
	var/mix_message = "The solution begins to bubble."
	var/reaction_sound = /effects/bubbles.ogg'
	var/log_is_important = 0 // If this reaction should be considered important for logging. Important recipes message admins when mixed, non-important ones just log to file.

/datum/chemical_reaction/proc/can_happen(datum/reagents/holder)
	//check that all the required reagents are present
	if(!holder.has_all_reagents(required_reagents))
		return 0

	//check that all the required catalysts are present in the required amount
	if(!holder.has_all_reagents(catalysts))
		return 0

	//check that none of the inhibitors are present in the required amount
	if(holder.has_any_reagent(inhibitors))
		return 0

	var/temperature = holder.my_atom ? holder.my_atom.temperature : T20C
	if(temperature < minimum_temperature || temperature > maximum_temperature)
		return 0

	return 1

/datum/chemical_reaction/proc/on_reaction(datum/reagents/holder, created_volume, reaction_flags)
	if(thermal_product && ATOM_IS_TEMPERATURE_SENSITIVE(holder.my_atom))
		ADJUST_ATOM_TEMPERATURE(holder.my_atom, thermal_product)

// This proc returns a list of all reagents it wants to use; if the holder has several reactions that use the same reagent, it will split the reagent evenly between them
/datum/chemical_reaction/proc/get_used_reagents()
	. = list()
	for(var/reagent in required_reagents)
		. += reagent

/datum/chemical_reaction/proc/get_reaction_flags(datum/reagents/holder)
	return 0

/datum/chemical_reaction/proc/process(datum/reagents/holder, limit)
	var/data = send_data(holder)

	var/reaction_volume = holder.maximum_volume
	for(var/reactant in required_reagents)
		var/A = holder.get_reagent_amount(reactant) / required_reagents[reactant] / limit // How much of this reagent we are allowed to use
		if(reaction_volume > A)
			reaction_volume = A

	var/reaction_flags = get_reaction_flags(holder)

	for(var/reactant in required_reagents)
		holder.remove_reagent(reactant, reaction_volume * required_reagents[reactant], safety = 1)

	//add the product
	var/amt_produced = result_amount * reaction_volume
	if(result)
		holder.add_reagent(result, amt_produced, data, safety = 1)

	on_reaction(holder, amt_produced, reaction_flags)

//called after processing reactions, if they occurred
/datum/chemical_reaction/proc/post_reaction(datum/reagents/holder)
	var/atom/container = holder.my_atom
	if(mix_message && container && !ismob(container))
		container.visible_message(SPAN_NOTICE("[icon2html(container, viewers(get_turf(container)))] [mix_message]"))
		playsound(container, reaction_sound, 80, 1)
		show_sound_effect(container.loc, soundicon = SFX_ICON_SMALL)

//obtains any special data that will be provided to the reaction products
//this is called just before reactants are removed.
/datum/chemical_reaction/proc/send_data(datum/reagents/holder, reaction_limit)
	return null

/* Common reactions */
/datum/chemical_reaction/inaprovaline
	name = "Inaprovaline"
	result = /datum/reagent/medicine/inaprovaline
	required_reagents = list(/datum/reagent/acetone = 1, /datum/reagent/carbon = 1, /datum/reagent/sugar = 1)
	result_amount = 3

/datum/chemical_reaction/dylovene
	name = "Dylovene"
	result = /datum/reagent/medicine/dylovene
	required_reagents = list(/datum/reagent/silicon = 1, /datum/reagent/potassium = 1, /datum/reagent/ammonia = 1)
	result_amount = 3

/datum/chemical_reaction/tramadol
	name = "Tramadol"
	result = /datum/reagent/medicine/painkiller/tramadol
	required_reagents = list(/datum/reagent/medicine/inaprovaline = 1, /datum/reagent/ethanol = 1, /datum/reagent/acetone = 1)
	result_amount = 3

/datum/chemical_reaction/paracetamol
	name = "Paracetamol"
	result = /datum/reagent/medicine/painkiller/paracetamol
	required_reagents = list(/datum/reagent/medicine/painkiller/tramadol = 1, /datum/reagent/sugar = 1, /datum/reagent/water = 1)
	result_amount = 3

/datum/chemical_reaction/oxycodone
	name = "Oxycodone"
	result = /datum/reagent/medicine/painkiller/tramadol/oxycodone
	required_reagents = list(/datum/reagent/ethanol = 1, /datum/reagent/medicine/painkiller/tramadol = 1)
	catalysts = list(/datum/reagent/toxin/phoron = 5)
	result_amount = 1

/datum/chemical_reaction/sterilizine
	name = "Sterilizine"
	result = /datum/reagent/medicine/sterilizine
	required_reagents = list(/datum/reagent/ethanol = 1, /datum/reagent/medicine/dylovene = 1, /datum/reagent/acid/hydrochloric = 1)
	result_amount = 3

/datum/chemical_reaction/mutagen
	name = "Unstable mutagen"
	result = /datum/reagent/unstable_mutagen
	required_reagents = list(/datum/reagent/radium = 1, /datum/reagent/phosphorus = 1, /datum/reagent/acid/hydrochloric = 1)
	result_amount = 3

/datum/chemical_reaction/thermite
	name = "Thermite"
	result = /datum/reagent/thermite
	required_reagents = list(/datum/reagent/aluminium = 1, /datum/reagent/iron = 1, /datum/reagent/acetone = 1)
	result_amount = 3
	mix_message = "The solution thickens into a coarse metallic paste."

/datum/chemical_reaction/space_drugs
	name = "Space Drugs"
	result = /datum/reagent/space_drugs
	required_reagents = list(/datum/reagent/mercury = 1, /datum/reagent/sugar = 1, /datum/reagent/lithium = 1)
	result_amount = 3
	minimum_temperature = 50 CELSIUS
	maximum_temperature = (50 CELSIUS) + 100

/datum/chemical_reaction/serotrotium
	name = "Serotrotium"
	result = /datum/reagent/serotrotium
	required_reagents = list(/datum/reagent/ethanol = 1, /datum/reagent/sugar = 1, /datum/reagent/lithium = 1)
	result_amount = 3
	minimum_temperature = 40 CELSIUS
	maximum_temperature = (40 CELSIUS) + 100

/datum/chemical_reaction/pacid
	name = "Polytrinic acid"
	result = /datum/reagent/acid/polytrinic
	required_reagents = list(/datum/reagent/acid/sulphuric = 1, /datum/reagent/acid/hydrochloric = 1, /datum/reagent/potassium = 1)
	result_amount = 3

/datum/chemical_reaction/synaptizine
	name = "Synaptizine"
	result = /datum/reagent/medicine/stimulant/synaptizine
	required_reagents = list(/datum/reagent/sugar = 1, /datum/reagent/lithium = 1, /datum/reagent/water = 1)
	result_amount = 3
	minimum_temperature = 30 CELSIUS
	maximum_temperature = (30 CELSIUS) + 100

/datum/chemical_reaction/hyronalin
	name = "Hyronalin"
	result = /datum/reagent/medicine/hyronalin
	required_reagents = list(/datum/reagent/radium = 1, /datum/reagent/medicine/dylovene = 1)
	result_amount = 2

/datum/chemical_reaction/arithrazine
	name = "Arithrazine"
	result = /datum/reagent/medicine/arithrazine
	required_reagents = list(/datum/reagent/medicine/hyronalin = 1, /datum/reagent/hydrazine = 1)
	result_amount = 2

/datum/chemical_reaction/impedrezene
	name = "Impedrezene"
	result = /datum/reagent/impedrezene
	required_reagents = list(/datum/reagent/mercury = 1, /datum/reagent/acetone = 1, /datum/reagent/sugar = 1)
	result_amount = 2

/datum/chemical_reaction/kelotane
	name = "Kelotane"
	result = /datum/reagent/medicine/kelotane
	required_reagents = list(/datum/reagent/silicon = 1, /datum/reagent/carbon = 1)
	result_amount = 2

/datum/chemical_reaction/peridaxon
	name = "Peridaxon"
	result = /datum/reagent/medicine/peridaxon
	required_reagents = list(/datum/reagent/medicine/bicaridine = 2, /datum/reagent/medicine/cryogenic/clonexadone = 2)
	catalysts = list(/datum/reagent/toxin/phoron = 5)
	result_amount = 2

/datum/chemical_reaction/leporazine
	name = "Leporazine"
	result = /datum/reagent/medicine/leporazine
	required_reagents = list(/datum/reagent/silicon = 1, /datum/reagent/copper = 1)
	catalysts = list(/datum/reagent/toxin/phoron = 5)
	result_amount = 2

/datum/chemical_reaction/cryptobiolin
	name = "Cryptobiolin"
	result = /datum/reagent/cryptobiolin
	required_reagents = list(/datum/reagent/potassium = 1, /datum/reagent/acetone = 1, /datum/reagent/sugar = 1)
	minimum_temperature = 30 CELSIUS
	maximum_temperature = 60 CELSIUS
	result_amount = 3

/datum/chemical_reaction/tricordrazine
	name = "Tricordrazine"
	result = /datum/reagent/medicine/tricordrazine
	required_reagents = list(/datum/reagent/medicine/inaprovaline = 1, /datum/reagent/medicine/dylovene = 1)
	result_amount = 2

/datum/chemical_reaction/alkysine
	name = "Alkysine"
	result = /datum/reagent/medicine/alkysine
	required_reagents = list(/datum/reagent/acid/hydrochloric = 1, /datum/reagent/ammonia = 1, /datum/reagent/medicine/dylovene = 1)
	result_amount = 2

/datum/chemical_reaction/dexalin
	name = "Dexalin"
	result = /datum/reagent/medicine/dexalin
	required_reagents = list(/datum/reagent/acetone = 2, /datum/reagent/toxin/phoron = 0.1)
	inhibitors = list(/datum/reagent/water = 1) // Messes with cryox
	result_amount = 1

/datum/chemical_reaction/dermaline
	name = "Dermaline"
	result = /datum/reagent/medicine/dermaline
	required_reagents = list(/datum/reagent/acetone = 1, /datum/reagent/phosphorus = 1, /datum/reagent/medicine/kelotane = 1)
	result_amount = 3
	minimum_temperature = (-50 CELSIUS) - 100
	maximum_temperature = -50 CELSIUS

/datum/chemical_reaction/dexalinp
	name = "Dexalin Plus"
	result = /datum/reagent/medicine/dexalin_plus
	required_reagents = list(/datum/reagent/medicine/dexalin = 1, /datum/reagent/carbon = 1, /datum/reagent/iron = 1)
	result_amount = 3

/datum/chemical_reaction/bicaridine
	name = "Bicaridine"
	result = /datum/reagent/medicine/bicaridine
	required_reagents = list(/datum/reagent/medicine/inaprovaline = 1, /datum/reagent/carbon = 1)
	inhibitors = list(/datum/reagent/sugar = 1) // Messes up with inaprovaline
	result_amount = 2

/datum/chemical_reaction/bicaridine_alt
	name = "Grauel Decomposition into Bicaridine"
	result = /datum/reagent/medicine/bicaridine
	required_reagents = list(/datum/reagent/grauel = 1, /datum/reagent/phosphorus = 1)
	result_amount = 2

/datum/chemical_reaction/meraline
	name = "Meraline"
	result = /datum/reagent/medicine/meraline
	required_reagents = list(/datum/reagent/medicine/inaprovaline = 1, /datum/reagent/medicine/bicaridine = 1, /datum/reagent/iron = 1)
	result_amount = 3

/datum/chemical_reaction/ossarepantes
	name = "Ossarepantes"
	result = /datum/reagent/medicine/ossarepantes
	required_reagents = list(/datum/reagent/medicine/bicaridine = 1, /datum/reagent/drink/milk = 1, /datum/reagent/radium = 1)
	result_amount = 3
	minimum_temperature = 50 CELSIUS
	maximum_temperature = (50 CELSIUS) + 100

/datum/chemical_reaction/hyperzine
	name = "Hyperzine"
	result = /datum/reagent/medicine/stimulant/hyperzine
	required_reagents = list(/datum/reagent/sugar = 1, /datum/reagent/phosphorus = 1, /datum/reagent/sulfur = 1)
	result_amount = 3

/datum/chemical_reaction/ryetalyn
	name = "Ryetalyn"
	result = /datum/reagent/medicine/ryetalyn
	required_reagents = list(/datum/reagent/medicine/arithrazine = 1, /datum/reagent/carbon = 1)
	result_amount = 2

/datum/chemical_reaction/cryoxadone
	name = "Cryoxadone"
	result = /datum/reagent/medicine/cryogenic/cryoxadone
	required_reagents = list(/datum/reagent/medicine/dexalin = 1, /datum/reagent/drink/ice = 1, /datum/reagent/acetone = 1)
	result_amount = 3
	minimum_temperature = (-25 CELSIUS) - 100
	maximum_temperature = -25 CELSIUS
	mix_message = "The solution becomes sludge-like."

/datum/chemical_reaction/nanitefluid
	name = "Nanite Fluid"
	result = /datum/reagent/medicine/cryogenic/nanite_fluid
	required_reagents = list(/datum/reagent/medicine/cryogenic/cryoxadone = 1, /datum/reagent/aluminium = 1, /datum/reagent/iron = 1)
	catalysts = list(/datum/reagent/toxin/phoron = 5)
	result_amount = 3
	minimum_temperature = (-25 CELSIUS) - 100
	maximum_temperature = -25 CELSIUS
	mix_message = "The solution becomes a metallic slime."

/datum/chemical_reaction/venaxilin
	name = "Venaxilin"
	result = /datum/reagent/medicine/dylovene/venaxilin
	required_reagents = list(/datum/reagent/medicine/dylovene = 1, /datum/reagent/medicine/spaceacillin = 1, /datum/reagent/toxin/venom = 1)
	result_amount = 1
	minimum_temperature = 50 CELSIUS
	maximum_temperature = 100 CELSIUS
	mix_message = "The solution steams and becomes cloudy."


/datum/chemical_reaction/clonexadone
	name = "Clonexadone"
	result = /datum/reagent/medicine/cryogenic/clonexadone
	required_reagents = list(/datum/reagent/medicine/cryogenic/cryoxadone = 1, /datum/reagent/sodium = 1)
	result_amount = 2
	minimum_temperature = -100 CELSIUS
	maximum_temperature = -75 CELSIUS
	mix_message = "The solution thickens into translucent slime."

/datum/chemical_reaction/spaceacillin
	name = "Spaceacillin"
	result = /datum/reagent/medicine/spaceacillin
	required_reagents = list(/datum/reagent/cryptobiolin = 1, /datum/reagent/medicine/inaprovaline = 1)
	result_amount = 2

/datum/chemical_reaction/imidazoline
	name = "Imidazoline"
	result = /datum/reagent/medicine/imidazoline
	required_reagents = list(/datum/reagent/carbon = 1, /datum/reagent/hydrazine = 1, /datum/reagent/medicine/dylovene = 1)
	result_amount = 2

/datum/chemical_reaction/ethylredoxrazine
	name = "Ethylredoxrazine"
	result = /datum/reagent/medicine/ethylredoxrazine
	required_reagents = list(/datum/reagent/acetone = 1, /datum/reagent/medicine/dylovene = 1, /datum/reagent/carbon = 1)
	result_amount = 3

/datum/chemical_reaction/naltrexone
	name = "Naltrexone"
	result = /datum/reagent/medicine/naltrexone
	required_reagents = list(/datum/reagent/medicine/antidepressant/methylphenidate = 1, /datum/reagent/sugar = 1, /datum/reagent/carbon = 1)
	result_amount = 3

/datum/chemical_reaction/varenicline
	name = "Varenicline"
	result = /datum/reagent/medicine/varenicline
	required_reagents = list(/datum/reagent/acetone = 1, /datum/reagent/phosphorus = 1, /datum/reagent/sodium = 1)
	result_amount = 3

/datum/chemical_reaction/soporific
	name = "Soporific"
	result = /datum/reagent/soporific
	required_reagents = list(/datum/reagent/chloral_hydrate = 1, /datum/reagent/sugar = 4)
	inhibitors = list(/datum/reagent/phosphorus) // Messes with the smoke
	result_amount = 5

/datum/chemical_reaction/chloralhydrate
	name = "Chloral Hydrate"
	result = /datum/reagent/chloral_hydrate
	required_reagents = list(/datum/reagent/ethanol = 1, /datum/reagent/acid/hydrochloric = 3, /datum/reagent/water = 1)
	result_amount = 1

/datum/chemical_reaction/vecuronium_bromide
	name = "Vecuronium Bromide"
	result = /datum/reagent/vecuronium_bromide
	required_reagents = list(/datum/reagent/ethanol = 1, /datum/reagent/mercury = 2, /datum/reagent/hydrazine = 2)
	result_amount = 1

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
	required_reagents = list(/datum/reagent/soporific = 5, /datum/reagent/copper = 5, /datum/reagent/toxin/cyanide = 5)
	result_amount = 2
	minimum_temperature = 90 CELSIUS
	maximum_temperature = 99 CELSIUS
	mix_message = "The solution boils off to form a fine powder."

/datum/chemical_reaction/mindbreaker
	name = "Mindbreaker Toxin"
	result = /datum/reagent/mindbreaker_toxin
	required_reagents = list(/datum/reagent/silicon = 1, /datum/reagent/hydrazine = 1, /datum/reagent/medicine/dylovene = 1)
	result_amount = 3
	mix_message = "The solution takes on an iridescent sheen."
	minimum_temperature = 75 CELSIUS
	maximum_temperature = (75 CELSIUS) + 25

/datum/chemical_reaction/lipozine
	name = "Lipozine"
	result = /datum/reagent/lipozine
	required_reagents = list(/datum/reagent/sodiumchloride = 1, /datum/reagent/ethanol = 1, /datum/reagent/radium = 1)
	result_amount = 3

/datum/chemical_reaction/surfactant
	name = "Azosurfactant"
	result = /datum/reagent/surfactant
	required_reagents = list(/datum/reagent/hydrazine = 2, /datum/reagent/carbon = 2, /datum/reagent/acid/sulphuric = 1)
	result_amount = 5
	mix_message = "The solution begins to foam gently."

/datum/chemical_reaction/diethylamine
	name = "Diethylamine"
	result = /datum/reagent/diethylamine
	required_reagents = list (/datum/reagent/ammonia = 1, /datum/reagent/ethanol = 1)
	result_amount = 2

/datum/chemical_reaction/hydroxylsan
	name = "Hydroxylsan"
	result = /datum/reagent/hydroxylsan
	required_reagents = list(/datum/reagent/ammonia = 1, /datum/reagent/water = 1)
	result_amount = 2

/datum/chemical_reaction/plantbgone
	name = "Plant-B-Gone"
	result = /datum/reagent/toxin/plant_b_gone
	required_reagents = list(/datum/reagent/toxin = 1, /datum/reagent/water = 4)
	result_amount = 5

/datum/chemical_reaction/foaming_agent
	name = "Foaming Agent"
	result = /datum/reagent/foaming_agent
	required_reagents = list(/datum/reagent/lithium = 1, /datum/reagent/hydrazine = 1)
	result_amount = 1
	mix_message = "The solution begins to foam vigorously."

/datum/chemical_reaction/glycerol
	name = "Glycerol"
	result = /datum/reagent/glycerol
	required_reagents = list(/datum/reagent/nutriment/cornoil = 3, /datum/reagent/acid/sulphuric = 1)
	result_amount = 1

/datum/chemical_reaction/sodiumchloride
	name = "Sodium Chloride"
	result = /datum/reagent/sodiumchloride
	required_reagents = list(/datum/reagent/sodium = 1, /datum/reagent/acid/hydrochloric = 1)
	result_amount = 2

/datum/chemical_reaction/condensedcapsaicin
	name = "Condensed Capsaicin"
	result = /datum/reagent/capsaicin/condensed
	required_reagents = list(/datum/reagent/capsaicin = 2)
	catalysts = list(/datum/reagent/toxin/phoron = 5)
	result_amount = 1

/datum/chemical_reaction/coolant
	name = "Coolant"
	result = /datum/reagent/coolant
	required_reagents = list(/datum/reagent/tungsten = 1, /datum/reagent/acetone = 1, /datum/reagent/water = 1)
	result_amount = 3
	log_is_important = 1
	mix_message = "The solution becomes thick and slightly slimy."

/datum/chemical_reaction/rezadone
	name = "Rezadone"
	result = /datum/reagent/medicine/rezadone
	required_reagents = list(
		/datum/reagent/medicine/arithrazine =1,
		/datum/reagent/cryptobiolin = 1,
		/datum/reagent/copper = 1,
		/datum/reagent/medicine/dermaline = 1,
		/datum/reagent/medicine/meraline = 1,
		/datum/reagent/uranium = 1
	)
	result_amount = 3

/datum/chemical_reaction/lexorin
	name = "Lexorin"
	result = /datum/reagent/lexorin
	required_reagents = list(/datum/reagent/toxin/phoron = 1, /datum/reagent/hydrazine = 1, /datum/reagent/ammonia = 1)
	result_amount = 3

/datum/chemical_reaction/methylphenidate
	name = "Methylphenidate"
	result = /datum/reagent/medicine/antidepressant/methylphenidate
	required_reagents = list(/datum/reagent/mindbreaker_toxin = 1, /datum/reagent/lithium = 1)
	result_amount = 3

/datum/chemical_reaction/citalopram
	name = "Citalopram"
	result = /datum/reagent/medicine/antidepressant/citalopram
	required_reagents = list(/datum/reagent/mindbreaker_toxin = 1, /datum/reagent/carbon = 1)
	result_amount = 3

/datum/chemical_reaction/paroxetine
	name = "Paroxetine"
	result = /datum/reagent/medicine/antidepressant/paroxetine
	required_reagents = list(/datum/reagent/mindbreaker_toxin = 1, /datum/reagent/acetone = 1, /datum/reagent/medicine/inaprovaline = 1)
	result_amount = 3

/datum/chemical_reaction/hair_remover
	name = "Hair Remover"
	result = /datum/reagent/toxin/hair_remover
	required_reagents = list(/datum/reagent/radium = 1, /datum/reagent/potassium = 1, /datum/reagent/acid/hydrochloric = 1)
	result_amount = 3
	mix_message = "The solution thins out and emits an acrid smell."

/datum/chemical_reaction/noexcutite
	name = "Noexcutite"
	result = /datum/reagent/medicine/noexcutite
	required_reagents = list(/datum/reagent/medicine/painkiller/tramadol/oxycodone = 1, /datum/reagent/medicine/dylovene = 1)
	result_amount = 2

/datum/chemical_reaction/methyl_bromide
	name = "Methyl Bromide"
	required_reagents = list(/datum/reagent/toxin/bromide = 1, /datum/reagent/ethanol = 1, /datum/reagent/hydrazine = 1)
	result_amount = 3
	result = /datum/reagent/toxin/methyl_bromide
	mix_message = "The solution begins to bubble, emitting a dark vapor."

/datum/chemical_reaction/adrenaline
	name = "Adrenaline"
	result = /datum/reagent/medicine/adrenaline
	required_reagents = list(/datum/reagent/medicine/inaprovaline = 1, /datum/reagent/medicine/stimulant/hyperzine = 1, /datum/reagent/medicine/dexalin_plus = 1)
	result_amount = 3

/* Solidification */
/datum/chemical_reaction/phoronsolidification
	name = "Solid Phoron"
	result = null
	required_reagents = list(/datum/reagent/iron = 5, /datum/reagent/toxin/phoron = 20)
	result_amount = 1
	minimum_temperature = (-80 CELSIUS) - 100
	maximum_temperature = -80 CELSIUS
	mix_message = "The solution hardens and begins to crystallize."

/datum/chemical_reaction/phoronsolidification/on_reaction(datum/reagents/holder, created_volume, reaction_flags)
	..()
	new /obj/item/stack/material/phoron(get_turf(holder.my_atom), created_volume)

/datum/chemical_reaction/plastication
	name = "Plastic"
	result = null
	required_reagents = list(/datum/reagent/acid/polytrinic = 1, /datum/reagent/toxin/plasticide = 2)
	result_amount = 1
	mix_message = "The solution solidifies into a grey-white mass."

/datum/chemical_reaction/plastication/on_reaction(datum/reagents/holder, created_volume, reaction_flags)
	..()
	new /obj/item/stack/material/plastic(get_turf(holder.my_atom), created_volume)

/* Grenade reactions */

/datum/chemical_reaction/explosion_potassium
	name = "Explosion"
	result = null
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/potassium = 1)
	result_amount = 2
	mix_message = null
	mix_message = "The solution bubbles vigorously!"

/datum/chemical_reaction/explosion_potassium/on_reaction(datum/reagents/holder, created_volume, reaction_flags)
	..()
	var/datum/effect/effect/system/reagents_explosion/e = new()
	e.set_up(round (created_volume/10, 1), holder.my_atom, 0, 0)
	if(isliving(holder.my_atom))
		e.amount *= 0.5
		var/mob/living/L = holder.my_atom
		if(L.stat != DEAD)
			e.amount *= 0.5
	e.start()
	holder.clear_reagents()

/datum/chemical_reaction/flash_powder
	name = "Flash powder"
	result = null
	required_reagents = list(/datum/reagent/aluminium = 1, /datum/reagent/potassium = 1, /datum/reagent/sulfur = 1 )
	result_amount = null
	mix_message = "The solution bubbles vigorously!"

/datum/chemical_reaction/flash_powder/on_reaction(datum/reagents/holder, created_volume, reaction_flags)
	..()
	var/location = get_turf(holder.my_atom)
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(2, 1, location)
	s.start()
	for(var/mob/living/carbon/M in viewers(world.view, location))
		switch(get_dist(M, location))
			if(0 to 3)
				if(hasvar(M, "glasses"))
					if(istype(M:glasses, /obj/item/clothing/glasses/sunglasses))
						continue

				M.flash_eyes()
				M.Weaken(15)

			if(4 to 5)
				if(hasvar(M, "glasses"))
					if(istype(M:glasses, /obj/item/clothing/glasses/sunglasses))
						continue

				M.flash_eyes()
				M.Stun(5)

/datum/chemical_reaction/emp_pulse
	name = "EMP Pulse"
	result = null
	required_reagents = list(/datum/reagent/uranium = 1, /datum/reagent/iron = 1) // Yes, laugh, it's the best recipe I could think of that makes a little bit of sense
	result_amount = 2
	mix_message = "The solution bubbles vigorously!"

/datum/chemical_reaction/emp_pulse/on_reaction(datum/reagents/holder, created_volume, reaction_flags)
	..()
	var/location = get_turf(holder.my_atom)
	// 100 created volume = 4 heavy range & 7 light range. A few tiles smaller than traitor EMP grandes.
	// 200 created volume = 8 heavy range & 14 light range. 4 tiles larger than traitor EMP grenades.
	empulse(location, round(created_volume / 24), round(created_volume / 14), 1)
	holder.clear_reagents()

/datum/chemical_reaction/nitroglycerin
	name = "Nitroglycerin"
	result = /datum/reagent/nitroglycerin
	required_reagents = list(/datum/reagent/glycerol = 1, /datum/reagent/acid/polytrinic = 1, /datum/reagent/acid/sulphuric = 1)
	result_amount = 2
	log_is_important = 1

/datum/chemical_reaction/nitroglycerin/on_reaction(datum/reagents/holder, created_volume, reaction_flags)
	..()
	var/datum/effect/effect/system/reagents_explosion/e = new()
	e.set_up(round (created_volume/2, 1), holder.my_atom, 0, 0)
	if(isliving(holder.my_atom))
		e.amount *= 0.5
		var/mob/living/L = holder.my_atom
		if(L.stat!=DEAD)
			e.amount *= 0.5
	e.start()
	holder.clear_reagents()

/datum/chemical_reaction/napalm
	name = "Napalm"
	result = /datum/reagent/napalm
	required_reagents = list(/datum/reagent/aluminium = 1, /datum/reagent/acid/sulphuric = 1, /datum/reagent/glycerol = 1 ) //because bananas grow on palms and palm oil is used to make napalm. =/= logic
	result_amount = 2
	mix_message = "The solution thickens and takes on a slimy sheen."

/datum/chemical_reaction/napalmb
	name = "Napalm B"
	result = /datum/reagent/napalm/b
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/fuel = 1 )
	result_amount = 2
	mix_message = "The solution thickens and takes on a slimy sheen."

/datum/chemical_reaction/chemsmoke
	name = "Chemsmoke"
	result = null
	required_reagents = list(/datum/reagent/potassium = 1, /datum/reagent/sugar = 1, /datum/reagent/phosphorus = 1)
	result_amount = 0.4
	mix_message = "The solution bubbles vigorously!"

/datum/chemical_reaction/chemsmoke/on_reaction(datum/reagents/holder, created_volume, reaction_flags)
	..()
	var/location = get_turf(holder.my_atom)
	var/datum/effect/effect/system/smoke_spread/chem/S = new /datum/effect/effect/system/smoke_spread/chem
	S.attach(location)
	S.set_up(holder, created_volume, 0, location)
	playsound(location, /effects/smoke.ogg', 50, 1, -3)
	spawn(0)
		S.start()
	holder.clear_reagents()

/datum/chemical_reaction/foam
	name = "Foam"
	result = null
	required_reagents = list(/datum/reagent/surfactant = 1, /datum/reagent/water = 1)
	result_amount = 2
	mix_message = "The solution bubbles vigorously!"

/datum/chemical_reaction/foam/on_reaction(datum/reagents/holder, created_volume, reaction_flags)
	..()
	var/location = get_turf(holder.my_atom)

	for(var/mob/M in viewers(5, location))
		to_chat(M, SPAN_WARNING("The solution spews out foam!"))

	var/datum/effect/effect/system/foam_spread/s = new()
	s.set_up(created_volume, location, holder, 0)
	s.start()
	holder.clear_reagents()

/datum/chemical_reaction/metalfoam
	name = "Metal Foam"
	result = null
	required_reagents = list(/datum/reagent/aluminium = 3, /datum/reagent/foaming_agent = 1, /datum/reagent/acid/polytrinic = 1)
	result_amount = 5
	mix_message = "The solution bubbles vigorously!"

/datum/chemical_reaction/metalfoam/on_reaction(datum/reagents/holder, created_volume, reaction_flags)
	..()
	var/location = get_turf(holder.my_atom)

	for(var/mob/M in viewers(5, location))
		to_chat(M, SPAN_WARNING("The solution spews out a metalic foam!"))

	var/datum/effect/effect/system/foam_spread/s = new()
	s.set_up(created_volume, location, holder, 1)
	s.start()

/datum/chemical_reaction/ironfoam
	name = "Iron Foam"
	result = null
	required_reagents = list(/datum/reagent/iron = 3, /datum/reagent/foaming_agent = 1, /datum/reagent/acid/polytrinic = 1)
	result_amount = 5
	mix_message = "The solution bubbles vigorously!"

/datum/chemical_reaction/ironfoam/on_reaction(datum/reagents/holder, created_volume, reaction_flags)
	..()
	var/location = get_turf(holder.my_atom)

	for(var/mob/M in viewers(5, location))
		to_chat(M, SPAN_WARNING("The solution spews out a metalic foam!"))

	var/datum/effect/effect/system/foam_spread/s = new()
	s.set_up(created_volume, location, holder, 2)
	s.start()

/* Paint */

/datum/chemical_reaction/red_paint
	name = "Red paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/crayon_dust/red = 1)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy red sheen."

/datum/chemical_reaction/red_paint/send_data()
	return "#fe191a"

/datum/chemical_reaction/orange_paint
	name = "Orange paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/crayon_dust/orange = 1)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy orange sheen."

/datum/chemical_reaction/orange_paint/send_data()
	return "#ffbe4f"

/datum/chemical_reaction/yellow_paint
	name = "Yellow paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/crayon_dust/yellow = 1)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy yellow sheen."

/datum/chemical_reaction/yellow_paint/send_data()
	return "#fdfe7d"

/datum/chemical_reaction/green_paint
	name = "Green paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/crayon_dust/green = 1)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy green sheen."

/datum/chemical_reaction/green_paint/send_data()
	return "#18a31a"

/datum/chemical_reaction/blue_paint
	name = "Blue paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/crayon_dust/blue = 1)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy blue sheen."

/datum/chemical_reaction/blue_paint/send_data()
	return "#247cff"

/datum/chemical_reaction/purple_paint
	name = "Purple paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/crayon_dust/purple = 1)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy purple sheen."

/datum/chemical_reaction/purple_paint/send_data()
	return "#cc0099"

/datum/chemical_reaction/grey_paint //mime
	name = "Grey paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/crayon_dust/grey = 1)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy grey sheen."

/datum/chemical_reaction/grey_paint/send_data()
	return "#808080"

/datum/chemical_reaction/brown_paint
	name = "Brown paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/crayon_dust/brown = 1)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy brown sheen."

/datum/chemical_reaction/brown_paint/send_data()
	return "#846f35"

/datum/chemical_reaction/blood_paint
	name = "Blood paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/blood = 2)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy red sheen."

/datum/chemical_reaction/blood_paint/send_data(datum/reagents/T)
	var/t = T.get_data("blood")
	if(t && t["blood_colour"])
		return t["blood_colour"]
	return "#fe191a" // Probably red

/datum/chemical_reaction/milk_paint
	name = "Milk paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/drink/milk = 5)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy white sheen."

/datum/chemical_reaction/milk_paint/send_data()
	return "#f0f8ff"

/datum/chemical_reaction/orange_juice_paint
	name = "Orange juice paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/drink/juice/orange = 5)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy orange sheen."

/datum/chemical_reaction/orange_juice_paint/send_data()
	return "#e78108"

/datum/chemical_reaction/tomato_juice_paint
	name = "Tomato juice paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/drink/juice/tomato = 5)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy red sheen."

/datum/chemical_reaction/tomato_juice_paint/send_data()
	return "#731008"

/datum/chemical_reaction/lime_juice_paint
	name = "Lime juice paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/drink/juice/lime = 5)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy green sheen."

/datum/chemical_reaction/lime_juice_paint/send_data()
	return "#365e30"

/datum/chemical_reaction/carrot_juice_paint
	name = "Carrot juice paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/drink/juice/carrot = 5)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy orange sheen."

/datum/chemical_reaction/carrot_juice_paint/send_data()
	return "#973800"

/datum/chemical_reaction/berry_juice_paint
	name = "Berry juice paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/drink/juice/berry = 5)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy red sheen."

/datum/chemical_reaction/berry_juice_paint/send_data()
	return "#990066"

/datum/chemical_reaction/grape_juice_paint
	name = "Grape juice paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/drink/juice/grape = 5)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy purple sheen."

/datum/chemical_reaction/grape_juice_paint/send_data()
	return "#863333"

/datum/chemical_reaction/poisonberry_juice_paint
	name = "Poison berry juice paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/toxin/poisonberryjuice = 5)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy purple sheen."

/datum/chemical_reaction/poisonberry_juice_paint/send_data()
	return "#863353"

/datum/chemical_reaction/watermelon_juice_paint
	name = "Watermelon juice paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/drink/juice/watermelon = 5)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy red sheen."

/datum/chemical_reaction/watermelon_juice_paint/send_data()
	return "#b83333"

/datum/chemical_reaction/lemon_juice_paint
	name = "Lemon juice paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/drink/juice/lemon = 5)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy yellow sheen."

/datum/chemical_reaction/lemon_juice_paint/send_data()
	return "#afaf00"

/datum/chemical_reaction/banana_juice_paint
	name = "Banana juice paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/drink/juice/banana = 5)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy yellow sheen."

/datum/chemical_reaction/banana_juice_paint/send_data()
	return "#c3af00"

/datum/chemical_reaction/potato_juice_paint
	name = "Potato juice paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, "potatojuice" = 5)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy brown sheen."

/datum/chemical_reaction/potato_juice_paint/send_data()
	return "#302000"

/datum/chemical_reaction/carbon_paint
	name = "Carbon paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/carbon = 1)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy black sheen."

/datum/chemical_reaction/carbon_paint/send_data()
	return "#333333"

/datum/chemical_reaction/aluminium_paint
	name = "Aluminium paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/aluminium = 1)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy white sheen."

/datum/chemical_reaction/aluminium_paint/send_data()
	return "#f0f8ff"

/* Slime cores */

/datum/chemical_reaction/slime
	hidden_from_codex = TRUE
	mix_message = "The slime core twitches sharply."
	var/required = null

/datum/chemical_reaction/slime/can_happen(datum/reagents/holder)
	if(holder.my_atom && istype(holder.my_atom, required))
		var/obj/item/slime_extract/T = holder.my_atom
		if(T.Uses > 0)
			return ..()
	return 0

/datum/chemical_reaction/slime/on_reaction(datum/reagents/holder)
	..()
	var/obj/item/slime_extract/T = holder.my_atom
	T.Uses--
	if(T.Uses <= 0)
		T.visible_message("[icon2html(T, viewers(get_turf(T)))]<span class='notice'>\The [T]'s power is consumed in the reaction.</span>")
		T.SetName("used slime extract")
		T.desc = "This extract has been used up."

//Grey
/datum/chemical_reaction/slime/spawn
	name = "Slime Spawn"
	result = null
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 1
	required = /obj/item/slime_extract/grey

/datum/chemical_reaction/slime/spawn/on_reaction(datum/reagents/holder)
	..()
	holder.my_atom.visible_message(SPAN_WARNING("Infused with phoron, the core begins to quiver and grow, and soon a new baby slime emerges from it!"))
	new /mob/living/carbon/slime(get_turf(holder.my_atom))

/datum/chemical_reaction/slime/monkey
	name = "Slime Monkey"
	result = null
	required_reagents = list(/datum/reagent/blood = 1)
	result_amount = 1
	required = /obj/item/slime_extract/grey

/datum/chemical_reaction/slime/monkey/on_reaction(datum/reagents/holder)
	..()
	for(var/i = 1, i <= 3, i++)
		new /obj/item/reagent_containers/food/snacks/monkeycube(get_turf(holder.my_atom))

//Green
/datum/chemical_reaction/slime/mutate
	name = "Mutation Toxin"
	result = /datum/reagent/mutation_toxin
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 1
	required = /obj/item/slime_extract/green

//Metal
/datum/chemical_reaction/slime/metal
	name = "Slime Metal"
	result = null
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 1
	required = /obj/item/slime_extract/metal

/datum/chemical_reaction/slime/metal/on_reaction(datum/reagents/holder)
	..()
	var/obj/item/stack/material/steel/M = new (get_turf(holder.my_atom))
	M.amount = 15
	var/obj/item/stack/material/plasteel/P = new (get_turf(holder.my_atom))
	P.amount = 5

//Gold
/datum/chemical_reaction/slime/crit
	name = "Slime Crit"
	result = null
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 1
	required = /obj/item/slime_extract/gold
	var/list/possible_mobs = list(
							/mob/living/simple_animal/friendly/cat,
							/mob/living/simple_animal/friendly/cat/kitten,
							/mob/living/simple_animal/friendly/corgi,
							/mob/living/simple_animal/friendly/corgi/puppy,
							/mob/living/simple_animal/friendly/cow,
							/mob/living/simple_animal/friendly/chick,
							/mob/living/simple_animal/friendly/chicken
							)

/datum/chemical_reaction/slime/crit/on_reaction(datum/reagents/holder)
	..()
	var/type = pick(possible_mobs)
	new type(get_turf(holder.my_atom))

//Silver
/datum/chemical_reaction/slime/bork
	name = "Slime Bork"
	result = null
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 1
	required = /obj/item/slime_extract/silver

/datum/chemical_reaction/slime/bork/on_reaction(datum/reagents/holder)
	..()
	var/list/borks = typesof(/obj/item/reagent_containers/food/snacks) - /obj/item/reagent_containers/food/snacks
	playsound(get_turf(holder.my_atom), /effects/phasein.ogg', 100, 1)
	for(var/mob/living/carbon/human/M in viewers(get_turf(holder.my_atom), null))
		if(M.eyecheck() < FLASH_PROTECTION_MODERATE)
			M.flash_eyes()

	for(var/i = 1, i <= 4 + rand(1,2), i++)
		var/chosen = pick(borks)
		var/obj/B = new chosen(get_turf(holder.my_atom))
		if(B)
			if(prob(50))
				for(var/j = 1, j <= rand(1, 3), j++)
					step(B, pick(NORTH, SOUTH, EAST, WEST))

//Blue
/datum/chemical_reaction/slime/frost
	name = "Slime Frost Oil"
	result = /datum/reagent/frostoil
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 10
	required = /obj/item/slime_extract/blue

//Dark Blue
/datum/chemical_reaction/slime/freeze
	name = "Slime Freeze"
	result = null
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 1
	required = /obj/item/slime_extract/darkblue
	mix_message = "The slime extract begins to vibrate violently!"

/datum/chemical_reaction/slime/freeze/on_reaction(datum/reagents/holder)
	set waitfor = 0
	..()
	sleep(50)
	playsound(get_turf(holder.my_atom), /effects/phasein.ogg', 100, 1)
	for(var/mob/living/M in range (get_turf(holder.my_atom), 7))
		M.bodytemperature -= 140
		to_chat(M, SPAN_WARNING("You feel a chill!"))

//Orange
/datum/chemical_reaction/slime/casp
	name = "Slime Capsaicin Oil"
	result = /datum/reagent/capsaicin
	required_reagents = list(/datum/reagent/blood = 1)
	result_amount = 10
	required = /obj/item/slime_extract/orange

/datum/chemical_reaction/slime/fire
	name = "Slime fire"
	result = null
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 1
	required = /obj/item/slime_extract/orange
	mix_message = "The slime extract begins to vibrate violently!"

/datum/chemical_reaction/slime/fire/on_reaction(datum/reagents/holder)
	set waitfor = 0
	..()
	sleep(50)
	if(!(holder.my_atom && holder.my_atom.loc))
		return

	var/turf/location = get_turf(holder.my_atom)
	location.assume_gas(GAS_PHORON, 250, 1400)
	location.hotspot_expose(700, 400)

//Yellow
/datum/chemical_reaction/slime/overload
	name = "Slime EMP"
	result = null
	required_reagents = list(/datum/reagent/blood = 1)
	result_amount = 1
	required = /obj/item/slime_extract/yellow

/datum/chemical_reaction/slime/overload/on_reaction(datum/reagents/holder, created_volume, reaction_flags)
	..()
	empulse(get_turf(holder.my_atom), 3, 7)

/datum/chemical_reaction/slime/cell
	name = "Slime Powercell"
	result = null
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 1
	required = /obj/item/slime_extract/yellow

/datum/chemical_reaction/slime/cell/on_reaction(datum/reagents/holder, created_volume, reaction_flags)
	..()
	new /obj/item/cell/slime(get_turf(holder.my_atom))

/datum/chemical_reaction/slime/glow
	name = "Slime Glow"
	result = null
	required_reagents = list(/datum/reagent/water = 1)
	result_amount = 1
	required = /obj/item/slime_extract/yellow
	mix_message = "The contents of the slime core harden and begin to emit a warm, bright light."

/datum/chemical_reaction/slime/glow/on_reaction(datum/reagents/holder, created_volume, reaction_flags)
	..()
	new /obj/item/device/flashlight/slime(get_turf(holder.my_atom))

//Purple
/datum/chemical_reaction/slime/psteroid
	name = "Slime Steroid"
	result = null
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 1
	required = /obj/item/slime_extract/purple

/datum/chemical_reaction/slime/psteroid/on_reaction(datum/reagents/holder, created_volume, reaction_flags)
	..()
	new /obj/item/slimesteroid(get_turf(holder.my_atom))

/datum/chemical_reaction/slime/jam
	name = "Slime Jam"
	result = /datum/reagent/slime_jelly
	required_reagents = list(/datum/reagent/sugar = 1)
	result_amount = 10
	required = /obj/item/slime_extract/purple

//Dark Purple
/datum/chemical_reaction/slime/plasma
	name = "Slime Plasma"
	result = null
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 1
	required = /obj/item/slime_extract/darkpurple

/datum/chemical_reaction/slime/plasma/on_reaction(datum/reagents/holder)
	..()
	var/obj/item/stack/material/phoron/P = new (get_turf(holder.my_atom))
	P.amount = 10

//Red
/datum/chemical_reaction/slime/glycerol
	name = "Slime Glycerol"
	result = /datum/reagent/glycerol
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 8
	required = /obj/item/slime_extract/red

/datum/chemical_reaction/slime/bloodlust
	name = "Bloodlust"
	result = null
	required_reagents = list(/datum/reagent/blood = 1)
	result_amount = 1
	required = /obj/item/slime_extract/red

/datum/chemical_reaction/slime/bloodlust/on_reaction(datum/reagents/holder)
	..()
	for(var/mob/living/carbon/slime/slime in viewers(get_turf(holder.my_atom), null))
		slime.rabid = 1
		slime.visible_message(SPAN_WARNING("The [slime] is driven into a frenzy!"))

//Pink
/datum/chemical_reaction/slime/ppotion
	name = "Slime Potion"
	result = null
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 1
	required = /obj/item/slime_extract/pink

/datum/chemical_reaction/slime/ppotion/on_reaction(datum/reagents/holder)
	..()
	new /obj/item/slimepotion(get_turf(holder.my_atom))

//Black
/datum/chemical_reaction/slime/mutate2
	name = "Advanced Mutation Toxin"
	result = /datum/reagent/advanced_mutation_toxin
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 1
	required = /obj/item/slime_extract/black

//Oil
/datum/chemical_reaction/slime/explosion
	name = "Slime Explosion"
	result = null
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 1
	required = /obj/item/slime_extract/oil
	mix_message = "The slime extract begins to vibrate violently!"

/datum/chemical_reaction/slime/explosion/on_reaction(datum/reagents/holder)
	set waitfor = 0
	..()
	sleep(50)
	explosion(get_turf(holder.my_atom), 1, 3, 6)

//Light Pink
/datum/chemical_reaction/slime/potion2
	name = "Slime Potion 2"
	result = null
	result_amount = 1
	required = /obj/item/slime_extract/lightpink
	required_reagents = list(/datum/reagent/toxin/phoron = 1)

/datum/chemical_reaction/slime/potion2/on_reaction(datum/reagents/holder)
	..()
	new /obj/item/slimepotion2(get_turf(holder.my_atom))

//Adamantine
/datum/chemical_reaction/slime/golem
	name = "Slime Golem"
	result = null
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 1
	required = /obj/item/slime_extract/adamantine

/datum/chemical_reaction/slime/golem/on_reaction(datum/reagents/holder)
	..()
	var/obj/effect/golemrune/Z = new /obj/effect/golemrune(get_turf(holder.my_atom))
	Z.announce_to_ghosts()

//Sepia
/datum/chemical_reaction/slime/film
	name = "Slime Film"
	result = null
	required_reagents = list(/datum/reagent/blood = 1)
	result_amount = 2
	required = /obj/item/slime_extract/sepia

/datum/chemical_reaction/slime/film/on_reaction(datum/reagents/holder)
	for(var/i in 1 to result_amount)
		new /obj/item/device/camera_film(get_turf(holder.my_atom))
	..()

/datum/chemical_reaction/slime/camera
	name = "Slime Camera"
	result = null
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 1
	required = /obj/item/slime_extract/sepia

/datum/chemical_reaction/slime/camera/on_reaction(datum/reagents/holder)
	new /obj/item/device/camera(get_turf(holder.my_atom))
	..()

//Bluespace
/datum/chemical_reaction/slime/teleport
	name = "Slime Teleport"
	result = null
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	required = /obj/item/slime_extract/bluespace
	reaction_sound = /datum/chemical_reaction
	var/name = null
	var/result = null
	var/list/required_reagents = list()
	var/list/catalysts = list()
	var/list/inhibitors = list()
	var/result_amount = 0
	var/hidden_from_codex
	var/maximum_temperature = INFINITY
	var/minimum_temperature = 0
	var/thermal_product
	var/mix_message = "The solution begins to bubble."
	var/reaction_sound = 'sounds/effects/bubbles.ogg'
	var/log_is_important = 0 // If this reaction should be considered important for logging. Important recipes message admins when mixed, non-important ones just log to file.

/datum/chemical_reaction/proc/can_happen(datum/reagents/holder)
	//check that all the required reagents are present
	if(!holder.has_all_reagents(required_reagents))
		return 0

	//check that all the required catalysts are present in the required amount
	if(!holder.has_all_reagents(catalysts))
		return 0

	//check that none of the inhibitors are present in the required amount
	if(holder.has_any_reagent(inhibitors))
		return 0

	var/temperature = holder.my_atom ? holder.my_atom.temperature : T20C
	if(temperature < minimum_temperature || temperature > maximum_temperature)
		return 0

	return 1

/datum/chemical_reaction/proc/on_reaction(datum/reagents/holder, created_volume, reaction_flags)
	if(thermal_product && ATOM_IS_TEMPERATURE_SENSITIVE(holder.my_atom))
		ADJUST_ATOM_TEMPERATURE(holder.my_atom, thermal_product)

// This proc returns a list of all reagents it wants to use; if the holder has several reactions that use the same reagent, it will split the reagent evenly between them
/datum/chemical_reaction/proc/get_used_reagents()
	. = list()
	for(var/reagent in required_reagents)
		. += reagent

/datum/chemical_reaction/proc/get_reaction_flags(datum/reagents/holder)
	return 0

/datum/chemical_reaction/proc/process(datum/reagents/holder, limit)
	var/data = send_data(holder)

	var/reaction_volume = holder.maximum_volume
	for(var/reactant in required_reagents)
		var/A = holder.get_reagent_amount(reactant) / required_reagents[reactant] / limit // How much of this reagent we are allowed to use
		if(reaction_volume > A)
			reaction_volume = A

	var/reaction_flags = get_reaction_flags(holder)

	for(var/reactant in required_reagents)
		holder.remove_reagent(reactant, reaction_volume * required_reagents[reactant], safety = 1)

	//add the product
	var/amt_produced = result_amount * reaction_volume
	if(result)
		holder.add_reagent(result, amt_produced, data, safety = 1)

	on_reaction(holder, amt_produced, reaction_flags)

//called after processing reactions, if they occurred
/datum/chemical_reaction/proc/post_reaction(datum/reagents/holder)
	var/atom/container = holder.my_atom
	if(mix_message && container && !ismob(container))
		container.visible_message(SPAN_NOTICE("[icon2html(container, viewers(get_turf(container)))] [mix_message]"))
		playsound(container, reaction_sound, 80, 1)
		show_sound_effect(container.loc, soundicon = SFX_ICON_SMALL)

//obtains any special data that will be provided to the reaction products
//this is called just before reactants are removed.
/datum/chemical_reaction/proc/send_data(datum/reagents/holder, reaction_limit)
	return null

/* Common reactions */
/datum/chemical_reaction/inaprovaline
	name = "Inaprovaline"
	result = /datum/reagent/medicine/inaprovaline
	required_reagents = list(/datum/reagent/acetone = 1, /datum/reagent/carbon = 1, /datum/reagent/sugar = 1)
	result_amount = 3

/datum/chemical_reaction/dylovene
	name = "Dylovene"
	result = /datum/reagent/medicine/dylovene
	required_reagents = list(/datum/reagent/silicon = 1, /datum/reagent/potassium = 1, /datum/reagent/ammonia = 1)
	result_amount = 3

/datum/chemical_reaction/tramadol
	name = "Tramadol"
	result = /datum/reagent/medicine/painkiller/tramadol
	required_reagents = list(/datum/reagent/medicine/inaprovaline = 1, /datum/reagent/ethanol = 1, /datum/reagent/acetone = 1)
	result_amount = 3

/datum/chemical_reaction/paracetamol
	name = "Paracetamol"
	result = /datum/reagent/medicine/painkiller/paracetamol
	required_reagents = list(/datum/reagent/medicine/painkiller/tramadol = 1, /datum/reagent/sugar = 1, /datum/reagent/water = 1)
	result_amount = 3

/datum/chemical_reaction/oxycodone
	name = "Oxycodone"
	result = /datum/reagent/medicine/painkiller/tramadol/oxycodone
	required_reagents = list(/datum/reagent/ethanol = 1, /datum/reagent/medicine/painkiller/tramadol = 1)
	catalysts = list(/datum/reagent/toxin/phoron = 5)
	result_amount = 1

/datum/chemical_reaction/sterilizine
	name = "Sterilizine"
	result = /datum/reagent/medicine/sterilizine
	required_reagents = list(/datum/reagent/ethanol = 1, /datum/reagent/medicine/dylovene = 1, /datum/reagent/acid/hydrochloric = 1)
	result_amount = 3

/datum/chemical_reaction/mutagen
	name = "Unstable mutagen"
	result = /datum/reagent/unstable_mutagen
	required_reagents = list(/datum/reagent/radium = 1, /datum/reagent/phosphorus = 1, /datum/reagent/acid/hydrochloric = 1)
	result_amount = 3

/datum/chemical_reaction/thermite
	name = "Thermite"
	result = /datum/reagent/thermite
	required_reagents = list(/datum/reagent/aluminium = 1, /datum/reagent/iron = 1, /datum/reagent/acetone = 1)
	result_amount = 3
	mix_message = "The solution thickens into a coarse metallic paste."

/datum/chemical_reaction/space_drugs
	name = "Space Drugs"
	result = /datum/reagent/space_drugs
	required_reagents = list(/datum/reagent/mercury = 1, /datum/reagent/sugar = 1, /datum/reagent/lithium = 1)
	result_amount = 3
	minimum_temperature = 50 CELSIUS
	maximum_temperature = (50 CELSIUS) + 100

/datum/chemical_reaction/serotrotium
	name = "Serotrotium"
	result = /datum/reagent/serotrotium
	required_reagents = list(/datum/reagent/ethanol = 1, /datum/reagent/sugar = 1, /datum/reagent/lithium = 1)
	result_amount = 3
	minimum_temperature = 40 CELSIUS
	maximum_temperature = (40 CELSIUS) + 100

/datum/chemical_reaction/pacid
	name = "Polytrinic acid"
	result = /datum/reagent/acid/polytrinic
	required_reagents = list(/datum/reagent/acid/sulphuric = 1, /datum/reagent/acid/hydrochloric = 1, /datum/reagent/potassium = 1)
	result_amount = 3

/datum/chemical_reaction/synaptizine
	name = "Synaptizine"
	result = /datum/reagent/medicine/stimulant/synaptizine
	required_reagents = list(/datum/reagent/sugar = 1, /datum/reagent/lithium = 1, /datum/reagent/water = 1)
	result_amount = 3
	minimum_temperature = 30 CELSIUS
	maximum_temperature = (30 CELSIUS) + 100

/datum/chemical_reaction/hyronalin
	name = "Hyronalin"
	result = /datum/reagent/medicine/hyronalin
	required_reagents = list(/datum/reagent/radium = 1, /datum/reagent/medicine/dylovene = 1)
	result_amount = 2

/datum/chemical_reaction/arithrazine
	name = "Arithrazine"
	result = /datum/reagent/medicine/arithrazine
	required_reagents = list(/datum/reagent/medicine/hyronalin = 1, /datum/reagent/hydrazine = 1)
	result_amount = 2

/datum/chemical_reaction/impedrezene
	name = "Impedrezene"
	result = /datum/reagent/impedrezene
	required_reagents = list(/datum/reagent/mercury = 1, /datum/reagent/acetone = 1, /datum/reagent/sugar = 1)
	result_amount = 2

/datum/chemical_reaction/kelotane
	name = "Kelotane"
	result = /datum/reagent/medicine/kelotane
	required_reagents = list(/datum/reagent/silicon = 1, /datum/reagent/carbon = 1)
	result_amount = 2

/datum/chemical_reaction/peridaxon
	name = "Peridaxon"
	result = /datum/reagent/medicine/peridaxon
	required_reagents = list(/datum/reagent/medicine/bicaridine = 2, /datum/reagent/medicine/cryogenic/clonexadone = 2)
	catalysts = list(/datum/reagent/toxin/phoron = 5)
	result_amount = 2

/datum/chemical_reaction/leporazine
	name = "Leporazine"
	result = /datum/reagent/medicine/leporazine
	required_reagents = list(/datum/reagent/silicon = 1, /datum/reagent/copper = 1)
	catalysts = list(/datum/reagent/toxin/phoron = 5)
	result_amount = 2

/datum/chemical_reaction/cryptobiolin
	name = "Cryptobiolin"
	result = /datum/reagent/cryptobiolin
	required_reagents = list(/datum/reagent/potassium = 1, /datum/reagent/acetone = 1, /datum/reagent/sugar = 1)
	minimum_temperature = 30 CELSIUS
	maximum_temperature = 60 CELSIUS
	result_amount = 3

/datum/chemical_reaction/tricordrazine
	name = "Tricordrazine"
	result = /datum/reagent/medicine/tricordrazine
	required_reagents = list(/datum/reagent/medicine/inaprovaline = 1, /datum/reagent/medicine/dylovene = 1)
	result_amount = 2

/datum/chemical_reaction/alkysine
	name = "Alkysine"
	result = /datum/reagent/medicine/alkysine
	required_reagents = list(/datum/reagent/acid/hydrochloric = 1, /datum/reagent/ammonia = 1, /datum/reagent/medicine/dylovene = 1)
	result_amount = 2

/datum/chemical_reaction/dexalin
	name = "Dexalin"
	result = /datum/reagent/medicine/dexalin
	required_reagents = list(/datum/reagent/acetone = 2, /datum/reagent/toxin/phoron = 0.1)
	inhibitors = list(/datum/reagent/water = 1) // Messes with cryox
	result_amount = 1

/datum/chemical_reaction/dermaline
	name = "Dermaline"
	result = /datum/reagent/medicine/dermaline
	required_reagents = list(/datum/reagent/acetone = 1, /datum/reagent/phosphorus = 1, /datum/reagent/medicine/kelotane = 1)
	result_amount = 3
	minimum_temperature = (-50 CELSIUS) - 100
	maximum_temperature = -50 CELSIUS

/datum/chemical_reaction/dexalinp
	name = "Dexalin Plus"
	result = /datum/reagent/medicine/dexalin_plus
	required_reagents = list(/datum/reagent/medicine/dexalin = 1, /datum/reagent/carbon = 1, /datum/reagent/iron = 1)
	result_amount = 3

/datum/chemical_reaction/bicaridine
	name = "Bicaridine"
	result = /datum/reagent/medicine/bicaridine
	required_reagents = list(/datum/reagent/medicine/inaprovaline = 1, /datum/reagent/carbon = 1)
	inhibitors = list(/datum/reagent/sugar = 1) // Messes up with inaprovaline
	result_amount = 2

/datum/chemical_reaction/bicaridine_alt
	name = "Grauel Decomposition into Bicaridine"
	result = /datum/reagent/medicine/bicaridine
	required_reagents = list(/datum/reagent/grauel = 1, /datum/reagent/phosphorus = 1)
	result_amount = 2

/datum/chemical_reaction/meraline
	name = "Meraline"
	result = /datum/reagent/medicine/meraline
	required_reagents = list(/datum/reagent/medicine/inaprovaline = 1, /datum/reagent/medicine/bicaridine = 1, /datum/reagent/iron = 1)
	result_amount = 3

/datum/chemical_reaction/ossarepantes
	name = "Ossarepantes"
	result = /datum/reagent/medicine/ossarepantes
	required_reagents = list(/datum/reagent/medicine/bicaridine = 1, /datum/reagent/drink/milk = 1, /datum/reagent/radium = 1)
	result_amount = 3
	minimum_temperature = 50 CELSIUS
	maximum_temperature = (50 CELSIUS) + 100

/datum/chemical_reaction/hyperzine
	name = "Hyperzine"
	result = /datum/reagent/medicine/stimulant/hyperzine
	required_reagents = list(/datum/reagent/sugar = 1, /datum/reagent/phosphorus = 1, /datum/reagent/sulfur = 1)
	result_amount = 3

/datum/chemical_reaction/ryetalyn
	name = "Ryetalyn"
	result = /datum/reagent/medicine/ryetalyn
	required_reagents = list(/datum/reagent/medicine/arithrazine = 1, /datum/reagent/carbon = 1)
	result_amount = 2

/datum/chemical_reaction/cryoxadone
	name = "Cryoxadone"
	result = /datum/reagent/medicine/cryogenic/cryoxadone
	required_reagents = list(/datum/reagent/medicine/dexalin = 1, /datum/reagent/drink/ice = 1, /datum/reagent/acetone = 1)
	result_amount = 3
	minimum_temperature = (-25 CELSIUS) - 100
	maximum_temperature = -25 CELSIUS
	mix_message = "The solution becomes sludge-like."

/datum/chemical_reaction/nanitefluid
	name = "Nanite Fluid"
	result = /datum/reagent/medicine/cryogenic/nanite_fluid
	required_reagents = list(/datum/reagent/medicine/cryogenic/cryoxadone = 1, /datum/reagent/aluminium = 1, /datum/reagent/iron = 1)
	catalysts = list(/datum/reagent/toxin/phoron = 5)
	result_amount = 3
	minimum_temperature = (-25 CELSIUS) - 100
	maximum_temperature = -25 CELSIUS
	mix_message = "The solution becomes a metallic slime."

/datum/chemical_reaction/venaxilin
	name = "Venaxilin"
	result = /datum/reagent/medicine/dylovene/venaxilin
	required_reagents = list(/datum/reagent/medicine/dylovene = 1, /datum/reagent/medicine/spaceacillin = 1, /datum/reagent/toxin/venom = 1)
	result_amount = 1
	minimum_temperature = 50 CELSIUS
	maximum_temperature = 100 CELSIUS
	mix_message = "The solution steams and becomes cloudy."


/datum/chemical_reaction/clonexadone
	name = "Clonexadone"
	result = /datum/reagent/medicine/cryogenic/clonexadone
	required_reagents = list(/datum/reagent/medicine/cryogenic/cryoxadone = 1, /datum/reagent/sodium = 1)
	result_amount = 2
	minimum_temperature = -100 CELSIUS
	maximum_temperature = -75 CELSIUS
	mix_message = "The solution thickens into translucent slime."

/datum/chemical_reaction/spaceacillin
	name = "Spaceacillin"
	result = /datum/reagent/medicine/spaceacillin
	required_reagents = list(/datum/reagent/cryptobiolin = 1, /datum/reagent/medicine/inaprovaline = 1)
	result_amount = 2

/datum/chemical_reaction/imidazoline
	name = "Imidazoline"
	result = /datum/reagent/medicine/imidazoline
	required_reagents = list(/datum/reagent/carbon = 1, /datum/reagent/hydrazine = 1, /datum/reagent/medicine/dylovene = 1)
	result_amount = 2

/datum/chemical_reaction/ethylredoxrazine
	name = "Ethylredoxrazine"
	result = /datum/reagent/medicine/ethylredoxrazine
	required_reagents = list(/datum/reagent/acetone = 1, /datum/reagent/medicine/dylovene = 1, /datum/reagent/carbon = 1)
	result_amount = 3

/datum/chemical_reaction/naltrexone
	name = "Naltrexone"
	result = /datum/reagent/medicine/naltrexone
	required_reagents = list(/datum/reagent/medicine/antidepressant/methylphenidate = 1, /datum/reagent/sugar = 1, /datum/reagent/carbon = 1)
	result_amount = 3

/datum/chemical_reaction/varenicline
	name = "Varenicline"
	result = /datum/reagent/medicine/varenicline
	required_reagents = list(/datum/reagent/acetone = 1, /datum/reagent/phosphorus = 1, /datum/reagent/sodium = 1)
	result_amount = 3

/datum/chemical_reaction/soporific
	name = "Soporific"
	result = /datum/reagent/soporific
	required_reagents = list(/datum/reagent/chloral_hydrate = 1, /datum/reagent/sugar = 4)
	inhibitors = list(/datum/reagent/phosphorus) // Messes with the smoke
	result_amount = 5

/datum/chemical_reaction/chloralhydrate
	name = "Chloral Hydrate"
	result = /datum/reagent/chloral_hydrate
	required_reagents = list(/datum/reagent/ethanol = 1, /datum/reagent/acid/hydrochloric = 3, /datum/reagent/water = 1)
	result_amount = 1

/datum/chemical_reaction/vecuronium_bromide
	name = "Vecuronium Bromide"
	result = /datum/reagent/vecuronium_bromide
	required_reagents = list(/datum/reagent/ethanol = 1, /datum/reagent/mercury = 2, /datum/reagent/hydrazine = 2)
	result_amount = 1

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
	required_reagents = list(/datum/reagent/soporific = 5, /datum/reagent/copper = 5, /datum/reagent/toxin/cyanide = 5)
	result_amount = 2
	minimum_temperature = 90 CELSIUS
	maximum_temperature = 99 CELSIUS
	mix_message = "The solution boils off to form a fine powder."

/datum/chemical_reaction/mindbreaker
	name = "Mindbreaker Toxin"
	result = /datum/reagent/mindbreaker_toxin
	required_reagents = list(/datum/reagent/silicon = 1, /datum/reagent/hydrazine = 1, /datum/reagent/medicine/dylovene = 1)
	result_amount = 3
	mix_message = "The solution takes on an iridescent sheen."
	minimum_temperature = 75 CELSIUS
	maximum_temperature = (75 CELSIUS) + 25

/datum/chemical_reaction/lipozine
	name = "Lipozine"
	result = /datum/reagent/lipozine
	required_reagents = list(/datum/reagent/sodiumchloride = 1, /datum/reagent/ethanol = 1, /datum/reagent/radium = 1)
	result_amount = 3

/datum/chemical_reaction/surfactant
	name = "Azosurfactant"
	result = /datum/reagent/surfactant
	required_reagents = list(/datum/reagent/hydrazine = 2, /datum/reagent/carbon = 2, /datum/reagent/acid/sulphuric = 1)
	result_amount = 5
	mix_message = "The solution begins to foam gently."

/datum/chemical_reaction/diethylamine
	name = "Diethylamine"
	result = /datum/reagent/diethylamine
	required_reagents = list (/datum/reagent/ammonia = 1, /datum/reagent/ethanol = 1)
	result_amount = 2

/datum/chemical_reaction/hydroxylsan
	name = "Hydroxylsan"
	result = /datum/reagent/hydroxylsan
	required_reagents = list(/datum/reagent/ammonia = 1, /datum/reagent/water = 1)
	result_amount = 2

/datum/chemical_reaction/plantbgone
	name = "Plant-B-Gone"
	result = /datum/reagent/toxin/plant_b_gone
	required_reagents = list(/datum/reagent/toxin = 1, /datum/reagent/water = 4)
	result_amount = 5

/datum/chemical_reaction/foaming_agent
	name = "Foaming Agent"
	result = /datum/reagent/foaming_agent
	required_reagents = list(/datum/reagent/lithium = 1, /datum/reagent/hydrazine = 1)
	result_amount = 1
	mix_message = "The solution begins to foam vigorously."

/datum/chemical_reaction/glycerol
	name = "Glycerol"
	result = /datum/reagent/glycerol
	required_reagents = list(/datum/reagent/nutriment/cornoil = 3, /datum/reagent/acid/sulphuric = 1)
	result_amount = 1

/datum/chemical_reaction/sodiumchloride
	name = "Sodium Chloride"
	result = /datum/reagent/sodiumchloride
	required_reagents = list(/datum/reagent/sodium = 1, /datum/reagent/acid/hydrochloric = 1)
	result_amount = 2

/datum/chemical_reaction/condensedcapsaicin
	name = "Condensed Capsaicin"
	result = /datum/reagent/capsaicin/condensed
	required_reagents = list(/datum/reagent/capsaicin = 2)
	catalysts = list(/datum/reagent/toxin/phoron = 5)
	result_amount = 1

/datum/chemical_reaction/coolant
	name = "Coolant"
	result = /datum/reagent/coolant
	required_reagents = list(/datum/reagent/tungsten = 1, /datum/reagent/acetone = 1, /datum/reagent/water = 1)
	result_amount = 3
	log_is_important = 1
	mix_message = "The solution becomes thick and slightly slimy."

/datum/chemical_reaction/rezadone
	name = "Rezadone"
	result = /datum/reagent/medicine/rezadone
	required_reagents = list(
		/datum/reagent/medicine/arithrazine =1,
		/datum/reagent/cryptobiolin = 1,
		/datum/reagent/copper = 1,
		/datum/reagent/medicine/dermaline = 1,
		/datum/reagent/medicine/meraline = 1,
		/datum/reagent/uranium = 1
	)
	result_amount = 3

/datum/chemical_reaction/lexorin
	name = "Lexorin"
	result = /datum/reagent/lexorin
	required_reagents = list(/datum/reagent/toxin/phoron = 1, /datum/reagent/hydrazine = 1, /datum/reagent/ammonia = 1)
	result_amount = 3

/datum/chemical_reaction/methylphenidate
	name = "Methylphenidate"
	result = /datum/reagent/medicine/antidepressant/methylphenidate
	required_reagents = list(/datum/reagent/mindbreaker_toxin = 1, /datum/reagent/lithium = 1)
	result_amount = 3

/datum/chemical_reaction/citalopram
	name = "Citalopram"
	result = /datum/reagent/medicine/antidepressant/citalopram
	required_reagents = list(/datum/reagent/mindbreaker_toxin = 1, /datum/reagent/carbon = 1)
	result_amount = 3

/datum/chemical_reaction/paroxetine
	name = "Paroxetine"
	result = /datum/reagent/medicine/antidepressant/paroxetine
	required_reagents = list(/datum/reagent/mindbreaker_toxin = 1, /datum/reagent/acetone = 1, /datum/reagent/medicine/inaprovaline = 1)
	result_amount = 3

/datum/chemical_reaction/hair_remover
	name = "Hair Remover"
	result = /datum/reagent/toxin/hair_remover
	required_reagents = list(/datum/reagent/radium = 1, /datum/reagent/potassium = 1, /datum/reagent/acid/hydrochloric = 1)
	result_amount = 3
	mix_message = "The solution thins out and emits an acrid smell."

/datum/chemical_reaction/noexcutite
	name = "Noexcutite"
	result = /datum/reagent/medicine/noexcutite
	required_reagents = list(/datum/reagent/medicine/painkiller/tramadol/oxycodone = 1, /datum/reagent/medicine/dylovene = 1)
	result_amount = 2

/datum/chemical_reaction/methyl_bromide
	name = "Methyl Bromide"
	required_reagents = list(/datum/reagent/toxin/bromide = 1, /datum/reagent/ethanol = 1, /datum/reagent/hydrazine = 1)
	result_amount = 3
	result = /datum/reagent/toxin/methyl_bromide
	mix_message = "The solution begins to bubble, emitting a dark vapor."

/datum/chemical_reaction/adrenaline
	name = "Adrenaline"
	result = /datum/reagent/medicine/adrenaline
	required_reagents = list(/datum/reagent/medicine/inaprovaline = 1, /datum/reagent/medicine/stimulant/hyperzine = 1, /datum/reagent/medicine/dexalin_plus = 1)
	result_amount = 3

/* Solidification */
/datum/chemical_reaction/phoronsolidification
	name = "Solid Phoron"
	result = null
	required_reagents = list(/datum/reagent/iron = 5, /datum/reagent/toxin/phoron = 20)
	result_amount = 1
	minimum_temperature = (-80 CELSIUS) - 100
	maximum_temperature = -80 CELSIUS
	mix_message = "The solution hardens and begins to crystallize."

/datum/chemical_reaction/phoronsolidification/on_reaction(datum/reagents/holder, created_volume, reaction_flags)
	..()
	new /obj/item/stack/material/phoron(get_turf(holder.my_atom), created_volume)

/datum/chemical_reaction/plastication
	name = "Plastic"
	result = null
	required_reagents = list(/datum/reagent/acid/polytrinic = 1, /datum/reagent/toxin/plasticide = 2)
	result_amount = 1
	mix_message = "The solution solidifies into a grey-white mass."

/datum/chemical_reaction/plastication/on_reaction(datum/reagents/holder, created_volume, reaction_flags)
	..()
	new /obj/item/stack/material/plastic(get_turf(holder.my_atom), created_volume)

/* Grenade reactions */

/datum/chemical_reaction/explosion_potassium
	name = "Explosion"
	result = null
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/potassium = 1)
	result_amount = 2
	mix_message = null
	mix_message = "The solution bubbles vigorously!"

/datum/chemical_reaction/explosion_potassium/on_reaction(datum/reagents/holder, created_volume, reaction_flags)
	..()
	var/datum/effect/effect/system/reagents_explosion/e = new()
	e.set_up(round (created_volume/10, 1), holder.my_atom, 0, 0)
	if(isliving(holder.my_atom))
		e.amount *= 0.5
		var/mob/living/L = holder.my_atom
		if(L.stat != DEAD)
			e.amount *= 0.5
	e.start()
	holder.clear_reagents()

/datum/chemical_reaction/flash_powder
	name = "Flash powder"
	result = null
	required_reagents = list(/datum/reagent/aluminium = 1, /datum/reagent/potassium = 1, /datum/reagent/sulfur = 1 )
	result_amount = null
	mix_message = "The solution bubbles vigorously!"

/datum/chemical_reaction/flash_powder/on_reaction(datum/reagents/holder, created_volume, reaction_flags)
	..()
	var/location = get_turf(holder.my_atom)
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(2, 1, location)
	s.start()
	for(var/mob/living/carbon/M in viewers(world.view, location))
		switch(get_dist(M, location))
			if(0 to 3)
				if(hasvar(M, "glasses"))
					if(istype(M:glasses, /obj/item/clothing/glasses/sunglasses))
						continue

				M.flash_eyes()
				M.Weaken(15)

			if(4 to 5)
				if(hasvar(M, "glasses"))
					if(istype(M:glasses, /obj/item/clothing/glasses/sunglasses))
						continue

				M.flash_eyes()
				M.Stun(5)

/datum/chemical_reaction/emp_pulse
	name = "EMP Pulse"
	result = null
	required_reagents = list(/datum/reagent/uranium = 1, /datum/reagent/iron = 1) // Yes, laugh, it's the best recipe I could think of that makes a little bit of sense
	result_amount = 2
	mix_message = "The solution bubbles vigorously!"

/datum/chemical_reaction/emp_pulse/on_reaction(datum/reagents/holder, created_volume, reaction_flags)
	..()
	var/location = get_turf(holder.my_atom)
	// 100 created volume = 4 heavy range & 7 light range. A few tiles smaller than traitor EMP grandes.
	// 200 created volume = 8 heavy range & 14 light range. 4 tiles larger than traitor EMP grenades.
	empulse(location, round(created_volume / 24), round(created_volume / 14), 1)
	holder.clear_reagents()

/datum/chemical_reaction/nitroglycerin
	name = "Nitroglycerin"
	result = /datum/reagent/nitroglycerin
	required_reagents = list(/datum/reagent/glycerol = 1, /datum/reagent/acid/polytrinic = 1, /datum/reagent/acid/sulphuric = 1)
	result_amount = 2
	log_is_important = 1

/datum/chemical_reaction/nitroglycerin/on_reaction(datum/reagents/holder, created_volume, reaction_flags)
	..()
	var/datum/effect/effect/system/reagents_explosion/e = new()
	e.set_up(round (created_volume/2, 1), holder.my_atom, 0, 0)
	if(isliving(holder.my_atom))
		e.amount *= 0.5
		var/mob/living/L = holder.my_atom
		if(L.stat!=DEAD)
			e.amount *= 0.5
	e.start()
	holder.clear_reagents()

/datum/chemical_reaction/napalm
	name = "Napalm"
	result = /datum/reagent/napalm
	required_reagents = list(/datum/reagent/aluminium = 1, /datum/reagent/acid/sulphuric = 1, /datum/reagent/glycerol = 1 ) //because bananas grow on palms and palm oil is used to make napalm. =/= logic
	result_amount = 2
	mix_message = "The solution thickens and takes on a slimy sheen."

/datum/chemical_reaction/napalmb
	name = "Napalm B"
	result = /datum/reagent/napalm/b
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/fuel = 1 )
	result_amount = 2
	mix_message = "The solution thickens and takes on a slimy sheen."

/datum/chemical_reaction/chemsmoke
	name = "Chemsmoke"
	result = null
	required_reagents = list(/datum/reagent/potassium = 1, /datum/reagent/sugar = 1, /datum/reagent/phosphorus = 1)
	result_amount = 0.4
	mix_message = "The solution bubbles vigorously!"

/datum/chemical_reaction/chemsmoke/on_reaction(datum/reagents/holder, created_volume, reaction_flags)
	..()
	var/location = get_turf(holder.my_atom)
	var/datum/effect/effect/system/smoke_spread/chem/S = new /datum/effect/effect/system/smoke_spread/chem
	S.attach(location)
	S.set_up(holder, created_volume, 0, location)
	playsound(location, 'sounds/effects/smoke.ogg', 50, 1, -3)
	spawn(0)
		S.start()
	holder.clear_reagents()

/datum/chemical_reaction/foam
	name = "Foam"
	result = null
	required_reagents = list(/datum/reagent/surfactant = 1, /datum/reagent/water = 1)
	result_amount = 2
	mix_message = "The solution bubbles vigorously!"

/datum/chemical_reaction/foam/on_reaction(datum/reagents/holder, created_volume, reaction_flags)
	..()
	var/location = get_turf(holder.my_atom)

	for(var/mob/M in viewers(5, location))
		to_chat(M, SPAN_WARNING("The solution spews out foam!"))

	var/datum/effect/effect/system/foam_spread/s = new()
	s.set_up(created_volume, location, holder, 0)
	s.start()
	holder.clear_reagents()

/datum/chemical_reaction/metalfoam
	name = "Metal Foam"
	result = null
	required_reagents = list(/datum/reagent/aluminium = 3, /datum/reagent/foaming_agent = 1, /datum/reagent/acid/polytrinic = 1)
	result_amount = 5
	mix_message = "The solution bubbles vigorously!"

/datum/chemical_reaction/metalfoam/on_reaction(datum/reagents/holder, created_volume, reaction_flags)
	..()
	var/location = get_turf(holder.my_atom)

	for(var/mob/M in viewers(5, location))
		to_chat(M, SPAN_WARNING("The solution spews out a metalic foam!"))

	var/datum/effect/effect/system/foam_spread/s = new()
	s.set_up(created_volume, location, holder, 1)
	s.start()

/datum/chemical_reaction/ironfoam
	name = "Iron Foam"
	result = null
	required_reagents = list(/datum/reagent/iron = 3, /datum/reagent/foaming_agent = 1, /datum/reagent/acid/polytrinic = 1)
	result_amount = 5
	mix_message = "The solution bubbles vigorously!"

/datum/chemical_reaction/ironfoam/on_reaction(datum/reagents/holder, created_volume, reaction_flags)
	..()
	var/location = get_turf(holder.my_atom)

	for(var/mob/M in viewers(5, location))
		to_chat(M, SPAN_WARNING("The solution spews out a metalic foam!"))

	var/datum/effect/effect/system/foam_spread/s = new()
	s.set_up(created_volume, location, holder, 2)
	s.start()

/* Paint */

/datum/chemical_reaction/red_paint
	name = "Red paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/crayon_dust/red = 1)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy red sheen."

/datum/chemical_reaction/red_paint/send_data()
	return "#fe191a"

/datum/chemical_reaction/orange_paint
	name = "Orange paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/crayon_dust/orange = 1)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy orange sheen."

/datum/chemical_reaction/orange_paint/send_data()
	return "#ffbe4f"

/datum/chemical_reaction/yellow_paint
	name = "Yellow paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/crayon_dust/yellow = 1)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy yellow sheen."

/datum/chemical_reaction/yellow_paint/send_data()
	return "#fdfe7d"

/datum/chemical_reaction/green_paint
	name = "Green paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/crayon_dust/green = 1)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy green sheen."

/datum/chemical_reaction/green_paint/send_data()
	return "#18a31a"

/datum/chemical_reaction/blue_paint
	name = "Blue paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/crayon_dust/blue = 1)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy blue sheen."

/datum/chemical_reaction/blue_paint/send_data()
	return "#247cff"

/datum/chemical_reaction/purple_paint
	name = "Purple paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/crayon_dust/purple = 1)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy purple sheen."

/datum/chemical_reaction/purple_paint/send_data()
	return "#cc0099"

/datum/chemical_reaction/grey_paint //mime
	name = "Grey paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/crayon_dust/grey = 1)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy grey sheen."

/datum/chemical_reaction/grey_paint/send_data()
	return "#808080"

/datum/chemical_reaction/brown_paint
	name = "Brown paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/crayon_dust/brown = 1)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy brown sheen."

/datum/chemical_reaction/brown_paint/send_data()
	return "#846f35"

/datum/chemical_reaction/blood_paint
	name = "Blood paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/blood = 2)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy red sheen."

/datum/chemical_reaction/blood_paint/send_data(datum/reagents/T)
	var/t = T.get_data("blood")
	if(t && t["blood_colour"])
		return t["blood_colour"]
	return "#fe191a" // Probably red

/datum/chemical_reaction/milk_paint
	name = "Milk paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/drink/milk = 5)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy white sheen."

/datum/chemical_reaction/milk_paint/send_data()
	return "#f0f8ff"

/datum/chemical_reaction/orange_juice_paint
	name = "Orange juice paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/drink/juice/orange = 5)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy orange sheen."

/datum/chemical_reaction/orange_juice_paint/send_data()
	return "#e78108"

/datum/chemical_reaction/tomato_juice_paint
	name = "Tomato juice paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/drink/juice/tomato = 5)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy red sheen."

/datum/chemical_reaction/tomato_juice_paint/send_data()
	return "#731008"

/datum/chemical_reaction/lime_juice_paint
	name = "Lime juice paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/drink/juice/lime = 5)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy green sheen."

/datum/chemical_reaction/lime_juice_paint/send_data()
	return "#365e30"

/datum/chemical_reaction/carrot_juice_paint
	name = "Carrot juice paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/drink/juice/carrot = 5)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy orange sheen."

/datum/chemical_reaction/carrot_juice_paint/send_data()
	return "#973800"

/datum/chemical_reaction/berry_juice_paint
	name = "Berry juice paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/drink/juice/berry = 5)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy red sheen."

/datum/chemical_reaction/berry_juice_paint/send_data()
	return "#990066"

/datum/chemical_reaction/grape_juice_paint
	name = "Grape juice paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/drink/juice/grape = 5)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy purple sheen."

/datum/chemical_reaction/grape_juice_paint/send_data()
	return "#863333"

/datum/chemical_reaction/poisonberry_juice_paint
	name = "Poison berry juice paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/toxin/poisonberryjuice = 5)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy purple sheen."

/datum/chemical_reaction/poisonberry_juice_paint/send_data()
	return "#863353"

/datum/chemical_reaction/watermelon_juice_paint
	name = "Watermelon juice paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/drink/juice/watermelon = 5)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy red sheen."

/datum/chemical_reaction/watermelon_juice_paint/send_data()
	return "#b83333"

/datum/chemical_reaction/lemon_juice_paint
	name = "Lemon juice paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/drink/juice/lemon = 5)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy yellow sheen."

/datum/chemical_reaction/lemon_juice_paint/send_data()
	return "#afaf00"

/datum/chemical_reaction/banana_juice_paint
	name = "Banana juice paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/drink/juice/banana = 5)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy yellow sheen."

/datum/chemical_reaction/banana_juice_paint/send_data()
	return "#c3af00"

/datum/chemical_reaction/potato_juice_paint
	name = "Potato juice paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, "potatojuice" = 5)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy brown sheen."

/datum/chemical_reaction/potato_juice_paint/send_data()
	return "#302000"

/datum/chemical_reaction/carbon_paint
	name = "Carbon paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/carbon = 1)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy black sheen."

/datum/chemical_reaction/carbon_paint/send_data()
	return "#333333"

/datum/chemical_reaction/aluminium_paint
	name = "Aluminium paint"
	result = /datum/reagent/paint
	required_reagents = list(/datum/reagent/toxin/plasticide = 1, /datum/reagent/water = 3, /datum/reagent/aluminium = 1)
	result_amount = 5
	mix_message = "The solution thickens and takes on a glossy white sheen."

/datum/chemical_reaction/aluminium_paint/send_data()
	return "#f0f8ff"

/* Slime cores */

/datum/chemical_reaction/slime
	hidden_from_codex = TRUE
	mix_message = "The slime core twitches sharply."
	var/required = null

/datum/chemical_reaction/slime/can_happen(datum/reagents/holder)
	if(holder.my_atom && istype(holder.my_atom, required))
		var/obj/item/slime_extract/T = holder.my_atom
		if(T.Uses > 0)
			return ..()
	return 0

/datum/chemical_reaction/slime/on_reaction(datum/reagents/holder)
	..()
	var/obj/item/slime_extract/T = holder.my_atom
	T.Uses--
	if(T.Uses <= 0)
		T.visible_message("[icon2html(T, viewers(get_turf(T)))]<span class='notice'>\The [T]'s power is consumed in the reaction.</span>")
		T.SetName("used slime extract")
		T.desc = "This extract has been used up."

//Grey
/datum/chemical_reaction/slime/spawn
	name = "Slime Spawn"
	result = null
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 1
	required = /obj/item/slime_extract/grey

/datum/chemical_reaction/slime/spawn/on_reaction(datum/reagents/holder)
	..()
	holder.my_atom.visible_message(SPAN_WARNING("Infused with phoron, the core begins to quiver and grow, and soon a new baby slime emerges from it!"))
	new /mob/living/carbon/slime(get_turf(holder.my_atom))

/datum/chemical_reaction/slime/monkey
	name = "Slime Monkey"
	result = null
	required_reagents = list(/datum/reagent/blood = 1)
	result_amount = 1
	required = /obj/item/slime_extract/grey

/datum/chemical_reaction/slime/monkey/on_reaction(datum/reagents/holder)
	..()
	for(var/i = 1, i <= 3, i++)
		new /obj/item/reagent_containers/food/snacks/monkeycube(get_turf(holder.my_atom))

//Green
/datum/chemical_reaction/slime/mutate
	name = "Mutation Toxin"
	result = /datum/reagent/mutation_toxin
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 1
	required = /obj/item/slime_extract/green

//Metal
/datum/chemical_reaction/slime/metal
	name = "Slime Metal"
	result = null
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 1
	required = /obj/item/slime_extract/metal

/datum/chemical_reaction/slime/metal/on_reaction(datum/reagents/holder)
	..()
	var/obj/item/stack/material/steel/M = new (get_turf(holder.my_atom))
	M.amount = 15
	var/obj/item/stack/material/plasteel/P = new (get_turf(holder.my_atom))
	P.amount = 5

//Gold
/datum/chemical_reaction/slime/crit
	name = "Slime Crit"
	result = null
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 1
	required = /obj/item/slime_extract/gold
	var/list/possible_mobs = list(
							/mob/living/simple_animal/friendly/cat,
							/mob/living/simple_animal/friendly/cat/kitten,
							/mob/living/simple_animal/friendly/corgi,
							/mob/living/simple_animal/friendly/corgi/puppy,
							/mob/living/simple_animal/friendly/cow,
							/mob/living/simple_animal/friendly/chick,
							/mob/living/simple_animal/friendly/chicken
							)

/datum/chemical_reaction/slime/crit/on_reaction(datum/reagents/holder)
	..()
	var/type = pick(possible_mobs)
	new type(get_turf(holder.my_atom))

//Silver
/datum/chemical_reaction/slime/bork
	name = "Slime Bork"
	result = null
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 1
	required = /obj/item/slime_extract/silver

/datum/chemical_reaction/slime/bork/on_reaction(datum/reagents/holder)
	..()
	var/list/borks = typesof(/obj/item/reagent_containers/food/snacks) - /obj/item/reagent_containers/food/snacks
	playsound(get_turf(holder.my_atom), 'sounds/effects/phasein.ogg', 100, 1)
	for(var/mob/living/carbon/human/M in viewers(get_turf(holder.my_atom), null))
		if(M.eyecheck() < FLASH_PROTECTION_MODERATE)
			M.flash_eyes()

	for(var/i = 1, i <= 4 + rand(1,2), i++)
		var/chosen = pick(borks)
		var/obj/B = new chosen(get_turf(holder.my_atom))
		if(B)
			if(prob(50))
				for(var/j = 1, j <= rand(1, 3), j++)
					step(B, pick(NORTH, SOUTH, EAST, WEST))

//Blue
/datum/chemical_reaction/slime/frost
	name = "Slime Frost Oil"
	result = /datum/reagent/frostoil
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 10
	required = /obj/item/slime_extract/blue

//Dark Blue
/datum/chemical_reaction/slime/freeze
	name = "Slime Freeze"
	result = null
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 1
	required = /obj/item/slime_extract/darkblue
	mix_message = "The slime extract begins to vibrate violently!"

/datum/chemical_reaction/slime/freeze/on_reaction(datum/reagents/holder)
	set waitfor = 0
	..()
	sleep(50)
	playsound(get_turf(holder.my_atom), 'sounds/effects/phasein.ogg', 100, 1)
	for(var/mob/living/M in range (get_turf(holder.my_atom), 7))
		M.bodytemperature -= 140
		to_chat(M, SPAN_WARNING("You feel a chill!"))

//Orange
/datum/chemical_reaction/slime/casp
	name = "Slime Capsaicin Oil"
	result = /datum/reagent/capsaicin
	required_reagents = list(/datum/reagent/blood = 1)
	result_amount = 10
	required = /obj/item/slime_extract/orange

/datum/chemical_reaction/slime/fire
	name = "Slime fire"
	result = null
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 1
	required = /obj/item/slime_extract/orange
	mix_message = "The slime extract begins to vibrate violently!"

/datum/chemical_reaction/slime/fire/on_reaction(datum/reagents/holder)
	set waitfor = 0
	..()
	sleep(50)
	if(!(holder.my_atom && holder.my_atom.loc))
		return

	var/turf/location = get_turf(holder.my_atom)
	location.assume_gas(GAS_PHORON, 250, 1400)
	location.hotspot_expose(700, 400)

//Yellow
/datum/chemical_reaction/slime/overload
	name = "Slime EMP"
	result = null
	required_reagents = list(/datum/reagent/blood = 1)
	result_amount = 1
	required = /obj/item/slime_extract/yellow

/datum/chemical_reaction/slime/overload/on_reaction(datum/reagents/holder, created_volume, reaction_flags)
	..()
	empulse(get_turf(holder.my_atom), 3, 7)

/datum/chemical_reaction/slime/cell
	name = "Slime Powercell"
	result = null
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 1
	required = /obj/item/slime_extract/yellow

/datum/chemical_reaction/slime/cell/on_reaction(datum/reagents/holder, created_volume, reaction_flags)
	..()
	new /obj/item/cell/slime(get_turf(holder.my_atom))

/datum/chemical_reaction/slime/glow
	name = "Slime Glow"
	result = null
	required_reagents = list(/datum/reagent/water = 1)
	result_amount = 1
	required = /obj/item/slime_extract/yellow
	mix_message = "The contents of the slime core harden and begin to emit a warm, bright light."

/datum/chemical_reaction/slime/glow/on_reaction(datum/reagents/holder, created_volume, reaction_flags)
	..()
	new /obj/item/device/flashlight/slime(get_turf(holder.my_atom))

//Purple
/datum/chemical_reaction/slime/psteroid
	name = "Slime Steroid"
	result = null
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 1
	required = /obj/item/slime_extract/purple

/datum/chemical_reaction/slime/psteroid/on_reaction(datum/reagents/holder, created_volume, reaction_flags)
	..()
	new /obj/item/slimesteroid(get_turf(holder.my_atom))

/datum/chemical_reaction/slime/jam
	name = "Slime Jam"
	result = /datum/reagent/slime_jelly
	required_reagents = list(/datum/reagent/sugar = 1)
	result_amount = 10
	required = /obj/item/slime_extract/purple

//Dark Purple
/datum/chemical_reaction/slime/plasma
	name = "Slime Plasma"
	result = null
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 1
	required = /obj/item/slime_extract/darkpurple

/datum/chemical_reaction/slime/plasma/on_reaction(datum/reagents/holder)
	..()
	var/obj/item/stack/material/phoron/P = new (get_turf(holder.my_atom))
	P.amount = 10

//Red
/datum/chemical_reaction/slime/glycerol
	name = "Slime Glycerol"
	result = /datum/reagent/glycerol
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 8
	required = /obj/item/slime_extract/red

/datum/chemical_reaction/slime/bloodlust
	name = "Bloodlust"
	result = null
	required_reagents = list(/datum/reagent/blood = 1)
	result_amount = 1
	required = /obj/item/slime_extract/red

/datum/chemical_reaction/slime/bloodlust/on_reaction(datum/reagents/holder)
	..()
	for(var/mob/living/carbon/slime/slime in viewers(get_turf(holder.my_atom), null))
		slime.rabid = 1
		slime.visible_message(SPAN_WARNING("The [slime] is driven into a frenzy!"))

//Pink
/datum/chemical_reaction/slime/ppotion
	name = "Slime Potion"
	result = null
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 1
	required = /obj/item/slime_extract/pink

/datum/chemical_reaction/slime/ppotion/on_reaction(datum/reagents/holder)
	..()
	new /obj/item/slimepotion(get_turf(holder.my_atom))

//Black
/datum/chemical_reaction/slime/mutate2
	name = "Advanced Mutation Toxin"
	result = /datum/reagent/advanced_mutation_toxin
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 1
	required = /obj/item/slime_extract/black

//Oil
/datum/chemical_reaction/slime/explosion
	name = "Slime Explosion"
	result = null
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 1
	required = /obj/item/slime_extract/oil
	mix_message = "The slime extract begins to vibrate violently!"

/datum/chemical_reaction/slime/explosion/on_reaction(datum/reagents/holder)
	set waitfor = 0
	..()
	sleep(50)
	explosion(get_turf(holder.my_atom), 1, 3, 6)

//Light Pink
/datum/chemical_reaction/slime/potion2
	name = "Slime Potion 2"
	result = null
	result_amount = 1
	required = /obj/item/slime_extract/lightpink
	required_reagents = list(/datum/reagent/toxin/phoron = 1)

/datum/chemical_reaction/slime/potion2/on_reaction(datum/reagents/holder)
	..()
	new /obj/item/slimepotion2(get_turf(holder.my_atom))

//Adamantine
/datum/chemical_reaction/slime/golem
	name = "Slime Golem"
	result = null
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 1
	required = /obj/item/slime_extract/adamantine

/datum/chemical_reaction/slime/golem/on_reaction(datum/reagents/holder)
	..()
	var/obj/effect/golemrune/Z = new /obj/effect/golemrune(get_turf(holder.my_atom))
	Z.announce_to_ghosts()

//Sepia
/datum/chemical_reaction/slime/film
	name = "Slime Film"
	result = null
	required_reagents = list(/datum/reagent/blood = 1)
	result_amount = 2
	required = /obj/item/slime_extract/sepia

/datum/chemical_reaction/slime/film/on_reaction(datum/reagents/holder)
	for(var/i in 1 to result_amount)
		new /obj/item/device/camera_film(get_turf(holder.my_atom))
	..()

/datum/chemical_reaction/slime/camera
	name = "Slime Camera"
	result = null
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	result_amount = 1
	required = /obj/item/slime_extract/sepia

/datum/chemical_reaction/slime/camera/on_reaction(datum/reagents/holder)
	new /obj/item/device/camera(get_turf(holder.my_atom))
	..()

//Bluespace
/datum/chemical_reaction/slime/teleport
	name = "Slime Teleport"
	result = null
	required_reagents = list(/datum/reagent/toxin/phoron = 1)
	required = /obj/item/slime_extract/bluespace
	reaction_sound = 'sounds